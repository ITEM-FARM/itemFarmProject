package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;
import model.ProductService;
import vo.ProductVO;

public class StoringInsertController implements CommonInterface {
	
	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/storing/storing_insert.jsp";
		String method = (String)data.get("method");
		
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		String valueType = request.getParameter("valueType");
		if(method.equals("POST")) {
			//ProductVO product = makeProduct(request,valueType);
			ProductService pservice = new ProductService();
			String selectValue = "";
			if (request.getParameter("selectValue1")=="") {
				selectValue = request.getParameter("selectValue2");
			} else {
				selectValue = request.getParameter("selectValue1");
			}
			request.setAttribute("productList",pservice.productSelect(selectValue,valueType));
			

		}
		return page;
	}

	private ProductVO makeProduct(HttpServletRequest request,String valueType) {
		
		ProductVO product = new ProductVO();
		
		
		
		
		if(valueType.equals("searchTotal")) {
			/*
			 * String temp = "";
			 * 
			 * for(int i=0;i<=selectValue.length()-1;i++) {
			 * if(Character.isDigit(selectValue.charAt(i))!=true) { product_name =
			 * selectValue; break; } temp += selectValue.charAt(i); }
			 * 
			 * if(product_name != null) { product.setProduct_name(product_name); return
			 * product; }
			 * 
			 * product_code = Integer.parseInt(temp); product_name = temp;
			 * product.setProduct_code(product_code);
			 * product.setProduct_name(product_name);
			 */
			String selectValue = request.getParameter("selectValue1");
			product.setTotal_select(selectValue);
			
		} else if(valueType.equals("searchCode")) {
			  
			int selectValue = Integer.parseInt(request.getParameter("selectValue2"));
			  product.setProduct_code(selectValue);
			 
		} else if(valueType.equals("searchName")) {

			String selectValue = request.getParameter("selectValue1");
			product.setProduct_name(selectValue);
		
		}
				return product;
	}

	

}
