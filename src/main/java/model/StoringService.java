package model;

import java.util.List;

import vo.BaljuVO;
import vo.StoringVO;

public class StoringService {
	StoringDAO storingdao = new StoringDAO();
	
	public String insertStoringList(StoringVO storing) {
		int result = storingdao.insertStoringList(storing);
		return result != 0 ? "입고성공" : "입고실패";
	}

	public String insertStoringDetail(List<StoringVO> storingDetailList) {
		int result = storingdao.insertStoringDetail(storingDetailList);
		return result > 0 ? "상세성공" : "상세실패";
	}

	public List<StoringVO> selectStoringList(int company_id) {
		return storingdao.selectStoringList(company_id);
	}

	public List<StoringVO> selectStoringDetail(String storing_code){
		return storingdao.selectStoringDetail(storing_code);
	}

}
