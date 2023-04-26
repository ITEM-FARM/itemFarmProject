package controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/*import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;*/

import frontcontroller.CommonInterface;
import model.ProductService;
import vo.ProductVO;

public class StoringInsertController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/storing/storing_insert.jsp";
		String method = (String) data.get("method");

		HttpServletRequest request = (HttpServletRequest) data.get("request");
		String mode = request.getParameter("mode");
		if (method.equals("POST")) {
			if(mode.equals("searchProduct")) {
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

			}else if(mode.equals("storeProduct")) {
				/*JSONParser parser = new JSONParser();
				String storingList = request.getParameter("storingList");
				JSONObject storingListJson = (JSONObject)parser.parse(storingList);
			
				 * System.out.println(storingList); String[] storingListArr =
				 * storingList.split(","); System.out.println(storingListArr);
				
				System.out.println(storingListJson.toJSONString()); */
			}
			
		} 
		return page;

	}

}
