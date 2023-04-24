package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import util.MysqlUtil;
import vo.CompanyVO;
import vo.ManagerVO;

public class LoginDAO {
	Connection conn;
	PreparedStatement st;
	ResultSet rs;
	
	//manager 로그인 
	public ManagerVO ManagerloginCheck(String id, String pw) {
		ManagerVO manager = null;
		
		String sql = "select * from manager where manager_id=? and manager_pw=?;";
		
		conn = MysqlUtil.getConnection();
		
		try {
			st = conn.prepareStatement(sql);
			st.setString(1, id);
			st.setString(2, pw);
			rs = st.executeQuery();
			while(rs.next()) {
				manager = new ManagerVO();
				manager.setManager_id(id);
				manager.setManager_name(rs.getString("manager_name"));
				manager.setManager_pw(pw);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			MysqlUtil.dbDisconnect(rs, st, conn); 
		}
		return manager;
	}
	
	//기업 로그인
	public CompanyVO companyLoginCheck(int id, String pw) {
		CompanyVO company = null;
		
		String sql = "select * from company where company_id=? and company_pw=?";
		
		conn = MysqlUtil.getConnection();
		
		try {
			st = conn.prepareStatement(sql);
			st.setInt(1, id);
			st.setString(2, pw);
			rs = st.executeQuery();
			while(rs.next()) {
				company = new CompanyVO();
				company.setCompany_commission(rs.getDouble("company_commission"));
				company.setCompany_id(id);
				company.setCompany_name(rs.getString("company_name"));
				company.setCompany_pw(pw);
				company.setCompany_status(rs.getString("company_status").charAt(0));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			MysqlUtil.dbDisconnect(rs, st, conn); 
		}
		return company;
	}
}
