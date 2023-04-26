package controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/*import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;*/

import frontcontroller.CommonInterface;
import model.ProductService;
import vo.ManagerVO;
import vo.ProductVO;
import vo.StoringVO;

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
				
				//입고리스트(그룹)
				StoringVO StoringList = makeStoringList(request);
				
				
				/*
				 * JSONParser parser = new JSONParser(); JSONArray arr =
				 * (JSONArray)parser.parse(request.getParameter("storingList"));
				 * System.out.println("storingMemo" + request.getParameter("storingMemo"));
				 * List<StoringVO> storingList = new ArrayList<>(); for(int
				 * i=0;i<arr.size();i++){
				 * 
				 * JSONObject tmp = (JSONObject)arr.get(i);//인덱스 번호로 접근해서 가져온다. StoringVO
				 * storingProduct = makeStoringProduct(tmp); String ss =
				 * (String)tmp.get("balju_code");
				 * 
				 * System.out.println("balju_code : "+ss); }
				 */
			}
			
		} 
		return page;

	}
	
	private StoringVO makeStoringList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		StoringVO StoringProduct = new StoringVO();
		
		
		
		//날짜->시리얼 넘버 만들기
		LocalDateTime now = LocalDateTime.now();
		String formatedNow = now.format(DateTimeFormatter.ofPattern("yyMMddkmmss"));
		
		//발주 코드 생성
		String code = "I";
		//셀렉한 기업 코드
		String comId = String.valueOf(session.getAttribute("comId"));
		System.out.println(comId);
		String selected_company = comId;
		
		
		//입고 코드
		String storing_code = code+selected_company+formatedNow;
		//매니져 id
		ManagerVO manager = (ManagerVO) session.getAttribute("managerUser");
		String manager_id = manager.getManager_id();
		//입고 등록일
		Date date = new Date();
		Timestamp storing_date = new Timestamp(date.getTime());
		//입고 메모
		String storing_memo = request.getParameter("storingMemo");
		
		
		//setting
		StoringProduct.setStoring_code(storing_code);
		StoringProduct.setManager_id(manager_id);
		StoringProduct.setStoring_date(storing_date);
		StoringProduct.setStoring_memo(storing_memo);
		
		return StoringProduct;
		
	}

}
