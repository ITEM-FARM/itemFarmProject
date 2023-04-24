package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import model.BaljuService;
import vo.ProductVO;

//[태영] 
public class BaljuCheckListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		
		if(method.equals("GET")) {
			BaljuService service = new BaljuService();
			HttpServletRequest request = (HttpServletRequest)data.get("request");
			HttpSession session = request.getSession();
			
			int comId = (Integer)session.getAttribute("comId");
			List<ProductVO> baljuchecklist = service.selectBaljuCheckList(comId);
			
			request.setAttribute("baljuchecklist", baljuchecklist);
		}
		
		return "/balju/balju.jsp";
	}

}
