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
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		
		/* ===========================================================
		Author: Rajkaran (2109039)
		Date: 9/6/2023
		Description: JAD CA1
		============================================================= */
		
		String path = request.getContextPath() + "/pages";

		String user = request.getParameter("loginId");
		String pwd = request.getParameter("password");
		
		if (!user.isEmpty() && !pwd.isEmpty() ) {

			PrintWriter out = response.getWriter();
			HttpSession session = request.getSession();

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

				// Step 4: Create Statement object
				Statement stmt = conn.createStatement();
				
				String sqlCall = "{CALL MemberLogin(?,?)}";
				
				CallableStatement cs = conn.prepareCall(sqlCall);
				cs.setString(1,user);
				cs.setString(2,pwd);

				// Execute SQL query
				ResultSet rs = cs.executeQuery();

				// Step 6: Process Result
				while (rs.next()) {
					id = rs.getInt("member_id");
					password = rs.getString("password");
					name = rs.getString("username");

				}

				// Step 7: Close connection
				conn.close();
			} catch (Exception e) {
				out.println("Error :" + e);
			}

			if (name.equalsIgnoreCase(user) && password.equals(pwd)) {

				// Create Role
				session.setAttribute("sessUserRole", "member");
				session.setAttribute("sessUserID", id);
				session.setMaxInactiveInterval(900);
				
						
				
				
				response.sendRedirect(path + "//index.jsp");
			} else {

				// for invalid credentials
				response.sendRedirect(path + "//login.jsp?errCode=invalidLogin");

			}
		}else {
			response.sendRedirect(path + "//login.jsp?errCode=invalidLogin");
		}
	}

}
