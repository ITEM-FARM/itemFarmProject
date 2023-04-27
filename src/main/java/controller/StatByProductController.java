package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import model.StatisticsService;
import vo.CompanyVO;
import vo.StatisticsVO;

public class StatByProductController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String method = (String) data.get("method");
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		StatisticsService service = new StatisticsService();
		CompanyVO companySession = new CompanyVO();
		CompanyVO companyFromDB = new CompanyVO();
		
		// 세션으로부터 Company 정보 받기
		int company_id = (int) session.getAttribute("comId"); // ★나중에 로그인 및 세션-setAttribute 전부 되면 그때 사용
		companySession.setCompany_id(company_id);
		companyFromDB = service.commission(companySession);
		
		// Jsp로 넘기기
		List<StatisticsVO> byProductList = service.byProduct_order(companyFromDB);
		session.setAttribute("byProductList", byProductList);
		session.setAttribute("byProductList_size", byProductList.size());
		
		String page = "/statistics/byProduct.jsp";
		return page;
	}
	
	
	// List
	
}