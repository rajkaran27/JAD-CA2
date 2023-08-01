<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
String userRole = (String) session.getAttribute("sessUserRole");

if (userRole != null && userRole.equals("member")) {
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String connURL = "jdbc:mysql://jad-database.coaftljc64cm.us-east-1.rds.amazonaws.com/bookstore?user=admin&password=pjraj12!";
        Connection conn = DriverManager.getConnection(connURL);

		String sqlStr = "SELECT books.*, authors.author_name, categories.category_name FROM books JOIN authors ON books.author_id = authors.author_id JOIN categories ON books.category_id = categories.category_id JOIN cart ON books.book_id = cart.book_id WHERE cart.member_id = ?;";
        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
        pstmt.setInt(1, (Integer) session.getAttribute("sessUserID"));

        ResultSet rs = pstmt.executeQuery();
        ArrayList<Integer> shoppingCart = new ArrayList<>();
        double totalCost = 0;

%>
<!DOCTYPE html>
<html>
<head>
    <!-- Add your head content here -->
</head>
<body>
    <!-- Add your body content here -->
    <h1>Shopping Cart</h1>
    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Category</th>
                <th>Price</th>
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("author_name") %></td>
                <td><%= rs.getString("category_name") %></td>
                <td><%= rs.getDouble("price") %></td>
            </tr>
            <% totalCost += rs.getDouble("price"); %>
            <% } %>
        </tbody>
    </table>
    <p>Total Cost: <%= totalCost %></p>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e);
    }
} else {
    response.sendRedirect("login.jsp?errCode=accessDenied");
}
%>
