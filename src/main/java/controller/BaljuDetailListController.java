package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;
import model.BaljuService;

public class BaljuDetailListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		
		BaljuService service = new BaljuService();
		request.setAttribute("baljuList", service.BaljuDeatailList(request.getParameter("baljuCode")));
		
		return "baljuDetailViewList.jsp";
	}

}
