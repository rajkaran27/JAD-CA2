<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="servlets.DBConnection"%>
<%
/* ===========================================================
Author: Pranjal (2228396)
Date: 9/6/2023
Description: JAD CA1
============================================================= */
%>
<%
String userRole = (String) session.getAttribute("sessUserRole");

String strmemberId = request.getParameter("memberId");
int memberId = Integer.parseInt(strmemberId);
String email = "";
String username = "";
String password = "";
if (userRole != null) {
	if (userRole.equals("member")) {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Member Information</title>
</head>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/adminBook.css">
<style>
img {
	height: 300px;
}
</style>
<body>
	<%@ include file="header.jsp"%>


	<div class="container">
		<%
		try {

			conn = DBConnection.getConnection();
			String sqlStr = "SELECT email, username, password FROM members WHERE members.member_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			// Set parameter values for placeholders
			pstmt.setString(1, strmemberId);

			// Step 5: Execute SQL query
			ResultSet rs = pstmt.executeQuery();

			// Step 6: Process Result
			while (rs.next()) {
				email = rs.getString("email");
				username = rs.getString("username");
				password = rs.getString("password");
		%>
		<h2 class="mb-4">Account Details</h2>
		<form>
			<div class="mb-3">
				<label for="username" class="form-label">Username</label> <input
					type="text" class="form-control" id="username" name="username"
					value=<%=username%> required>
			</div>
			<div class="mb-3">
				<label for="email" class="form-label">Email</label> <input
					type="email" class="form-control" id="email" name="email"
					value=<%=email%> required>
			</div>
			<div class="mb-3">
				<label for="password" class="form-label">Password</label> <input
					type="password" class="form-control" id="password" name="password"
					value=<%=password%> required>
			</div>
			<div class="d-flex justify-content-between mt-5 mb-5">
				<div class="text-start" style="color: #0C243C;">
					<a class="btn btn-danger btn-lg delete-button"
						onclick="confirmDelete(<%=memberId%>)">Delete Account</a>
				</div>
				<div class="text-end" style="color: #0C243C;">
					<a class="btn btn-primary btn-lg update-button"
						href="updateMemberProfile.jsp?memberId=<%=memberId%>">Update
						Info</a>
				</div>
			</div>
		</form>
		<%
		}
		// Step 7: Close connection
		conn.close();
		} catch (Exception e) {
		out.println("Error :" + e);
		}
		%>
	</div>



	<div class="container">
		<h2>Order History</h2>

		<div class="card">
			<div class="card-header">
				<h3 class="text-start" style="color: black">17 June 2023</h3>
				<h3 class="text-end" style="color: black">Total Cost: $14.99</h3>
			</div>
			<div class="card-body">
				<div class="row">
					<div class="col-md-2">
						<img
							src="https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1646534743i/60556912.jpg"
							alt="Book Image">
					</div>
					<div class="col-md-6">
						<h4 style="color: black;">The Housemaid</h4>
					</div>
				</div>
			</div>
			<div class="card-footer" style="color: black">Order ID: 124</div>
		</div>
	</div>

	<script>
		function confirmDelete(memberId) {
		  if (confirm("Are you sure you want your account?")) {
		    window.location.href = "<%=request.getContextPath()%>
		/DeleteMemberProfileServlet?memberId="
						+ memberId;
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