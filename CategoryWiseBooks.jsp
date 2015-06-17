<%@page import="library.models.Book_Model" %>
<%@page import="java.sql.*" %>

<%
	int id=Integer.parseInt(request.getParameter("id"));
	Book_Model b = new Book_Model();
	ResultSet rs = b.getCategoryAllBooks(id);
	if(rs != null){
		while(rs.next()) {
%>
	<tr>
		<td><%= rs.getInt("book_id") %></td>
		<td><%= rs.getString("book_name") %></td>
		<td><%= rs.getString("book_author") %></td>
		<td><%= rs.getString("book_isbn") %></td>
		<td><%= rs.getInt("book_edition") %></td>
	</tr>
<%
		}
	}
	else {
%>
	<tr colspan="5">
		<td>No Records Found</td>
	</tr>
<%
	}
%>