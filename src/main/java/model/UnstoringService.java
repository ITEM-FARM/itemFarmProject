package model;

import java.util.List;

import vo.UnstoringVO;

public class UnstoringService {
	
	UnstoringDAO dao = new UnstoringDAO();
	
	// 신규 주문건 등록 (참조 : EmpDAO - empInsert)
	public int unstoringInsert(UnstoringVO unstore) {
		return dao.unstoringInsert(unstore);
	}
	
	// 주문건 조회
	public List<UnstoringVO> selectAll() {
		return dao.selectAll();
	}

}
