package library.models;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;


public class Book_Issue_Return_Model {
    
    PreparedStatement ps;
    ResultSet rs;
    
    public ResultSet getIssuedBook(String uname) {
        
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select a.*,b.book_name,b.book_author,c.member_id from book_details b, book_issue_return a, member_details c where a.book_id=b.book_id AND c.member_id=a.member_id AND c.member_username=?";
                ps = con.prepareStatement(sql);
                ps.setString(1,uname);
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
    
    public int addIssuedBook(String issue_date, String exp_return_date, int book_id, int member_id) {
        
        Connection con = Connection_DB.getConnection();
        int result = 0;
        int fine = 0;
        
        if(con != null) {
            try{
                String sql="Insert into book_issue_return values(NULL,?,?,NULL,?,?,'issued')";
                ps = con.prepareStatement(sql);
                ps.setString(1,issue_date);
                ps.setString(2,exp_return_date);
                ps.setInt(3,book_id);
                ps.setInt(4,member_id);
                result = ps.executeUpdate();
                
                return result;
            }
            catch(Exception e) {
                e.printStackTrace();
                return result;
            }
        }
        return result;
    }
    
    public ResultSet getBookId(String book_name) {
        
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select book_id,book_name from book_details where book_name=?";
                ps = con.prepareStatement(sql);
                ps.setString(1,book_name);
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
	
	public ResultSet getAllIssuedBooks(String uname) {
        
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select a.*,b.book_name,c.member_username from book_issue_return a, book_details b, member_details c where a.book_id=b.book_id AND a.member_id=c.member_id AND member_username=?";
                ps = con.prepareStatement(sql);
                ps.setString(1,uname);
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
	
	public ResultSet getAllIssuedBooks() {
        
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select a.*,b.book_name,c.member_first_name,c.member_last_name from book_issue_return a, book_details b, member_details c where a.book_id=b.book_id AND a.member_id=c.member_id AND a.status='issued'";
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
	
	public long calculateDate(String startDate, String stopDate){
        
        long diffDays=0;
        
        try {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date start_dt = format.parse(startDate);
            Date stop_dt = format.parse(stopDate);

            long date_diff = stop_dt.getTime() - start_dt.getTime();
            diffDays = date_diff / (24 * 60 * 60 * 1000);

            return diffDays;
        }
        catch(Exception e){
            e.printStackTrace();
            return diffDays;
        }
    }
	
	public int returnBookStatus(int book_id, int member_id, String act_return_date){
	
		Connection con = Connection_DB.getConnection();
		int result = 0;
		
        if(con != null) {
			try {
				String sql = "Update book_issue_return set status='returned', actual_return_date=? where book_id=? AND member_id=?";
				ps = con.prepareStatement(sql);
				ps.setString(1,act_return_date);
				ps.setInt(2,book_id);
				ps.setInt(3,member_id);
				result = ps.executeUpdate();
				
				return result;
			}
			catch(Exception e){
				e.printStackTrace();
				return result;
			}
        }
		return result;
	}
}