<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payment Succesful</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css"
		integrity="sha256-2XFplPlrFClt0bIdPgpz8H7ojnk10H69xRqd9+uTShA="
		crossorigin="anonymous" />

	<%
/* 	String member_id = request.getParameter("member_id");

	out.println("<h1>" + member_id + "</h1>"); */
	String receipt = (String) session.getAttribute("receipt");
	String orders  = (String) session.getAttribute("orders");
	double total = (double) session.getAttribute("total");
	%>

<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<div class="invoice-title">
							<h4 class="float-end font-size-15">
								 <span
									class="badge bg-success font-size-12 ms-2">Paid</span>
							</h4>
							<div class="mb-4">
								<h2 class="mb-1 text-muted">Kitty Reads</h2>
							</div>
						</div>
						<hr class="my-4">
						<%=receipt %>

						<div class="py-2">
							<h5 class="font-size-15">Order Summary</h5>
							<div class="table-responsive">
								<table
									class="table align-middle table-nowrap table-centered mb-0">
									<thead>
										<tr>
											<th style="width: 70px;">No.</th>
											<th>Item</th>
											<th>Price</th>
											<th>Quantity</th>
											<th class="text-end" style="width: 120px;">Total</th>
										</tr>
									</thead>
									<tbody>
										<%=orders %>
<!-- 										<tr>
											<th scope="row" colspan="4" class="text-end">Sub Total</th>
											<td class="text-end">$732.50</td>
										</tr> -->

<!-- 										<tr>
											<th scope="row" colspan="4" class="border-0 text-end">
												Discount :</th>
											<td class="border-0 text-end">- $25.50</td>
										</tr>

										<tr>
											<th scope="row" colspan="4" class="border-0 text-end">
												Shipping Charge :</th>
											<td class="border-0 text-end">$20.00</td>
										</tr>

										<tr>
											<th scope="row" colspan="4" class="border-0 text-end">
												Tax</th>
											<td class="border-0 text-end">$12.00</td>
										</tr> -->

										<tr>
											<th scope="row" colspan="4" class="border-0 text-end">Total</th>
											<td class="border-0 text-end">
												<h4 class="m-0 fw-semibold">$<%=total%></h4>
											</td>
										</tr>

									</tbody>
								</table>
							</div>
							<div class="d-print-none mt-4">
								<div class="float-end">
									<a 
										class="btn btn-success me-1"><i class="fa fa-print"></i></a> <a
										href="checkout.jsp" class="btn btn-primary w-md">Back to Homepage</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>