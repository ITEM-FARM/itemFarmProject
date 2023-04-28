package model;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import util.MysqlUtil;
import vo.CompanyVO;
import vo.ProductVO;
import vo.UnstoringDetailVO;
import vo.UnstoringVO;

public class UnstoringDAO {

	Connection conn;
	Statement st;
	PreparedStatement pst; // ?지원
	PreparedStatement pst2; // ?지원
//	CallableStatement cst; //SP지원 (Stored Procedure 할때 필요) 
	ResultSet rs;
	int resultCount; // insert, update, delete건수
	int result; // executeBatch의 리턴값들을 담기 위한 변수
	
	
	// 엑셀 파일 업로드 => insert into DB
	public int ordersInsert(List<UnstoringDetailVO> list, UnstoringVO vo1, String magID) {
		String sql_1 = """
				insert into unstoring(unstoring_code, customer_name, customer_address, order_register, manager_id)
				values(?, ?, ?, ?, ?)
				""";
		String sql_2 = """
				insert into unstoring_detail
				values(?, ?, ?)
				""";
		System.out.println("magID "+magID);
		conn = MysqlUtil.getConnection();
		try {
			// 1번만 해야 하는 '출고'
			pst = conn.prepareStatement(sql_1);
			pst.setString(1, vo1.getUnstoring_code());
			pst.setString(2, vo1.getCustomer_name());
			pst.setString(3, vo1.getCustomer_address());
			pst.setDate(4, vo1.getOrder_register());
			pst.setString(5, magID);
			int result1 = pst.executeUpdate(); // 얘는 외래키 때문에 먼저 해줘야되서 일단 먼저 executeUpdate
			System.out.println("result1 "+result1);
			
			// 여러번 실행해야 하는 '출고 디테일'
			conn.setAutoCommit(false);
			pst2 = conn.prepareStatement(sql_2);
			for(int i=0; i<list.size(); i++) {
				UnstoringDetailVO detail = new UnstoringDetailVO();
				detail = list.get(i);

				pst2.setString(1, vo1.getUnstoring_code());
				pst2.setInt(2, detail.getProduct_code());
				pst2.setInt(3, detail.getUnstoring_quantity());
				pst2.addBatch();
			}
			int[] arr1 = pst2.executeBatch();
			conn.commit();
			
			int result2 = eB2(arr1);
			System.out.println("result2 "+result2);
			result = result1 + result2;
		} catch (SQLException e) {
			System.out.println("DAO - 엑셀 파일 업로드에서 에러");
			e.printStackTrace();
		}
		System.out.println("DAO result = "+result);
		return result;
	}
	
	
	// 주문건 상세조회
	public List<UnstoringDetailVO> selectUnstoringDetail(UnstoringVO vo, CompanyVO vo2) {
		String sql = """
				select ud.unstoring_code '주문번호', ud.product_code '상품번호', p.product_name '상품명', ud.unstoring_quantity '상품수량', u.customer_name, u.customer_address, u.tracking_number, u.unstoring_state
				from unstoring_detail ud join unstoring u on ud.unstoring_code = u.unstoring_code 
	                     join product p on p.product_code = ud.product_code
                         join company c on c.company_id = p.company_id
				where ud.unstoring_code = ? and c.company_id = ?
				""";
		List<UnstoringDetailVO> unstoringDetailList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setString(1, vo.getUnstoring_code());
			pst.setInt(2, vo2.getCompany_id());
			
			rs = pst.executeQuery();
			while (rs.next()) {
				UnstoringDetailVO detailVO = makeUnstoringDetail(rs);
				unstoringDetailList.add(detailVO);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		return unstoringDetailList;
	}
	
	
	private UnstoringDetailVO makeUnstoringDetail(ResultSet rs2) throws SQLException {
		UnstoringDetailVO detailVO = new UnstoringDetailVO();
		detailVO.setUnstoring_code(rs.getString("주문번호"));
		detailVO.setProduct_code(rs.getInt("상품번호"));
		detailVO.setProduct_name(rs.getString("상품명"));
		detailVO.setUnstoring_quantity(rs.getInt("상품수량"));
		
		// 용희 : 주문건 상세조회 페이지에서 '주문자 정보'를 주기 위해 필요했음.
		detailVO.setCustomer_name(rs.getString("u.customer_name"));
		detailVO.setCustomer_address(rs.getString("u.customer_address"));
		detailVO.setTracking_number(rs.getString("u.tracking_number"));
		detailVO.setUnstoring_state(rs.getString("u.unstoring_state"));
		
		return detailVO;
	}


	// 송장입력 버튼 
	// => (1) 입력한 송장번호로 update
	// => (2) 재고(product_stock) (-)되게끔 : 이건 트리거?? 아니면 update문을 2번?? (addBatch? or statement 2개?) 
	public int trackingNumberInput(List<UnstoringVO> list, String trkNum, List<UnstoringDetailVO> detailList, Timestamp timestamp) {
		String sql_track = """
				update unstoring
				set tracking_number = ?, unstoring_state = '출고완료', unstoring_date = ?
				where unstoring_code = ?
				""";
		String sql_stock = """
				update product
				set product_stock = product_stock - (select unstoring_quantity
													   from unstoring_detail
													   where product_code = ? and unstoring_code = ?)
				where product_code = ?
				""";
		conn = MysqlUtil.getConnection();
		UnstoringVO unstoring = new UnstoringVO();
		UnstoringDetailVO detailVO = new UnstoringDetailVO();
		try {
			conn.setAutoCommit(false);
			pst = conn.prepareStatement(sql_track);
			pst2 = conn.prepareStatement(sql_stock);
			
			// 여러 건을 모두 update 해야 하므로 for + addBatch/executeBatch
			for(int i=0; i<list.size(); i++) {
				// sql_track
				pst.setString(1, trkNum);
				unstoring = list.get(i);
				pst.setTimestamp(2, timestamp);
				pst.setString(3, unstoring.getUnstoring_code());
				
				// sql_stock
				detailVO = detailList.get(i);
				pst2.setInt(1, detailVO.getProduct_code());
				System.out.println("detailVO.getProduct_code() : "+detailVO.getProduct_code());
				pst2.setString(2, detailVO.getUnstoring_code());
				System.out.println("detailVO.getUnstoring_code() : "+detailVO.getUnstoring_code());
				pst2.setInt(3, detailVO.getProduct_code());
				
				pst.addBatch();
				pst2.addBatch();
			}
			int[] arr1 = pst.executeBatch();
		    int[] arr2 = pst2.executeBatch();
			conn.commit();
			
			System.out.println("DAO - 송장입력에서 arr1 " + Arrays.toString(arr1));
			System.out.println("DAO - 송장입력에서 arr2 " + Arrays.toString(arr2));
			
			result = eB1(arr1, arr2);
//			resultCount = pst.executeUpdate(); // 여러 건이어도 executeUpdate의 리턴값은 1인가 보네
		} catch (SQLException e) {
			result = -1;
			System.out.println("DAO - 송장입력에서 try catch 에러");
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		return result;
	}
	
	
	// 송장번호에 해당하는 출고상세(상품코드/주문수량) 정보를 불러오기 위한
	public List<UnstoringDetailVO> selectDetailByTrkNum(List<UnstoringVO> list) {
		String sql = """
				select unstoring_code, product_code, unstoring_quantity, unstoring_date
				from unstoring_detail join unstoring using(unstoring_code)
				where unstoring_code = ?
				""";
		conn = MysqlUtil.getConnection();
		List<UnstoringDetailVO> detailList = new ArrayList<>();
		UnstoringVO unstoring = null;
		try {
			conn.setAutoCommit(false);
			pst = conn.prepareStatement(sql);
			
			for(int i=0; i<list.size(); i++) {
				unstoring = list.get(i);
				pst.setString(1, unstoring.getUnstoring_code());
				
				rs = pst.executeQuery();
				while(rs.next()) {
					UnstoringDetailVO detailVO = new UnstoringDetailVO();
					detailVO.setUnstoring_code(rs.getString("unstoring_code"));
					detailVO.setProduct_code(rs.getInt("product_code"));
					detailVO.setUnstoring_quantity(rs.getInt("unstoring_quantity"));
//					detailVO.setUnstoring_date(rs.getTimestamp("unstoring_date"));
					System.out.println(rs.getTimestamp("unstoring_date"));
					detailList.add(detailVO);
				}
			}
		} catch (SQLException e) {
			System.out.println("DAO - 송장번호에 해당하는 출고상세(상품코드/주문수량) 정보를 불러오기에서 에러");
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		return detailList;
	}
	
	
	
	// 주문취소 버튼 => 주문상태(unstoring_state)를 '주문취소'로 update (O)
	public int cancelOrder(List<UnstoringVO> list) {
		String sql = """
				update unstoring
				set unstoring_state = '주문취소', tracking_number = 'Canceled'
				where unstoring_code = ?	
				""";
		conn = MysqlUtil.getConnection();
		UnstoringVO unstoring = new UnstoringVO();
		try {
			conn.setAutoCommit(false);
			pst = conn.prepareStatement(sql);
			
			for(int i=0; i<list.size(); i++) {
				unstoring = list.get(i);
				pst.setString(1, unstoring.getUnstoring_code());
				
				pst.addBatch();
			}
			int[] arr1 = pst.executeBatch();
			conn.commit();
			
			System.out.println("DAO - 주문취소에서 arr1 " + Arrays.toString(arr1));
			
			result = eB2(arr1);
			// resultCount = pst.executeUpdate(); // executeUpdate가 아니라 Batch를 썼으므로 이걸 쓰는건 그리 좋지 않다. (by쌤)
		} catch (SQLException e) {
			result = -1;
			System.out.println("DAO - 주문취소에서 try catch 에러");
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		return result;
	}
	
	
	// executeBatch의 리턴값인 int[] 배열을 풀어서 더해주기 위한 메소드 (송장입력/주문취소)
	public int eB1(int[] arr1, int[] arr2) {
		int result = 0;
		for(int i=0; i<arr1.length; i++) {
			result += arr1[i];
		}
		for(int i=0; i<arr2.length; i++) {
			result += arr2[i];
		}
		System.out.println("eb1 "+result);
		return result;
	}
	
	public int eB2(int[] arr1) {
		int result = 0;
		for(int i=0; i<arr1.length; i++) {
			result += arr1[i];
		}
		System.out.println("eb2 "+result);
		return result;
	}
	
	
	// 주문건 등록 양식에 '상품코드' 가져오기 위한
	public List<ProductVO> selectProductCode(CompanyVO companyVO){
		String sql = """
				select distinct(product_code) '상품번호', product_name '상품명'
				from product 
				where company_id = ?
				""";
		List<ProductVO> productList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, companyVO.getCompany_id());

			rs = pst.executeQuery();
			while (rs.next()) {
				ProductVO productVO = new ProductVO();
				productVO.setProduct_code(rs.getInt("상품번호"));
				productVO.setProduct_name(rs.getString("상품명"));
				productList.add(productVO);
			}
		} catch (SQLException e) {
			System.out.println("DAO - 상품코드 가져오는 부분에서 에러");
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		return productList;
	}
	

	// 신규 주문건 등록 - insert 2개 문장을 따로 따로하여 각 테이블에 넣기
	// (참조: 과거 EmpDAO)
	public int unstoringInsert(UnstoringVO unstoring, UnstoringDetailVO detail) {
		// 단, 송장번호, 출고상태에 대해선 insert X (송장번호는 null이 될 거고, 출고상태는 내가 준 디폴트값('출고대기')으로 될
		// 듯??)
		String sql_insert_1 = """
				insert into unstoring(unstoring_code, customer_name, customer_address, order_register, unstoring_date, unstoring_memo, manager_id)
				values(?,?,?,?,?,?,?)
				""";
		String sql_insert_2 = """
				insert into unstoring_detail(unstoring_code, product_code, unstoring_quantity)
				values(?,?,?)
				""";
		conn = MysqlUtil.getConnection();
		try {
			conn.setAutoCommit(false);
			pst = conn.prepareStatement(sql_insert_1);
			pst.setString(1, unstoring.getUnstoring_code());
			pst.setString(2, unstoring.getCustomer_name());
			pst.setString(3, unstoring.getCustomer_address());
			pst.setDate(4, unstoring.getOrder_register());
			pst.setDate(5, unstoring.getUnstoring_date());
			pst.setString(6, unstoring.getUnstoring_memo());
			pst.setString(7, unstoring.getManager_id());
			int a = pst.executeUpdate();
			System.out.println("a: "+a);
			
			pst2 = conn.prepareStatement(sql_insert_2);
			pst2.setString(1, unstoring.getUnstoring_code());
			pst2.setInt(2, detail.getProduct_code());
			pst2.setInt(3, detail.getUnstoring_quantity());
			int b = pst2.executeUpdate();
			System.out.println("b: "+b);
			
			conn.commit();

			resultCount = a+b;
			System.out.println("resultCount"+resultCount);
		} catch (SQLException e) {
			resultCount = -1;
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		return resultCount;
	}
	
	
	// 주문건 조회 (company_id가 100번인 기업의 주문건은 VO 형태로 여러개니까 List<>)
	public List<UnstoringVO> selectAll(CompanyVO company) { // ★★ 로그인해서 세션에 저장된 그 회사의 정보가 들어와야 하고 => 그놈의 company_id로 아래
															// sql 조회할 거니가 필요함

		String sql = """
				select distinct(u.unstoring_code), customer_name, customer_address, order_register, unstoring_date, tracking_number, unstoring_state, u.manager_id, unstoring_memo
				from unstoring u join unstoring_detail ud on u.unstoring_code = ud.unstoring_code
				 				 join product p on ud.product_code = p.product_code
				             	 join company c on c.company_id = p.company_id
				where p.company_id = ?
				order by tracking_number
				"""; // [MySQL] order by의 이유 : 송장번호가 null인 '출고대기' 상태의 주문들을 먼저 보여주기 위해 이렇게 하였음. 
		
		List<UnstoringVO> unstoreList = new ArrayList<>();
		conn = MysqlUtil.getConnection();
		try {
			pst = conn.prepareStatement(sql);
			pst.setInt(1, company.getCompany_id());

			rs = pst.executeQuery();
			while (rs.next()) {
				UnstoringVO unstoring = makeUnstore(rs);
				unstoreList.add(unstoring);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			MysqlUtil.dbDisconnect(rs, pst, conn);
		}
		return unstoreList;
	}

	private UnstoringVO makeUnstore(ResultSet rs) throws SQLException {
		UnstoringVO unstoring = new UnstoringVO();
		unstoring.setUnstoring_code(rs.getString("Unstoring_code"));
		unstoring.setCustomer_name(rs.getString("Customer_name"));
		unstoring.setCustomer_address(rs.getString("Customer_address"));
		unstoring.setOrder_register(rs.getDate("Order_register"));
		unstoring.setUnstoring_date(rs.getDate("Unstoring_date"));
		unstoring.setTracking_number(rs.getString("Tracking_number"));
		unstoring.setUnstoring_state(rs.getNString("Unstoring_state"));
		unstoring.setManager_id(rs.getString("Manager_id"));
		unstoring.setUnstoring_memo(rs.getString("Unstoring_memo"));

		return unstoring;
	}
	
}


