package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;

import vo.WarehousingVO;

public class WarehousingDAO {
	Connection conn; 
	Statement st;
	PreparedStatement pst; 
	CallableStatement cst; 
	ResultSet rs;
	
	public List<WarehousingVO> warehousingList(String cond) {
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
			join storing using(storing_id)
			join product using(product_code)
			where company_id = ?
			""";
		
		return null;
	}
}
