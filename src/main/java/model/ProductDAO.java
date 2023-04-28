package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mysql.cj.MysqlConnection;

import util.MysqlUtil;
import vo.CompanyVO;
import vo.ProductVO;

public class ProductDAO {
	Connection conn;
	Statement st;
	PreparedStatement pst; // ?지원
	ResultSet rs;
	int resultCount;
	
	// 은빈: 특정 기업의 전체 상품 조회
	public List<ProductVO> productList(int comID, String cond) {
		String sql = "select * from product join manager using(manager_id) where company_id=" + comID;
		
		if (!cond.equals("all")) {
			sql += " and product_status='" + cond + "'";
		}
		List<ProductVO> productList = new ArrayList<>();
		
		conn = MysqlUtil.getConnection();
		
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				ProductVO product = makeAllProduct(rs);
				productList.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, st, conn);
		}
		
		return productList;
	}
	
	// 은빈: 상품 정보 수정
	public int productModify(ProductVO product) {
		String sql = """
				update product
				set subcategory_name=?, product_name=?, product_cost=?, product_price=?,
				product_stock=?, product_safety=?, product_status=?
				where product_code=?
				""";
		
		conn = MysqlUtil.getConnection();
		
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, product.getSubcategory_name());
			pst.setString(2, product.getProduct_name());
			pst.setInt(3, product.getProduct_cost());
			pst.setInt(4, product.getProduct_price());
			pst.setInt(5, product.getProduct_stock());
			pst.setInt(6, product.getProduct_safety());
			pst.setString(7, Character.toString(product.getProduct_status()));
			pst.setInt(8, product.getProduct_code());
			resultCount = pst.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(null, pst, conn);
		}
		
		return resultCount;
	}
	
	// 은빈: 상품 등록
	public int productInsert(ProductVO product) {
		String sql = """
			insert into product(product_code, subcategory_name, company_id, product_name, product_cost, product_price,
								product_stock, product_safety, product_status, product_regdate, manager_id)
			values(nextval('seq_product'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
			""";
		
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, product.getSubcategory_name());
			pst.setInt(2, product.getCompany_id());
			pst.setString(3, product.getProduct_name());
			pst.setInt(4, product.getProduct_cost());
			pst.setInt(5, product.getProduct_price());
			pst.setInt(6, product.getProduct_stock());
			pst.setInt(7, product.getProduct_safety());
			pst.setString(8, Character.toString(product.getProduct_status()));
			pst.setTimestamp(9, product.getProduct_regdate());
			pst.setString(10, product.getManager_id());
			resultCount = pst.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(null, pst, conn);
		}
		
		return resultCount;
	}

	//이솔: product 상품명, 상품코드 톻합검색
	public List<ProductVO> productSelect(String selectValue, String valueType, int comId) {
		Map<String, String> map = new HashMap<>();
		String sql = "select * from product  where company_id = " + comId;
		
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
				  sql += " and (";
				  count++;
			  } else {
				  sql += " or";
			  }
			  sql+=" cast(" + product.getKey() + " as char(10)) like '%" + product.getValue() + "%'";  
		  }
		  
		sql += ")";
				
		System.out.println(sql);
		  
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
	
	// 은빈: 조회, 수정을 위한 모든 열이 있는 상품 만들기
	private ProductVO makeAllProduct(ResultSet rs) throws SQLException {
		ProductVO product = new ProductVO();		
		
		product.setCompany_id(rs.getInt("Company_id"));
		product.setProduct_code(rs.getInt("Product_code"));
		product.setSubcategory_name(rs.getString("Subcategory_name"));
		product.setProduct_name(rs.getString("Product_name"));
		product.setProduct_cost(rs.getInt("Product_cost"));
		product.setProduct_price(rs.getInt("Product_price"));
		product.setProduct_stock(rs.getInt("Product_stock"));
		product.setProduct_safety(rs.getInt("Product_safety"));
		product.setProduct_regdate(rs.getTimestamp("Product_regdate"));
		product.setProduct_status(rs.getString("Product_status").charAt(0));
		product.setManager_name(rs.getString("Manager_name"));
		
		return product;
	}

}