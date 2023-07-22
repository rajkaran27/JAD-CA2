package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AddBookServlet
 */
@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddBookServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/* ===========================================================
		Author: Rajkaran (2109039)
		Date: 9/6/2023
		Description: JAD CA1
		============================================================= */
		
		// TODO Auto-generated method stub
		String path = request.getContextPath() + "/pages";

		String author = request.getParameter("author");
		String category = request.getParameter("category");
		String publisher = request.getParameter("publisher");
		String src = request.getParameter("src");
		String title = request.getParameter("title");
		String desc = request.getParameter("desc");
		String ISBN = request.getParameter("isbn");
		String price = request.getParameter("price");
		String pubDate = request.getParameter("pubDate");
		String rating = request.getParameter("rating");
		String quantity = request.getParameter("quantity");

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		if (!(author.isEmpty() || category.isEmpty() || publisher.isEmpty() || src.isEmpty() || title.isEmpty()
				|| desc.isEmpty() || ISBN.isEmpty() || price.isEmpty() || pubDate.isEmpty() || rating.isEmpty()
				|| quantity.isEmpty())) {
		
		title = title.toUpperCase();	
		
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
				String sqlStr = "INSERT INTO books(category_id,isbn,title,quantity,price,author_id,publisher_id,image,description,rating,publication_date) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement pstmt = conn.prepareStatement(sqlStr);

				// Set parameter values for placeholders
				pstmt.setString(1, category);
				pstmt.setString(2, ISBN);
				pstmt.setString(3, title);
				pstmt.setString(4, quantity);
				pstmt.setString(5, price);
				pstmt.setString(6, author);
				pstmt.setString(7, publisher);
				pstmt.setString(8, src);
				pstmt.setString(9, desc);
				pstmt.setString(10, rating);
				pstmt.setString(11, pubDate);

				// Execute SQL query
				int rowsAffected = pstmt.executeUpdate();

				response.sendRedirect(path + "//bookShelf.jsp?errCode=added");
				// Step 7: Close connection
				conn.close();
			} catch (Exception e) {
				out.println("Error :" + e);
			}

		} else {
			response.sendRedirect(path + "//login.jsp?errCode=accessDenied");
		}

	}

}
