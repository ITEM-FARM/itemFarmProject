package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import model.CompanyService;
import model.LoginService;
import vo.CompanyVO;
import vo.ManagerVO;

public class LoginCheckController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		String method = (String) data.get("method");
		String page = "";
		if (method.equals("GET")) {
			page = "/auth/login.jsp";
		} else { // POST 요청시
			

			// logintype은 3PL(manager)인지 기업(company)인지 구분
			String logintype = request.getParameter("logintype");

			// id와 pw 가져오기
			String inputID = request.getParameter("inputID");
			String inputPW = request.getParameter("inputPW");

			LoginService loginservice = new LoginService();
			HttpSession session = request.getSession();

			if (logintype.equals("manager")) {
				ManagerVO manager = loginservice.ManagerloginCheck(inputID, inputPW);
				CompanyService companyservice = new CompanyService();
				CompanyVO company = companyservice.defaultCompany();

				if(manager == null) {
					page = "redirect:/auth/loginCheck.do";
				} else {// 매니저 로그인 성공시
					page = "/";

					session.setAttribute("comId", company.getCompany_id()); 
					session.setAttribute("comName", company.getCompany_name());
				}
				System.out.println("manager 로그인:" + manager);

				session.setAttribute("managerUser", manager==null?"FAIL":manager);	
			}else if(logintype.equals("company")) {
				//company loginCheck전에 활성화, 비활성화 기업인지 확인하기
				String isActiveCompany = loginservice.isActiveCompany(Integer.valueOf(inputID));
				
				//System.out.println("isActiveCompany: " + isActiveCompany);
				if(isActiveCompany.equals("N")) {//비활성화된 기업이라면
					session.setAttribute("companyUser", "N");
					
					page = "redirect:/auth/loginCheck.do";
				}else {
					CompanyVO company = loginservice.companyLoginCheck(Integer.valueOf(inputID), inputPW); 
					
					if(company == null) {
						page = "redirect:/auth/loginCheck.do";
					}else { //기업 로그인 성공시
						session.setAttribute("comId", company.getCompany_id()); 
						session.setAttribute("comName", company.getCompany_name());
						page = "/";
					}
					System.out.println("company 로그인:" + company);
					session.setAttribute("companyUser", company==null?"FAIL":company);
				}
			
			}
		}

		return page;
	}

}
