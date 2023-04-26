package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;
import model.BaljuService;
import vo.BaljuVO;

public class BaljuDetailListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		String page = "baljuDetailViewList.jsp";
		BaljuService service = new BaljuService();
		request.setAttribute("baljuList", service.BaljuDeatailList(request.getParameter("baljuCode")));
		String storingModalBaljuDetail = request.getParameter("mode");
		
		
		//태영: mode 없음
		if(storingModalBaljuDetail==null) {
			return page;
		}
		
		
		//이솔: 모달 발주 확정 리스트 불러오기
		if(storingModalBaljuDetail.equals("modalBaljuDetail")) {
			page = "/storing/baljuViewDetail.jsp";
		} else if(storingModalBaljuDetail.equals("storeBaljuDetail")) {
			String baljuCodeList = request.getParameter("baljuCodeList");
			String[] baljuCodeArr = baljuCodeList.split(",");
			List<BaljuVO> baljuList = service.BaljuDetailLists(baljuCodeArr);
			request.setAttribute("baljuListRows", baljuList);
			//JSON만들기
			page = "/storing/baljuListJson.jsp";
		}
		
		return page;
	}

}
