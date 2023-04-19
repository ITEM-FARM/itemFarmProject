package model;

import java.util.List;

import vo.CompanyVO;

public class CompanyService {
	CompanyDAO dao = new CompanyDAO();
	
	public List<CompanyVO> companyList() {
		return dao.companyList();
	}
}
