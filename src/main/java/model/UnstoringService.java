package model;

import java.util.List;

import vo.CompanyVO;
import vo.UnstoringDetailVO;
import vo.UnstoringVO;

public class UnstoringService {

	UnstoringDAO dao = new UnstoringDAO();

	// 송장입력 버튼 => 입력한 송장번호로 update
	public int trackingNumberInput(UnstoringVO unstoring) {
		return dao.trackingNumberInput(unstoring);
	}

	// 주문취소 버튼 => 주문상태(unstoring_state)를 '주문취소'로 update
	public int cancelOrder(UnstoringVO unstoring) {
		return dao.cancelOrder(unstoring);
	}

	// 신규 주문건 등록 (참조 : EmpDAO - empInsert)
	public int unstoringInsert(UnstoringVO unstore) {
		return dao.unstoringInsert(unstore);
	}

	// 주문건 조회
	public List<UnstoringVO> selectAll(CompanyVO company) {
		return dao.selectAll(company);
	}
	
	// 주문건 상세조회
	public List<UnstoringDetailVO> selectUnstoringDetail(UnstoringVO vo) {
		return dao.selectUnstoringDetail(vo);
	}

}
