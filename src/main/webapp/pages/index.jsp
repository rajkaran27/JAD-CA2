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
<title>Paws &amp; Paperback</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/main.css">
</head>
<style>
body {
	/* added */
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.container {
	flex: 1;
}
</style>
<body>
<%@ include file="header.jsp"%>
	<%
	// Retrieve search results from session
	String searchResults = (String) session.getAttribute("searchResults");

	// Clear the search results from the session
	session.removeAttribute("searchResults");
	%>

	<div class="container text-center mt-3">
		<img src="${pageContext.request.contextPath}/assets/brandLogo.png"
			alt="Paws" class="img-fluid">
	</div>

	<div class="container mt-4">
		<div class="row justify-content-center">
			<div class="col-12 col-md-6">
				<form action="<%=request.getContextPath()%>/SearchBookServlet"
					method="GET" class="input-group">
					<input type="text" class="form-control form-control-lg"
						placeholder="Search by author or title" name="search">
					<div class="input-group-append">
						<button class="btn btn-primary btn-lg" type="submit">Search</button>
					</div>
				</form>
			</div>
		</div>
	</div>

	<%
	if (searchResults != null) {
	%>
	<div class="container mt-5" id="bookDisplay">
		<p class='text-center'>Click on a book to find out more!</p>
		<div class="row">
			<%=searchResults%>
		</div>
	</div>
	<%
	}
	%>


</body>
<%@ include file="footer.jsp"%>
</html>