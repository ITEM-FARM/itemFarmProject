package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import frontcontroller.CommonInterface;
import model.ProductService;
import vo.ProductVO;

public class ProductModifyController implements CommonInterface{

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		// 은빈: post 요청: 상품 정보 수정
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		
		ProductVO product = makeProduct(request);
		ProductService service = new ProductService();
		String message = service.productModify(product);
		
		return "redirect:/product/productList.do";
	}

	private ProductVO makeProduct(HttpServletRequest request) {
		ProductVO product = new ProductVO();
		
		String subcategory_name = request.getParameter("subcategory_name");
		String product_name = request.getParameter("product_name");
		int product_cost = Integer.parseInt(request.getParameter("product_cost"));
		int product_price = Integer.parseInt(request.getParameter("product_price"));
		int product_stock = Integer.parseInt(request.getParameter("product_stock"));
		int product_safety = Integer.parseInt(request.getParameter("product_safety"));
		char product_status = request.getParameter("product_status").charAt(0);
		int product_code = Integer.parseInt(request.getParameter("product_code"));
		
		product.setProduct_cost(product_cost);
		product.setProduct_name(product_name);
		product.setProduct_price(product_price);
		product.setProduct_safety(product_safety);
		product.setProduct_status(product_status);
		product.setProduct_stock(product_stock);
		product.setSubcategory_name(subcategory_name);
		product.setProduct_code(product_code);
		
		return product;
	}
	
}
