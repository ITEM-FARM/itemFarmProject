<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
    <!--  chart.js cdn -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<title>카테고리별 매출현황</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>

				<!-- 시작 -->
				<div class="container-fluid">
					<h1 class="h3 mb-2 text-gray-800"><i class="fas fa-fw fa-chart-area"></i>카테고리별 매출현황</h1>	
						<p><i class="fas fa-coins"></i>&nbsp; 수수료율 : <fmt:formatNumber value="${categoryList[0].commission}" type="percent" pattern="0.0%"></fmt:formatNumber></p> 
					
					<div class="row justify-content-center">
						<div class="col-6">
							<div class="card shadow mb-4">
								<div class="card-body">
									<canvas id="myChart"></canvas>
								</div>
							</div>
						</div>
						
						<div class="col-6">
							<div class="card shadow mb-4">
								<div class="card-body">
									<canvas id="myChart2"></canvas>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row justify-content-center">
					<div class="col"> 
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">조회 결과 - 총 ${categoryList_size }건</h6>
							
						</div>


						<div class="card-body">
							<div class="table-responsive">

								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr id="headrow">
											<th>Index</th>
											<th>카테고리</th>
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
									<tbody id="categoryTbody">
										<c:forEach var="category" items="${categoryList }" varStatus="status">
											<tr>
												<td>${status.count }</td>
												<td style="color:#000000DD;">${category.order_subcategory_name }</td>
												<td style="color:#0d6efdDD;">${category.order_count }</td>
												<td style="color:#0d6efdDD;"><fmt:formatNumber value="${category.order_amount}"></fmt:formatNumber></td>
												<td style="color:#dc3545DD;">${category.cancel_count }</td>
												<td style="color:#dc3545DD;"><fmt:formatNumber value="${category.cancel_amount}"></fmt:formatNumber></td>
												<td style="color:#000000DD;">${category.revenue_count }</td>
												<td style="color:#000000DD;"><fmt:formatNumber value="${category.revenue_amount}"></fmt:formatNumber></td>
												<td style="color:#000000DD;"><fmt:formatNumber value="${category.total_cost}"></fmt:formatNumber></td>
												<td style="color:#000000DD;"><fmt:formatNumber value="${category.net_profit}"></fmt:formatNumber></td>
												<td style="color:#000000DD;"><fmt:formatNumber value="${category.net_profit_margin}" type="percent" pattern="0.0%"></fmt:formatNumber></td>
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
				</div>
				</div>
				<!-- 끝 -->
				
				
			</div>
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
	
	<script>
	
	//데이터 가져오기
	$(function(){
		var labels2 = [];
		var data2 = [];
		
		var data3 = [];
		var data4 = [];
		
		$("#categoryTbody > tr").each(function(index, tr){
			
			if(index<=7){
				$(this).find("td").each(function(i,td){
					if(i==1){
						labels2.push(td.innerHTML);
					}else if(i==7){
						data2.push(Number((td.innerHTML).replace(/,/gi,'')));
					}else if(i==9){
						data3.push(Number((td.innerHTML).replace(/,/gi,'')));
					}else if(i==10){
						data4.push(Number((td.innerHTML).replace(/%/gi,'')))
					}
				});
			}
		});
		
		console.log(labels2);
		console.log(data2);
		console.log(data3);
		console.log(data4);
	
	
	//첫 번째 차트 만들기	
	  const ctx = document.getElementById('myChart');
	
	  new Chart(ctx, {
	    type: 'bar',
	    options: {
	        plugins: {
	            title: {
	                display: true,
	                text: '매출액 현황'
	            }
	        }
	    },
	    data: {
	      labels: labels2,
	      datasets: [{
	        label: '매출액',
	        data: data2,
	        borderWidth: 1
	      }]
	    },


	  });
	  
	  //두 번째 차트 만들기
	  const ctx2 = document.getElementById('myChart2');
	  
	  //const labels = ['1','2','3','4','5','6','7'];
	  const data = {
	    labels: labels2,
	    datasets: [
	      {
	        label: '순이익금액',
	        data: data3,
	        yAxisID: 'y',
	      },
	      {
	        label: '순이익률',
	        data: data4,
	        yAxisID: 'y1',
	        type:'line',
	      }
	    ]
	  };
	  
	  new Chart(ctx2, {
		  type: 'bar',
		  data: data,
		  options: {
		    responsive: true,
		    interaction: {
		      mode: 'index',
		      intersect: false,
		    },
		    stacked: false,
		    plugins: {
		      title: {
		        display: true,
		        text: '순이익 현황'
		      }
		    },
		    scales: {
		      y: {
		        type: 'linear',
		        display: true,
		        position: 'left',
		      },
		      y1: {
		        type: 'linear',
		        display: true,
		        position: 'right',

		        // grid line settings
		        grid: {
		          drawOnChartArea: false, // only want the grid lines for one axis to show up
		        },
		      },
		    }
		  },
	  });
	  
	});
	</script>
</body>
</html>