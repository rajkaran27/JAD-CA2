package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
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
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		/* ===========================================================
		Author: Rajkaran (2109039)
		Date: 9/6/2023
		Description: JAD CA1
		============================================================= */
		
		String path = request.getContextPath() + "/pages";

		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		if (!(username==null && email==null && password ==null) || !(username.isEmpty() && email.isEmpty() && password.isEmpty())) {

			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();

			try {
				// Step 1: Load JDBC Driver
				Class.forName("com.mysql.cj.jdbc.Driver");

				// Step 2: Define Connection URL
				String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

				// Step 3: Establish connection to URL
				Connection conn = DriverManager.getConnection(connURL);

				String sqlCall = "{CALL RegisterMember(?,?,?)}";

				CallableStatement cs = conn.prepareCall(sqlCall);
				cs.setString(1, email);
				cs.setString(2, username);
				cs.setString(3, password);

				// Execute SQL
				int rowsAffected = cs.executeUpdate();

				if (rowsAffected != 0) {
					response.sendRedirect(path + "//login.jsp?errCode=registered");
				} else {
					response.sendRedirect(path + "//register.jsp?errCode=empty");
				}

				// Step 7: Close connection
				conn.close();
			} catch (Exception e) {
				out.println("Error :" + e);
			}
		} else {
			response.sendRedirect(path + "//register.jsp?errCode=empty");
		}
	}

}
