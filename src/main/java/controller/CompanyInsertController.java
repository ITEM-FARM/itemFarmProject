package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;
import model.CompanyService;
import vo.CompanyVO;

public class CompanyInsertController implements CommonInterface{
	// post 요청: 기업 등록
	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		CompanyVO company = makeCompany(request);
		CompanyService service = new CompanyService();
		String message = service.companyInsert(company);
		
		return "redirect:/company/companyList.do";
	}
	
	private CompanyVO makeCompany(HttpServletRequest request) {
		CompanyVO company = new CompanyVO();
		
		String company_name = request.getParameter("company_name");
		String company_pw = request.getParameter("company_pw");
		double company_commission = Double.parseDouble(request.getParameter("company_commission"));
		char company_status = request.getParameter("company_status").charAt(0);
		
		company.setCompany_commission(company_commission);
		company.setCompany_name(company_name);
		company.setCompany_pw(company_pw);
		company.setCompany_status(company_status);
		
		return company;
	}
}
