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

		response.sendRedirect("http://localhost:8080/JAD-CA2/pages/paymentSuccessful.jsp");

		try {
			StringBuilder htmlBuilder = new StringBuilder();

			Connection conn = DBConnection.getConnection();

			String sqlCall = "{CALL ProcessOrder(?)}";

			CallableStatement cs = conn.prepareCall(sqlCall);
			cs.setString(1, memberId);

			// Step 5: Execute SQL query
			ResultSet rs = cs.executeQuery();
			while(rs.next()) {
				
			}
			
			
			response.sendRedirect(path+"//paymentSuccessful.jsp");

			
			// Close connection
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			out.println("Error: " + e);
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
