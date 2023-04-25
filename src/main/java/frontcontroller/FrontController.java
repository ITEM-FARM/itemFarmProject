package frontcontroller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.LoginCheckController;
import controller.BaljuCheckListController;
import controller.BaljuConfirmListController;
import controller.BaljuDetailListController;
import controller.CompanyInsertController;
import controller.UnstoringCancelOrderController;
import controller.CompanyListController;
import controller.CompanyModifyController;
import controller.ProductInsertController;
import controller.ProductListController;
import controller.ProductModifyController;
import controller.SessionController;
import controller.StatisticsController;
import controller.StoringInsertController;
import controller.UnstoringTrackingNumberInputController;
import controller.UnstoringDetailController;
import controller.StoringListController;
import controller.UnstoringInsertController;
import controller.UnstoringListController;
import controller.UnstoringTestController;
import controller.UnstoringTestReadController;
import controller.WarehousingController;


@WebServlet("*.do")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getServletPath();
		CommonInterface controller = null;
		Map<String, Object> data = new HashMap<>();
		
		data.put("method", request.getMethod());
		data.put("request", request);
		data.put("response", response);
		
		switch (path) {
		case "/auth/loginCheck.do"://[태영] 로그인 
			controller = new LoginCheckController();
			break;
		case "/balju/baljuCheckList.do": //[태영]발주서 생성
			controller = new BaljuCheckListController();
			break;
		case "/balju/baljuConfirmList.do"://[태영]발주 조회, 상세 조회
			controller = new BaljuConfirmListController();
			break;
		case "/balju/baljuDetailList.do":
			controller = new BaljuDetailListController();
			break;
		case "/company/companyList.do":
			controller = new CompanyListController();
			break;
		case "/company/companyModify.do":
			controller = new CompanyModifyController();
			break;
		case "/company/companyInsert.do":
			controller = new CompanyInsertController();
			break;
		case "/product/productList.do":
			controller = new ProductListController();
			break;
		case "/product/productModify.do":
			controller = new ProductModifyController();
			break;
		case "/product/productInsert.do":
			controller = new ProductInsertController();
			break;
		case "/statistics/new.do":
			controller = new StatisticsController();
			break;
		case "/storing/storing_insert.do":
			controller = new StoringInsertController();
			break;
		case "/storing/storing_list.do":
			controller = new StoringListController();
			break;
		case "/unstoring/unstoringInsert.do": // 주문건 등록 (출고관리)
			controller = new UnstoringInsertController();
			break;
		case "/unstoring/unstoringList.do": // 주문건 조회 (출고관리)
			controller = new UnstoringListController();
			break;
		case "/unstoring/trackingNumberInput.do": // 송장번호 입력 ajax (출고관리)
			controller = new UnstoringTrackingNumberInputController();
			break;
		case "/unstoring/cancelOrder.do": // 주문취소 ajax (출고관리)
			controller = new UnstoringCancelOrderController();
			break;
		case "/unstoring/unstoringDetail.do": // 주문건 상세조회 (모달) - 일단 포기 
			controller = new UnstoringDetailController();
			break;
		case "/unstoring/unstoringTest.do": // 주문건 상세조회 (리디렉트)
			controller = new UnstoringTestController();
			break;
		case "/unstoring/unstoringTestRead.do": // 주문건 상세조회 (리디렉트)
			controller = new UnstoringTestReadController();
			break;
		case "/warehousing/new.do":
			controller = new WarehousingController();
			break;
		case "/session.do":
			controller = new SessionController();
			break;	
		default:
			break;
		}
		
		String page = null;
		
		try {
			page = controller.execute(data);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(page.indexOf("redirect:") >= 0) {
			response.sendRedirect(page.substring(9));
		} else if (page.indexOf("responseBody:") >= 0) {
		 response.getWriter().append(page.substring(13));
		} else {
			RequestDispatcher rd;
			rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		}
	}
 
	
}
