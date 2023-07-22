package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
		/* ===========================================================
		Author: Rajkaran (2109039)
		Date: 9/6/2023
		Description: JAD CA1
		============================================================= */
		
		String path = request.getContextPath() + "/pages";

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();

		String userRole = (String) session.getAttribute("sessUserRole");
		ArrayList<Integer> shoppingCart = (ArrayList<Integer>) session.getAttribute("shoppingCart");
		String strbookId = request.getParameter("bookId");
		int book_id = Integer.parseInt(strbookId);

		if (userRole != null) {
			if (userRole.equals("member")) {

				if (shoppingCart == null) {
					shoppingCart = new ArrayList<>();
					session.setAttribute("shoppingCart", shoppingCart);
				}

				shoppingCart.add(book_id);

				session.setAttribute("shoppingCart", shoppingCart);
				response.sendRedirect(path+"//viewCart.jsp");

			} else {
				response.sendRedirect(path + "//login.jsp?errCode=accessDenied");
			}
		} else {
			response.sendRedirect(path + "//login.jsp?errCode=accessDenied");
		}

	}

}
