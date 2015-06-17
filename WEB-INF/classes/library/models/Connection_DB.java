package library.models;
import java.sql.*;

public class Connection_DB {
    
    static Connection con=null;
    public static Connection getConnection() {
        try {
            String connectionURL="jdbc:mysql://localhost:3306/library_management";
            Class.forName("com.mysql.jdbc.Driver");
            con=DriverManager.getConnection(connectionURL,"root","root123");
            return con;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }   
}
