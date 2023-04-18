package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class BaljuController implements CommonInterface{

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		return "/balju/balju.jsp";
	}

}
