<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="servlets.DBConnection"%>
<%
String userRole = (String) session.getAttribute("sessUserRole");
if (userRole != null) {
	if (userRole.equals("member")) {
		int member_id1 = (int) session.getAttribute("sessUserID");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout Page</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
</head>
<body>
	<%@ include file="header.jsp"%>

<%-- 	<%
	int bookCount = 0;
	double totalCost = 0;
	String title = null;
	String src = null;
	int bookId = 0;
	int quantity = 0;
	double price = 0;

	try {
		conn = DBConnection.getConnection();

		String sqlStr = "SELECT books.*, authors.author_name, categories.category_name,cart.cart_quantity FROM books JOIN authors ON books.author_id = authors.author_id JOIN categories ON books.category_id = categories.category_id JOIN cart ON books.book_id = cart.book_id WHERE cart.member_id = ?;";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);

		pstmt.setInt(1, member_id1);

		ResultSet rs = pstmt.executeQuery();

		while (rs.next()) {

			title = rs.getString("title");
			src = rs.getString("image");
			bookId = rs.getInt("book_id");
			quantity = rs.getInt("cart_quantity");
			price = rs.getDouble("price");
			totalCost = (quantity * price) + totalCost;
			bookCount += quantity;
		}
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		out.println("Error: " + e);
	} --%>
	%>

	<div class="container">
		<div class="py-5 text-center">
			<h2 class="align-start">Checkout</h2>
		</div>
		<form class="needs-validation" novalidate
			action="<%=request.getContextPath()%>/AuthorizePaymentServlet"
			method="POST">
			<div class="row">
				<div class="col-md-4 order-md-2 mb-4">
					<h4 class="d-flex justify-content-between align-items-center mb-3">
						<span class="text-muted">Summary</span>
					</h4>
					<ul class="list-group mb-3">
						<%
						int bookCount = 0;
						double totalCost = 0;
						String title = null;
						String src = null;
						int bookId = 0;
						int quantity = 0;
						double price = 0;

						try {
							conn = DBConnection.getConnection();

							String sqlStr = "SELECT books.*, authors.author_name, categories.category_name,cart.cart_quantity FROM books JOIN authors ON books.author_id = authors.author_id JOIN categories ON books.category_id = categories.category_id JOIN cart ON books.book_id = cart.book_id WHERE cart.member_id = ?;";
							PreparedStatement pstmt = conn.prepareStatement(sqlStr);

							pstmt.setInt(1, member_id1);

							ResultSet rs = pstmt.executeQuery();

							while (rs.next()) {

								title = rs.getString("title");
								src = rs.getString("image");
								bookId = rs.getInt("book_id");
								quantity = rs.getInt("cart_quantity");
								price = rs.getDouble("price");
								totalCost = (quantity * price) + totalCost;
								bookCount += quantity;
						%>
						<li
							class="list-group-item d-flex justify-content-between lh-condensed">
							<div class="d-flex align-items-center">
								<div class="flex-grow-1">
									<h6 class="my-0 text-center"><%=title%></h6>
									<small class="text-muted text-center"><%=price%></small> <input
										type="hidden" name="bookId" value="<%=bookId%>"> <input
										type="hidden" name="onePrice" value="<%=price%>"> <input
										type="hidden" name="oneQuantity" value="<%=quantity%>">
								</div>
							</div> <span class="text-muted"> <img src="<%=src%>"
								class="img-fluid rounded-3" style="width: 120px;" alt="Book">
						</span>
						</li>
						<%
						}
						conn.close();
						} catch (Exception e) {
						e.printStackTrace();
						out.println("Error: " + e);
						}
						%>
						<li class="list-group-item d-flex justify-content-between"><span>Total
								Items</span> <strong><%=bookCount%></strong> <input type="hidden"
							value="<%=bookCount%>" name="quantity"></li>
						<li class="list-group-item d-flex justify-content-between"><span>Total
								(SGD)</span> <strong>$<%=totalCost%></strong> <input type="hidden"
							name="price" value="<%=totalCost%>"></li>
					</ul>

				</div>
				<div class="col-md-8 order-md-1">
					<h4 class="mb-3">Billing address</h4>

					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="firstName">First name</label> <input type="text"
								class="form-control" id="firstName" placeholder="" value=""
								required>
							<div class="invalid-feedback">Valid first name is required.
							</div>
						</div>
						<div class="col-md-6 mb-3">
							<label for="lastName">Last name</label> <input type="text"
								class="form-control" id="lastName" placeholder="" value=""
								required>
							<div class="invalid-feedback">Valid last name is required.
							</div>
						</div>
					</div>
					<div class="mb-3">
						<label for="email">Email <span class="text-muted">(Optional)</span></label>
						<input type="email" class="form-control" id="email"
							placeholder="you@example.com">
						<div class="invalid-feedback">Please enter a valid email
							address for shipping updates.</div>
					</div>

					<div class="mb-3">
						<label for="address">Address</label> <input type="text"
							class="form-control" id="address" placeholder="1234 Main St"
							required>
						<div class="invalid-feedback">Please enter your shipping
							address.</div>
					</div>

					<div class="mb-3">
						<label for="address2">Address 2 <span class="text-muted">(Optional)</span></label>
						<input type="text" class="form-control" id="address2"
							placeholder="Apartment or suite">
					</div>

					<div class="row">
						<div class="col-md-4 mb-3">
							<label for="zip">Postal Code</label> <input type="text"
								class="form-control" id="zip" placeholder="" required>
							<div class="invalid-feedback">Postal code required.</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="phone">Phone Number</label> <input type="text"
								class="form-control" id="phone" placeholder="" required>
							<div class="invalid-feedback">Phone number required.</div>
						</div>
						<div class="col-md-4 mb-3">
							<label for="unit">Unit Number</label> <input type="text"
								class="form-control" id="unit" placeholder="" required>
							<div class="invalid-feedback">Unit number required.</div>
						</div>
					</div>

					<hr class="mb-4">
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input"
							id="same-address"> <label class="custom-control-label"
							for="same-address">Shipping address is the same as my
							billing address</label>
					</div>
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="save-info">
						<label class="custom-control-label" for="save-info">Save
							this information for next time</label>
					</div>
					<hr class="mb-4">
					<button class="btn btn-primary btn-lg btn-block" type="submit">Continue
						to payment</button>

				</div>
			</div>
		</form>
	</div>
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
