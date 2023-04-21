package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;
import model.UnstoringService;
import vo.UnstoringVO;

public class UnstoringListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/unstoring/unstoring_list.jsp";

		UnstoringService service = new UnstoringService();
		List<UnstoringVO> unstoreList = service.selectAll();

		// request가 유지되는 동안 저장한다. (dispatch 방식으로 forward 할 거니까)
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		request.setAttribute("unstoreList", unstoreList);

		return page;
	}

}
