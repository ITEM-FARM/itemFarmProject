<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/commonCSS.jsp"%>
<title>Insert title here</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp"%>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp"%>

				<div class="container-fluid">
					<!-- empSelect.jsp 보고 따라함 -->
					<!-- 여기 안에 내용을 다 써야 한다는 소리구나 -->
					<h1>주문건 조회 페이지</h1>
					<form method="get" action="">
						<table class="table table-hover">
							<thead>
								<tr>
									<!-- 순서 칼럼 1개 + VO 칼럼 9개 -->
									<th>순서</th>
									<th>주문번호</th>
									<th>주문자 성함</th>
									<th>주문자 주소</th>
									<th>주문일자</th>
									<th>출고일자</th>
									<th>송장번호</th>
									<th>주문상태</th>
									<th>출고담당자</th>
									<th>주문메모(비고)</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${unstoreList }" varStatus="status">
								<tr>
									<td>${status.count }</td>
									<td>${list.unstore_code }</td>
									<td>${list.customer_name }</td>
									<td>${list.customer_address }</td>
									<td>${list.order_register }</td>
									<td>${list.unstore_date }</td>
									<td>${list.tracking_number }</td>
									<td>${list.unstore_status }</td>
									<td>${list.manager_id }</td>
									<td>${list.unstore_memo }</td>
								</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td>tfoot 테스트</td>
								</tr>
							</tfoot>
						</table>

					</form>
				</div>
			</div>
			<%@ include file="../common/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../common/commonBtn.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
</body>
</html>