package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class CompanyController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		return "/company/company.jsp";
	}

}
