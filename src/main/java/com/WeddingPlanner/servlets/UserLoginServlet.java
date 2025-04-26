package com.WeddingPlanner.servlets;

import com.WeddingPlanner.model.User;
import com.WeddingPlanner.services.UserAuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserAuthService authService = new UserAuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String currentDateTime = "2025-04-26 20:46:05";

        // Get the authenticated user
        User authenticatedUser = authService.authenticateUser(username, password, getServletContext());

        if (authenticatedUser != null) {
            // Success - create session and redirect to appropriate dashboard
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("userType", authenticatedUser.getUserType());
            session.setAttribute("loginTime", currentDateTime);
            session.setAttribute("currentUser", "Krishmal2004");

            // Redirect based on user type
            String redirectPath = "VENDOR".equals(authenticatedUser.getUserType()) ? 
                "vendor-dashboard.jsp" : "buyer-dashboard.jsp";
            response.sendRedirect(redirectPath);
        } else {
            // Failed login
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}