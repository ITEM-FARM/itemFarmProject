package controller;

import java.util.Map;

import frontcontroller.CommonInterface;

public class ProductController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		return "/product/product.jsp";
	}

}
