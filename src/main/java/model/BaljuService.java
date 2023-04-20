package model;

import java.util.List;

import vo.ProductVO;

public class BaljuService {
	BaljuDAO baljudao = new BaljuDAO();
	
	//[태영] 기업별 발주 체크리스트 가져오기(안전재고>현재재고)
	public List<ProductVO> selectBaljuCheckList(int company_id){
		return baljudao.selectBaljuCheckList(company_id);
	}
}
