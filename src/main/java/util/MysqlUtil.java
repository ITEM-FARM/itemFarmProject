package util;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
public class MysqlUtil {
	static DataSource ds=null;
	//MySQL과 JDBC연결
	 
	public static Connection getConnection() {
		Connection conn = null;
		Context initContext;
		
		try {
			initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/itemfarm");
			conn = ds.getConnection();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return conn;
		
	 
	}
	 
	
	
//	public static Connection getConnection() {
//	Connection conn = null;
//	String url="jdbc:mysql://192.168.0.97:3306/itemfarm";
//	String userid="itemfarm", password="1234";
//	try {
//		Class.forName("com.mysql.cj.jdbc.Driver");
//		conn = DriverManager.getConnection(url, userid, password);
//	} catch (ClassNotFoundException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	} catch (SQLException e) {
//		// TODO Auto-generated catch block
//		e.printStackTrace();
//	}
//	return conn;
//}
	
	//자원반납
		public static void dbDisconnect(ResultSet rs, Statement st, Connection conn) {
			try {
				if(rs!=null) rs.close();
				if(st!=null) st.close();
				if(conn!=null) conn.close();
				ds = null;
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
}