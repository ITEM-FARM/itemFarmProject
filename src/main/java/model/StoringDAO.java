package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.MysqlUtil;
import vo.BaljuVO;
import vo.StoringVO;

public class StoringDAO {
	Connection conn;
	Statement st;
	ResultSet rs;
	PreparedStatement pst;

	int resultCount;

	//[이솔]: insert 입고 (그룹)
	public int insertStoringList(StoringVO storing) {
		String sql = """
				
				insert into storing(storing_code, manager_id, storing_date, storing_memo)
				values (?, ?, ?, ?) 
				
				""";
		conn = MysqlUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, storing.getStoring_code());
			pst.setString(2, storing.getManager_id());
			pst.setTimestamp(3, storing.getStoring_date());
			pst.setString(4, storing.getStoring_memo());
			
			resultCount = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		return resultCount;
	}

	//[이솔] insert 입고 상세
	public int insertStoringDetail(List<StoringVO> storingDetailList) {
		int[] totalArr = new int[storingDetailList.size()];
		String sql = """
				
				insert into storing_detail(storing_code, product_code, balju_code, storing_quantity)
				values (?, ?, ?, ?)
				
				""";
		
		conn = MysqlUtil.getConnection();
		
		try {
			conn.setAutoCommit(false);
			pst = conn.prepareStatement(sql);
			String balju_code = null;
			for (StoringVO detail : storingDetailList) {
				pst.setString(1, detail.getStoring_code());
				pst.setInt(2, detail.getProduct_code());
				if( !detail.getBalju_code().equals("-")) {
					balju_code = detail.getBalju_code();
				}
				pst.setString(3, balju_code);
				pst.setInt(4, detail.getStoring_quantity());
				
				
				
				pst.addBatch();
				pst.clearParameters();
				
			}
			
			totalArr = pst.executeBatch();
			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		
		
		return totalArr.length;
	}

	
	//[이솔] 입고 내역 조회(그룹)
	public List<StoringVO> selectStoringList(int company_id) {
		String sql = """
				SELECT s.storing_code, s.storing_date, s.manager_id, s.storing_memo
				FROM storing s JOIN storing_detail d ON s.storing_code = d.storing_code 
					JOIN product p ON d.product_code = p.product_code
				WHERE company_id = ?
				GROUP BY s.storing_code 
				ORDER bY s.storing_date desc 
				""";
		List<StoringVO> storingList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, company_id);
			rs = pst.executeQuery();
			while(rs.next()) {
				StoringVO storing = makeStoring(rs);
				storingList.add(storing);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		
		return storingList;
	}
	
	
	//[이솔] 입고 내역 조회(상세)
	public List<StoringVO> selectStoringDetail(String storing_code) {
		String sql = """
				SELECT d.product_code, p.product_name, d.storing_quantity, d.balju_code
				FROM storing s JOIN storing_detail d ON s.storing_code = d.storing_code 
							JOIN product p ON d.product_code = p.product_code
				WHERE s.storing_code = '""" + storing_code + "'";
	
		
		List<StoringVO> storingList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				System.out.println("있음?");
				StoringVO storing = makeStoringDetail(rs);
				storingList.add(storing);
			}
			
	
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		
		return storingList;
	}
	
	
	private StoringVO makeStoring(ResultSet rs) {
		StoringVO storing = new StoringVO();
		try {
			storing.setStoring_code(rs.getString("storing_code"));
			storing.setStoring_date(rs.getTimestamp("storing_date"));
			storing.setManager_id(rs.getString("manager_id"));
			storing.setStoring_memo(rs.getString("storing_memo"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return storing;
	}
	
	
	private StoringVO makeStoringDetail(ResultSet rs) throws SQLException {
		StoringVO storing = new StoringVO();
		
		storing.setProduct_code(rs.getInt("product_code"));
		storing.setProduct_name(rs.getString("product_name"));
		storing.setStoring_quantity(rs.getInt("storing_quantity"));
		storing.setBalju_code(rs.getString("balju_code"));
		
		return storing;
	}


	

}
