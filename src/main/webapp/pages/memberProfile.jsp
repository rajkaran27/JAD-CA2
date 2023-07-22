<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
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
.card {
	margin: 0;
	width: 700px;
	box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
	-webkit-box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
	-moz-box-shadow: -1px 4px 40px 10px rgba(0, 0, 0, 0.54);
}
</style>
<body>
	<%@ include file="header.jsp"%>

	<div class="container d-flex justify-content-center align-items-center">
		<div>
			<%
			try {

				// Step 1: Load JDBC Driver
				Class.forName("com.mysql.cj.jdbc.Driver");

				// Step 2: Define Connection URL
				String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

				// Step 3: Establish connection to URL
				Connection conn = DriverManager.getConnection(connURL);

				// Step 4: Create PreparedStatement object
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
			<div class="container">
				<h2 class="mb-4">Account Details</h2>
				<form>
					<div class="mb-3">
						<label for="username" class="form-label">Username:</label>
						<!-- <input
							type="text" class="form-control" id="username" name="username"
							value="Delvin" required> -->
						<%=username%>
					</div>
					<div class="mb-3">
						<label for="email" class="form-label">Email:</label>
						<!-- <input
							type="email" class="form-control" id="email" name="email"
							required> -->
						<%=email%>
					</div>
					<div class="mb-3">
						<label for="password" class="form-label">Password:</label>
						<!-- <input
							type="password" class="form-control" id="password"
							name="password" value="delv123" required> -->
						<%=password%>
					</div>
					<!-- <button type="submit" class="btn btn-primary float-end">Save
						Changes</button> -->
				</form>
				<div class="text-center" style="color: #0C243C">
					<a class="btn btn-primary btn-sm update-button"
						href="updateMemberProfile.jsp?memberId=<%=memberId%>">Update
						Info</a>
				</div>
				<div class="text-center mt-5" style="color: #0C243C;">
					<a class="btn btn-danger btn-sm delete-button"
						onclick="confirmDelete(<%=memberId%>)">Delete Account</a>
				</div>
			</div>
			<%
			}
			// Step 7: Close connection
			conn.close();
			} catch (Exception e) {
			out.println("Error :" + e);
			}
			%>
		</div>
	</div>

	<script>
		function confirmDelete(memberId) {
		  if (confirm("Are you sure you want your account?")) {
		    window.location.href = "<%=request.getContextPath()%>/DeleteMemberProfileServlet?memberId="+ memberId;
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