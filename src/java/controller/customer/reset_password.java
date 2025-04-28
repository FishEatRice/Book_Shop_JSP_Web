package controller.customer;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class reset_password extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if ("create".equals(action)) {
            String sessionOtp = (String) request.getSession().getAttribute("otp"); // OTP stored in session
            String userOtp = request.getParameter("otp"); // OTP user entered

            if (sessionOtp == null || userOtp == null || !sessionOtp.equals(userOtp)) {
                // OTP incorrect
                request.getSession().setAttribute("error", "Invalid OTP. Please try again.");
                response.sendRedirect("/galaxy_bookshelf/web/customer/customerForgetPassword.jsp");
                return; // Stop here, don't reset password
            }

            // OTP correct, now reset password
            String email = request.getParameter("email");
            String newPassword = request.getParameter("password");

            // TODO: Update password in your database based on email
            // Example (pseudo code):
            // CustomerDAO.updatePasswordByEmail(email, newPassword);
            // Clear the OTP after successful reset
            request.getSession().removeAttribute("otp");

            // Redirect to success page
            response.sendRedirect("/galaxy_bookshelf/customer/customerLogin.jsp");
        }
    }
}
