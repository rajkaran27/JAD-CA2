<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%
String userRole = (String) session.getAttribute("sessUserRole");

if (userRole != null) {
	if (userRole.equals("owner")) {
%>

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
<title>Admin Page</title>
</head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/adminBook.css">

<body>
	<%@ include file="header.jsp"%>
	<%
	String message = request.getParameter("errCode");

	if (message != null) {
		if (message.equals("updated")) {
	%>
	<script>
	alert("Book Updated Succesfully!")
	</script>
	<%
	} else if (message.equals("added")) {
	%>
	<script>
	alert("Book Added Succesfully!")
	</script>

	<%
	}
	}
	%>
	<div class="container">
		<h1>Book Shelf</h1>

		<div class="card my-4" style="background-color: #0C243C;">
			<div class="card-header h2">Add a new Book</div>
			<div class="card-body">
				<form action="<%=request.getContextPath()%>/AddBookServlet"
					method="POST">
					<div class="mb-3">
						<label for="imageLink" class="form-label">Image Link</label> <input
							type="text" class="form-control" id="imageLink" name="src"
							placeholder="Enter image link" required>
					</div>

					<div class="mb-3">
						<label for="title" class="form-label">Title of Book</label> <input
							class="form-control" id="description" name="title" rows="3"
							placeholder="Enter title" type="text" required></input>
					</div>

					<div class="mb-3">
						<label for="description" class="form-label">Description</label>s
						<textarea class="form-control" id="description" name="desc"
							rows="3" placeholder="Enter description" required></textarea>
					</div>

					<div class="row mb-3">
						<div class="col">
							<label for="price" class="form-label">Price</label> <input
								type="number" class="form-control" id="price" name="price"
								placeholder="Enter price" step=".01" required>
						</div>
						<div class="col">
							<label for="isbn" class="form-label">ISBN</label> <input
								type="text" class="form-control" id="isbn" name="isbn"
								placeholder="Enter ISBN" required>
						</div>
					</div>

					<div class="row mb-3">
						<div class="col">
							<label for="quantity" class="form-label">Quantity</label> <input
								type="number" class="form-control" id="quantity" name="quantity"
								placeholder="Enter quantity" required>
						</div>
						<div class="col">
							<label for="rating" class="form-label">Rating</label> <input
								type="number" class="form-control" id="rating" name="rating"
								placeholder="Enter rating" required>
						</div>
					</div>

					<div class="mb-3">
						<label for="publicationDate" class="form-label">Publication
							Date</label> <input type="text" class="form-control" id="pubDate"
							name="pubDate" required> <small>Please enter the
							date in this format (e.g. 17 March 2009)</small>
					</div>


					<div class="mb-3">
						<label for="category" class="form-label">Category</label> <select
							class="form-select" id="category" name="category">
							<option value="" selected disabled>Select category</option>
							<%
							// Category dynamic listing

							try {

								// Step 1: Load JDBC Driver
								Class.forName("com.mysql.cj.jdbc.Driver");

								// Step 2: Define Connection URL
								String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

								// Step 3: Establish connection to URL
								Connection conn = DriverManager.getConnection(connURL);

								// Step 4: Create Statement object
								Statement stmt = conn.createStatement();

								// Step 5: Execute SQL Command
								String sqlStr = "SELECT * from categories";
								ResultSet rs = stmt.executeQuery(sqlStr);

								while (rs.next()) {
									int category_id = rs.getInt("category_id");
									String category = rs.getString("category_name");
							%>
							<option value="<%=category_id%>"><%=category%></option>
							<%
							}

							// Step 7: Close connection
							conn.close();
							} catch (Exception e) {
							out.println("Error :" + e);
							}
							%>
						</select>
					</div>

					<div class="mb-3">
						<label for="author" class="form-label">Author</label> <select
							class="form-select" id="author" name="author">
							<option value="" selected disabled>Select author</option>
							<%
							// Author dynamic listing

							try {

								// Step 1: Load JDBC Driver
								Class.forName("com.mysql.cj.jdbc.Driver");

								// Step 2: Define Connection URL
								String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

								// Step 3: Establish connection to URL
								Connection conn = DriverManager.getConnection(connURL);

								// Step 4: Create Statement object
								Statement stmt = conn.createStatement();

								// Step 5: Execute SQL Command
								String sqlStr = "SELECT * from authors";
								ResultSet rs = stmt.executeQuery(sqlStr);

								while (rs.next()) {
									int author_id = rs.getInt("author_id");
									String author = rs.getString("author_name");
							%>
							<option value="<%=author_id%>"><%=author%></option>
							<%
							}

							// Step 7: Close connection
							conn.close();
							} catch (Exception e) {
							out.println("Error :" + e);
							}
							%>
						</select>
					</div>

					<div class="mb-3">
						<label for="publisher" class="form-label">Publisher</label> <select
							class="form-select" id="publisher" name="publisher">
							<option value="" selected disabled>Select publisher</option>
							<%
							// Publisher dynamic listing

							try {

								// Step 1: Load JDBC Driver
								Class.forName("com.mysql.cj.jdbc.Driver");

								// Step 2: Define Connection URL
								String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

								// Step 3: Establish connection to URL
								Connection conn = DriverManager.getConnection(connURL);

								// Step 4: Create Statement object
								Statement stmt = conn.createStatement();

								// Step 5: Execute SQL Command
								String sqlStr = "SELECT * from publishers";
								ResultSet rs = stmt.executeQuery(sqlStr);

								while (rs.next()) {
									int publisher_id = rs.getInt("publisher_id");
									String publisher = rs.getString("publisher_name");
							%>
							<option value="<%=publisher_id%>"><%=publisher%></option>
							<%
							}

							// Step 7: Close connection
							conn.close();
							} catch (Exception e) {
							out.println("Error :" + e);
							}
							%>
						</select>
					</div>

					<button type="submit" class="btn btn-primary">Add Book</button>
				</form>
			</div>
		</div>


		<div>
			<h2>Modify Existing Books</h2>
			<table class="table">
				<thead>
					<tr>
						<th>Title</th>
						<th>Author</th>
						<th>Quantity</th>
						<th>Options</th>
					</tr>
				</thead>
				<tbody>
					<%
					// Books dynamic listing

					try {
						// Step 1: Load JDBC Driver
						Class.forName("com.mysql.cj.jdbc.Driver");

						// Step 2: Define Connection URL
						String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

						// Step 3: Establish connection to URL
						Connection conn = DriverManager.getConnection(connURL);

						// Step 4: Create Statement object
						Statement stmt = conn.createStatement();

						// Step 5: Execute SQL Command
						String sqlStr = "SELECT books.book_id,books.title,books.quantity,authors.author_name FROM books JOIN authors ON authors.author_id=books.author_id;";
						ResultSet rs = stmt.executeQuery(sqlStr);

						// Step 6: Process Result
						while (rs.next()) {
							String title = rs.getString("title");
							String author = rs.getString("author_name");
							int quantity = rs.getInt("quantity");
							int bookId = rs.getInt("book_id");
					%>
					<tr>
						<td><%=title%></td>
						<td><%=author%></td>
						<td><%=quantity%></td>
						<td><a class="btn btn-primary btn-sm update-button"
							href="updateBook.jsp?bookId=<%=bookId%>">Update</a> <a
							class="btn btn-danger btn-sm delete-button"
							onclick="confirmDelete(<%=bookId%>)">Delete</a></td>
					</tr>
					<%
					}

					// Step 7: Close connection
					conn.close();
					} catch (Exception e) {
					out.println("Error :" + e);
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

	</div>


	<script>
	//to delete book confirmation.
		function confirmDelete(bookId) {
		  if (confirm("Are you sure you want to delete this book?")) {
		    window.location.href = "<%=request.getContextPath()%>/DeleteBookServlet?bookId=" + bookId;
		  }
		}		
	</script>

	<%@ include file="footer.jsp"%>
</body>
</html>
<%
// send them back if they are not owner
} else {
response.sendRedirect("login.jsp?errCode=accessDenied");
}
} else {
response.sendRedirect("login.jsp?errCode=accessDenied");
}
%>
