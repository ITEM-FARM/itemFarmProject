package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.MysqlUtil;
import vo.CompanyVO;
import vo.ProductVO;
import vo.StatisticsVO;

public class StatisticsDAO {
	
	Connection conn;
	Statement st;
	PreparedStatement pst; // ?지원
	PreparedStatement pst2; // ?지원
//	CallableStatement cst; //SP지원 (Stored Procedure 할때 필요) 
	ResultSet rs;
	int resultCount; // insert, update, delete건수
	int result; // executeBatch의 리턴값들을 담기 위한 변수
	double comm; // 기업별 수수료 데이터 담기 위한 변수 
	
	
	// 기업별 수수료 데이터 가져오는 작업
	public CompanyVO commission(CompanyVO company) {
		String sql = """
				select company_commission 
				from company
				where company_id = ?
				""";
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, company.getCompany_id());
			
			rs = pst.executeQuery();
			while(rs.next()) {
				company.setCompany_commission(rs.getDouble("company_commission"));
//				company.setCompany_status(rs.getString("company_status").charAt(0)); // status가 char(1)라서
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return company;
	}
	
	
	// 상품별 매출통계
	public List<StatisticsVO> byProduct_order(CompanyVO company) {
		String sql_order = """
				select * 
				from  
				(select '주문', product_code '주문코드', product_name '주문상품', sum(unstoring_quantity) '주문수량'  , sum(product_price) '주문금액', sum(product_cost) '주문원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ?
				group by product_name, product_code) AA 
				left outer join 
				(select '주문취소', product_code '취소코드', product_name '취소상품', sum(unstoring_quantity) '취소수량' , sum(product_price) '취소금액', sum(product_cost) '취소원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? and unstoring_state = '주문취소'
				group by product_name, product_code) BB on (AA.주문상품 = BB.취소상품)
				union
				select *
				from 
				(select '주문', product_code '주문코드', product_name '주문상품', sum(unstoring_quantity) '주문수량'  , sum(product_price) '주문금액', sum(product_cost) '주문원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? 
				group by product_name, product_code) AA  
				right outer  join 
				(select '주문취소', product_code '취소코드', product_name '취소상품', sum(unstoring_quantity) '취소수량' , sum(product_price) '취소금액', sum(product_cost) '취소원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? and unstoring_state = '주문취소'
				group by product_name, product_code) BB  on (AA.주문상품 = BB.취소상품)
				""";
		List<StatisticsVO> statList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql_order);
			pst.setInt(1, company.getCompany_id());
			pst.setInt(2, company.getCompany_id());
			pst.setInt(3, company.getCompany_id());
			pst.setInt(4, company.getCompany_id());
			
			rs = pst.executeQuery();
			while(rs.next()) {
				StatisticsVO stat = makeByProduct(rs, company);
				statList.add(stat);
			}
		} catch (SQLException e) {
			System.out.println("DAO - 상품별 매출통계에서 에러");
			e.printStackTrace();
		}
		return statList;
	}
	
	
	private StatisticsVO makeByProduct(ResultSet rs, CompanyVO company) throws SQLException {
		StatisticsVO stat = new StatisticsVO();
		int oc, oa, cc, ca;
		int total_cost; // 판매원가 (=총 원가)
		int revenue; // 순매출액
		double net_margin_profit; // 순이익률
		
		stat = common(rs, company);
		stat.setOrder_product_name(rs.getString("주문상품"));
		stat.setCancel_product_name(rs.getString("취소상품"));
		stat.setOrder_product_code(rs.getInt("주문코드"));
		stat.setCancel_product_code(rs.getInt("취소코드"));
		
		return stat;
	}
 

	// 카테고리별 매출통계
	public List<StatisticsVO> category_order(CompanyVO company) {
		String sql_order = """
				select * 
				from  
				(select '주문', subcategory_name '주문_카테고리', sum(unstoring_quantity) '주문수량'  , sum(product_price) '주문금액', sum(product_cost) '주문원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? 
				group by subcategory_name) AA 
				left outer join 
				(select '주문취소', subcategory_name '취소_카테고리', sum(unstoring_quantity) '취소수량' , sum(product_price) '취소금액', sum(product_cost) '취소원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? and unstoring_state = '주문취소'
				group by subcategory_name) BB on (AA.주문_카테고리 = BB.취소_카테고리)
				union
				select *
				from 
				(select '주문', subcategory_name '주문_카테고리', sum(unstoring_quantity) '주문수량'  , sum(product_price) '주문금액', sum(product_cost) '주문원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ?
				group by subcategory_name) AA  
				right outer  join 
				(select '주문취소', subcategory_name '취소_카테고리', sum(unstoring_quantity) '취소수량' , sum(product_price) '취소금액', sum(product_cost) '취소원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? and unstoring_state = '주문취소'
				group by subcategory_name) BB  on (AA.주문_카테고리 = BB.취소_카테고리)
				""";
		List<StatisticsVO> statList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql_order);
			pst.setInt(1, company.getCompany_id());
			pst.setInt(2, company.getCompany_id());
			pst.setInt(3, company.getCompany_id());
			pst.setInt(4, company.getCompany_id());
			
			rs = pst.executeQuery();
			while(rs.next()) {
				StatisticsVO stat = makeCategory(rs, company);
				statList.add(stat);
			}
		} catch (SQLException e) {
			System.out.println("DAO - 카테고리별 매출통계에서 에러");
			e.printStackTrace();
		}
		return statList;
	}
	
	
	private StatisticsVO makeCategory(ResultSet rs, CompanyVO company) throws SQLException {
		StatisticsVO stat = new StatisticsVO();
		int oc, oa, cc, ca;
		int total_cost; // 판매원가 (=총 원가)
		int revenue; // 순매출액
		double net_margin_profit; // 순이익률
		
		stat = common(rs, company);
		stat.setOrder_subcategory_name(rs.getString("주문_카테고리"));
		stat.setCancel_subcategory_name(rs.getString("취소_카테고리"));
		
		return stat;
	}
	
	
	// 일별 매출통계
	public List<StatisticsVO> daily_order(CompanyVO company) {
		String sql_order = """
				select * 
				from  
				(select '주문', order_register '주문일자', sum(unstoring_quantity) '주문수량'  , sum(product_price) '주문금액', sum(product_cost) '주문원가'  
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? 
				group by order_register
				order by order_register desc) AA 
				left outer join 
				(select '주문취소', order_register '취소일자', sum(unstoring_quantity) '취소수량' , sum(product_price) '취소금액', sum(product_cost) '취소원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? and unstoring_state = '주문취소'
				group by order_register) BB on (AA.주문일자 = BB.취소일자)
				union
				select *
				from 
				(select '주문', order_register '주문일자', sum(unstoring_quantity) '주문수량'  , sum(product_price) '주문금액', sum(product_cost) '주문원가'  
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? group by order_register) AA  
				right outer  join 
				(select '주문취소', order_register '취소일자', sum(unstoring_quantity) '취소수량' , sum(product_price) '취소금액', sum(product_cost) '취소원가'
				from product join unstoring_detail using(product_code) join unstoring using(unstoring_code)
				where company_id = ? and unstoring_state = '주문취소'
				group by order_register) BB  on (AA.주문일자 = BB.취소일자)
				""";
		List<StatisticsVO> statList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql_order);
			pst.setInt(1, company.getCompany_id());
			pst.setInt(2, company.getCompany_id());
			pst.setInt(3, company.getCompany_id());
			pst.setInt(4, company.getCompany_id());
			
			rs = pst.executeQuery();
			while(rs.next()) {
				StatisticsVO stat = makeStat(rs, company);
				statList.add(stat);
			}
		} catch (SQLException e) {
			System.out.println("DAO - 일별 매출통계에서 에러");
			e.printStackTrace();
		}
		return statList;
	}
	
	
	private StatisticsVO makeStat(ResultSet rs, CompanyVO company) throws SQLException {
		StatisticsVO stat = new StatisticsVO();
		int oc, oa, cc, ca;
		int total_cost; // 판매원가 (=총 원가)
		int revenue; // 순매출액
		double net_margin_profit; // 순이익률
		
		stat = common(rs, company);
		stat.setOrder_register(rs.getString("주문일자"));
		stat.setCancel_register(rs.getString("취소일자"));
		
		return stat; 
	}
	
	
	// 공통 작업을 위한 메소드
	private StatisticsVO common(ResultSet rs, CompanyVO company) throws SQLException {
		StatisticsVO stat = new StatisticsVO();
		int oc, oa, cc, ca;
		int total_cost; // 판매원가 (=총 원가)
		int revenue; // 순매출액
		double net_margin_profit; // 순이익률
		
		oc = rs.getInt("주문수량");
		oa = rs.getInt("주문금액");
		cc = rs.getInt("취소수량");
		ca = rs.getInt("취소금액");
		total_cost = rs.getInt("주문원가") - rs.getInt("취소원가"); 
		
		stat.setOrder_count(oc);
		stat.setOrder_amount(oa);
		stat.setCancel_count(cc);
		stat.setCancel_amount(ca);
		stat.setRevenue_count(oc-cc); // DAO에서 바로 계산하여 순매출수량 세팅
		stat.setRevenue_amount(oa-ca); // 순매출액 세팅
		revenue = oa - ca;
		
		// 이따가 기업별 comm 받아서 여기서 계산해서 순이익 세팅해버리자
		comm = company.getCompany_commission();
		stat.setCommission(comm);
		stat.setTotal_cost(total_cost); // 판매원가
		stat.setNet_profit((revenue-total_cost)*(1-comm)); // 순이익 = (순매출 - 총 원가) * 커미션
//		System.out.println((revenue-total_cost)*(1-comm) + " : 순이익 double 소수점 몇째자리까지??");
		
		// 순이익률
		net_margin_profit = (((revenue-total_cost)*(1-comm))/revenue);
		if(Double.isNaN(net_margin_profit)) {
			net_margin_profit = 0;
		}
		stat.setNet_profit_margin(net_margin_profit);
		
		return stat;
	}
	
	
	
	
	


	/*
	 * // 일별 매출통계 (2)주문 취소 public void daily_cancel(CompanyVO company) { String sql
	 * = """ select order_register '주문일자', sum(unstoring_quantity) '취소수량',
	 * sum(product_price) '취소금액' from product join unstoring_detail
	 * using(product_code) join unstoring using(unstoring_code) where company_id = ?
	 * and unstoring_state = '주문취소' group by order_register """; conn =
	 * MysqlUtil.getConnection(); try { pst = conn.prepareStatement(sql);
	 * pst.setInt(1, company.getCompany_id()); } catch (SQLException e) {
	 * System.out.println("DAO - 일별 매출통계 (2)에서 에러"); e.printStackTrace(); } }
	 */
}
