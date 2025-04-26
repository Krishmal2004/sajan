package com.WeddingPlanner.servlets;

import com.WeddingPlanner.model.User;
import com.WeddingPlanner.model.VendorDetails;
import com.WeddingPlanner.services.UserAuthService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private UserAuthService authService;

    @Override
    public void init() throws ServletException {
        authService = new UserAuthService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/signup.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Get common form parameters
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String userType = request.getParameter("userType");

        // Validate common input
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Create new user object
        User newUser = new User();
        newUser.setFirstName(firstName.trim());
        newUser.setLastName(lastName.trim());
        newUser.setEmail(email.trim().toLowerCase());
        newUser.setUsername(username.trim());
        newUser.setPassword(password);
        newUser.setUserType(userType);

        // Set registration metadata
        String currentDateTime = "2025-04-26 20:16:46";
        String currentUser = "Krishmal2004";
        newUser.setDateRegistered(currentDateTime);
        newUser.setLastLogin(currentDateTime);
        newUser.setRegisteredBy(currentUser);
        newUser.setStatus("active");

        // Handle vendor-specific details if user type is VENDOR
        if ("VENDOR".equals(userType)) {
            String businessName = request.getParameter("businessName");
            String businessType = request.getParameter("businessType");
            String description = request.getParameter("description");
            String contactNumber = request.getParameter("contactNumber");
            String[] services = request.getParameterValues("services");

            // Validate vendor fields
            if (businessName == null || businessName.trim().isEmpty() ||
                businessType == null || businessType.trim().isEmpty() ||
                contactNumber == null || contactNumber.trim().isEmpty()) {
                
                request.setAttribute("error", "All vendor fields are required");
                request.getRequestDispatcher("/signup.jsp").forward(request, response);
                return;
            }

            // Create and set vendor details
            VendorDetails vendorDetails = new VendorDetails();
            vendorDetails.setBusinessName(businessName.trim());
            vendorDetails.setBusinessType(businessType);
            vendorDetails.setDescription(description != null ? description.trim() : "");
            vendorDetails.setContactNumber(contactNumber.trim());
            vendorDetails.setServices(services != null ? services : new String[0]);
            vendorDetails.setRating(0.0);
            vendorDetails.setReviewCount(0);
            
            newUser.setVendorDetails(vendorDetails);
        }

        // Attempt to register user
        boolean registrationSuccess = authService.registerUser(newUser, getServletContext());

        if (registrationSuccess) {
            // Create session for new user
            HttpSession session = request.getSession();
            session.setAttribute("username", newUser.getUsername());
            session.setAttribute("userType", userType);
            session.setAttribute("registrationTime", currentDateTime);
            
            // Redirect based on user type
            String redirectPath = "VENDOR".equals(userType) ? 
                "/vendor-dashboard.jsp" : "/buyer-dashboard.jsp";
            response.sendRedirect(request.getContextPath() + redirectPath);
        } else {
            request.setAttribute("error", "Registration failed. Username or email may already exist.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }
}