package library.models;
import java.sql.*;

public class Book_Model {
    
	PreparedStatement ps;
    ResultSet rs;
    
	public ResultSet getAllBooks() {
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select a.*,b.category_name from book_details a, book_category b where a.book_category_id=b.category_id";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
               
                return rs;
            }
            catch(Exception e) {
                e.printStackTrace();
                return null;
            }
        }  
        return null;
    }
	
    public ResultSet getBook(int id) {
        
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select * from book_details where book_id=?";
                ps = con.prepareStatement(sql);
                ps.setInt(1,id);
                rs = ps.executeQuery();
                
                return rs;
            }
            catch(Exception e) {
                e.printStackTrace();
                return null;
            }
        }  
        return null;
    }
    
    public int addBook(String name, String isbn, String author, int edition, int category) {
        
        Connection con = Connection_DB.getConnection();
        int result = 0;
        
        if(con != null) {
            try {
                String sql="Insert into book_details values(NULL,?,?,?,?,?)";
                ps = con.prepareStatement(sql);
                ps.setString(1,name);
                ps.setString(2,isbn);
                ps.setString(3,author);
                ps.setInt(4,edition);
                ps.setInt(5,category);
                result = ps.executeUpdate();

                System.out.println(result);

                return result;
            }
            catch(Exception e) {
                e.printStackTrace();
                return result;
            }
        } 
        return result;
    }
	
	public ResultSet getCategoryAllBooks(int category_id) {
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select a.*,b.category_name from book_details a, book_category b where a.book_category_id=b.category_id AND b.category_id=? ORDER BY b.category_name";
                ps = con.prepareStatement(sql);
				ps.setInt(1,category_id);
                rs = ps.executeQuery();

                return rs;
            }
            catch(Exception e) {
                e.printStackTrace();
                return null;
            }
        }  
        return null;
    }
	
	public ResultSet getCategoryName() {
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select * from book_category";
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                
                return rs;
            }
            catch(Exception e) {
                e.printStackTrace();
                return null;
            }
        }  
        return null;
    }
}