package controller;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import frontcontroller.CommonInterface;
import model.UnstoringService;
import vo.CompanyVO;
import vo.UnstoringVO;

public class UnstoringListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		UnstoringService service = new UnstoringService();
		HttpSession session = request.getSession();
		
		
		// [by 은빈's] 세션으로부터 기업정보 얻어서 CompanyVO 형태로 넘겨주기 (Company_name으로 주문건 조회하기 위해 => ★ company_name으로 하려했더니 쪼인이 너무 더 더러워져서 일단 company_id로 ㄱㄱ)
		CompanyVO company = new CompanyVO();
		int company_id = (int) session.getAttribute("comId"); // ★나중에 로그인 및 세션-setAttribute 전부 되면 그때 사용
		company.setCompany_id(company_id); 
		System.out.println("company_id " + company_id);
		
		List<UnstoringVO> unstoringList = service.selectAll(company);
		
		// 용희 : 총 주문건수를 세기 위한 코드 (List 클래스의 size 메소드 이용)
		UnstoringVO vo = new UnstoringVO();
		int totalCount = unstoringList.size();
		vo.setTotalCount(totalCount);
		// request가 유지되는 동안 저장한다. (dispatch 방식으로 forward 할 거니까)
		request.setAttribute("totalCount", totalCount);
		request.setAttribute("unstoringList", unstoringList);
		
		
		String page = "/unstoring/unstoring_list.jsp";
		return page;
	}

}
