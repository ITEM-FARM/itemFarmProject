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
	
	//[태영] 발주 테이블 조회
	public List<BaljuVO> BaljuList(int company_id){
		return baljudao.BaljuList(company_id);
	}
	
	//[태영] 발주 내역 상세 조회(상품 포함) --> row 한건
	public List<BaljuVO> BaljuDeatailList(String balju_code){
		return baljudao.BaljuDeatailList(balju_code);
	}
	
	//[이솔] 발주 내역 상세 조회(상품 포함) --> row 여러개 (배열)
	public List<BaljuVO> BaljuDetailLists(String []balju_code){
		return baljudao.BaljuDetailLists(balju_code);
	}
	
	//[이솔] 입고페이지에서 발주 테이블 조회(발주 불러오기) --> status='Y'인 것만
	public List<BaljuVO> StoringBaljuList(int company_id){
		return baljudao.StoringBaljuList(company_id);
	}
	
	//[이솔] 입고 확정 시, 발주 status 'D'로 변경
	public String BaljuStatusList(String []balju_status){
		int result = baljudao.BaljuStatusList(balju_status);
		return result!= 0? "발주서변경성공-D":"발주서변경실패-Y"  ;
	}
}
