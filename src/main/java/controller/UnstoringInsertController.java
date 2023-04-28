package controller;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import frontcontroller.CommonInterface;
import model.UnstoringService;
import util.DateUtil;
import vo.CompanyVO;
import vo.ManagerVO;
import vo.ProductVO;
import vo.UnstoringDetailVO;
import vo.UnstoringVO;

public class UnstoringInsertController implements CommonInterface {

	// 용희 : '주문건 등록' post 요청 => DB에 insert 하는 컨트롤러 (참조 파일 : EmpInsertController)
	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/unstoring/unstoring_insert.jsp";
		String method = (String) data.get("method");
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		
		// 세션으로부터 Company 정보 받기
		CompanyVO companyVO = new CompanyVO();
		int company_id = (int) session.getAttribute("comId");
		companyVO.setCompany_id(company_id); 
		
		// 세션으로부터 Manager 정보 받기 (참조: LoginCheckController)
		ManagerVO managerUser =  (ManagerVO) session.getAttribute("managerUser");
		String magID = managerUser.getManager_id();
		
		// 주문건 등록 양식에 '상품코드' 가져오기 위한
		UnstoringService service = new UnstoringService();
		List<ProductVO> productList = service.selectProductCode(companyVO);
		request.setAttribute("productList", productList);
		
		
		if (method.equals("GET")) {
			// 1. 조회
			return page;
			
		} else { // POST 요청
			// 2. form 양식
			UnstoringVO unstoringVO = makeUnstoringVO(request);
			UnstoringDetailVO unstoringDetailVO = makeUnstoringDetailVO(request);
			int resultInsert = 0;
			
			
			//////////////////////////// 주문번호 만들기 ////////////////////////////
			// 등록일을 위한 현재 날짜 가져오기
			LocalDateTime now = LocalDateTime.now();
			Timestamp timestamp = Timestamp.valueOf(now);
//			createBalju.setBalju_date(timestamp); //현재등록날짜
			
			// 현재 작업 중인 코드 (발주(B), 입고(I), 출고(O))
			String code = "O";
			
			// 셀렉한 기업 코드 - ★ 추후 세션으로 가져올 예정
			String selected_company = Integer.toString(company_id);
			System.out.println("셀렉한 기업 코드 : " + selected_company);
			
			// 날짜->시리얼 넘버 만들기
			String formatedNow = now.format(DateTimeFormatter.ofPattern("yyMMddkmmss"));
			
			// 출고(=주문) 코드 생성
			String unstoringCode = code+selected_company+formatedNow;
			
			//매니저 아이디 - ★ 추후 세션으로 가져올 예정
			String manager_id = magID;
			//////////////////////////// 주문번호 만들기 끝 ////////////////////////////
			
			
			// 출고번호 setter => 이 과정을.. 아래 makeUnstoringVO 쪽으로 넘겨줘도 될 듯. 파라미터로 필요한 데이터 넘겨서
			unstoringVO.setUnstoring_code(unstoringCode);
			unstoringVO.setManager_id(manager_id);
			

			// 용희 : Insert 문장 2개라서 각각 실행하였음.  
			resultInsert = service.unstoringInsert(unstoringVO, unstoringDetailVO);
			System.out.println("Insert 컨트롤러: "+resultInsert);
			session.setAttribute("resultInsert", resultInsert); 
//			request.setAttribute("resultInsert", resultInsert);

//			page = "redirect:/unstoring/unstoringInsert.do";
//			page = "/unstoring/unstoringInsert.do";
			page = "/unstoring/unstoring_insert.jsp";
		}

		return page;
	}

	// 1. 출고 테이블 
	private UnstoringVO makeUnstoringVO(HttpServletRequest request) {
		// input 5개 - ★ 여기도 세션 적용해주면서 바꿔줘야 할 듯?
		String customer_name = request.getParameter("customer_name");
		String customer_address = request.getParameter("customer_address");
		Date order_register = DateUtil.convertToDate(request.getParameter("order_register"));
		String unstoring_memo = request.getParameter("unstoring_memo");

		// VO 객체에 넣어주기 (객체 형태로 데이터 전송해야 하니까)
		UnstoringVO unstoringVO = new UnstoringVO();
		unstoringVO.setCustomer_name(customer_name);
		unstoringVO.setCustomer_address(customer_address);
		unstoringVO.setOrder_register(order_register);
		unstoringVO.setUnstoring_memo(unstoring_memo);
		
		return unstoringVO;
	}
	
	// 2. 출고 상세 테이블
	private UnstoringDetailVO makeUnstoringDetailVO(HttpServletRequest request) {
		String unstoring_code = request.getParameter("unstoring_code");
		int product_code = Integer.parseInt(request.getParameter("product_code"));
		int unstoring_quantity = Integer.parseInt(request.getParameter("unstoring_quantity"));
		
		UnstoringDetailVO unstoringDetailVO = new UnstoringDetailVO();
		unstoringDetailVO.setUnstoring_code(unstoring_code);
		unstoringDetailVO.setProduct_code(product_code);
		unstoringDetailVO.setUnstoring_quantity(unstoring_quantity);
		
		return unstoringDetailVO;
	}

}
