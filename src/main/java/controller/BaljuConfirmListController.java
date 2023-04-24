package controller;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import frontcontroller.CommonInterface;
import model.BaljuService;
import vo.BaljuVO;

public class BaljuConfirmListController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "baljuConfirmList.jsp"; 
		String method = (String)data.get("method");
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		
		if(method.equals("GET")) {
			//조회 
			return page;
			
		}else {
			//balju과 balju_detail 테이블에 넣기
			BaljuService service = new BaljuService();
			
			BaljuVO createBalju = new BaljuVO();
			
			//등록일을 위한 현재 날짜 가져오기
			LocalDateTime now = LocalDateTime.now();
			Timestamp timestamp = Timestamp.valueOf(now);

			//현재 작업 중인 코드 (발주(B), 입고(I), 출고(O))
			String code = "B";
			
			//셀렉한 기업 코드
			String selected_company = "14";
			
			//날짜->시리얼 넘버 만들기
			String formatedNow = now.format(DateTimeFormatter.ofPattern("yyMMddkmmss"));
			
			//발주 코드 생성
			String baljucode = code+selected_company+formatedNow;
			//System.out.println("baljucode: " + baljucode); //baljucode: B14230421144441
			
			//매니저 아이디 - 추후 세션으로 가져올 예정
			String manager_id = "ty";
			
			createBalju.setBalju_code(baljucode); //발주코드
			createBalju.setManager_id(manager_id); //매니저 아이디
			createBalju.setBalju_date(timestamp); //현재등록날짜
			
			
			
			////////////////////// String Buffer 영역 ///////////////////////
			//baljuCheckList를 받기 위해서 StringBuffer를 사용해야 한다.
			//balju.jsp에서 넘겨받은 상품 정보들 
			String body = null;
	        StringBuilder stringBuilder = new StringBuilder();
	        BufferedReader bufferedReader = null;
	        
	        InputStream inputStream = request.getInputStream();
	        
	        if (inputStream != null) {
	        	bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
	        	char[] charBuffer = new char[128];
	        	int bytesRead = -1;
	        	while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
	        }
	        
	        body = stringBuilder.toString();
	        body = "{\"baljuCheckList\":" + body + "}" ;
	        //System.out.println(body);
	        
	        JSONParser parser = new JSONParser();
	        JSONObject obj = (JSONObject)parser.parse(body);
			//System.out.println(obj.get("baljuCheckList"));
			JSONArray arr = (JSONArray) obj.get("baljuCheckList");
			//System.out.println(arr);
			
			List<Integer> OrderQuantity = new ArrayList<>();
			List<Integer> ProductCode = new ArrayList<>();
			
			for(Object item : arr) {
				JSONObject obj2 = (JSONObject)item;
				int obj2Size = obj2.size();
				
				String key = "";
				String val = "";
				Iterator<String> keys = obj2.keySet().iterator();
				
				for(int i=0; i<obj2Size; i++) {
					key = keys.next();
					val = (String)obj2.get(key);
					
					System.out.println(key + "=>" + val);
					if(key.equals("balju_memo")) {
						//System.out.println(val);
						createBalju.setBalju_memo(val);
						break;
					}
					
					if(key.equals("order_quantity")) {
						OrderQuantity.add(Integer.valueOf(val));
					}else if(key.equals("product_code")) {
						ProductCode.add(Integer.valueOf(val));
					}
					
				}
			}
			
			//////////////////////String Buffer 영역 end ///////////////////////

			String BaljuBox = service.createBaljuBox(createBalju);
			System.out.println(BaljuBox); //insert 성공여부
			
			for(int i=0; i<ProductCode.size(); i++) {
				BaljuVO createBaljuItem = new BaljuVO();
				createBaljuItem.setBalju_code(baljucode); //balju_detail 발주코드
				System.out.println(OrderQuantity);
				System.out.println(ProductCode);
				createBaljuItem.setProduct_code(ProductCode.get(i));
				createBaljuItem.setBalju_quantity(OrderQuantity.get(i));
				
				String BaljuBoxItem = service.baljuIteminBaljuBox(createBaljuItem);
				System.out.println(BaljuBoxItem);
			}
			
			//어차피 ajax라 balju.jsp로 돌아간다. 그래서 responseBody를 보내주기
			return "responseBody:OK";
		}
		
		
	}

}
