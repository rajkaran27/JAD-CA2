<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
String userRole = (String) session.getAttribute("sessUserRole");
if (userRole != null) {
	if (userRole.equals("member")) {
		int member_id1 = (int) session.getAttribute("sessUserID");
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
<title>Shopping Cart</title>
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

table tbody td, table thead th {
	color: white;
}

.card-body p, .card-body h4, .card-footer p {
	color: #0C243C;
}
</style>
<body>
	<%@ include file="header.jsp"%>

	<%
	int bookCount = 0;
	double totalCost = 0;
	List<Map<String, Object>> cartItems = new ArrayList<>();

	try {
		conn = DBConnection.getConnection();

		String sqlStr = "SELECT books.*, authors.author_name, categories.category_name,cart.cart_quantity FROM books JOIN authors ON books.author_id = authors.author_id JOIN categories ON books.category_id = categories.category_id JOIN cart ON books.book_id = cart.book_id WHERE cart.member_id = ?;";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);

		pstmt.setInt(1, member_id1);

		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {
			Map<String, Object> cartItem = new HashMap<>();
			cartItem.put("title", rs.getString("title"));
			cartItem.put("src", rs.getString("image"));
			cartItem.put("author", rs.getString("author_name"));
			cartItem.put("category", rs.getString("category_name"));
			cartItem.put("bookId", rs.getInt("book_id"));
			cartItem.put("quantity", rs.getInt("cart_quantity"));
			cartItem.put("price", rs.getDouble("price"));
			cartItems.add(cartItem);
		}
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		out.println("Error: " + e);
	}
	%>

	<%
	if (cartItems.isEmpty()) {
	%>
	<div class="container mt-5">
		<div class="row">
			<div class="offset-lg-3 col-lg-6 col-md-12 col-12 text-center">
				<img src="${pageContext.request.contextPath}/assets/bag.svg" alt=""
					class="img-fluid mb-4">
				<h2>Your shopping cart is empty</h2>
				<p class="mb-4">Keep Shopping!</p>
				<a href="home.jsp" class="btn btn-primary">Explore Books</a>
			</div>
		</div>
	</div>
	<%
	} else {
	%>
	<div class="container h-100 py-5">
		<h1 class="mb-5">Shopping Cart</h1>
		<div
			class="row d-flex justify-content-center align-items-center h-100">
			<div class="col-lg-8 col-xl-9">
				<div class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th scope="col" class="h5">Books</th>
								<th scope="col">Category</th>
								<th scope="col">Quantity</th>
								<th scope="col">Price</th>
								<th scope="col">Status</th>
							</tr>
						</thead>
						<tbody>
							<%
							for (Map<String, Object> cartItem : cartItems) {
								String title = (String) cartItem.get("title");
								String src = (String) cartItem.get("src");
								String author = (String) cartItem.get("author");
								String category = (String) cartItem.get("category");
								int bookId = (int) cartItem.get("bookId");
								int quantity = (int) cartItem.get("quantity");
								double price = (double) cartItem.get("price");
								totalCost = (quantity * price) + totalCost;
								bookCount += quantity;
							%>
							<tr>
								<th scope="row">
									<div class="d-flex align-items-center">
										<img src="<%=src%>" class="img-fluid rounded-3"
											style="width: 120px;" alt="Book">
										<div class="flex-column ms-4">
											<p class="mb-2" style="color: #FDF4E3;">
												<%=title%>
											</p>
											<p class="mb-0" style="color: #FDF4E3;">
												<%=author%>
											</p>
										</div>
									</div>
								</th>
								<td class="align-middle">
									<p class="mb-0" style="font-weight: 500;">
										<%=category%>
									</p>
								</td>
								<td class="align-middle">
									<p class="mb-0" style="font-weight: 500;">
										<input type="number"  min="1"
											class="form-control" style="max-width: 80px;"
											value="<%=quantity%>"
											 />

									</p>
								</td>
								<td class="align-middle">
									<p class="mb-0" style="font-weight: 500;">
										$<span id="bookCost_<%=bookId%>" data-price="<%=price%>">
											<%=String.format("%.2f", (quantity * price))%>
										</span>
									</p>
								</td>
								<td class="align-middle"><a
									class="btn btn-danger btn-sm delete-button"
									onclick="confirmDelete(<%=bookId%>)"> Delete </a></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</div>

			<div class="col-lg-4 col-xl-3">
				<div class="card">
					<div class="card-body">
						<div class="d-flex justify-content-between"
							style="font-weight: 500;">
							<p class="mb-2">Total Books:</p>
							<p class="mb-2"><%=bookCount%></p>
						</div>
						<hr class="my-4">
						<div class="d-flex justify-content-between mb-4"
							style="font-weight: 500;">
							<p class="mb-2">Total Cost:</p>
							<p class="mb-2" id="totalCost">
								$<%=String.format("%.2f", totalCost)%>
							</p>
						</div>
						<button type="button" class="btn btn-primary btn-block btn-lg ">
							<div class="d-flex justify-content-end">
								<a href="checkout.jsp">Checkout</a>
							</div>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	%>

	<script>
        function confirmDelete(bookId) {
            var memberId = <%= member_id1 %>;
            if (confirm("Are you sure you want to delete this item?")) {
                window.location.href = "<%=request.getContextPath()%>/RemoveFromCartServlet?bookId=" + bookId +"&memberId="+memberId;
            }
        }
    </script>
	<%@ include file="footer.jsp"%>
</body>
</html>
<%
} else {
response.sendRedirect("login.jsp?errCode=accessDenied");
}
} else {
response.sendRedirect("login.jsp?errCode=accessDenied");
}
%>
