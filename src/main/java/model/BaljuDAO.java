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
import vo.BaljuVO;
import vo.ProductVO;

public class BaljuDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst;
	CallableStatement cst;
	ResultSet rs;
	int resultCount;
	
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

	//[태영]발주 상품 가져오는 용 checklist 
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
	
	/////////////////////////////////////////////////////////////////////////////////////////
	
	//[태영] 기업별 발주 넣기 in balju 테이블
	public int createBaljuBox(BaljuVO balju) {
		String sql = """
			insert into balju values ( ?, ?, ?, ?)
		""";
		
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, balju.getBalju_code());
			pst.setString(2, balju.getManager_id());
			pst.setTimestamp(3, balju.getBalju_date());
			pst.setString(4, balju.getBalju_memo());
			
			resultCount = pst.executeUpdate();
			System.out.println("Balju resultCount:" + resultCount );
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			MysqlUtil.dbDisconnect(null, pst, conn);
		}
		return resultCount;
	}
	
	//[태영] 기업별 발주넣기 in balju_detail 테이블 
	public int baljuIteminBaljuBox(BaljuVO balju) {
		//해당 발주코드가 balju테이블에 있는지 확인후 balju_detail에 넣는다.
		String sql = """
			insert into balju_detail(balju_code, product_code, balju_quantity)
			values ( 
				(select balju_code from balju where balju_code=?), ?, ?
			)
		""";
		conn = MysqlUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, balju.getBalju_code());
			pst.setInt(2, balju.getProduct_code());
			pst.setInt(3, balju.getBalju_quantity());
			
			resultCount = pst.executeUpdate();
			System.out.println("Balju_detail resultCount:" + resultCount);
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			MysqlUtil.dbDisconnect(null, pst, conn);
		}
		return resultCount;
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////
	
}
