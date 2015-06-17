<%@page import="library.models.Book_Issue_Return_Model" %>
<%@page import="java.sql.*" %>

<%
	int bk_id = Integer.parseInt(request.getParameter("book_id"));
	int mem_id = Integer.parseInt(request.getParameter("member_id"));
	String act_return_date = request.getParameter("act_return_date");
	
	Book_Issue_Return_Model model=new Book_Issue_Return_Model();
	model.returnBookStatus(bk_id,mem_id,act_return_date);
%>