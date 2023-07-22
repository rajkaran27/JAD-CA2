<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="header.jsp"%>
<%@page import="java.sql.*"%>
<%
/* ===========================================================
Author: Pranjal (2228396)
Date: 9/6/2023
Description: JAD CA1
============================================================= */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Kitty Reads Category</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/main.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/category.css">
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
</head>
<body>
	<%
	try {
		StringBuilder htmlBuilder = new StringBuilder();

		// Step 1: Load JDBC Driver
		Class.forName("com.mysql.cj.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 4: Create PreparedStatement object
		String sqlStr = "SELECT * FROM bookstore.categories;";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);

		// Step 5: Execute SQL query
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		while (rs.next()) {
			String category = rs.getString("category_name");
			int catId = rs.getInt("category_id");

			htmlBuilder.append("<a href='catDetails.jsp?catId=").append(catId).append("' class='category-button'>")
			.append(category).append("</a>");
		}

		session.setAttribute("categoryButtons", htmlBuilder.toString());

		// Close connection
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		out.println("Error: " + e);
	}
	%>

	<div class="container text-center mt-3">
		<img src="${pageContext.request.contextPath}/assets/brandLogo.png"
			alt="Paws" class="img-fluid">
	</div>
	<%
	// Retrieve category buttons from session
	String categoryButtons = (String) session.getAttribute("categoryButtons");

	// Clear the category buttons from the session
	session.removeAttribute("categoryButtons");
	%>
	<div class="container mt-5" id="categoryDisplay">
		<%=categoryButtons%>
	</div>

</body>
<%@ include file="footer.jsp"%>
</html>