package model;

import java.util.List;

import vo.BaljuVO;
import vo.ProductVO;

public class BaljuService {
	BaljuDAO baljudao = new BaljuDAO();
	
	//[태영] 기업별 발주 체크리스트 가져오기(안전재고>현재재고)
	public List<ProductVO> selectBaljuCheckList(int company_id){
		return baljudao.selectBaljuCheckList(company_id);
	}
	
	//[태영] 기업별 발주 넣기 in balju 테이블
	public String createBaljuBox(BaljuVO balju) {
		int result = baljudao.createBaljuBox(balju);
		return result != 0 ? "발주성공" : "발주실패";
	}
	
	//[태영] 기업별 발주넣기 in balju_detail 테이블 
	public String baljuIteminBaljuBox(BaljuVO balju) {
		int result = baljudao.baljuIteminBaljuBox(balju);
		return result!= 0 ? "발주아이템성공" : "발주아이템실패";
	}
}
