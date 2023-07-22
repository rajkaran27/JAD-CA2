package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SearchBookServlet
 */
@WebServlet("/SearchBookServlet")
public class SearchBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchBookServlet() {
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

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		
		String searchQuery = request.getParameter("search");

		try {
			StringBuilder htmlBuilder = new StringBuilder();

			// Step 1: Load JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);
			
			
			String sqlCall = "{CALL SearchBookIndex(?,?)}";
			
			CallableStatement cs = conn.prepareCall(sqlCall);
			cs.setString(1,searchQuery);
			cs.setString(2,searchQuery);
			
			// Step 5: Execute SQL query
			ResultSet rs = cs.executeQuery();

			// Step 6: Process Result
			while (rs.next()) {	
				String title = rs.getString("title");
				String src = rs.getString("image");
				double price = rs.getDouble("price");
				int bookId = rs.getInt("book_id");
				String category = rs.getString("category_name");
				
				htmlBuilder.append("<div class='col-md-4 mb-4'>")
			    .append("<div class='card' style='border-radius:10px;'>")
			    .append("<a href='bookDetails.jsp?bookId=").append(bookId).append("'>")
			    .append("<img src='").append(src).append("' class='card-img-top' alt='Book Image' style='height:600px;' />")
			    .append("</a>")
			    .append("<div class='card-body'>")
			    .append("<div class='text-center'>")
			    .append("<a href='bookDetails.jsp?bookId=").append(bookId).append("' style='text-decoration: none; color:#0C243C;'>")
			    .append("<h4 class='card-title fw-bold'>").append(title).append("</h4>")
			    .append("</a>")
			    .append("</div>")
			    .append("<p class='text-center mb-2' style='text-decoration: none; color:#0C243C;'>").append(category).append(" | S$").append(price).append("</p>")
			    .append("</div>")
			    .append("</div>")
			    .append("</div>");
				
			}

				
			session.setAttribute("searchResults", htmlBuilder.toString());
			response.sendRedirect(path+"//index.jsp?searchResults=true");


			// Close connection
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.println("Error: " + e);
		}
	}

}
