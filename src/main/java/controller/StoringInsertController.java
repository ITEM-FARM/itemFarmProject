package controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

/*import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;*/

import frontcontroller.CommonInterface;
import model.BaljuService;
import model.ProductService;
import model.StoringService;
import vo.ManagerVO;
import vo.ProductVO;
import vo.StoringVO;

public class StoringInsertController implements CommonInterface {
	private String storing_code;
	
	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/storing/storing_insert.jsp";
		String method = (String) data.get("method");
		
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		String mode = request.getParameter("mode");
		int comId = (Integer)session.getAttribute("comId");
		
		if (method.equals("POST")) {
			if(mode.equals("searchProduct")) {
				String valueType = request.getParameter("valueType");

				ProductService p_service = new ProductService();
				

				// 이솔: product 상품명, 상품코드 톻합검색
				String selectValue = "";
				if (request.getParameter("selectValue1") == "") {
					selectValue = request.getParameter("selectValue2");
				} else {
					selectValue = request.getParameter("selectValue1");
				}

				List<ProductVO> productList = p_service.productSelect(selectValue, valueType, comId);

				request.setAttribute("productList", productList);
				
				page = "productSearch.jsp";

			}else if(mode.equals("storeProduct")) {
				
				//입고리스트(그룹)
				StoringVO storingList = makeStoringList(request);
				StoringService s_service = new StoringService();
				String message1 = s_service.insertStoringList(storingList);
				if(message1.equals("입고실패")) {
					System.out.println(message1);
					return "responseBody:리스트 삽입 ERROR";
				}
				
				
				JSONParser parser = new JSONParser();
				JSONArray arr = (JSONArray)parser.parse(request.getParameter("storingList"));
				List<StoringVO> storingDetailList = new ArrayList<>();
				String baljuStatus = request.getParameter("baljuStatus");
				if(baljuStatus != "") {
					BaljuService service = new BaljuService();
					String[] baljuStatusList = baljuStatus.split(",");
					String message2 = service.BaljuStatusList(baljuStatusList);
					if(message2.equals("발주서변경실패-Y")) {
						System.out.println(message2);
						return "responseBody:발주서변경실패-Y ERROR";
					}
				}
				
				
				for(int i=0;i<arr.size();i++){
					JSONObject tmp = (JSONObject)arr.get(i);
					StoringVO storingDetail = makeStoringDetail(tmp);
					storingDetailList.add(storingDetail);
				}
				
				String message3 = s_service.insertStoringDetail(storingDetailList);
				if(message3.equals("상세실패")) {
					System.out.println(message3);
					return "responseBody:상세 삽입 ERROR";
				}
				
				return "responseBody:성공";
				
			}
			
		} 
		return page;

	}
	
	
	private StoringVO makeStoringDetail(JSONObject tmp) {
		StoringVO storingDetail = new StoringVO();
		
		
		int productCode = Integer.parseInt((String)tmp.get("product_code"));
		int storingQuantity = Integer.parseInt((String)tmp.get("storing_quantity"));
		String baljuCode = (String)tmp.get("balju_code");
		
		storingDetail.setStoring_code(storing_code);
		storingDetail.setProduct_code(productCode);
		storingDetail.setBalju_code(baljuCode);
		storingDetail.setStoring_quantity(storingQuantity);
		
		return storingDetail;
	}

	
	private StoringVO makeStoringList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		StoringVO storingProduct = new StoringVO();
		
		
		
		//등록일 위한 현재 날짜 가져오기
		LocalDateTime now = LocalDateTime.now();
		Timestamp storing_date = Timestamp.valueOf(now);
		
		//발주 코드 생성
		String code = "I";
		
		//셀렉한 기업 코드
		String comId = String.valueOf(session.getAttribute("comId"));
		String selected_company = comId;
		
		//시리얼 넘버 만들기
		String formatedNow = now.format(DateTimeFormatter.ofPattern("yyMMddkmmss"));
		
		
		//입고 코드
		storing_code = code+selected_company+formatedNow;
		
		//매니져 id
		ManagerVO manager = (ManagerVO) session.getAttribute("managerUser");
		String manager_id = manager.getManager_id();
		
		//입고 등록일
		
		
		//입고 메모
		String storing_memo = request.getParameter("storingMemo");
		
		
		//setting
		storingProduct.setStoring_code(storing_code);
		storingProduct.setManager_id(manager_id);
		storingProduct.setStoring_date(storing_date);
		storingProduct.setStoring_memo(storing_memo);
		
		return storingProduct;
		
	}

}
