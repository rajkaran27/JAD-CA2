package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.*;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/UpdateMemberServlet")
public class UpdateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateMemberServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*
		 * =========================================================== Author: Pranjal
		 * (2228396) Date: 9/6/2023 Description: JAD CA1
		 * =============================================================
		 */
		String path = request.getContextPath() + "/pages";

		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String member_id = request.getParameter("memberId");

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String userRole = (String) session.getAttribute("sessUserRole");

		try {

			Connection conn = DBConnection.getConnection();

			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			String sqlStr = "UPDATE members SET email=?,username=?,password=? WHERE member_id=?";

			PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			// Set parameter values for placeholders

			pstmt.setString(1, email);
			pstmt.setString(2, username);
			pstmt.setString(3, password);
			pstmt.setString(4, member_id);

			// Execute SQL query
			int rowsAffected = pstmt.executeUpdate();

			if (userRole.equals("member")) {
				response.sendRedirect(path + "//memberProfile.jsp" + "?memberId=" + member_id);
			} else if (userRole.equals("owner")) {
				response.sendRedirect(path + "//memberInfo.jsp");

			}

			// Step 7: Close connection
			conn.close();
		} catch (Exception e) {
			out.println("Error :" + e);
		}
	}

}
