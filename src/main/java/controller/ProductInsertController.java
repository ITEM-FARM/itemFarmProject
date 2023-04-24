package controller;

import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import model.ProductService;
import vo.ProductVO;

public class ProductInsertController implements CommonInterface{

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		ProductVO product = makeProduct(request);
		ProductService service = new ProductService();
		String message = service.productInsert(product);

		return "redirect:/product/productList.do";
	}

	private ProductVO makeProduct(HttpServletRequest request) {
		HttpSession session = request.getSession();
		ProductVO product = new ProductVO();
		
		String subcategory_name = request.getParameter("subcategory_name");
		int company_id = (int) session.getAttribute("comId");
		String product_name = request.getParameter("product_name");
		int product_cost = Integer.parseInt(request.getParameter("product_cost"));
		int product_price = Integer.parseInt(request.getParameter("product_price"));
		int product_stock = Integer.parseInt(request.getParameter("product_stock"));
		int product_safety = Integer.parseInt(request.getParameter("product_safety"));
		char product_status = request.getParameter("product_status").charAt(0);
		Date date = new Date();
		Timestamp product_regdate = new Timestamp(date.getTime());
		String manager_id = (String) session.getAttribute("managerId");
		
		product.setProduct_cost(product_cost);
		product.setProduct_name(product_name);
		product.setProduct_price(product_price);
		product.setProduct_safety(product_safety);
		product.setProduct_status(product_status);
		product.setProduct_stock(product_stock);
		product.setSubcategory_name(subcategory_name);
		product.setCompany_id(company_id);
		product.setProduct_regdate(product_regdate);
		product.setManager_id(manager_id);
		
		return product;
	}
}
