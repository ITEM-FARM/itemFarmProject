package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import model.StoringService;
import vo.StoringVO;

public class StoringListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "storing_list.jsp"; 
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		HttpSession session = request.getSession();
		String storingModalDetail = request.getParameter("mode");
		
		//조회 
		StoringService service = new StoringService();
		int comId = (Integer)session.getAttribute("comId");
	
		List<StoringVO> storingList = service.selectStoringList(comId);
		request.setAttribute("storingList", storingList);
		
		
		if(storingModalDetail==null) {
			return page;
		}
		
		
		
		if(storingModalDetail.equals("storingDetail")) {
			page = "storingDetailView.jsp";
			request.setAttribute("storingDetail", service.selectStoringDetail(request.getParameter("storingCode")));
		}
		
		return page;
	}

}
