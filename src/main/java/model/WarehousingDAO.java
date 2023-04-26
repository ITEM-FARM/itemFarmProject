package model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import util.MysqlUtil;
import vo.WarehousingVO;

public class WarehousingDAO {
	Connection conn;
	PreparedStatement pst; 
	ResultSet rs;
	
	// 은빈: 입출고 내역 조회
	public List<WarehousingVO> warehousingList(int comID, String cond) {
		String sql_unstoring = """
			select product_code, product_name, unstoring_date, unstoring_quantity
			from unstoring_detail
			join unstoring using(unstoring_code)
			join product using(product_code)
			where unstoring_state='출고완료' and company_id = ?	
			""";
		String sql_storing = """
			select product_code, product_name, balju_code, storing_date, storing_quantity
			from storing_detail
			join storing using(storing_code)
			join product using(product_code)
			where company_id = ?
			""";
		
		conn = MysqlUtil.getConnection();
		List<WarehousingVO> warehousingList = new ArrayList<>();
		
		try {
			if (!cond.equals("storing")) {
				pst = conn.prepareStatement(sql_unstoring);
				
				pst.setInt(1, comID);
				rs = pst.executeQuery();
				
				while(rs.next()) {
					WarehousingVO warehousing = makeWarehousing(rs, "unstoring");
					warehousingList.add(warehousing);
				}
			}
			if (!cond.equals("unstoring")) {
				pst = conn.prepareStatement(sql_storing);
				
				pst.setInt(1, comID);
				rs = pst.executeQuery();
				
				while(rs.next()) {
					WarehousingVO warehousing = makeWarehousing(rs, "storing");
					warehousingList.add(warehousing);
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		
		Collections.sort(warehousingList);
		return warehousingList;
	}

	// 은빈: VO 만드는 함수
	private WarehousingVO makeWarehousing(ResultSet rs, String mode) throws SQLException {
		WarehousingVO warehousing = new WarehousingVO();
		
		int product_code = rs.getInt("product_code");
		String product_name = rs.getString("product_name");
		String warehousing_state;
		String balju_code;
		Date warehousing_date;
		int warehousing_quantity;		
		
		if(mode.equals("unstoring")) {
			warehousing_state = "출고";
			balju_code = null;
			warehousing_date = rs.getDate("unstoring_date");
			warehousing_quantity = rs.getInt("unstoring_quantity");
		} else {
			warehousing_state = "입고";
			balju_code = rs.getString("balju_code");
			warehousing_date = rs.getDate("storing_date");
			warehousing_quantity = rs.getInt("storing_quantity");
		}
		
		warehousing.setBalju_code(balju_code);
		warehousing.setProduct_code(product_code);
		warehousing.setProduct_name(product_name);
		warehousing.setWarehousing_date(warehousing_date);
		warehousing.setWarehousing_quantity(warehousing_quantity);
		warehousing.setWarehousing_state(warehousing_state);
		
		return warehousing;
	}
}
