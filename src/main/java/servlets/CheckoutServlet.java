package servlets;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

/**
 * Servlet implementation class CheckoutServlet
 */
@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CheckoutServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getContextPath() + "/pages";
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		int memberId = Integer.parseInt(request.getParameter("memberId"));

		try {
			Connection conn = DBConnection.getConnection();

			// Update cart items with the new quantities
			Enumeration<String> paramNames = request.getParameterNames();
			while (paramNames.hasMoreElements()) {
				String paramName = paramNames.nextElement();
				if (paramName.startsWith("quantity_")) {
					int bookId = Integer.parseInt(paramName.substring("quantity_".length()));
					int quantity = Integer.parseInt(request.getParameter(paramName));

					// Perform the update in the database for the specific book and member
					String updateSqlStr = "UPDATE cart SET cart_quantity = ? WHERE book_id = ? AND member_id = ?;";
					PreparedStatement updatePstmt = conn.prepareStatement(updateSqlStr);
					updatePstmt.setInt(1, quantity);
					updatePstmt.setInt(2, bookId);
					updatePstmt.setInt(3, memberId);
					updatePstmt.executeUpdate();
				}
			}

			conn.close();

			// Redirect the user to the checkout page or any other desired page
			response.sendRedirect(path + "/checkout.jsp");
		} catch (Exception e) {
			out.println("Error: " + e);
		}
	}
}
