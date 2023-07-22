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
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<title>Register</title>
<style>
#registerForm {
	box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
	-webkit-box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
	-moz-box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
}
</style>
</head>
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
						<img
							src="${pageContext.request.contextPath}/assets/logo.png"
							alt="logo" width="100">
					</div>
					<div class="card shadow-lg" style="background-color: #FFFFFF">
						<div class="card-body p-5">
							<h1 class="fs-4 card-title fw-bold mb-4" style="color: #0C243C">Sign Up</h1>
							<form action="<%=request.getContextPath()%>/RegisterServlet"
								method="POST">
								<div class="mb-3">
									<label class="mb-2 text-muted" for="email">Username</label> <input
										type="text" class="form-control" required autofocus
										name="username">
								</div>
								
								<div class="mb-3">
									<label class="mb-2 text-muted" for="email">E-mail</label> <input
										type="email" class="form-control" required autofocus
										name="email">
								</div>
								
								<div class="mb-3">
									<div class="mb-2 w-100">
										<label class="text-muted" for="password">Password</label>
									</div>
									<input id="password" type="password" class="form-control"
										name="password" required>
								</div>

								<div class="d-flex align-items-center">
									<button type="submit" class="btn btn-primary ms-auto">Register</button>
								</div>
							</form>

							<%
							if (message != null) {
								if (message.equals("empty")) {
							%>
							<div class="m-3">
								<p>Do not leave any fields empty.</p>
							</div>
							<%
							}
							}
							%>

						</div>
					</div>
				</div>
			</div>
		</div>
	</section>




	<%@ include file="footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>
</html>