package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class StatisticsController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		return "/statistics/statistics.jsp";
	}

}
