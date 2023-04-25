package model;

import java.util.List;

import vo.CompanyVO;
import vo.UnstoringDetailVO;
import vo.UnstoringVO;

public class UnstoringService {

	UnstoringDAO dao = new UnstoringDAO();

	// 송장입력 버튼 => 입력한 송장번호로 update
	public int trackingNumberInput(List<UnstoringVO> listVO, String trkNum) {
		return dao.trackingNumberInput(listVO, trkNum);
	}

	// 주문취소 버튼 => 주문상태(unstoring_state)를 '주문취소'로 update
	public int cancelOrder(List<UnstoringVO> listVO) {
		return dao.cancelOrder(listVO);
	}
	
	// 주문건 등록 양식에 '상품코드' 가져오기 위한
	public List<UnstoringDetailVO> selectProductCode(CompanyVO companyVO){
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
