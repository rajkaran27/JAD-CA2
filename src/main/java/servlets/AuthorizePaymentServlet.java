package servlets;

import java.io.IOException;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.paypal.base.rest.PayPalRESTException;

@WebServlet("/AuthorizePaymentServlet")
public class AuthorizePaymentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public AuthorizePaymentServlet() {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String[] priceArray = request.getParameterValues("onePrice");
		String[] quantityArray = request.getParameterValues("oneQuantity");
		String[] bookIdsArray = request.getParameterValues("bookId");
		OrderDetail orderDetail = new OrderDetail();

		List<Integer> bookIdsList = new ArrayList<>();
		for (String bookId : bookIdsArray) {
			bookIdsList.add(Integer.parseInt(bookId));
		}

		List<Double> pricesList = new ArrayList<>();
		for (String price : priceArray) {
			pricesList.add(Double.parseDouble(price));
		}

		List<Integer> quantitiesList = new ArrayList<>();
		for (String quantity : quantityArray) {
			quantitiesList.add(Integer.parseInt(quantity));
		}

		orderDetail.setBookIds(bookIdsList);
		orderDetail.setPrice(pricesList);
		orderDetail.setQuantity(quantitiesList);

		try {
			PaymentServices paymentServices = new PaymentServices();
			String approvalLink = paymentServices.authorizePayment(orderDetail);

			response.sendRedirect(approvalLink);

		} catch (PayPalRESTException ex) {
			request.setAttribute("errorMessage", ex.getMessage());
			ex.printStackTrace();
			request.getRequestDispatcher("error.jsp").forward(request, response);
		}
	}

}
