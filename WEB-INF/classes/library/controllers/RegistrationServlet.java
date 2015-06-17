package library.controllers;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import library.models.Member_Model;

public class RegistrationServlet extends HttpServlet {
	public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
        
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String phno = request.getParameter("phno");
        String uname = request.getParameter("username");
        String pswd = request.getParameter("password");
        String cpswd = request.getParameter("cpassword");
        
        try {

			Member_Model m = new Member_Model();
			int result = m.addMember(fname, lname, email, phno, uname, pswd);

			response.sendRedirect("LoginForm.jsp");
		}

        catch(Exception e) {
            e.printStackTrace();
        }		
	}
}