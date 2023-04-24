package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import model.ProductService;
import vo.ProductVO;

public class ProductListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		String method = (String) data.get("method");
		String page = null;

		HttpSession session = request.getSession();
		int comId = (int) session.getAttribute("comId"); 

		ProductService service = new ProductService();
		List<ProductVO> productList = null;
		
		if(method.equals("GET")) {
			productList = service.productList(comId, "all");
			page = "/product/product_list.jsp";
		} else {
			String cond = request.getParameter("filter");
			productList = service.productList(comId, cond);
			page = "/product/product_body.jsp";
		}
		
		request.setAttribute("productList", productList);
		
		return page;
	}

}
