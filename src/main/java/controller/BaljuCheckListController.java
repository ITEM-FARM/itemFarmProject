package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
			//14는 기업 아이디
			List<ProductVO> baljuchecklist = service.selectBaljuCheckList(14);
			
			HttpServletRequest request = (HttpServletRequest)data.get("request");
			request.setAttribute("baljuchecklist", baljuchecklist);
		}
		
		return "/balju/balju.jsp";
	}

}
