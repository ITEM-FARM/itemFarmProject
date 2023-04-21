package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;

public class UnstoringDetailController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		String modalTest = request.getParameter("modalTest");
		request.setAttribute("modalTest", modalTest);
		System.out.println("컨트롤러에서 " + modalTest);
		
		String page = "/unstoring/unstoringDetail.do";
		return page;
	}

}
