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
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">

<style>
#loginForm {
	box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
	-webkit-box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
	-moz-box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
}
</style>

</head>
<body>
	<%@ include file="header.jsp"%>


	<%
	
	
	
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
							<h1 class="fs-4 card-title fw-bold mb-4" style="color: #0C243C">Login</h1>
							<form action="<%=request.getContextPath()%>/LoginServlet"
								method="POST">
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
									<button type="submit" class="btn btn-primary ms-auto">Login</button>
								</div>
							</form>

							<%
							if (message != null) {
								if (message.equals("invalidLogin")) {
							%>
							<div class="m-3" style="color: #0C243C">
								<p class="text-center">Wrong username or password. Try
									again.</p>
							</div>
							<%
							} else if (message.equals("accessDenied")) {
							%>
							<div class="m-3" style="color: #0C243C">
								<p class="text-center">Access Denied.</p>
							</div>
							<%
							} else if (message.equals("registered")) {
							%>
							<div class="m-3" style="color: #0C243C">
								<p class="text-center">You have joined the kittens!</p>
							</div>
							<%
							}
							}
							%>


						</div>
						<div class="card-footer py-3 border-0">
							<div class="text-center" style="color: #0C243C">
								Don't have an account? <a href="register.jsp" class="text-dark">Create
									One</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


	<%@ include file="footer.jsp"%>
</body>
</html>