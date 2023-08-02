package servlets;

import java.util.*;

import com.paypal.api.payments.*;
import com.paypal.base.rest.*;
import java.math.BigDecimal;
import java.math.RoundingMode;

public class PaymentServices {
	private static final String CLIENT_ID = "AeGEdt8yTT23C474Q2CK9-2GAvW6CQLofLw5gz5QQF6-DgdufoLdm3ciHuKzn72CW9FQbR9yh0zKqpnU";
	private static final String CLIENT_SECRET = "EKGl2fYCaYOUv15EpCsH1Mca2LJjw-7k_-yfzRx2SIJ2b08MpXl5kPxtgRVlMjcN4LJ4MTBOFR8dzKDq";
	private static final String MODE = "sandbox";

	public String authorizePayment(OrderDetail orderDetail) throws PayPalRESTException {

		Payer payer = getPayerInformation();
		RedirectUrls redirectUrls = getRedirectURLs();
		Transaction transaction = getSingleTransaction(orderDetail); // Change to getSingleTransaction

		Payment requestPayment = new Payment();
		requestPayment.setTransactions(Collections.singletonList(transaction)); // Change to set a single transaction
		requestPayment.setRedirectUrls(redirectUrls);
		requestPayment.setPayer(payer);
		requestPayment.setIntent("authorize");

		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

		Payment approvedPayment = requestPayment.create(apiContext);

		return getApprovalLink(approvedPayment);

	}

	private Payer getPayerInformation() {
		Payer payer = new Payer();
		payer.setPaymentMethod("paypal");

		PayerInfo payerInfo = new PayerInfo();
		payerInfo.setFirstName("William").setLastName("Peterson").setEmail("william.peterson@company.com");

		payer.setPayerInfo(payerInfo);

		return payer;
	}

	private RedirectUrls getRedirectURLs() {
		RedirectUrls redirectUrls = new RedirectUrls();
		redirectUrls.setCancelUrl("http://localhost:8080/PaypalTest/cancel.html");
		redirectUrls.setReturnUrl("http://localhost:8080/PaypalTest/review_payment");

		return redirectUrls;
	}

	private Transaction getSingleTransaction(OrderDetail orderDetail) {
		List<Integer> bookIds = orderDetail.getBookIds();
		List<Double> prices = orderDetail.getPrice();
		List<Integer> quantities = orderDetail.getQuantity();

		BigDecimal totalAmount = BigDecimal.ZERO;

		ItemList itemList = new ItemList();
		List<Item> items = new ArrayList<>();

		for (int i = 0; i < bookIds.size(); i++) {
			int bookId = bookIds.get(i);
			double price = prices.get(i);
			int quantity = quantities.get(i);

			BigDecimal itemTotal = BigDecimal.valueOf(price * quantity).setScale(2, RoundingMode.HALF_UP);
			totalAmount = totalAmount.add(itemTotal);

			Item item = new Item();
			item.setCurrency("USD");
			item.setName("Book"); // You can set the name as per your requirement
			item.setPrice(BigDecimal.valueOf(price).setScale(2, RoundingMode.HALF_UP).toString());
			item.setTax("0.00"); // Assuming there is no tax for the books
			item.setQuantity(String.valueOf(quantity)); // Set the quantity as a string

			items.add(item);
		}

		itemList.setItems(items);

		// Set the transaction amount
		Amount amount = new Amount();
		amount.setCurrency("USD");
		amount.setTotal(totalAmount.toString());

		// Set details for the transaction
		Details details = new Details();
		details.setShipping("0");
		details.setSubtotal(totalAmount.toString());
		details.setTax("0");
		amount.setDetails(details);

		// Create the transaction
		Transaction transaction = new Transaction();
		transaction.setAmount(amount);
		transaction.setDescription("Books Purchase");
		transaction.setItemList(itemList);

		return transaction;
	}

	private String getApprovalLink(Payment approvedPayment) {
		List<Links> links = approvedPayment.getLinks();
		String approvalLink = null;

		for (Links link : links) {
			if (link.getRel().equalsIgnoreCase("approval_url")) {
				approvalLink = link.getHref();
				break;
			}
		}

		return approvalLink;
	}

	public Payment getPaymentDetails(String paymentId) throws PayPalRESTException {
		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);
		return Payment.get(apiContext, paymentId);
	}

	public Payment executePayment(String paymentId, String payerId) throws PayPalRESTException {
		PaymentExecution paymentExecution = new PaymentExecution();
		paymentExecution.setPayerId(payerId);

		Payment payment = new Payment().setId(paymentId);

		APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, MODE);

		return payment.execute(apiContext, paymentExecution);
	}

}
