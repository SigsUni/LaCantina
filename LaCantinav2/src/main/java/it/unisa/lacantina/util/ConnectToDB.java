package it.unisa.lacantina.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectToDB {

    private static final String DEFAULT_URL  = "jdbc:mysql://localhost:3306/LaCantina";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASS = "";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver non trovato", e);
        }

        String url  = System.getProperty("lacantina.db.url",  DEFAULT_URL);
        String user = System.getProperty("lacantina.db.user", DEFAULT_USER);
        String pass = System.getProperty("lacantina.db.pass", DEFAULT_PASS);

        return DriverManager.getConnection(url, user, pass);
    }
}
