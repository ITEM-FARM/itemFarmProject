package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;
import vo.ProductVO;

public class StoringInsertController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/storing/storing_insert.jsp";
		String method = (String)data.get("method");
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		if(method.equals("POST")) {
			ProductVO product = makeProduct(request);
			
			
			
			
			
			
//			if ()
//			product.setProduct_code(valueSelect);
//			
		}
		return page;
	}

	private ProductVO makeProduct(HttpServletRequest request) {
		
		ProductVO product = new ProductVO();
		String valueSelect = request.getParameter("valueSelect");
		String temp = "";
		
		int product_code = 0;
		String product_name = null;
		
		for(int i=0;i<=valueSelect.length()+1;i++) {
			if(Character.isDigit(valueSelect.charAt(i))!=true) {
				product_name = valueSelect; 
				break;
			}
			temp += valueSelect.charAt(i);
		}
	
		if(product_name != null) {
			product.setProduct_name(product_name);
			//return product;
			System.out.println(product.getProduct_name());
			return null;
		}
		
		product_code = Integer.parseInt(temp);
		product_name = temp;
		
		product.setProduct_code(product_code);
		product.setProduct_name(product_name);
		
		System.out.println(product.getProduct_code());
		System.out.println(product.getProduct_name());
		//return product;
		return null;
	}

	

}
