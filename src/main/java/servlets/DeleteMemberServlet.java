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
 * Servlet implementation class DeleteMemberServlet
 */
@WebServlet("/DeleteMemberServlet")
public class DeleteMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteMemberServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/* ===========================================================
		Author: Pranjal (2228396)
		Date: 9/6/2023
		Description: JAD CA1
		============================================================= */
		
		String path = request.getContextPath() + "/pages";

		String memberId = request.getParameter("memberId");
		int member_id = Integer.parseInt(memberId);

		PrintWriter out = response.getWriter();

		try {
			// Step 1: Load JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 5: Execute SQL Command
			String sqlCall = "{CALL DeleteMember(?)}";

			CallableStatement cs = (CallableStatement) conn.prepareCall(sqlCall);
			cs.setInt(1, member_id);

			// Step 5: Execute SQL query
			ResultSet rs = cs.executeQuery();

			response.sendRedirect(path + "//memberInfo.jsp");

			// Step 7: Close connection
			conn.close();
		} catch (Exception e) {
			out.println("Error :" + e);
		}
	}

}
