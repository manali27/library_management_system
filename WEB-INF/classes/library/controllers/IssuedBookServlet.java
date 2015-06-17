package library.controllers;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import library.models.Member_Model;
import library.models.Book_Issue_Return_Model;

public class IssuedBookServlet extends HttpServlet {
	public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		response.setContentType("text/html");
		
		String book_id = request.getParameter("book_id");
        String member_uname = request.getParameter("member_uname");        
        String issue_date = request.getParameter("issue_date");
        String exp_return_date = request.getParameter("exp_return_date");
        int member_id = 0;
        String mem_uname = "";
        int bk_id = Integer.parseInt(book_id);
        
        try {
            
            Member_Model m = new Member_Model();
            ResultSet rs = m.getMemberId(member_uname);
            
            if(rs != null){
                rs.next();
                member_id = rs.getInt("member_id");
                mem_uname = rs.getString("member_username");
            }
 
            if(!(member_uname.equals("") || book_id.equals("") || issue_date.equals("") || exp_return_date.equals(""))) {
                if(member_uname.equals(mem_uname)) {
                    
                    Book_Issue_Return_Model bk = new Book_Issue_Return_Model();                    
                    bk.addIssuedBook(issue_date, exp_return_date, bk_id, member_id);
					response.sendRedirect("LibrarianHome.jsp#pagethree");
                } 
                else {
                    request.setAttribute("status","invalid");
                }
            }  
            else {
                request.setAttribute("status","invalid");
            }
            response.sendRedirect("LibrarianHome.jsp#pagethree");
        }
        catch(Exception e) {
            e.printStackTrace();
        }
	}
}