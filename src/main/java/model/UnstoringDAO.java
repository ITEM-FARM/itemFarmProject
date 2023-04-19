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
import vo.UnstoringVO;

public class UnstoringDAO {
	
	Connection conn;
	Statement st;
	PreparedStatement pst; // ?지원
//	CallableStatement cst; //SP지원 (Stored Procedure 할때 필요) 
	ResultSet rs;
	int resultCount; // insert, update, delete건수

	// 신규 주문건 등록 (참조 : EmpDAO - empInsert)
	public int unstoringInsert(UnstoringVO unstore) {
		// 단, 송장번호, 출고상태에 대해선 insert X (송장번호는 null이 될 거고, 출고상태는 내가 준 디폴트값('출고대기')으로 될 듯??)
		String sql = """
				insert into unstoring(unstoring_code, customer_name, customer_address, order_register, unstoring_date, unstoring_memo, manager_id)
				values(?,?,?,?,?,?,?)
				""";
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, unstore.getUnstoring_code());
			pst.setString(2, unstore.getCustomer_name());
			pst.setString(3, unstore.getCustomer_address());
			pst.setDate(4, unstore.getOrder_register());
			pst.setDate(5, unstore.getUnstoring_date());
			pst.setString(6, unstore.getUnstoring_memo());
			pst.setString(7, unstore.getManager_id());
//			pst.setString(8, unstore.getTracking_number());
//			pst.setString(9, unstore.getUnstoring_state());
			
			resultCount = pst.executeUpdate();
			System.out.println(resultCount);
		} catch (SQLException e) {
			resultCount = -1;
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		System.out.println(resultCount);
		return resultCount;
	}
	
	// 주문건 조회 (company_id가 100번인 기업의 주문건은 VO 형태로 여러개니까 List<>)
	public List<UnstoringVO> selectAll() {
		
		String sql = """
				select * 
				from unstoring join unstoring_detail on(unstoring_code) join product on(product_code) join company on(company_id)
				where company.company_id = ?
				"""; // 에러떴음 : Column 'company_id' in where clause is ambiguous
		CompanyVO company = new CompanyVO();
		List<UnstoringVO> unstoreList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, company.getCompany_id());
			
			rs = pst.executeQuery();
			while(rs.next()) {
				UnstoringVO unstore = makeUnstore(rs);
				unstoreList.add(unstore);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		return unstoreList;
	}

	private UnstoringVO makeUnstore(ResultSet rs) throws SQLException {
		UnstoringVO unstore = new UnstoringVO();
		unstore.setUnstoring_code(rs.getString("Unstoring_code"));
		unstore.setCustomer_name(rs.getString("Customer_name"));
		unstore.setCustomer_address(rs.getString("Customer_address"));
		unstore.setOrder_register(rs.getDate("Order_register"));
		unstore.setUnstoring_date(rs.getDate("Unstoring_date"));
		unstore.setTracking_number(rs.getString("Tracking_number"));
		unstore.setUnstoring_state(rs.getNString("Unstoring_state"));
		unstore.setManager_id(rs.getString("Manager_id"));
		unstore.setUnstoring_memo(rs.getString("Unstoring_memo")); 
		
		return unstore;
	}

}
