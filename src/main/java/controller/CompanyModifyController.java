package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;
import model.CompanyService;
import vo.CompanyVO;

public class CompanyModifyController implements CommonInterface{
	@Override
	public String execute(Map<String, Object> data) throws Exception {
		// 은빈: post요청 - 기업 정보 수정
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		
		CompanyVO company = makeCompany(request);
		CompanyService service = new CompanyService();
		String message = service.companyModify(company);
		
		return "redirect:/company/companyList.do";
	}

	private CompanyVO makeCompany(HttpServletRequest request) {
		CompanyVO company = new CompanyVO();
		
		int company_id = Integer.parseInt(request.getParameter("company_id"));
		String company_name = request.getParameter("company_name");
		String company_pw = request.getParameter("company_pw");
		double company_commission = Double.parseDouble(request.getParameter("company_commission"));
		char company_status = request.getParameter("company_status").charAt(0);
		
		company.setCompany_commission(company_commission);
		company.setCompany_id(company_id);
		company.setCompany_name(company_name);
		company.setCompany_pw(company_pw);
		company.setCompany_status(company_status);
		
		return company;
	}

}
