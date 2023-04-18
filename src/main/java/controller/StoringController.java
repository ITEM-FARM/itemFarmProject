package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class StoringController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		return "/storing/storing.jsp";
	}

}
