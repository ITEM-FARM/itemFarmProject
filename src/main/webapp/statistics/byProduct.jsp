<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
	<title>상품별 매출현황</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>




				<!-- 시작 -->
				<div class="container-fluid">
					<h1 class="h3 mb-2 text-gray-800"><i class="fas fa-fw fa-chart-area"></i>상품별 매출현황</h1>	
						<p><i class="fas fa-exclamation-triangle"></i>&nbsp; 수수료율 : <fmt:formatNumber value="${byProductList[0].commission}" type="percent" pattern="0.0%"></fmt:formatNumber></p> 
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">조회 결과 - 총 ${byProductList_size }건</h6>
							
						</div>


						<div class="card-body">
							<div class="table-responsive">

								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr id="headrow">
											<th>Index</th>
											<th>상품코드</th>
											<th>상품명</th>
											<th>주문수량</th>
											<th>주문금액 (원)</th>
											<th>취소수량</th>
											<th>취소금액 (원)</th>
											<th>순매출수량</th>
											<th>순매출금액 (원)</th>
											<th>판매원가</th>
											<th>순이익금액 (원)</th>
											<th>순이익률 (%)</th>
										</tr>
									</thead> 
									<tbody>
										<c:forEach var="byProduct" items="${byProductList }" varStatus="status">
											<tr>
												<td>${status.count }</td>
												<td style="color:#000000DD;">${byProduct.order_product_code }</td>
												<td style="color:#000000DD;">${byProduct.order_product_name }</td>
												<td style="color:#0d6efdDD;">${byProduct.order_count }</td>
												<td style="color:#0d6efdDD;"><fmt:formatNumber value="${byProduct.order_amount}"></fmt:formatNumber></td>
												<td style="color:#dc3545DD;">${byProduct.cancel_count }</td>
												<td style="color:#dc3545DD;"><fmt:formatNumber value="${byProduct.cancel_amount}"></fmt:formatNumber></td>
												<td style="color:#000000DD;">${byProduct.revenue_count }</td>
												<td style="color:#000000DD;"><fmt:formatNumber value="${byProduct.revenue_amount}"></fmt:formatNumber></td>
												<td style="color:#000000DD;"><fmt:formatNumber value="${byProduct.total_cost}"></fmt:formatNumber></td>
												<td style="color:#000000DD;"><fmt:formatNumber value="${byProduct.net_profit}"></fmt:formatNumber></td>
												<td style="color:#000000DD;"><fmt:formatNumber value="${byProduct.net_profit_margin}" type="percent" pattern="0.0%"></fmt:formatNumber></td>
											</tr>
											
										</c:forEach>
									</tbody>
								</table>


								<!-- JSON 데이터 보내기 위한 form -->
								<!-- 2-1. 송장번호 -->
								<form id="frm1" action="/unstoring/trackingNumberInput.do">
									<input type="hidden" id="jsonTrkNum" name="jsonTrkNum"> <!-- 정해준 name으로 자바에서 getParameter 하면 넘어감 -->
								</form>
								
								<!-- 2-2. 주문취소 -->
								<form id="frm2" action="/unstoring/cancelOrder.do">
									<input type="hidden" id="jsonCancel" name="jsonCancel">
								</form>
							</div>
						</div>
					</div>
				</div>
				<!-- 끝 -->
				
				
			</div>
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
</body>
</html>