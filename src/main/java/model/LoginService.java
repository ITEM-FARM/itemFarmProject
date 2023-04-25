package model;

import vo.CompanyVO;
import vo.ManagerVO;

public class LoginService {
	LoginDAO dao = new LoginDAO();
	
	//매니저 로그인
	public ManagerVO ManagerloginCheck(String id, String pw) {
		return dao.ManagerloginCheck(id, pw);
	}
	
	//기업 로그인
	public CompanyVO companyLoginCheck(int id, String pw) {
		return dao.companyLoginCheck(id, pw);
	}
	
	//기업 활성화 여부 살펴보기
	public String isActiveCompany(int id) {
		return dao.isActiveCompany(id);
	}
}
