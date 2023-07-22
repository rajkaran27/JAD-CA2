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

if (userRole != null) {
	if (userRole.equals("owner")) {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Member</title>
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
	String strmemberId = request.getParameter("memberId");
	int member_id = Integer.parseInt(strmemberId);

	String email = "";
	String username = "";
	String password = "";
	/* int memberId = 0; */

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
		pstmt.setInt(1, member_id);

		// Step 5: Execute SQL query
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		while (rs.next()) {
			email = rs.getString("email");
			username = rs.getString("username");
			password = rs.getString("password");
			/* memberId = rs.getInt("member_id"); */

		}
		// Close connection
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		out.println("Error: " + e);
	}
	%>

	<div class="container mt-4">
		<h1>Update Member</h1>
		<form method="POST"
			action="<%=request.getContextPath()%>/UpdateMemberServlet">

			<div class="mb-3">
				<label for="email" class="form-label">Email</label> <input
					class="form-control" id="email" name="email"
					placeholder="Enter email" type="email" value="<%=email%>"></input>
			</div>

			<div class="mb-3">
				<label for="username" class="form-label">Username</label> <input
					class="form-control" id="username" name="username"
					placeholder="Enter username" type="text" value="<%=username%>"></input>
			</div>

			<div class="mb-3">
				<label for="password" class="form-label">Password</label> <input
					class="form-control" id="password" name="password"
					placeholder="Enter password" type="password" value="<%=password%>"></input>
			</div>

			<div class="d-flex justify-content-end">
				<input type="hidden" name="memberId" value="<%=member_id%>">
				<button type="submit" class="btn btn-primary">Update Member</button>
			</div>
		</form>
	</div>
	<%
	} else {
	response.sendRedirect("login.jsp?errCode=accessDenied");
	}
	} else {
	response.sendRedirect("login.jsp?errCode=accessDenied");
	}
	%>

	<%@ include file="footer.jsp"%>
</body>
</html>