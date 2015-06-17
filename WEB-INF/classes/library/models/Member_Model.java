package library.models;
import java.sql.*;

public class Member_Model {
    
    PreparedStatement ps;
    ResultSet rs;
    
    public ResultSet getMember(String uname) {
        System.out.println("connecting");
        Connection con = Connection_DB.getConnection();
		 System.out.println("connected");
        if(con != null) {
            try {
                String sql="Select * from member_details where member_username=?";
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
    
	public ResultSet getMemberId(String member_uname) {
        
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select member_id,member_username from member_details where member_username=?";
                ps = con.prepareStatement(sql);
                ps.setString(1,member_uname);
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
	
    public int addMember(String fname, String lname, String email, String phno, String uname, String pswd) {
        
        Connection con = Connection_DB.getConnection();
        int result = 0;
        
        if(con != null) {
            try {
                String sql="Insert into member_details values(NULL,?,?,?,?,?,?,2)";
                ps = con.prepareStatement(sql);
                ps.setString(1,fname);
                ps.setString(2,lname);
                ps.setString(3,email);
                ps.setString(4,phno);
                ps.setString(5,uname);
                ps.setString(6,pswd);
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
	
	public ResultSet getAllMembers() {
        Connection con = Connection_DB.getConnection();
        if(con != null) {
            try {
                String sql="Select * from member_details";
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