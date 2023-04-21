package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;
import model.UnstoringService;
import vo.UnstoringVO;

public class UnstoringCancelOrderController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		UnstoringVO unstoring = new UnstoringVO();
		String unstoring_code = request.getParameter("unstoring_code");
		unstoring.setUnstoring_code(unstoring_code); // 1. 주문코드를 받아서 set 
		
		UnstoringService service = new UnstoringService();
		int result = service.cancelOrder(unstoring); // 2. 받은 주문코드를 가져가서 cancelOrder를 실행하여 주문상태 update 
		
		request.setAttribute("result", result);
		
		String page = "redirect:/unstoring/unstoringList.do";
		return page;
	}

}
