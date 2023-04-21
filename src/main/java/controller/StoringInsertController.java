package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import frontcontroller.CommonInterface;
import model.ProductService;
import vo.ProductVO;

public class StoringInsertController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/storing/storing_insert.jsp";
		String method = (String) data.get("method");

		HttpServletRequest request = (HttpServletRequest) data.get("request");

		if (method.equals("POST")) {

			String valueType = request.getParameter("valueType");

			ProductService pservice = new ProductService();

			// 이솔: product 상품명, 상품코드 톻합검색
			String selectValue = "";
			if (request.getParameter("selectValue1") == "") {
				selectValue = request.getParameter("selectValue2");
			} else {
				selectValue = request.getParameter("selectValue1");
			}

			List<ProductVO> productList = pservice.productSelect(selectValue, valueType);

			request.setAttribute("productList", productList);
			
			page = "productSearch.jsp";

//			System.out.println("valueType : " + request.getParameter("valueType"));
//			System.out.println("selectValue1 : " + request.getParameter("selectValue1"));
//			System.out.println("selectValue2 : " + request.getParameter("selectValue2"));

//			JSONArray arr = new JSONArray();
//			for (ProductVO product : productList) {
//				JSONObject obj = new JSONObject();
//				obj.put("product_code", product.getProduct_code());
//				obj.put("product_name", product.getProduct_name());
//				obj.put("product_stock", product.getProduct_stock());
//				obj.put("product_safety", product.getProduct_safety());
//				arr.add(obj);
//			}
//
//			JSONObject productsObj = new JSONObject();
//			productsObj.put("productList",arr);
//			
//			return "responseBody:" + productsObj.toJSONString();
		}
		return page;

	}

}
