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

	%>
	<%=receipt %>
<%-- 	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<div class="card">
					<div class="card-body">
						<div class="invoice-title">
							<h4 class="float-end font-size-15">
								Order ID: #DS0204 <span
									class="badge bg-success font-size-12 ms-2">Paid</span>
							</h4>
							<div class="mb-4">
								<h2 class="mb-1 text-muted">Kitty Reads</h2>
							</div>
						</div>
						<hr class="my-4">
						<div class="row">
							<div class="col-sm-6">
								<div class="text-muted">
									<h5 class="font-size-16 mb-3">Billed To:</h5>
									<h5 class="font-size-15 mb-2">Preston Miller</h5>
									<p class="mb-1">4068 Post Avenue Newfolden, MN 56738</p>
									<p class="mb-1">
										<a href="/cdn-cgi/l/email-protection" class="__cf_email__"
											data-cfemail="2c7c5e495f58434261454040495e6c4d5e41555f5c55024f4341">[email&#160;protected]</a>
									</p>
									<p>001-234-5678</p>
								</div>
							</div>

							<div class="col-sm-6">
								<div class="text-muted text-sm-end">
									<div>
										<h5 class="font-size-15 mb-1">Invoice No:</h5>
										<p>#DZ0112</p>
									</div>
									<div class="mt-4">
										<h5 class="font-size-15 mb-1">Invoice Date:</h5>
										<p>12 Oct, 2020</p>
									</div>
									<div class="mt-4">
										<h5 class="font-size-15 mb-1">Order No:</h5>
										<p>#1123456</p>
									</div>
								</div>
							</div>

						</div>

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
										<tr>
											<th scope="row">01</th>
											<td>
												<div>
													<h5 class="text-truncate font-size-14 mb-1">Black
														Strap A012</h5>
													<p class="text-muted mb-0">Watch, Black</p>
												</div>
											</td>
											<td>$ 245.50</td>
											<td>1</td>
											<td class="text-end">$ 245.50</td>
										</tr>

										<tr>
											<th scope="row">02</th>
											<td>
												<div>
													<h5 class="text-truncate font-size-14 mb-1">Stainless
														Steel S010</h5>
													<p class="text-muted mb-0">Watch, Gold</p>
												</div>
											</td>
											<td>$ 245.50</td>
											<td>2</td>
											<td class="text-end">$491.00</td>
										</tr>

										<tr>
											<th scope="row" colspan="4" class="text-end">Sub Total</th>
											<td class="text-end">$732.50</td>
										</tr>

										<tr>
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
										</tr>

										<tr>
											<th scope="row" colspan="4" class="border-0 text-end">Total</th>
											<td class="border-0 text-end">
												<h4 class="m-0 fw-semibold">$739.00</h4>
											</td>
										</tr>

									</tbody>
								</table>
							</div>
							<div class="d-print-none mt-4">
								<div class="float-end">
									<a href="javascript:window.print()"
										class="btn btn-success me-1"><i class="fa fa-print"></i></a> <a
										href="#" class="btn btn-primary w-md">Back to Homepage</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<form id="paymentDoneForm" action="<%=request.getContextPath()%>/PaymentDone" method="POST">
		<input type="hidden" name="memberId"
			value="<%=request.getParameter("member_id")%>">
	</form>

	<!-- Add a script to submit the form on page load -->
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			document.getElementById("paymentDoneForm").submit();
		});
	</script>
 --%>


</body>
</html>