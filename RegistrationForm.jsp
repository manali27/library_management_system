<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="css/jquery.mobile-1.4.2.min.css" />
		<script src="js/jquery-2.1.3.min.js"></script>
		<script src="js/jquery.mobile-1.4.2.min.js"></script>
		<script type="text/javascript" src="js/jquery.inputmask.js"></script>
		<script type="text/javascript">
		$( document ).ready(function() { 
		
			$("#phno").focus(function(){
				$("#phno").inputmask("9999999999");     
			});
		
			$( "#registration_form" ).submit(function(){
				var fname = $.trim($('#fname').val());
				var lname = $.trim($('#lname').val());
				var email = $.trim($('#email').val());
				var phno = $.trim($('#phno').val());
				var uname = $.trim($('#username').val());
				var pswd = $.trim($('#password').val());
				var cpswd = $.trim($('#cpassword').val());
				
				var validate = 0;
				var error="";
				
				if (fname  === '') {
					validate = 1;
					error+="<p>First Name cannot be empty</p>";
				}
				if (lname  === '') {
					validate = 1;
					error+="<p>Last Name cannot be empty</p>";
				}
				if (email  === '') {
					validate = 1;
					error+="<p>Email cannot be empty</p>";
				}
				if (phno  === '') {
					validate = 1;
					error+="<p>Phone Number cannot be empty</p>";
				}
				if (uname  === '') {
					validate = 1;
					error+="<p>Username cannot be empty</p>";
				}
				if (pswd  === '') {
					validate = 1;
					error+="<p>Password cannot be empty</p>";
				}
				if (cpswd  === '') {
					validate = 1;
					error+="<p>Confirm Password cannot be empty</p>";
				}
				if(!(pswd === cpswd)) {
					validate = 1;
					error+="<p>Password Mismatch</p>";
				}
				if(validate == 1){
					$( "#jsvalidation" ).html(error);
					$( "#jsvalidation" ).popup( "open",{transition:"flip"});
					return false;
				}
				
			});

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
						<h3>Create Your Account</h3>

						<form name="registration_form" id="registration_form" action="RegistrationServlet" data-ajax="false">
							<label for="fname" class="ui-hidden-accessible">First Name:</label>
							<input type="text" name="fname" id="fname" placeholder="First Name" />
							
							<label for="lname" class="ui-hidden-accessible">Last Name:</label>
							<input type="text" name="lname" id="lname" placeholder="Last Name" />
					
							<label for="email" class="ui-hidden-accessible">Email Address:</label>
							<input type="email" name="email" id="email" placeholder="Email Address" />
					
							<label for="phno" class="ui-hidden-accessible">Phone Number:</label>
							<input type="tel" name="phno" id="phno" placeholder="Phone Number" />
		
							<label for="username" class="ui-hidden-accessible">Username:</label>
							<input type="text" name="username" id="username" placeholder="Username" />
					
							<label for="password" class="ui-hidden-accessible">Password:</label>
							<input type="password" name="password" id="password" placeholder="Password" />
						
							<label for="cpassword" class="ui-hidden-accessible">Confirm Password:</label>
							<input type="password" name="cpassword" id="cpassword" placeholder="Re-Type Your Password" /><br/>
					
							<button type="submit" class="ui-btn ui-icon-arrow-r ui-btn-icon-right ui-corner-all ui-shadow">Create Account</button>
						</form>
					</div>
				</div>
			</div>			
			<div data-role="popup" style="color:red" id="jsvalidation">
				
			</div>
		</div>
	</body>
</html>