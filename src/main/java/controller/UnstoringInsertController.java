package controller;

import java.sql.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import frontcontroller.CommonInterface;
import model.UnstoringService;
import util.DateUtil;
import vo.UnstoringVO;

public class UnstoringInsertController implements CommonInterface {

	// 용희 : '주문건 등록' post 요청 => DB에 insert 하는 컨트롤러 (참조 파일 : EmpInsertController)
	
	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/unstoring/unstoring_insert.jsp";

		String method = (String) data.get("method");
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		
		// 인코딩 되는지 확인 용도
		System.out.println(request.getParameter("customer_name"));

		if (method.equals("POST")) {
			UnstoringVO unstore = makeUnstore(request);
			UnstoringService service = new UnstoringService();
			int result = service.unstoringInsert(unstore);

			// redirect니까 request엔 저장하기 좀 그러니까 session에다가 해보자고(by 쌤)
			session.setAttribute("result", result);

			page = "redirect:/unstoring/unstoringInsert.do";
		} else { // GET 요청
			
		}

		return page;
	}

	private UnstoringVO makeUnstore(HttpServletRequest request) {
		// 칼럼 7개
		String unstoring_code = request.getParameter("unstoring_code");
		String customer_name = request.getParameter("customer_name");
		String customer_address = request.getParameter("customer_address");
		Date order_register = DateUtil.convertToDate(request.getParameter("order_register"));
		Date unstoring_date = DateUtil.convertToDate(request.getParameter("unstoring_date"));
		String unstoring_memo = request.getParameter("unstoring_memo");
		String manager_id = request.getParameter("manager_id");

		// VO 객체에 넣어주기 (객체 형태로 데이터 전송해야 하니까)
		UnstoringVO unstore = new UnstoringVO();
		unstore.setUnstoring_code(unstoring_code);
		unstore.setCustomer_name(customer_name);
		unstore.setCustomer_address(customer_address);
		unstore.setOrder_register(order_register);
		unstore.setUnstoring_date(unstoring_date);
		unstore.setUnstoring_memo(unstoring_memo);
		unstore.setManager_id(manager_id);
		
		return unstore;
	}

}
