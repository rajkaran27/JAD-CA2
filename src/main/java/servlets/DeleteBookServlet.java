package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
/**
 * Servlet implementation class DeleteBookServlet
 */
@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		/* ===========================================================
		Author: Rajkaran (2109039)
		Date: 9/6/2023
		Description: JAD CA1
		============================================================= */
		
		String path = request.getContextPath() + "/pages";

		String bookId = request.getParameter("bookId");
		int book_id = Integer.parseInt(bookId);

		PrintWriter out = response.getWriter();

		try {
			// Step 1: Load JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			String sqlCall = "{CALL DeleteBook(?)}";

			CallableStatement cs = (CallableStatement) conn.prepareCall(sqlCall);
			cs.setInt(1, book_id);

			// Step 5: Execute SQL query
			ResultSet rs = cs.executeQuery();

			response.sendRedirect(path + "//bookShelf.jsp");

			// Step 7: Close connection
			conn.close();
		} catch (Exception e) {
			out.println("Error :" + e);
		}

	}


}
