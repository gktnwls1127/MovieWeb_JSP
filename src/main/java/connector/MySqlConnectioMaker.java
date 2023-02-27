package connector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySqlConnectioMaker implements ConnectionMaker{
    private final String ADDRESS = "jdbc:mysql://localhost/movie";
    private final String USERNAME = "root";
    private final String PASSWORD = "1111";
    @Override
    public Connection makeConnection() {
        Connection connection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(ADDRESS, USERNAME, PASSWORD);

        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }

        return connection;
    }
}
