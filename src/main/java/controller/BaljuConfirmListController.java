package controller;

import java.util.Arrays;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.util.json.JSONParser;

import frontcontroller.CommonInterface;

public class BaljuConfirmListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "balju.jsp"; //기존 페이지는 balju.jsp 페이지
		String method = (String)data.get("method");
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		
		if(method.equals("POST")) {
			System.out.println("여기는 걸리는가");
			String baljuCheckList = request.getParameter("baljuCheckList");
			System.out.println(baljuCheckList);
			page = "baljuConfirmList.jsp";
		}
		
		return page;
	}

}
