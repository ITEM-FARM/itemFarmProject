<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/commonCSS.jsp"%>
<title>Insert title here</title>
<script>
	// 용희 : '주문건 등록' 성공하면 알림창 표시
	
	//1. EmpInsert컨트롤러에서 set한 msg(입력성공/입력실패)를 여기서 받아서  
	var msg = "${result}";
	if (msg == 1) {
		alert(msg); // 2. 화면에 출력
		msg = null;
	}
</script>
</head>
<body>
	<!-- 3. 그리고 그 msg 변수에 빈값을 넣어버려(빈값이면 출력 안하게 해놨으니까). scope는 session으로 해서 -->
	<div id="wrapper">
		<%@ include file="../common/nav.jsp"%>
		<c:set var="msg" value="" scope="session"></c:set>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp"%>

				<div class="container-fluid">
					<!-- empInsert.jsp 보고 따라함 -->
					<!-- 여기 안에 내용을 다 써야 한다는 소리구나 -->
					<h1>주문건 등록 페이지</h1>
					<form method="post" action="/unstoring/unstoringInsert.do">
						<table>
							<!-- ★ 우선 방법1, 방법2 확정된게 아니라 입력 패턴은 넣지 않았음. -->
							<!-- ★ 주문번호 : 자동생성 될 거라서 나중에 뺄 수도 -->
							<!-- ★ 주문일자, 출고일자 : 클릭하면 달력이 나오게 해서 직접 날짜 정할 수 있게 해주고 싶은데 -->
							<!-- ★ 관리자id : 로그인한 관리자 id 그대로 입력되게 할 거라서 나중엔 빼야할 듯 -->
							<tr>
								<td><label for="unstoring_code">주문 번호</label></td>
								<td><input name="unstoring_code" id="unstoring_code"
									type="text" required placeholder="주문번호 입력" autofocus></td>
							</tr>
							<tr>
								<td><label for="customer_name">주문자 성함</label></td>
								<td><input name="customer_name" id="customer_name"
									type="text" required placeholder="주문자 성함 입력"></td>
							</tr>
							<tr>
								<td><label for="customer_address">주문자 주소</label></td>
								<td><input name="customer_address" id="customer_address"
									type="text" required placeholder="주문자 주소 입력"></td>
							</tr>
							<tr>
								<td><label for="order_register">주문 일자</label></td>
								<td><input name="order_register" id="order_register"
									type="date" required placeholder="주문일자"></td>
							</tr>
							<tr>
								<td><label for="unstoring_date">출고 일자</label></td>
								<td><input name="unstoring_date" id="unstoring_date"
									type="date" required placeholder="출고일자"></td>
							</tr>
							<tr>
								<td><label for="unstoring_memo">주문 메모</label></td>
								<td><input name="unstoring_memo" id="unstoring_memo"
									type="text" placeholder="주문메모 입력"></td>
							</tr>
							<tr>
								<td><label for="manager_id">출고 관리자 id</label></td>
								<td><input name="manager_id" id="manager_id" type="text"
									required placeholder="출고관리자id 입력"></td>
							</tr>
							<tr style="text-align: center;">
								<td colspan="2"><input type="submit" value="등록"></td>
							</tr>
						</table>

					</form>
				</div>
			</div>
			<%@ include file="../common/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../common/commonETC.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
</body>
</html>