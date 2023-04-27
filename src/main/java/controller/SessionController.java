package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;

public class SessionController implements CommonInterface{
	// get 요청: 변경된 조회 기업 세션에 저장
	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		
		int comId = Integer.parseInt(request.getParameter("comId"));
		String comName = request.getParameter("comName");
		session.setAttribute("comId", comId); 
		session.setAttribute("comName", comName);
		
		return "responseBody:OK";
	}

}
