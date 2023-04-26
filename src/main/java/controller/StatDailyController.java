package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import model.StatisticsService;
import vo.CompanyVO;
import vo.StatisticsVO;

public class StatDailyController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "redirect:/statistics/daily.jsp";
		String method = (String) data.get("method");
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		StatisticsService service = new StatisticsService();
		CompanyVO companySession = new CompanyVO();
		CompanyVO companyFromDB = new CompanyVO();
		
		// 세션으로부터 Company 정보 받기 (여기 모듈화 마렵네)
		int company_id = (int) session.getAttribute("comId"); // ★나중에 로그인 및 세션-setAttribute 전부 되면 그때 사용
		companySession.setCompany_id(company_id);
		companyFromDB = service.commission(companySession);
		double comm = companyFromDB.getCompany_commission(); // DB로부터 얻은 각 기업의 수수료
		
		// 위에서 얻은 기업별 수수료를 바탕으로, DB에서 얻은 매출액에 곱해서 순이익을 계산해야 함.
		List<StatisticsVO> statList = service.daily_order(companyFromDB);
		session.setAttribute("statList", statList);
		
		return page;
	}
	
}