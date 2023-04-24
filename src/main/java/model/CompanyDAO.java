package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.MysqlUtil;
import vo.CompanyVO;

public class CompanyDAO {
	Connection conn; 
	Statement st;
	PreparedStatement pst; 
	CallableStatement cst; 
	ResultSet rs;
	int resultCount;
	
	// 은빈: 전체 기업 조회
	public List<CompanyVO> companyList() {
		String sql = "select * from company order by company_id";
		List<CompanyVO> companyList = new ArrayList<>();
		
		conn = MysqlUtil.getConnection();
		
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				CompanyVO company = makeCompany(rs);
				companyList.add(company);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, st, conn);
		}
		
		
		return companyList;
	}
	
	// 은빈: 기업 정보 수정
	public int companyModify(CompanyVO company) {
		String sql = """
				update company
				set company_name=?, company_pw=?, company_commission=?, company_status=?
				where company_id=?
				""";
		
		conn = MysqlUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, company.getCompany_name());
			pst.setString(2, company.getCompany_pw());
			pst.setDouble(3, company.getCompany_commission());
			pst.setString(4, Character.toString(company.getCompany_status()));
			pst.setInt(5, company.getCompany_id());
			resultCount = pst.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(null, pst, conn);
		}
		return resultCount;
	}
	
	// 은빈: 기업 등록
	
	
	// 은빈: 첫 기업 불러오기 (3PL 로그인 시 선택될 default 기업)
	public CompanyVO defaultCompany() {
		String sql = "select company_id, company_name from company order by company_id limit 1";
		CompanyVO company = null;
		
		conn = MysqlUtil.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			if(rs.next()) {
				company = new CompanyVO();
				company.setCompany_id(rs.getInt("Company_id"));
				company.setCompany_name(rs.getString("Company_name"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, st, conn);
		}
		
		return company;
	}

	// 은빈: company 객체 생성
	private CompanyVO makeCompany(ResultSet rs) throws SQLException {
		CompanyVO company = new CompanyVO();
		
		company.setCompany_commission(rs.getDouble("Company_commission"));
		company.setCompany_id(rs.getInt("Company_id"));
		company.setCompany_name(rs.getString("Company_name"));
		company.setCompany_pw(rs.getString("Company_pw"));
		company.setCompany_status(rs.getString("Company_status").charAt(0));
		
		return company;
	}
}
