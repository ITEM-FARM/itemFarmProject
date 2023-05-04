package controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import frontcontroller.CommonInterface;
import vo.CompanyVO;

public class UnstoringTestReadController implements CommonInterface {

	@Override
	public String execute(Map<String, Object> data) throws Exception {
		String page = "/unstoring/unstoring_detail.jsp";
		HttpServletRequest request = (HttpServletRequest) data.get("request");
		HttpSession session = request.getSession();
		
		// 용희 : 페이지에 따라 header 부분 안 보이게끔 하는 if문을 위한 임의의 숫자
		// 일단 header_2.jsp 복붙해서 임시 땜빵
		
		return page;
	}

}
