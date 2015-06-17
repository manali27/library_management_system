<%@page import="library.models.Book_Issue_Return_Model" %>
<%@page import="java.sql.*" %>

<%
	String uname = request.getParameter("uname");
	Book_Issue_Return_Model bk = new Book_Issue_Return_Model();
	ResultSet rs2 = bk.getAllIssuedBooks(uname);
	Book_Issue_Return_Model model=new Book_Issue_Return_Model();
	if(rs2 != null){
		while(rs2.next()) {
%>
	<tr>
		<td><%= rs2.getInt("book_id") %></td>
		<td><%= rs2.getString("book_name") %></td>
		<td><%= rs2.getString("issue_date") %></td>
		<td><%= rs2.getString("expected_return_date") %></td>
		
		<%
			if(rs2.getString("actual_return_date") == null) {
		%>
			<td><input type="date" name="act_return_date" class="<%= rs2.getInt("book_id") %>-endDate"  id="act_return_date" placeholder="Return Date" /></td>
			
			<td class="<%= rs2.getInt("book_id") %>-fine" >0</td>
			<td>
				<button name="calc_fine" id="calc_fine" class="ui-btn ui-btn-inline ui-shadow ui-mini" data-bookid="<%= rs2.getInt("book_id") %>" data-startdate="<%= rs2.getString("expected_return_date") %>"  >Calculate Fine</button>
			
				<button name="return" id="return" class="ui-btn ui-btn-inline ui-shadow ui-mini" data-bkid="<%= rs2.getInt("book_id") %>" data-memid="<%= rs2.getInt("member_id") %>">Return</button>
			</td>
		</tr>
		<%
			}
			else {
			long days=model.calculateDate(rs2.getString("expected_return_date"),rs2.getString("actual_return_date"));
			long fine=0;
			if(days>0){
				fine=days*5;
			}
		%>
			<td id="return_date"><%= rs2.getString("actual_return_date") %></td>
			<td><%= fine %></td>
			<td>
				<button name="calc_fine" id="calc_fine" class="ui-btn ui-btn-inline ui-shadow ui-mini" disabled="" >Calculate Fine</button>
				
				<button name="return" id="return" class="ui-btn ui-btn-inline ui-shadow ui-mini" disabled="">Return</button>
			</td>
		</tr>
		<%
				}	
			}
		}
	%>