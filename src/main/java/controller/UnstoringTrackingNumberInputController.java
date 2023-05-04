package controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import frontcontroller.CommonInterface;
import model.UnstoringService;
import vo.CompanyVO;
import vo.UnstoringDetailVO;
import vo.UnstoringVO;

public class UnstoringTrackingNumberInputController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		UnstoringService service = new UnstoringService();
		
		// (1)송장입력, (2)출고일자 입력을 위한 현재 날짜 가져오기 => DB에 DATETIME 타입
		LocalDateTime now = LocalDateTime.now();
		Timestamp timestamp = Timestamp.valueOf(now);
		
		// 세션으로부터 Company 정보 받기
		CompanyVO companyVO = new CompanyVO();
		int company_id = (int) session.getAttribute("comId"); // ★나중에 로그인 및 세션-setAttribute 전부 되면 그때 사용
		companyVO.setCompany_id(company_id);

//		세션으로부터 Manager 정보 받기 (참조: LoginCheckController)
//		String magID = (String) session.getAttribute("magID");
		
		
		// org.json.simple.* 라이브러리를 사용하는 경우
		/**** JSON 받는 방법 ****/
	    // 1. request로 문자열형식의 데이터를 받고 (★★★왜냐면 String으로 찍히더라고 JS 단에서)
		String jsonTrkNum = request.getParameter("jsonTrkNum");
		
		// 2. 파싱 : String으로 온 놈을 파싱해서 JSON 객체에 담아주고 
	    JSONParser parser = new JSONParser();
	    JSONObject obj1 = (JSONObject) parser.parse(jsonTrkNum); 
		
		// 3. key를 줘서 { }를 먼저 한번 벗기고, JSONArray에 담아 (왜냐면 배열 형태니까) (★근데 그냥 배열에 담으면 에러 나더라고)
		JSONArray arr =  (JSONArray) obj1.get("key");
		
		// 4. 벗긴 그 JSONArray를 loop 
		List<UnstoringVO> list = new ArrayList<>();
		for(int i=0; i<arr.size(); i++) {
			// 각각이 {"number" : 1} , {"number" : 2} 이런 식으로 되고
			// 다시 JSON오브젝트 타입에 담고
			JSONObject obj2 = (JSONObject) arr.get(i); 
			
			// 5. 마지막으로 키:값 형태로 값을 얻어내면 되나..?
			String unstoring_code = String.valueOf(obj2.get("number"));
			
			// 6. code 수만큼 VO를 new해서 값을 세팅해주고
			UnstoringVO vo = new UnstoringVO();
			vo.setUnstoring_code(unstoring_code);
			
			// 7. List에 담아 (왜냐면 List 형태로 DAO에 보내야 하거든)
			list.add(vo);
		}
		String trkNum = createTrkNum(now); // A. 송장번호 생성
		List<UnstoringDetailVO> detailList = makeDetail(list, service);
		
		//송장입력 로직 처리하게끔
		int resultTrkNum = service.trackingNumberInput(list, trkNum, detailList, timestamp);
		int trk = (resultTrkNum > 0) ? 0:1;
	    session.setAttribute("trk", trk);
	    
	    String page = "redirect:/unstoring/unstoringList.do"; 
	    return page;
	}
	
	
	
	// 송장번호 생성
	public String createTrkNum(LocalDateTime now) {
		// 현재 작업 중인 코드 (발주(B), 입고(I), 출고(O), 송장(T))
		String code = "T-";

		// 날짜->시리얼 넘버 만들기
		String formatedNow = now.format(DateTimeFormatter.ofPattern("yyMMddkmmss"));

		// 송장번호 생성
		String trkNum = code + formatedNow;

		return trkNum;
	}
	
	
	
	// 송장번호 List => for문 => 각 송장번호에 해당하는 detailVO를 가져와서 다시 detailList에 담아주기??
	public List<UnstoringDetailVO> makeDetail(List<UnstoringVO> listVO, UnstoringService service) {
		return service.selectDetailByTrkNum(listVO);
	}
	

}


