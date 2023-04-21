package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mysql.cj.MysqlConnection;

import util.MysqlUtil;
import vo.ProductVO;

public class ProductDAO {

	Connection conn;
	Statement st;
	PreparedStatement pst; // ?지원

	ResultSet rs;
	
	public List<ProductVO> productSelect(String selectValue, String valueType) {
		Map<String, String> map = new HashMap<>();
		String sql = "select * from product  where 1=1 ";
		
		if (valueType.equals("searchTotal")) {	 
			map.put("product_code", selectValue);
			map.put("product_name", selectValue);	
		} else if(valueType.equals("searchCode")) {
			map.put("product_code", selectValue);
		} else if(valueType.equals("searchName")) {
			map.put("product_name", selectValue);
		}
		
		int count = 0;
		  for(Map.Entry<String, String> product: map.entrySet()) { 
			  if (count ==0) {
				  sql += "and";
				  count++;
			  } else {
				  sql += "or";
			  }
			  sql+=" cast(" + product.getKey() + " as char(10)) like '%" + product.getValue() + "%'";  
			  
			  
		  }
		List<ProductVO> productList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				ProductVO product =makeProduct(rs);
				productList.add(product);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, st, conn);
		}
		
		return productList;
	}

	private ProductVO makeProduct(ResultSet rs) throws SQLException {
		ProductVO product = new ProductVO();
		
		product.setProduct_code(rs.getInt("Product_code"));
		product.setProduct_name(rs.getString("Product_name"));
		product.setProduct_stock(rs.getInt("Product_stock"));
		product.setProduct_safety(rs.getInt("Product_safety"));
		
		
		
		
		return product;
	}

}
