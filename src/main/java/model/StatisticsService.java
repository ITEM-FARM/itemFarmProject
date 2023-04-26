package model;

import java.util.List;

import vo.CompanyVO;
import vo.StatisticsVO;

public class StatisticsService {
	
	StatisticsDAO dao = new StatisticsDAO();
	
	// 기업별 수수료 데이터 가져오는 작업
	public CompanyVO commission(CompanyVO company) {
		return dao.commission(company);
	}
	
	// 일별 매출통계
	public List<StatisticsVO> daily_order(CompanyVO company) {
		return dao.daily_order(company);
	}

}
