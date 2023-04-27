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

		HttpSession session = request.getSession();
		int comId = (int) session.getAttribute("comId"); 

		ProductService service = new ProductService();
		List<ProductVO> productList = null;
		
		// get: 처음 페이지 로드
		if(method.equals("GET")) {
			productList = service.productList(comId, "all");
			request.setAttribute("filter", "all");
		} else {
			// post: 전체/활성/비활성 필터
			String cond = request.getParameter("prodStatus-filter");
			productList = service.productList(comId, cond);
			request.setAttribute("filter", cond);
		}
		
		request.setAttribute("productList", productList);
		
		return "/product/product_list.jsp";
	}

}
