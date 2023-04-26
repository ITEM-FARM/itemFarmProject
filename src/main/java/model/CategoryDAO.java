package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.MysqlUtil;
import vo.CategoryVO;

public class CategoryDAO {
	Connection conn;
	Statement st;
	ResultSet rs;
	
	public List<CategoryVO> categoryList() {
		String sql = "select * from category";
		List<CategoryVO> categoryList = new ArrayList<>();
		
		conn = MysqlUtil.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				CategoryVO category = new CategoryVO();
				category.setCategory_code(rs.getString("Category_code"));
				category.setCategory_name(rs.getString("Category_name"));
				
				categoryList.add(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, st, conn);
		}
		
		return categoryList;
	}
	
	public List<CategoryVO> subcategoryList() {
		String sql = "select * from subcategory";
		List<CategoryVO> categoryList = new ArrayList<>();
		
		conn = MysqlUtil.getConnection();
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			
			while(rs.next()) {
				CategoryVO category = new CategoryVO();
				category.setCategory_code(rs.getString("Category_code"));
				category.setSubcategory_name(rs.getString("Subcategory_name"));
				
				categoryList.add(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, st, conn);
		}
		
		return categoryList;
	}
}
