package servlets;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
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
		/* ===========================================================
		Author: Pranjal (2228396)
		Date: 9/6/2023
		Description: JAD CA1
		============================================================= */
		String path = request.getContextPath() + "/pages";
		// Retrieve the bookId parameter from the request
		String bookIdStr = request.getParameter("bookId");

		if (bookIdStr != null && !bookIdStr.isEmpty()) {
			try {
				int bookId = Integer.parseInt(bookIdStr);

				// Get the cart from the session
				HttpSession session = request.getSession();
				ArrayList<Integer> cart = (ArrayList<Integer>) session.getAttribute("shoppingCart");

				// Check if the cart exists
				if (cart != null) {
					// Remove the bookId from the cart
					cart.remove(Integer.valueOf(bookId));

					// Update the cart in the session
					session.setAttribute("shoppingCart", cart);
				}
			} catch (NumberFormatException e) {
				// Handle invalid bookId format
				e.printStackTrace();
			}
		}

		// Redirect back to the view cart page
		response.sendRedirect(path + "//viewCart.jsp");

	}
}
