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
		
		
		// 용희 : 뭐로 해야 오는지 테스트
		String number = (String) request.getAttribute("unstoring_code");
		System.out.println("컨트롤러에서1 "+ number);
		
		String number2 = request.getParameter("unstoring_code");
		System.out.println("컨트롤러에서2 "+ number2);
		
		String sessionData = (String) session.getAttribute("sessionData");
		System.out.println("컨트롤러에서 세션데이터 왔니? " + sessionData);
		// 테스트 끝
		
		
		UnstoringVO vo = new UnstoringVO();
		vo.setUnstoring_code(number2);
		UnstoringService service = new UnstoringService();
		List<UnstoringDetailVO> detailVO = service.selectUnstoringDetail(vo);
		
		// redirect 방식이니까 session에 저장함
		session.setAttribute("detailVO", detailVO);
		System.out.println("세션에 왔나? " + detailVO);
		
		String page = "redirect:/unstoring/unstoringTestRead.do";
		return page;
	}

}
