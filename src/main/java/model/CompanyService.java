package model;

import java.util.List;

import vo.CompanyVO;

public class CompanyService {
	CompanyDAO dao = new CompanyDAO();
	
	// 은빈: 전체 기업 조회
	public List<CompanyVO> companyList(String cond) {
		return dao.companyList(cond);
	}
	
	// 은빈: 기업 정보 수정
	public String companyModify(CompanyVO company) {
		int result = dao.companyModify(company);
		return result > 0 ? "정보를 수정했습니다." : "정보 수정에 실패했습니다.";
	}
	
	// 은빈: 기업 등록
	public String companyInsert(CompanyVO company) {
		int result = dao.companyInsert(company);
		return result > 0 ? "등록에 성공했습니다." : "등록에 실패했습니다.";
	}
	
	// 은빈: default 기업 추출
	public CompanyVO defaultCompany() {
		return dao.defaultCompany();
	}
}
