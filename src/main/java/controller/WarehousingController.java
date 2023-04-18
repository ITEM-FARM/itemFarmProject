package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class WarehousingController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		return "/warehousing/warehousing.jsp";
	}

}
