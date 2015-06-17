<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="css/jquery.mobile-1.4.2.min.css" />
		<script src="js/jquery-2.1.3.min.js"></script>
		<script src="js/jquery.mobile-1.4.2.min.js"></script>
		<script type="text/javascript">
		$( document ).ready(function() { 
			$( "#login_form" ).submit(function(){
				var username = $.trim($('#username').val());
				var password = $.trim($('#password').val());
				
				var validate = 0;
				var error="";
				
				if (username  === '') {
					validate = 1;
					error+="<p>Username cannot be empty</p>";
				}
				if (password  === '') {
					validate = 1;
					error+="<p>Password cannot be empty</p>";
				}
				if(validate == 1){
					$( "#jsvalidation" ).html(error);
					$( "#jsvalidation" ).popup( "open",{transition:"flip"});
					return false;
				}
				
			});

		});
		$( window ).load(function() {
		  <%
			if(session.getAttribute("status") != null){
			%>
				$( "#jspvalidation" ).popup( "open",{transition:"flip"});
			<%
				}
			%>
		});
		</script>
	</head>
	<body>
		<div data-role="page" data-theme="a">
			<div data-role="header">
				<h1 style="font-family: 'Times New Roman', Times, serif; font-size: 30px;">Library Management System</h1>
			</div>
			<div data-role="main" class="ui-content">
				<div class="ui-grid-b">
					<div class="ui-block-a"></div>
					<div class="ui-block-b">
						<h3>Login Here</h3>
						
						<form name="login_form" id="login_form"  action="LoginServlet"  data-ajax="false">							
							<label for="username" class="ui-hidden-accessible">Username:</label>
							<input type="text" name="username" id="username" placeholder="Username" />
							
							<label for="password" class="ui-hidden-accessible">Password:</label>
							<input type="password" name="password" id="password" placeholder="Password" /><br/>
							
							<button type="submit" class="ui-btn ui-icon-arrow-r ui-btn-icon-right ui-corner-all ui-shadow">Login</button>
						</form>
						<p style="border-top: 4px solid #ACACAC; font-size: 14px; margin: 30px 0 100px; padding-top: 15px;">
							Don't have an account yet?
							<a href="RegistrationForm.jsp" data-ajax="false" style="float: right;">Create Account</a>
						</p>
					</div>
				</div>
			</div>
			<div data-role="popup" style="color:red" id="jsvalidation">
				
			</div>

			<%
                if(session.getAttribute("status") != null){
            %>
            <div data-role="popup" style="color:red" id="jspvalidation">
				<%= session.getAttribute("status") %>
			</div>
            <%
				session.setAttribute("status",null);
                }
            %>		
		</div>
	</body>
</html>