package model;

import java.sql.Timestamp;
import java.util.List;

import vo.CompanyVO;
import vo.ProductVO;
import vo.UnstoringDetailVO;
import vo.UnstoringVO;

public class UnstoringService {

	UnstoringDAO dao = new UnstoringDAO();
	
	// 엑셀 업로드 파일 => insert into DB
	public int ordersInsert(List<UnstoringDetailVO> list, UnstoringVO vo1, String magID) { 
		return dao.ordersInsert(list, vo1, magID);
	}

	// 송장입력 버튼 => 입력한 송장번호로 update
	public int trackingNumberInput(List<UnstoringVO> list, String trkNum, List<UnstoringDetailVO> detailList, Timestamp timestamp) {
		return dao.trackingNumberInput(list, trkNum, detailList, timestamp);
	}
	
	// 송장번호에 해당하는 출고상세(상품코드/주문수량) 정보를 불러오기 위한
	public List<UnstoringDetailVO> selectDetailByTrkNum(List<UnstoringVO> list) {
		return dao.selectDetailByTrkNum(list);
	}

	// 주문취소 버튼 => 주문상태(unstoring_state)를 '주문취소'로 update
	public int cancelOrder(List<UnstoringVO> list) {
		return dao.cancelOrder(list);
	}
	
	// 주문건 등록 양식에 '상품코드' 가져오기 위한
	public List<ProductVO> selectProductCode(CompanyVO companyVO){
		return dao.selectProductCode(companyVO);
	}

	// 신규 주문건 등록 1 (출고 테이블 Insert)
	public int unstoringInsert(UnstoringVO unstore, UnstoringDetailVO detail) {
		return dao.unstoringInsert(unstore, detail);
	}
	
	// 주문건 조회
	public List<UnstoringVO> selectAll(CompanyVO company) {
		return dao.selectAll(company);
	}
	
	// 주문건 상세조회
	public List<UnstoringDetailVO> selectUnstoringDetail(UnstoringVO vo, CompanyVO vo2) {
		return dao.selectUnstoringDetail(vo, vo2);
	}

}
