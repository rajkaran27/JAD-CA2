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
 * Servlet implementation class AdminLoginServlet
 */
@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminLoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/* ===========================================================
		Author: Rajkaran (2109039)
		Date: 9/6/2023
		Description: JAD CA1
		============================================================= */
		
		String path = request.getContextPath() + "/pages";

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		// Initializing variables
		String user = request.getParameter("loginId");
		String pwd = request.getParameter("password");

		if (!user.isEmpty() && !pwd.isEmpty()) {

			String password = "";
			String name = "";
			Integer id = 0;

			try {

				// Step 1: Load JDBC Driver
				Class.forName("com.mysql.cj.jdbc.Driver");

				// Step 2: Define Connection URL
				String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

				// Step 3: Establish connection to URL
				Connection conn = DriverManager.getConnection(connURL);

				String sqlCall = "{CALL AdminLogin(?,?)}";

				CallableStatement cs = conn.prepareCall(sqlCall);
				cs.setString(1, user);
				cs.setString(2, pwd);

				// Execute SQL query
				ResultSet rs = cs.executeQuery();

				// Step 6: Process Result
				while (rs.next()) {

					id = rs.getInt("admin_id");
					password = rs.getString("password");
					name = rs.getString("username");

				}

				// Step 7: Close connection
				conn.close();
			} catch (Exception e) {
				out.println("Error :" + e);
			}

			if (name.equalsIgnoreCase(user) && password.equals(pwd)) { // Create Role
				session.setAttribute("sessUserRole", "owner");
				session.setMaxInactiveInterval(900);
				
				
				response.sendRedirect(path + "//index.jsp");
			} else {

				// for invalid credentials
				response.sendRedirect(path + "//adminLogin.jsp?errCode=invalidLogin");

			}
		} else {
			response.sendRedirect(path + "//login.jsp?errCode=invalidLogin");
		}

	}

}