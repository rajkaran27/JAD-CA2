<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
/* ===========================================================
Author: Rajkaran (2109039)
Date: 9/6/2023
Description: JAD CA1
============================================================= */
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Login</title>
</head>
<style>
#loginForm {
	box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
	-webkit-box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
	-moz-box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
}
</style>
<body>
<%@ include file="header.jsp"%>


	<%
	// to check if users keyed in wrong password/username
	String message = request.getParameter("errCode");
	%>
	<section class="h-100" style="background-color: #0C243C;">
		<div class="container h-100">
			<div class="row justify-content-sm-center h-100">
				<div class="col-xxl-4 col-xl-5 col-lg-5 col-md-7 col-sm-9">
					<div class="text-center my-5">
						<img src="${pageContext.request.contextPath}/assets/logo.png"
							alt="logo" width="100">
					</div>
					<div class="card shadow-lg" style="background-color: #FFFFFF">
						<div class="card-body p-5">
							<h1 class="fs-4 card-title fw-bold mb-4" style="color: #0C243C">Admin Login</h1>
							<form action="<%=request.getContextPath()%>/AdminLoginServlet"
								method="GET">
								<div class="mb-3">
									<label class="mb-2 text-muted" for="email">Username</label> <input
										type="text" class="form-control" required autofocus
										name="loginId">
								</div>

								<div class="mb-3">
									<div class="mb-2 w-100">
										<label class="text-muted" for="password">Password</label>
									</div>
									<input id="password" type="password" class="form-control"
										name="password" required>
								</div>

								<div class="d-flex align-items-center">
									<button type="submit" class="btn btn-primary ms-auto"
										>Login</button>
								</div>
							</form>
							<%
							if (message != null && message.equals("invalidLogin")) {
							%>
							<div class="m-3" style="color:#0C243C">
								<p class="text-center">Wrong username or password. Try
									again.</p>
							</div>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<%@ include file="footer.jsp"%>

</body>
</html>