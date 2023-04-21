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
		HttpSession session = request.getSession();

		int comID = Integer.parseInt(request.getParameter("comID"));
		session.setAttribute("comID", comID);
		
		ProductService service = new ProductService();
		
		List<ProductVO> companyList = service.productList(comID);
		
		request.setAttribute("productList", companyList);
		
		return "/product/product_list.jsp";
	}

}
