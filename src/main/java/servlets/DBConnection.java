package servlets;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	public static Connection getConnection() {
		Connection connection = null;

		/*
		 * String dbUrl =
		 * "jdbc:mysql://jad-database.coaftljc64cm.us-east-1.rds.amazonaws.com/bookstore";
		 * String dbUser = "admin"; String dbPassword = "pjraj12!";
		 */

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try {
			connection = DriverManager.getConnection("jdbc:mysql://localhost/bookstore?user=root&password=pjraj12!&serverTimezone=UTC");
			//connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return connection;

	}
}
