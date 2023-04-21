package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class UnstoringDetailController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		
		
		String page = "/unstoring/unstoring_detail.jsp";
		return page;
	}

}
