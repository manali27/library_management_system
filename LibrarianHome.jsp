<%@page import="library.models.Book_Issue_Return_Model" %>
<%@page import="library.models.Member_Model" %>
<%@page import="library.models.Book_Model" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="css/jquery.mobile-1.4.2.min.css" />
		<link rel="stylesheet" type="text/css" href="css/tooltipster.css" />
		<link rel="stylesheet" type="text/css" href="css/tooltipster-light.css" />
		<script type="text/javascript" src="js/jquery-2.1.3.min.js"></script>
		<script type="text/javascript" src="js/jquery.mobile-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/jquery.inputmask.js"></script>
		<script type="text/javascript" src="js/jquery.tooltipster.min.js"></script>
		<script type="text/javascript" src="js/LibrarianHome.js"></script> 
		<script type="text/javascript">
		$( document ).ready(function() { 
		
			$("#isbn").focus(function(){
				$("#isbn").inputmask("999-9-99-999999-9");     
			});		
			
			$('.tooltip').tooltipster({ 
				position: 'left',
				theme: 'tooltipster-light'
			});
			
			$( "#add_book_form" ).submit(function(){
				var bookname = $.trim($('#bkname').val());
				var isbn = $.trim($('#isbn').val());
				var author = $.trim($('#author').val());
				var edition = $.trim($('#edition').val());
				var category = $.trim($('#category').val());
				
				var validate1 = 0;
				var error1="";
				
				if (bookname  === '') {
					validate1 = 1;
					error1+="<p>Book Name cannot be empty</p>";
				}
				if (isbn  === '') {
					validate1 = 1;
					error1+="<p>ISBN cannot be empty</p>";
				}
				if (author  === '') {
					validate1 = 1;
					error1+="<p>Author Name cannot be empty</p>";
				}
				if (edition  === '') {
					validate1 = 1;
					error1+="<p>Book Edition cannot be empty</p>";
				}
				if (category  === '') {
					validate1 = 1;
					error1+="<p>Select a Book Category first.</p>";
				}
				if(validate1 == 1){
					$( "#jsvalidation1" ).html(error1);
					$( "#jsvalidation1" ).popup( "open",{transition:"flip"});
					return false;
				}				
			});
			
			$( "#add_issued_book_form" ).submit(function(){
				var book_id = $.trim($('#book_id').val());
				var member_uname = $.trim($('#member_uname').val());
				var issue_date = $.trim($('#issue_date').val());
				var exp_return_date = $.trim($('#exp_return_date').val());
				
				var validate2 = 0;
				var error2="";
				
				if (book_id  === '') {
					validate2 = 1;
					error2+="<p>Book ID cannot be empty</p>";
				}
				if (member_uname  === '') {
					validate2 = 1;
					error2+="<p>Member Username cannot be empty</p>";
				}
				if (issue_date  === '') {
					validate2 = 1;
					error2+="<p>Book Issue Date must be selected</p>";
				}
				if (exp_return_date  === '') {
					validate2 = 1;
					error2+="<p>Book Expected Return Date must be selected</p>";
				}
				if(validate2 == 1){
					$( "#jsvalidation2" ).html(error2);
					$( "#jsvalidation2" ).popup( "open",{transition:"flip"});
					return false;
				}				
			});
		});
		</script>
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
		<%! 
			HttpSession hs; 
		%>
		<%
			hs = request.getSession();
			if(hs.getAttribute("uname") == null){
				response.sendRedirect("LoginForm.jsp");
			}
		%>
		
        <div data-role="page" data-theme="a" id="pageone">
            <div data-role="header">	
				<a href="#" class="ui-btn ui-icon-user ui-btn-icon-left" style="cursor: default; margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Welcome <%=  hs.getAttribute("uname") %></a>
                <h1 style="font-family: 'Times New Roman', Times, serif; font-size: 30px;">Library Management System</h1>
				<a href="Logout.jsp" class="ui-btn ui-icon-power ui-btn-icon-left" style="margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Logout</a>
				
				<div data-role="navbar">
					<ul>
						<li><a href="#" class="ui-btn-active ui-state-persist" data-icon="eye">Show Books</a></li>
						<li><a href="#pagetwo" data-icon="plus">Add Book</a></li>
						<li><a href="#pagethree" data-icon="plus">Issue Book</a></li>
						<li><a href="#pagefour" data-icon="back">Return Book</a></li>
					</ul>
				</div>
            </div>
			
			<div data-role="main" class="ui-content">
				
				<div class="ui-grid-b">
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
									<input type="radio" name="books" id="issuedbooks" value="off">
									<label for="issuedbooks">Issued Books</label>
								</li>							
							</div>
							<div class="ui-block-c">							
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
											ResultSet rs = b.getAllBooks();
											if(rs != null){
												while(rs.next()) {
										%>
											<tr>
												<td><%= rs.getInt("book_id") %></td>
												<td><%= rs.getString("book_name") %></td>
												<td><%= rs.getString("book_author") %></td>
												<td><%= rs.getString("book_isbn") %></td>
												<td><%= rs.getInt("book_edition") %></td>
												<td><%= rs.getString("category_name") %></td>
											</tr>
										<%
												}
											}
										%>
									</tbody>
								</table>
							</div>
							
							<div id="issuedBooks" style="display:none;">
								<table data-role="table" class="ui-responsive ui-shadow">
									<thead>
										<tr>
											<th>Book ID</th>
											<th>Book Name</th>
											<th>Issued Date</th>
											<th>Expected Return Date</th>
											<th>Issued By</th>
										</tr>
									</thead>
									<tbody>
										<%
											Book_Issue_Return_Model bk3 = new Book_Issue_Return_Model();
											ResultSet rs4 = bk3.getAllIssuedBooks();
											if(rs4 != null){
												while(rs4.next()) {
										%>

											<tr>
												<td><%= rs4.getInt("book_id") %></td>
												<td><%= rs4.getString("book_name") %></td>
												<td><%= rs4.getString("issue_date") %></td>
												<td><%= rs4.getString("expected_return_date") %></td>
												<td><%= rs4.getString("member_first_name")+" "+rs4.getString("member_last_name") %></td>											
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
											ResultSet rs3; 
											int category_id;
											String category_name;
										%>
										<%
											Book_Model bk2 = new Book_Model();
											rs3 = bk2.getCategoryName();
											if(rs3 != null){
												while(rs3.next()) {
												category_id = rs3.getInt("category_id");
												category_name = rs3.getString("category_name");
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
						<li><a href="#pageone" data-icon="eye">Show Books</a></li>
						<li><a href="#" class="ui-btn-active ui-state-persist" data-icon="plus">Add Book</a></li>
						<li><a href="#pagethree" data-icon="plus">Issue Book</a></li>
						<li><a href="#pagefour" data-icon="back">Return Book</a></li>
					</ul>
				</div>
			</div>

			<div data-role="main" class="ui-content">
				<div class="ui-grid-b">
					<div class="ui-block-a"></div>
					<div class="ui-block-b">
						<h3>Add the New Arrivals Here</h3>
						
						<form name="add_book_form" id="add_book_form" action="AddBookServlet" data-ajax="false">					
							<label for="bkname" class="ui-hidden-accessible">Book Name:</label>
							<input type="text" name="bkname" id="bkname" placeholder="Book Name" />
							
							<label for="isbn" class="ui-hidden-accessible">ISBN:</label>
							<input type="text" name="isbn" id="isbn" placeholder="ISBN" />
					
							<label for="author" class="ui-hidden-accessible">Author Name:</label>
							<input type="text" name="author" id="author" placeholder="Author Name" />
					
							<label for="edition" class="ui-hidden-accessible">Book Edition:</label>
							<input type="number" name="edition" id="edition" min="1" placeholder="Book Edition" />
		
							<select name="category" id="category">
								<option value="">Select Category</option>
								<%! 
									ResultSet rs4; 
									int category_id1;
									String category_name1;
								%>
								<%
									Book_Model bk4 = new Book_Model();
									rs3 = bk4.getCategoryName();
									if(rs3 != null){
										while(rs3.next()) {
										category_id1 = rs3.getInt("category_id");
										category_name1 = rs3.getString("category_name");
									%>														
								<option value="<%= category_id1 %>"><%= category_name1 %></option>
								<%
										}
									}
								%>
							</select><br/>
					
							<button type="submit" class="ui-btn ui-icon-arrow-r ui-btn-icon-right ui-corner-all ui-shadow">Add Book</button>
						</form>
					</div>
				</div>
			</div>
			<div data-role="popup" style="color:red" id="jsvalidation1">
				
			</div>	
		</div>
		
		<div data-role="page" data-theme="a" id="pagethree">
			<div data-role="header">
				<a href="#" class="ui-btn ui-icon-user ui-btn-icon-left ui-btn-left" style="cursor: default; margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Welcome <%=  hs.getAttribute("uname") %></a>
				<h1 style="font-family: 'Times New Roman', Times, serif; font-size: 30px;">Library Management System</h1>
				<a href="Logout.jsp" class="ui-btn ui-icon-power ui-btn-icon-left ui-btn-right" style="margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Logout</a>
				<div data-role="navbar">
					<ul>
						<li><a href="#pageone" data-icon="eye">Show Books</a></li>
						<li><a href="#pagetwo" data-icon="plus">Add Book</a></li>
						<li><a href="#" class="ui-btn-active ui-state-persist" data-icon="plus">Issue Book</a></li>
						<li><a href="#pagefour" data-icon="back">Return Book</a></li>
					</ul>
				</div>
			</div>

			<div data-role="main" class="ui-content">
				<div class="ui-grid-b">
					<div class="ui-block-a"></div>
					<div class="ui-block-b">
						<h3>Add the Issued Books Here</h3>
						
						<form name="add_issued_book_form" id="add_issued_book_form" action="IssuedBookServlet" data-ajax="false">					
							<label for="book_id" class="ui-hidden-accessible">Book ID:</label>
							<input type="text" name="book_id" id="book_id" placeholder="Book ID" />
							
							<label for="member_uname" class="ui-hidden-accessible">Member Username:</label>
							<input type="text" name="member_uname" id="member_uname" placeholder="Member Username" />
					
							<label for="issue_date" class="ui-hidden-accessible">Book Issue Date:</label>
							<input type="date" name="issue_date" id="issue_date" placeholder="Book Issue Date" class="tooltip" title="Book Issue Date" />
					
							<label for="exp_return_date" class="ui-hidden-accessible">Expected Return Date:</label>
							<input type="date" name="exp_return_date" id="exp_return_date" placeholder="Expected Return Date" class="tooltip" title="Book Expected Return Date"/><br/>
					
							<button type="submit" class="ui-btn ui-icon-arrow-r ui-btn-icon-right ui-corner-all ui-shadow">Issue Book</button>
						</form>
					</div>
				</div>
			</div>
			<div data-role="popup" style="color:red" id="jsvalidation2">
				
			</div>
		</div>
		
		<div data-role="page" data-theme="a" id="pagefour">
			<div data-role="header">			
				<a href="#" class="ui-btn ui-icon-user ui-btn-icon-left" style="cursor: default; margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Welcome <%=  hs.getAttribute("uname") %></a>
				<h1 style="font-family: 'Times New Roman', Times, serif; font-size: 30px;">Library Management System</h1>
				<a href="Logout.jsp" class="ui-btn ui-icon-power ui-btn-icon-left" style="margin-top: 13px;height: 16px;padding-top: 15px;padding-bottom: 15px;">Logout</a>
				<div data-role="navbar">
					<ul>
						<li><a href="#pageone" data-icon="eye">Show Books</a></li>
						<li><a href="#pagetwo" data-icon="plus">Add Book</a></li>
						<li><a href="#pagethree" data-icon="plus">Issue Book</a></li>
						<li><a href="#" class="ui-btn-active ui-state-persist" data-icon="back">Return Book</a></li>
					</ul>
				</div>
			</div>

			<div data-role="main" class="ui-content">
				<div class="ui-grid-solo">
					<div class="ui-block-a">
						<h3>Add the Returned Books Here</h3>
						
						<form name="list_uname_form">
							<ul data-role="listview" data-filter="true" data-filter-reveal="true" data-filter-placeholder="Search member..." data-insert="true">
								<%! ResultSet rs1; 
									String uname;
								%>
								<%
									Member_Model m = new Member_Model();
									rs1 = m.getAllMembers();
									if(rs1 != null){
										while(rs1.next()) {
										uname = rs1.getString("member_username");
								%>							
									<li><a href="#" id="uname_btn" class="ui-btn"><%= rs1.getString("member_username") %></a></li>		
								<%
										}
									}
								%>
							</ul>
						</form><br/><br/>
							
						<!-- <form name="return_books_form" > -->
							<table data-role="table" class="ui-responsive ui-shadow">
								<thead>
									<tr>
										<th>Book ID</th>
										<th>Book Name</th>
										<th>Issue Date</th>
										<th>Expected Return Date</th>
										<th>Actual Return Date</th>
										<th>Fine Amount</th>
										<th>Actions</th>
									</tr>
								</thead>
								<tbody id="unameBookTable">
									
								</tbody>
							</table>
						<!-- </form> -->
 					</div>
				</div>
			</div>
		</div>
	</body>
</html>