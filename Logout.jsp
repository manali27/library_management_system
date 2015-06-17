 <%
	HttpSession hs = request.getSession();
	hs.invalidate();
	response.sendRedirect("LoginForm.jsp");
 %>