<%@page import="library.models.Book_Issue_Return_Model" %>
<%@page import="java.sql.*" %>

<%
	String act_return_date = request.getParameter("act_return_date");
	String exp_return_date = request.getParameter("exp_return_date");
	Book_Issue_Return_Model model=new Book_Issue_Return_Model();
	long days=model.calculateDate(act_return_date,exp_return_date);
	
%>
<%= days %>