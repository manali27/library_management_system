package library.controllers;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import library.models.Member_Model;

public class LoginServlet extends HttpServlet {
	public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String uname = request.getParameter("username");
        String pswd = request.getParameter("password");
		
		HttpSession hs = request.getSession();  
		hs.setAttribute("status",null);
		
        try {           
            
            Member_Model m = new Member_Model();
            ResultSet rs = m.getMember(uname);

            if(rs.first()){
                String username = rs.getString("member_username");
                String password = rs.getString("member_password");
				
                if(!(uname.equals("")) || pswd.equals("")) {
                    if(uname.equals(username) && pswd.equals(password)) {  
                        hs.setAttribute("uname",username);
                        hs.setAttribute("user_id",rs.getInt("member_id"));
                        hs.setAttribute("role_id",rs.getInt("member_role_id"));
                        
                        if((hs.getAttribute("role_id").equals(1))) {
                            response.sendRedirect("LibrarianHome.jsp");
                        }
                        else {
                            response.sendRedirect("MemberHome.jsp");
                        }
                    }
                    else {
                        hs.setAttribute("status","<p>Username or Password is incorrect</p>");
                        response.sendRedirect("LoginForm.jsp");
                    }
                }               

                else {
                    hs.setAttribute("status","<p>Username or Password cannot be blank</p>");
                    response.sendRedirect("LoginForm.jsp");
                }
            } 
			else {
				hs.setAttribute("status","<p>Username or Password is incorrect</p>");
                response.sendRedirect("LoginForm.jsp");
			}
        }
        catch(Exception e) {
            e.printStackTrace();
        }
	}
}