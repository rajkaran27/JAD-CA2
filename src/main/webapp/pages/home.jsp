<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
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
				<div class="col-6 col-sm-3 mb-4">
					<img src="bestseller_book1.jpg" alt="Bestseller Book 1"
						class="img-fluid">
					<p>Book Title 1</p>
					<p>Author Name 1</p>
				</div>
				<div class="col-6 col-sm-3 mb-4">
					<img src="bestseller_book2.jpg" alt="Bestseller Book 2"
						class="img-fluid">
					<p>Book Title 2</p>
					<p>Author Name 2</p>
				</div>
				<div class="col-6 col-sm-3 mb-4">
					<img src="bestseller_book3.jpg" alt="Bestseller Book 3"
						class="img-fluid">
					<p>Book Title 3</p>
					<p>Author Name 3</p>
				</div>
				<div class="col-6 col-sm-3 mb-4">
					<img src="bestseller_book4.jpg" alt="Bestseller Book 4"
						class="img-fluid">
					<p>Book Title 4</p>
					<p>Author Name 4</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Fiction Section -->
	<div id="fiction" class="mt-5">
		<div class="container text-center">
			<h3 class="text-center mb-4 border-bottom">Fiction</h3>
			<div class="row">
				<!-- Replace the example book covers and details with actual book data -->
				<div class="col-6 col-sm-3 mb-4">
					<img src="fiction_book1.jpg" alt="Fiction Book 1" class="img-fluid">
					<p>Book Title 1</p>
					<p>Author Name 1</p>
				</div>
				<div class="col-6 col-sm-3 mb-4">
					<img src="fiction_book2.jpg" alt="Fiction Book 2" class="img-fluid">
					<p>Book Title 2</p>
					<p>Author Name 2</p>
				</div>
				<div class="col-6 col-sm-3 mb-4">
					<img src="fiction_book3.jpg" alt="Fiction Book 3" class="img-fluid">
					<p>Book Title 3</p>
					<p>Author Name 3</p>
				</div>
				<div class="col-6 col-sm-3 mb-4">
					<img src="fiction_book4.jpg" alt="Fiction Book 4" class="img-fluid">
					<p>Book Title 4</p>
					<p>Author Name 4</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Non-Fiction Section -->
	<div id="nonfiction" class="mt-5">
		<div class="container text-center">
			<h3 class="container text-center border-bottom">Non-Fiction</h3>
			<div class="row">
				<!-- Replace the example book covers and details with actual book data -->
				<div class="col-6 col-sm-3 mb-4">
					<img src="nonfiction_book1.jpg" alt="Non-Fiction Book 1"
						class="img-fluid">
					<p>Book Title 1</p>
					<p>Author Name 1</p>
				</div>
				<div class="col-6 col-sm-3 mb-4">
					<img src="nonfiction_book2.jpg" alt="Non-Fiction Book 2"
						class="img-fluid">
					<p>Book Title 2</p>
					<p>Author Name 2</p>
				</div>
				<div class="col-6 col-sm-3 mb-4">
					<img src="nonfiction_book3.jpg" alt="Non-Fiction Book 3"
						class="img-fluid">
					<p>Book Title 3</p>
					<p>Author Name 3</p>
				</div>
				<div class="col-6 col-sm-3 mb-4">
					<img src="nonfiction_book4.jpg" alt="Non-Fiction Book 4"
						class="img-fluid">
					<p>Book Title 4</p>
					<p>Author Name 4</p>
				</div>
			</div>
		</div>
	</div>




</body>
<%@ include file="footer.jsp"%>
</html>