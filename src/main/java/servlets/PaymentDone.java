package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class PaymentDone
 */
@WebServlet("/PaymentDone")
public class PaymentDone extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PaymentDone() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());

		String path = request.getContextPath() + "/pages";

		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String memberId = request.getParameter("member_id");

		double total_price = 0;

		try {
			StringBuilder receipt = new StringBuilder();
			StringBuilder orders = new StringBuilder();

			

			Connection conn = DBConnection.getConnection();

			String sqlCall = "{CALL ProcessOrder(?)}";

			CallableStatement cs = conn.prepareCall(sqlCall);
			cs.setString(1, memberId);
			
			int orderCount = 1;
			boolean isFirstRow = true; 

			ResultSet rs = cs.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				double price = rs.getDouble("price");
				int quantity = rs.getInt("quantity");

				orders.append("<tr>\r\n" + "    <th scope=\"row\">" + orderCount + "</th>\r\n" + "    <td>\r\n"
						+ "        <div>\r\n" + "            <h5 class=\"text-truncate font-size-14 mb-1\">")
						.append(title).append("</h5></div>\r\n" + "    </td>\r\n" + "    <td>$").append(price)
						.append("</td>\r\n" + "    <td>").append(quantity)
						.append("</td>\r\n" + "    <td class=\"text-end\">$").append(price * quantity)
						.append("</td>\r\n" + "</tr>");
				orderCount++;
				total_price +=price;
				if (isFirstRow) {

					String first = rs.getString("firstname");
					String last = rs.getString("lastname");
					String address1 = rs.getString("address1");
					String address2 = rs.getString("address2");
					String postal = rs.getString("postalcode");
					String unit = rs.getString("unit");
					String date = rs.getString("order_date");
					String email = rs.getString("email");
					String phone = rs.getString("phone");
					String orderId = rs.getString("order_id");

					receipt.append("<div class=\"row\">\r\n" + "    <div class=\"col-sm-6\">\r\n"
							+ "        <div class=\"text-muted\">\r\n"
							+ "            <h5 class=\"font-size-16 mb-3\">Billed To:</h5>\r\n"
							+ "            <h5 class=\"font-size-15 mb-2\">").append(first).append(" ").append(last)
							.append("</h5>\r\n" + "            <p class=\"mb-1\">").append(address1).append(" ")
							.append(address2).append(" ").append(postal).append(" ").append(unit)
							.append("</p>\r\n" + "            <p class=\"mb-1\">").append(email)
							.append("</p>\r\n" + "            <p>").append(phone)
							.append("</p>\r\n" + "        </div>\r\n" + "    </div>\r\n" + "\r\n"
									+ "    <div class=\"col-sm-6\">\r\n"
									+ "        <div class=\"text-muted text-sm-end\">\r\n" + "            <div>\r\n"
									+ "                <h5 class=\"font-size-15 mb-1\">Order ID:</h5>\r\n"
									+ "                <p>")
							.append(orderId)
							.append("</p>\r\n" + "            </div>\r\n" + "            <div class=\"mt-4\">\r\n"
									+ "                <h5 class=\"font-size-15 mb-1\">Invoice Date:</h5>\r\n"
									+ "                <p>")
							.append(date).append("</p>\r\n" + "            </div>\r\n" + "        </div>\r\n"
									+ "    </div>\r\n" + "</div>");

					isFirstRow = false;
				}

			}

			session.setAttribute("total", total_price);
			session.setAttribute("receipt", receipt.toString());
			session.setAttribute("orders", orders.toString());
			response.sendRedirect(path + "//paymentSuccessful.jsp");

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.println("Error: " + e);
		}

	}
}
