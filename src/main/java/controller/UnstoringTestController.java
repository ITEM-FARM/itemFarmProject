package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.connector.Response;

import frontcontroller.CommonInterface;
import model.UnstoringService;
import vo.CompanyVO;
import vo.UnstoringDetailVO;
import vo.UnstoringVO;

public class UnstoringTestController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		UnstoringService service = new UnstoringService();
		
		// 용희 : 주문번호를 get하여 그에 해당하는 '주문건 상세조회' 보여주기
		String number2 = request.getParameter("unstoring_code");
		
		// unstoring_detail.jsp 에서 주문번호를 보여주기 위한 작업
		session.setAttribute("detailCode", number2);
		
		
		// [by 은빈's] 세션으로부터 기업정보 얻어서 CompanyVO 형태로 넘겨주기 (Company_name으로 주문건 조회하기 위해 => ★
		// company_name으로 하려했더니 쪼인이 너무 더 더러워져서 일단 company_id로 ㄱㄱ)
		CompanyVO companyVO = new CompanyVO();
		int company_id = (int) session.getAttribute("comId"); // ★나중에 로그인 및 세션-setAttribute 전부 되면 그때 사용
		companyVO.setCompany_id(company_id);
		
		
		UnstoringVO unstoringVO = new UnstoringVO();
		unstoringVO.setUnstoring_code(number2);
		List<UnstoringDetailVO> detailVO = service.selectUnstoringDetail(unstoringVO, companyVO);
		
		// redirect 방식이니까 session에 저장함 (굳이 redirect로 했어야 했나? dispatch도 괜찮았으려나)
		session.setAttribute("detailVO", detailVO);
		System.out.println(detailVO);
		
		String page = "redirect:/unstoring/unstoringTestRead.do";
		return page;
	}

}
