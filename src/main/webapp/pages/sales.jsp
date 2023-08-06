<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%
/* ===========================================================
Author: Pranjal (2228396)
Date: 6/8/2023
Description: JAD CA2
============================================================= */
%>
<%
String userRole = (String) session.getAttribute("sessUserRole");

if (userRole != null) {
	if (userRole.equals("owner")) {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Report</title>
<style>
.sales-box {
	border: 1px solid #ccc;
	padding: 20px;
	margin: 10px;
	min-height: 150px;
}

img {
	height: 150px;
}

.table td {
	vertical-align: middle;
}
</style>
</head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/adminBook.css">
<body>
	<%@ include file="header.jsp"%>
	<div class="container">
		<div style="border: 1px solid #ccc; padding: 20px;">
			<h1>Sales Management</h1>
			<hr>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="sales-box">
					<h3>Recent Orders</h3>
					<hr>
					<div class="card">
						<div class="card-header">
							<div class="row">
								<%
								try {
									conn = DBConnection.getConnection();

									// Step 4: Create Statement object
									Statement stmt = conn.createStatement();

									// Step 5: Execute SQL Command
									String sqlStr = "SELECT member_id, order_date, order_id FROM orders WHERE order_date = (SELECT MAX(order_date) FROM orders);";
									PreparedStatement pstmt = conn.prepareStatement(sqlStr);
									ResultSet rs = pstmt.executeQuery();

									// Step 6: Process Result
									while (rs.next()) {
										String date = rs.getString("order_date");
										String order_id = rs.getString("order_id");
										int memberId = rs.getInt("member_id");
										/* conn = DBConnection.getConnection(); */

										// Step 4: Create Statement object
										Statement stmt2 = conn.createStatement();

										// Step 5: Execute SQL Command
										String sqlStr2 = "SELECT members.email, members.firstname AS name FROM orders JOIN members ON orders.member_id = members.member_id WHERE orders.member_id = ?;";
										PreparedStatement pstmt2 = conn.prepareStatement(sqlStr2);
										pstmt2.setInt(1, memberId);
										ResultSet rs2 = pstmt2.executeQuery();

										// Step 6: Process Result
										if (rs2.next()) {
									String email = rs2.getString("email");
									String name = rs2.getString("name");
								%>
								<div class="col-md-6">
									<h5 class="text-start" style="color: black;">
										MemberID:
										<%=memberId%></h5>
									<p class="text-start" style="color: black;">
										Member name:
										<%=name%></p>
									<p class="text-start" style="color: black;">
										Member email:
										<%=email%></p>
								</div>
								<div class="col-md-6">
									<h5 class="text-end" style="color: black;">
										Date&Time:
										<%=date%></h5>
								</div>

								<div class="card-body">
									<table class="table">
										<thead>
											<tr>
												<th scope="col">Image</th>
												<th scope="col">Title</th>
												<th scope="col">Quantity</th>
												<th scope="col">Price</th>
											</tr>
										</thead>
										<tbody>
											<%
											// Step 4: Create Statement object
											Statement stmt3 = conn.createStatement();

											// Step 5: Execute SQL Command
											String sqlStr3 = "SELECT b.image AS book_image_link, b.title AS book_title, oi.quantity AS quantity, b.price AS price FROM orders o JOIN orderitem oi ON o.order_id = oi.order_id JOIN books b ON oi.book_id = b.book_id WHERE o.order_id = ?;";
											PreparedStatement pstmt3 = conn.prepareStatement(sqlStr3);
											pstmt3.setString(1, order_id);
											ResultSet rs3 = pstmt3.executeQuery();
											while (rs3.next()) {
												String book_image = rs3.getString("book_image_link");
												String title = rs3.getString("book_title");
												int quantity = rs3.getInt("quantity");
												double price = rs3.getDouble("price");
												double total_price = 0;
												total_price = total_price + price;
											%>
											<tr>
												<td><img src="<%=book_image%>" alt="Book Image"></td>
												<td><%=title%></td>
												<td><%=quantity%></td>
												<td><%=price%></td>
											</tr>
											<%
											}
											}
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
								<div class="card-footer">
									<div class="row">
										<div class="col-md-6 offset-md-6">
											<h5 class="text-end" style="color: black;">
												Total Cost: $<%=session.getAttribute("total_price")%></h5>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="sales-box">
					<h3>Top 10 Customers by Purchase Value</h3>
					<hr>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>Customer ID</th>
								<th>Customer Name</th>
								<th>Purchase Value</th>
							</tr>
						</thead>
						<tbody>
							<%
							try {
								conn = DBConnection.getConnection();

								// Step 4: Create Statement object
								Statement stmt = conn.createStatement();

								// Step 5: Execute SQL Command
								String sqlStr = "SELECT m.firstname AS name, o.member_id, o.total FROM orders o JOIN members m ON o.member_id = m.member_id ORDER BY o.total DESC;";
								PreparedStatement pstmt = conn.prepareStatement(sqlStr);
								ResultSet rs = pstmt.executeQuery(sqlStr);

								// Step 6: Process Result
								while (rs.next()) {
									double total = rs.getDouble("total");
									String name = rs.getString("name");
									int memberId = rs.getInt("member_id");
							%>
							<tr>
								<td><%=memberId%></td>
								<th><%=name%></th>
								<td><%=total%></td>
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