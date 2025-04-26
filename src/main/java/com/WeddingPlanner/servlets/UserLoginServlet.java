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

@WebServlet("/LoginServlet")
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
        
        System.out.println("Login attempt - Username: " + username); // Debug log
        
        try {
            User authenticatedUser = authService.authenticateUser(username, password, getServletContext());
            
            if (authenticatedUser != null) {
                System.out.println("User authenticated successfully: " + username); // Debug log
                HttpSession session = request.getSession();
                session.setAttribute("username", authenticatedUser.getUsername());
                session.setAttribute("userType", authenticatedUser.getUserType());
                session.setAttribute("loginTime", "2025-04-26 21:27:52");
                
                String redirectPath = "VENDOR".equals(authenticatedUser.getUserType()) ? 
                    "vendor-dashboard.jsp" : "buyer-dashboard.jsp";
                response.sendRedirect(redirectPath);
            } else {
                System.out.println("Authentication failed for user: " + username); // Debug log
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Login error: " + e.getMessage()); // Error log
            e.printStackTrace();
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}