<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@ page import="servlets.DBConnection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
</head>
<body>
	<%@ include file="header.jsp"%>

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


	<!-- Best Sellers Section -->
	<div id="bestseller" class="mt-5">
		<div class="container text-center">
			<h3 class="text-center mb-4 border-bottom">Best Sellers</h3>
			<div class="row">
				<%
				
				try {
					conn = DBConnection.getConnection();

					String sqlStr = "SELECT books.*, authors.author_name, categories.category_name FROM books JOIN authors ON books.author_id = authors.author_id JOIN categories ON books.category_id = categories.category_id ORDER BY purchased DESC LIMIT 4;";
					PreparedStatement pstmt = conn.prepareStatement(sqlStr);

					ResultSet rs = pstmt.executeQuery();

					while (rs.next()) {

						String title = rs.getString("title");
						String src = rs.getString("image");
						String author = rs.getString("author_name");
						String category = rs.getString("category_name");
						int bookId = rs.getInt("book_id");
				%>
				<div class="col-6 col-sm-3 mb-4">
					<a href='bookDetails.jsp?bookId=<%=bookId%>'
						style="text-decoration: none;">
						<div class='card' style='border-radius: 15px; width: 20rem;'>
							<div class='bg-image'>
								<img src='<%=src%>'
									style='border-top-left-radius: 15px; border-top-right-radius: 15px;'
									class='img-fluid' alt='Book Image' />
							</div>
							<div class='card-body pb-0'>
								<div
									class='d-flex justify-content-between align-items-end pb-2 mb-1'>
									<p style="color: black"><%=title%></p>
									<p style="color: black"><%=author%></p>
								</div>
							</div>
						</div>
					</a>
				</div>
				<%
				}
				conn.close();
				} catch (Exception e) {
				e.printStackTrace();
				out.println("Error: " + e);
				}
				%>

			</div>
		</div>
	</div>

	<!-- Fiction Section -->
	<div id="fiction" class="mt-5">
		<div class="container text-center">
			<h3 class="text-center mb-4 border-bottom">Fiction</h3>
			<div class="row">
				<%
				try {
					conn = DBConnection.getConnection();

					String sqlStr = "SELECT books.*, authors.author_name, categories.category_name FROM books JOIN authors ON books.author_id = authors.author_id JOIN categories ON books.category_id = categories.category_id WHERE categories.category_id=1;";
					PreparedStatement pstmt = conn.prepareStatement(sqlStr);

					ResultSet rs = pstmt.executeQuery();

					while (rs.next()) {

						String title = rs.getString("title");
						String src = rs.getString("image");
						String author = rs.getString("author_name");
						String category = rs.getString("category_name");
						int bookId = rs.getInt("book_id");
				%>
				<div class="col-6 col-sm-3 mb-4">
					<a href='bookDetails.jsp?bookId=<%=bookId%>'
						style="text-decoration: none;">
						<div class='card' style='border-radius: 15px; width: 20rem;'>
							<div class='bg-image'>
								<img src='<%=src%>'
									style='border-top-left-radius: 15px; border-top-right-radius: 15px;'
									class='img-fluid' alt='Book Image' />
							</div>
							<div class='card-body pb-0'>
								<div
									class='d-flex justify-content-between align-items-end pb-2 mb-1'>
									<p style="color: black"><%=title%></p>
									<p style="color: black"><%=author%></p>
								</div>
							</div>
						</div>
					</a>
				</div>
				<%
				}
				conn.close();
				} catch (Exception e) {
				e.printStackTrace();
				out.println("Error: " + e);
				}
				%>
			</div>
		</div>
	</div>

	<!-- Non-Fiction Section -->
	<div id="nonfiction" class="mt-5">
		<div class="container text-center">
			<h3 class="container text-center border-bottom">Horror</h3>
			<div class="row">
				<%
				try {
					conn = DBConnection.getConnection();

					String sqlStr = "SELECT books.*, authors.author_name, categories.category_name FROM books JOIN authors ON books.author_id = authors.author_id JOIN categories ON books.category_id = categories.category_id WHERE categories.category_id=8;";
					PreparedStatement pstmt = conn.prepareStatement(sqlStr);

					ResultSet rs = pstmt.executeQuery();

					while (rs.next()) {

						String title = rs.getString("title");
						String src = rs.getString("image");
						String author = rs.getString("author_name");
						String category = rs.getString("category_name");
						int bookId = rs.getInt("book_id");
				%>
				<div class="col-6 col-sm-3 mb-4">
					<a href='bookDetails.jsp?bookId=<%=bookId%>'
						style="text-decoration: none;">
						<div class='card' style='border-radius: 15px; width: 20rem;'>
							<div class='bg-image'>
								<img src='<%=src%>'
									style='border-top-left-radius: 15px; border-top-right-radius: 15px;'
									class='img-fluid' alt='Book Image' />
							</div>
							<div class='card-body pb-0'>
								<div
									class='d-flex justify-content-between align-items-end pb-2 mb-1'>
									<p style="color: black"><%=title%></p>
									<p style="color: black"><%=author%></p>
								</div>
							</div>
						</div>
					</a>
				</div>
				<%
				}
				conn.close();
				} catch (Exception e) {
				e.printStackTrace();
				out.println("Error: " + e);
				}
				%>
			</div>
		</div>
	</div>



	<%@ include file="footer.jsp"%>
</body>
</html>