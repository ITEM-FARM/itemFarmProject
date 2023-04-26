package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import model.WarehousingService;
import vo.WarehousingVO;

public class WarehousingListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		String method = (String) data.get("method");
		
		HttpSession session = request.getSession();
		int comId = (int) session.getAttribute("comId"); 
		
		WarehousingService service = new WarehousingService();
		List<WarehousingVO> warehousingList = null;
		
		if(method.equals("GET")) {
			warehousingList = service.warehousingList(comId, "all");
			request.setAttribute("filter", "all");
		} else {
			String cond = request.getParameter("warehousing-filter");
			warehousingList = service.warehousingList(comId, cond);
			request.setAttribute("filter", cond);
		}
		request.setAttribute("warehousingList", warehousingList);
		
		return "/warehousing/warehousing_list.jsp";
	}

}
