<%@page import="util.MysqlUtil"%>


<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
	
    <%@ include file="../common/commonCSS.jsp" %>
    <!-- Custom styles for this page -->
    <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<title>발주 등록 폼</title>
	
	<style>
		/* [태영] 테이블 마우스 hover시 background 색 변경 */
		#dataTable #datarow:hover{
			background-color: #dddfeb;
		}
		
		.selected{
			background-color: #dddfeb;
		}
		
		
	</style>
	
	<script>
		$(function(){
			$("#headrow > th").hover(function(){
				var index = $(this).index();
				$(this).addClass('selected');
				$("table tr>td:nth-child("+(index+1)+")").addClass('selected');
			},function(){
				var index = $(this).index();
				$(this).removeClass('selected');
				$("table tr>td:nth-child("+(index+1)+")").removeClass('selected');
			});
		});
	
	</script>

</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
				<!-- [태영] Start : Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">신한 DS 발주 등록</h1>
                    <p><i class="fas fa-exclamation-triangle"></i> 발주 수량은 안전재고와 비교하여 자동 계산된 수량입니다.</p>
          		<!-- [태영] End : Page Heading  -->
          		
          		
          		<!-- [태영] Table영역 -->
          		<form method="post" action="<%=request.getContextPath()%>/balju/baljuConfirmList.do">
                    <div class="card shadow mb-4">
                    <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">발주 상품 체크리스트</h6>
                    </div>
                    
                    
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr id="headrow">
                                        	<th>Index</th>
                                            <th>상품코드</th>
                                            <th>상품명</th>
                                            <th>현재재고</th>
                                            <th>안전재고</th>
                                            <th>발주수량</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${baljuchecklist}" var="bal" varStatus="status">
                                        	<tr id="datarow">
                                        		<td>
													<div class="form-check">
													  <input class="form-check-input" type="checkbox"  id="flexCheckDefault" name="baljuCheckBT" onchange="chkCall(this)">

													  <label class="form-check-label text-primary" for="flexCheckDefault">
													    <h6>${status.count }</h6>
													  </label>
													</div>
                                        		</td>
                                        		<td>${bal.product_code}</td>
                                        		<td>${bal.product_name}</td>
                                        		<td>${bal.product_stock}</td>
                                        		<td>${bal.product_safety}</td>
                                        		<td>${bal.order_quantity}</td>
                                        	</tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                    </div>
                    
                    <div class="card shadow mb-4">
                	<div class="card-header py-3">
                      <h6 class="m-0 font-weight-bold text-primary">발주 등록 폼</h6>
                    </div>
                    <div class="card-body">
	                    <div class="input-group">
						  <span class="input-group-text">비고란</span>
						  <textarea class="form-control" aria-label="With textarea" 
						  placeholder="내용을 입력해주세요" id="balju_memo"></textarea>
						</div>
						<br>
						<div class="d-grid gap-2 d-md-flex justify-content-md-end">
						  <button class="btn btn-primary me-md-2" type="button" id="ConfirmBT">확정</button>
						</div>
                    </div>
              	</div>
              	</form>
				</div>
				
			</div>
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
	
	<!-- Page level plugins -->
    <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>  
    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
	
	<script>
		//[태영] 확정 버튼을 누르면 ajax를 이용해 check된 데이터만 넘기는 로직
		var arr = [];
		function chkCall(obj){
				if($(obj).is(':checked')){
					console.log("체크");
					arr.push(clickEvent(event));
				}else{
					console.log("체크해제");
					obj = clickEvent(event);
					console.log(obj["product_code"]);
					
					arr = arr.filter((element) => {
						console.log("pp",element["product_code"]);
						return element["product_code"] != obj["product_code"];
					});
				}
				console.log(arr);
			}
		$(function(){ 
			//var arr = [];
			//[태영] 1. checkbox 클릭시 clickEvent가 작동하도록 한다.
			 
			
			/* $('input:checkbox[name="baljuCheckBT"]').click(function(){
				//체크되었는지 여부 확인
				if($(this).is(':checked')){
					console.log("체크");
					arr.push(clickEvent(event));
				}else{
					console.log("체크해제");
					obj = clickEvent(event);
					console.log(obj["product_code"]);
					
					arr = arr.filter((element) => {
						console.log("pp",element["product_code"]);
						return element["product_code"] != obj["product_code"];
					});
				}
				console.log(arr);
			}); */
		
			$('#ConfirmBT').on("click", ()=>{
				var obj = {};
				obj["balju_memo"] = $('#balju_memo').val()
				arr.push(obj);
				console.log(arr);
				$.ajax({
					url:"baljuConfirmList.do",
					data:JSON.stringify(arr),
					method:"post",
					contentType: 'application/json; charset=utf-8',
					success:(result,status,xhr)=>{
						console.log("textStatus", result);
						location.href="baljuConfirmList.do";
					},
					error:(jqXHR, textStatus, errorThrown)=>{
						console.log("textStatus", textStatus);
					}
				});
			});
		});
		
		function clickEvent(event){
			
			console.log("target:",$(event.target)); //checkbox target 확인
			//target과 가까운 tr 태그 찾기
			var row = $(event.target).closest('tr');
			//td태그 찾기
			var column = row.find('td');
			//console.log('row', row);
			//console.log('column', column);
			
			var obj = {};
			$.each(column, function(index, item){
				//console.log(index, item.innerHTML);
				
				if(index === 1){
					obj["product_code"] = item.innerHTML;
				}else if(index = 5){
					obj["order_quantity"] = item.innerHTML;
				}
			});
			
			//console.log(obj);
			return obj;
		}
	</script>
</body>
</html>