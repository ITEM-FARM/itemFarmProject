package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class UnstoringTestReadController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		
		System.out.println("여기 안 왔음??");
		
		String page = "/unstoring/unstoring_detail.jsp";
		return page;
	}

}
