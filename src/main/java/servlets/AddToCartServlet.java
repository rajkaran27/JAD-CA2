package servlets;

import java.io.*;
import java.io.PrintWriter;
import java.net.*;
import java.net.URLEncoder;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Servlet implementation class AddToCartServlet
 */
@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddToCartServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getContextPath() + "/pages";
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		String userRole = (String) session.getAttribute("sessUserRole");
		String strbookId = request.getParameter("bookId");
		Integer member_id = (Integer) session.getAttribute("sessUserID"); // Use Integer data type here
		int book_id = Integer.parseInt(strbookId);

		if (userRole != null) {
			if (userRole.equals("member")) {
				try {
					System.out.println(member_id);
					System.out.println(book_id);

					Connection conn = DBConnection.getConnection();

					String sqlCall = "{CALL AddToCart(?,?,?)}";

					CallableStatement cs = conn.prepareCall(sqlCall);
					cs.setInt(1, member_id); // Use setInt for member_id
					cs.setInt(2, book_id);
					cs.setInt(3, 1);
					cs.executeUpdate();
					cs.close();
					conn.close();

					response.sendRedirect(path + "/viewCart.jsp");
				} catch (SQLIntegrityConstraintViolationException e) {
					e.printStackTrace();
					out.println("Error: " + e);
				} catch (Exception e) {
					e.printStackTrace();
					out.println("Error: " + e);
				}
			} else {
				response.sendRedirect(path + "//login.jsp?errCode=accessDenied");
			}
		} else {
			response.sendRedirect(path + "//login.jsp?errCode=accessDenied");
		}
	}

}
