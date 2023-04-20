package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.mysql.cj.jdbc.CallableStatement;

import util.MysqlUtil;
import vo.ProductVO;

public class BaljuDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst;
	CallableStatement cst;
	ResultSet rs;
	
	//[태영] 기업별 발주 체크리스트 가져오기(안전재고>현재재고)
	public List<ProductVO> selectBaljuCheckList(int company_id){
		String sql = """
				select product_code, product_name, product_stock, product_safety, (product_safety-product_stock)as order_quantity
				from product
				where company_id=? and (product_safety-product_stock>0)
				""";
		List<ProductVO> baljuchecklist = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, company_id);
			rs = pst.executeQuery();
			while(rs.next()) {
				ProductVO product = makeproductfrombalju(rs);
				baljuchecklist.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		
		return baljuchecklist;
	}

	//발주용 checklist 
	private ProductVO makeproductfrombalju(ResultSet rs) {
		ProductVO product = new ProductVO();
		
		try {
			product.setProduct_code(rs.getInt("product_code"));
			product.setProduct_name(rs.getString("product_name"));
			product.setProduct_stock(rs.getInt("product_stock"));
			product.setProduct_safety(rs.getInt("product_safety"));
			product.setOrder_quantity(rs.getInt("order_quantity"));
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return product;
	}
	
	
}
