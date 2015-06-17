<%@page import="library.models.Book_Issue_Return_Model" %>
<%@page import="library.models.Book_Model" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="css/jquery.mobile-1.4.2.min.css" />
		<script src="js/jquery-2.1.3.min.js"></script>
		<script src="js/jquery.mobile-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/LibrarianHome.js"></script> 
		<style>
			tr {
				border: 1px solid lightgray;
			}
			tr:nth-child(even) {
				background: #e9e9e9;
			}
			thead > tr {
				background: #d5d5d5;
			}
		</style>
    </head>
    <body>
		<%! HttpSession hs; %>
		<% 
			hs = request.getSession(); 
			if(hs.getAttribute("uname") == null){
				response.sendRedirect("LoginForm.jsp");
			}
		%>
		
		<div data-role="page" data-theme="a" id="pageone">
            <div data-role="header">	
				<a href="#" class="ui-btn ui-icon-user ui-btn-icon-left ui-btn-left" style="cursor: default; margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Welcome <%=  hs.getAttribute("uname") %></a>
                <h1 style="font-family: 'Times New Roman', Times, serif; font-size: 30px;">Library Management System</h1>
				<a href="Logout.jsp" class="ui-btn ui-icon-power ui-btn-icon-left ui-btn-right" style="margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Logout</a>
				<div data-role="navbar">
					<ul>
						<li><a href="#pageone" class="ui-btn-active ui-state-persist" data-icon="search">Search Books</a></li>
						<li><a href="#pagetwo" data-icon="eye">View Your Book Details</a></li>
					</ul>
				</div>
            </div>
            <div data-role="main" class="ui-content">
				<div class="ui-grid-a">
					<form>
						<ul>
							<div class="ui-block-a">							
								<li>
									<input type="radio" name="books" id="allbooks" value="on" checked="checked">
									<label for="allbooks">All Books</label>
								</li>							
							</div>

							<div class="ui-block-b">							
								<li>
									<input type="radio" name="books" id="categorybooks" value="other">
									<label for="categorybooks">Category wise Books</label>
								</li>							
							</div>	
						</ul>
					</form>
				</div><br/>
				
				<center>
					<div class="ui-grid-solo">
						<div class="ui-block-a">
							<div id="allBooks">
								<table data-role="table" class="ui-responsive ui-shadow" >
									<thead>
										<tr>
											<th>Book ID</th>
											<th>Book Name</th>
											<th>Author</th>
											<th>ISBN</th>
											<th>Edition</th>
											<th>Category</th>
										</tr>
									</thead>
									<tbody>
										<%
											Book_Model b = new Book_Model();
											ResultSet rs1 = b.getAllBooks();
											if(rs1 != null){
												while(rs1.next()) {
										%>
											<tr>
												<td><%= rs1.getInt("book_id") %></td>
												<td><%= rs1.getString("book_name") %></td>
												<td><%= rs1.getString("book_author") %></td>
												<td><%= rs1.getString("book_isbn") %></td>
												<td><%= rs1.getInt("book_edition") %></td>
												<td><%= rs1.getString("category_name") %></td>
											</tr>
										<%
												}
											}
										%>
									</tbody>
								</table>
							</div>
							
							<div id="categoryBooks" style="display:none;">
								<div class="ui-field-contain">
									<label for="category" class="ui-hidden-accessible">Book Category</label>
									<select name="book_category" id="book_category">
										<option>Select Category</option>
										<%! 
											ResultSet rs2; 
											int category_id;
											String category_name;
										%>
										<%
											Book_Model bk2 = new Book_Model();
											rs2 = bk2.getCategoryName();
											if(rs2 != null){
												while(rs2.next()) {
												category_id = rs2.getInt("category_id");
												category_name = rs2.getString("category_name");
											%>														
										<option value="<%= category_id %>"><%= category_name %></option>
										<%
												}
											}
										%>
									</select>
								</div>
								<table data-role="table" class="ui-responsive ui-shadow">
									<thead>
										<tr>
											<th>Book ID</th>
											<th>Book Name</th>
											<th>Author</th>
											<th>ISBN</th>
											<th>Edition</th>
										</tr>
									</thead>
									<tbody id="categoryBooksTable">									
									</tbody>
								</table>
							</div>
						</div>           
					</div>
				</center>
			</div>
		</div>	
		
        <div data-role="page" data-theme="a" id="pagetwo">
            <div data-role="header">	
				<a href="#" class="ui-btn ui-icon-user ui-btn-icon-left ui-btn-left" style="cursor: default; margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Welcome <%=  hs.getAttribute("uname") %></a>
                <h1 style="font-family: 'Times New Roman', Times, serif; font-size: 30px;">Library Management System</h1>
				<a href="Logout.jsp" class="ui-btn ui-icon-power ui-btn-icon-left ui-btn-right" style="margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Logout</a>
				<div data-role="navbar">
					<ul>
						<li><a href="#pageone" data-icon="search">Search Books</a></li>
						<li><a href="#pagetwo" class="ui-btn-active ui-state-persist" data-icon="eye">View Your Book Details</a></li>
					</ul>
				</div>
            </div>
            <div data-role="main" class="ui-content">
				<center>
					<div class="ui-grid-solo">
						<div class="ui-block-a">
							<h3>Your Book Details</h3>
							<table data-role="table" class="ui-responsive ui-shadow">
								<thead>
									<tr>
										<th>Book ID</th>
										<th>Book Name</th>
										<th>Author</th>
										<th>Issue Date</th>
										<th>Expected Return Date</th>
										<th>Actual Return Date</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
								
								<%
									String uname = (String)hs.getAttribute("uname");
								%>
								<%
									Book_Issue_Return_Model bk = new Book_Issue_Return_Model();
									ResultSet rs3 = bk.getIssuedBook(uname);
									if(rs3 != null){
										while(rs3.next()) {
								%>
									<tr>
										<td><%= rs3.getInt("book_id") %></td>
										<td><%= rs3.getString("book_name") %></td>
										<td><%= rs3.getString("book_author") %></td>
										<td><%= rs3.getString("issue_date") %></td>
										<td><%= rs3.getString("expected_return_date") %></td>
										<td><%= rs3.getString("actual_return_date") %></td>
										<td><%= rs3.getString("status") %></td>
									</tr>
								<%
										}
									}
								%>
								</tbody>
							</table>
						</div>
					</div>
				</center>
            </div>           
        </div>
    </body>
</html>
