package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.net.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class RemoveFromCartServlet
 */
@WebServlet("/RemoveFromCartServlet")
public class RemoveFromCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RemoveFromCartServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		/*
		 * =========================================================== Author: Pranjal
		 * (2228396) Date: 9/6/2023 Description: JAD CA1
		 * =============================================================
		 */
		String path = request.getContextPath() + "/pages";
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		String bookIdStr = request.getParameter("bookId");
		String memberIdStr = request.getParameter("memberId");

		int bookId = Integer.parseInt(bookIdStr);
		int memberId = Integer.parseInt(memberIdStr);
		
		
		try {
			Connection conn = DBConnection.getConnection();

			// Step 5: Execute SQL Command
			String sqlStr = "DELETE FROM cart WHERE book_id=? AND member_id=?;";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			// Set parameter values for placeholders
			pstmt.setInt(1, bookId);
			pstmt.setInt(2, memberId);
			
			
			pstmt.executeUpdate();
			//response.sendRedirect(path + "//bookShelf.jsp?errCode=added");
			conn.close();
		} catch (Exception e) {
			out.println("Error :" + e);
		}

		response.sendRedirect(path + "//viewCart.jsp");

	}
}
