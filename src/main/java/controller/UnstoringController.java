package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class UnstoringController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		return "/unstoring/unstoring.jsp";
	}

}
