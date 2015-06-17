package library.controllers;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import library.models.Book_Model;

public class AddBookServlet extends HttpServlet {
	public void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		response.setContentType("text/html");
		
		String book_name = request.getParameter("bkname");
        String isbn = request.getParameter("isbn");
        String author = request.getParameter("author");
        String bk_edition = request.getParameter("edition");
        String bk_category = request.getParameter("category");
        int edition = Integer.parseInt(bk_edition);
        int category = Integer.parseInt(bk_category);
        
        try {
            if(!(book_name.equals("") || isbn.equals("") || author.equals("") || bk_edition.equals("") || bk_category.equals(""))) {
                Book_Model bk = new Book_Model();
                bk.addBook(book_name, isbn, author, edition, category);
				response.sendRedirect("LibrarianHome.jsp#pagetwo");
            }
            else {
                request.setAttribute("status","invalid");
            }   
            response.sendRedirect("LibrarianHome.jsp#pagetwo");
        }
        catch(Exception e) {
            e.printStackTrace();
        }
	}
}