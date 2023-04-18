package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class AuthController implements CommonInterface{

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		return "/auth/auth.jsp";
	}

}
