package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import model.UnstoringService;
import vo.UnstoringVO;

public class TrackingNumberInputController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		UnstoringVO unstoring = new UnstoringVO();
		String unstoring_code = request.getParameter("unstoring_code");
		String tracking_number = request.getParameter("tracking_number");
		unstoring.setUnstoring_code(unstoring_code); // 1. 주문코드와 송장번호를 getParameter해서 set
		unstoring.setTracking_number(tracking_number); 
		
		UnstoringService service = new UnstoringService();
		int result = service.trackingNumberInput(unstoring); // 2. 받은 VO를 trackingNumberInput을 실행하여 송장번호 update
		
		HttpSession session = request.getSession();
		session.setAttribute("result", result);
		
		String page = "redirect:/unstoring/unstoringList.do";
		return page;
	}

}
