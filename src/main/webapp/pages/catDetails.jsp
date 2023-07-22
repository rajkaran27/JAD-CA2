<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<title>Search By Category</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/index.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/main.css">
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
	<%@ include file="header.jsp"%>
	<%
	String genreName = "";
	String catId = request.getParameter("catId");
	int cat_id = 0;
	if (catId != null) {
		cat_id = Integer.parseInt(catId);
	} else {
		out.print("error");
	}
	try {
		StringBuilder htmlBuilder = new StringBuilder();

		// Step 1: Load JDBC Driver
		Class.forName("com.mysql.cj.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		String genreSqlStr = "SELECT category_name FROM categories WHERE category_id = ?;";
		PreparedStatement genrePstmt = conn.prepareStatement(genreSqlStr);
		genrePstmt.setInt(1, cat_id);
		ResultSet genreRs = genrePstmt.executeQuery();

		//  Retrieve genre name
		if (genreRs.next()) {
			genreName = genreRs.getString("category_name");
		}

		// Step 4: Create PreparedStatement object
		String sqlStr = "SELECT books.*, categories.category_name, categories.category_id FROM books JOIN categories ON books.category_id = categories.category_id WHERE categories.category_id = ?;";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		// Set parameter values for placeholders
		pstmt.setInt(1, cat_id);
		// Step 5: Execute SQL query
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		while (rs.next()) {
			String title = rs.getString("title");
			String src = rs.getString("image");
			String category = rs.getString("category_name");
			double price = rs.getDouble("price");
			int bookId = rs.getInt("book_id");

			htmlBuilder.append("<div class='col-md-4 mb-4'>")
		    .append("<div class='card' style='border-radius:10px;'>")
		    .append("<a href='bookDetails.jsp?bookId=").append(bookId).append("'>")
		    .append("<img src='").append(src).append("' class='card-img-top' alt='Book Image' style='height:600px;' />")
		    .append("</a>")
		    .append("<div class='card-body'>")
		    .append("<div class='text-center'>")
		    .append("<a href='bookDetails.jsp?bookId=").append(bookId).append("' style='text-decoration: none; color:#0C243C;'>")
		    .append("<h4 class='card-title fw-bold'>").append(title).append("</h4>")
		    .append("</a>")
		    .append("</div>")
		    .append("<p class='text-center mb-2' style='text-decoration: none; color:#0C243C;'>").append(category).append(" | S$").append(price).append("</p>")
		    .append("</div>")
		    .append("</div>")
		    .append("</div>");

		}

		session.setAttribute("searchResults", htmlBuilder.toString());

		// Close connection
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		out.println("Error: " + e);
	}
	%>
	<%
	// Retrieve search results from session
	String searchResults = (String) session.getAttribute("searchResults");

	// Clear the search results from the session
	session.removeAttribute("searchResults");
	%>
	<div class="container mt-5" id="bookDisplay">
		<div class="container text-center mt-3">
			<h1><%=genreName%></h1>
		</div>
		<div class="row">
			<%=searchResults%>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>