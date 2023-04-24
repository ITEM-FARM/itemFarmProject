package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import vo.CompanyVO;

public class UnstoringTestReadController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/unstoring/unstoring_detail.jsp";
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		System.out.println("UnstoringTestReadController에 왔음");
		
		
		// 용희 : 페이지에 따라 header 부분 안 보이게끔 하는 if문을 위한 임의의 숫자
		// 일단 header_2.jsp 복붙해서 임시 땜빵
		
		
//		CompanyVO company = new CompanyVO();
//		int company_id = (int) session.getAttribute("comId"); // ★나중에 로그인 및 세션-setAttribute 전부 되면 그때 사용
//		company.setCompany_id(company_id); 
//		System.out.println("세션으로부터 company_id 오는지 체크 : " + company_id);
		
		return page;
	}

}
