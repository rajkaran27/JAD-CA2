<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
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
<title>Header</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/headerFooter.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/main.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/header.css">
</head>
<body>
	<%
	String userRoleH = (String) session.getAttribute("sessUserRole");
	String genre = "";
	/* catID */
	int genre_id = 0;
	try {
		// Step 1: Load JDBC Driver
		Class.forName("com.mysql.cj.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 4: Create PreparedStatement object

		String sqlStr = "SELECT * FROM bookstore.categories;";

		PreparedStatement pstmt = conn.prepareStatement(sqlStr);

		// Step 5: Execute SQL query
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		while (rs.next()) {
			String categoryName = rs.getString("category_name");
			String genreSqlStr = "SELECT category_id FROM categories WHERE category_name = ?;";
			PreparedStatement genrePstmt = conn.prepareStatement(genreSqlStr);
			genrePstmt.setString(1, categoryName.toUpperCase());
			ResultSet genreRs = genrePstmt.executeQuery();

			//  Retrieve genre name
			if (genreRs.next()) {
		genre_id = genreRs.getInt("category_id");
			}
			genre += "<a href=\"catDetails.jsp?catId=" + genre_id + "\">" + "<span>" + categoryName + "</span></a>";
		}

		// Close connection
		conn.close();
	} catch (Exception e) {
		e.printStackTrace();
		out.println("Error: " + e);
	}
	%>

	<header>
		<nav class="navbar navbar-expand-lg navbar-light bg-white">
			<div class="container-fluid">
				<button class="navbar-toggler" type="button"
					data-mdb-toggle="collapse" data-mdb-target="#navbarExample01"
					aria-controls="navbarExample01" aria-expanded="false"
					aria-label="Toggle navigation">
					<i class="fas fa-bars"></i>
				</button>
				<div class="collapse navbar-collapse" id="navbarExample01">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item active"><a class="nav-link"
							aria-current="page" href="index.jsp">Home</a></li>

						<!-- Categories -->
						<li class="navbar-item has-dropdown is-hoverable"><a
							class="nav-link" href="category.jsp">Genre</a>
							<div class="navbar-dropdown">
								<div class="navbar-dropdown-list">
									<%=genre%>
								</div>
							</div></li>
					</ul>
				</div>
				<%
				if (userRoleH != null) {
					if (userRoleH.equals("member")) {
						if (session.getAttribute("sessUserID") != null) {
					int member_id = (int) session.getAttribute("sessUserID");
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
						String sqlStr = "SELECT email, username, password FROM members WHERE member_id= ?;";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setInt(1, member_id);
						ResultSet rs = pstmt.executeQuery();

						// Step 6: Process Result
						while (rs.next()) {
				%>
				<div class="d-flex">
					<a class="nav-link"
						href="memberProfile.jsp?memberId=<%=member_id%>">Profile</a> <a
						class="nav-link" href="viewCart.jsp" id="userCart">Cart</a>
					<form class="d-flex">
						<button class="btn btn-outline-primary me-2" type="button"
							onClick="window.location.href='logoutFunction.jsp'">Logout</button>
					</form>
				</div>
				<%
				}
				conn.close();
				} catch (Exception e) {
				out.println("Error: " + e);
				}
				}
				} else if (userRoleH.equals("owner")) {
				%>
				<div class="d-flex">
					<a class="btn" href="memberInfo.jsp">Member Management</a> <a
						class="btn" href="bookShelf.jsp">BookShelf</a>
					<form class="d-flex">
						<button class="btn btn-outline-primary me-2" type="button"
							onClick="window.location.href='logoutFunction.jsp'">Logout</button>
					</form>
				</div>

				<%
				}
				} else {
				%>
				<div class="d-flex">
					<form class="d-flex">
						<ul class="navbar-nav">
							<li class="navbar-item has-dropdown is-hoverable"><a
								class="nav-link" onclick="return false;">Login Menu</a>
								<div class="navbar-dropdown">
									<div class="navbar-dropdown-list">
										<a href="login.jsp"><span>Member Login</span></a> <a
											href="adminLogin.jsp"><span>Admin Login</span></a>
									</div>
								</div></li>
						</ul>
					</form>
				</div>
				<%
				}
				%>


			</div>
		</nav>

	</header>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</body>
</html>
