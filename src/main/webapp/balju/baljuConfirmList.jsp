<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
    
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
    <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<title>발주내역</title>
	
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
					<h1 class="h3 mb-2 text-gray-800">신한 DS 확정 발주 내역 조회</h1>
					<p><i class="fas fa-exclamation-triangle"></i> 발주서 번호를 누르면 상세 조회가 가능합니다.</p>
					
					<div class="card shadow mb-4">
					<div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">발주서 목록</h6>
                    </div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
									<thead>
		                              <tr id="headrow">
		                              		<th>Index</th>
		                                    <th>발주서번호</th>
		                                    <th>발주날짜</th>
		                                    <th>발주담당자</th>
		                                    <th>비고</th>
		                            	</tr>
		                            </thead>
		                            <tbody>
		                            	<c:forEach items="${baljulist}" var="balist" varStatus="status">
			                            	<tr id="datarow">
			                            		<td>${status.count }</td>
			                            		<td>
			                            			<a href="#" data-toggle="modal" data-target="#detailModal">
			                            			${balist.balju_code}</a>
			                            		</td>
			                            		<td><fmt:formatDate value="${balist.balju_date}" pattern="yy-MM-dd HH:mm:ss" /></td>
			                            		<td>${balist.manager_id}</td>
			                            		<td>${balist.balju_memo}</td>
			                            	</tr>
		                            	</c:forEach>
		                            </tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				
				
			</div>
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
	
	<%@ include file="baljuDetailModal.jsp" %>
	
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
	
	<!-- Page level plugins -->
    <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
    
    <script>
    	$(function(){
    		$('a[data-target="#detailModal"]').click(function(){
    			$.ajax({
    				url:"baljuDetailList.do",
    				data:{baljuCode: $(this).text().trim()},
    				method:"get",
    				success:(result,status,xhr)=>{
						//console.log("textStatus", result);
						$("#here").html(result);
						$("#exampleModalLabel").html("<span class='text-primary'>"+ $(this).text().trim() + "</span> 발주서 상세 조회");
					},
					error:(jqXHR, textStatus, errorThrown)=>{
						//console.log("textStatus", textStatus);
					}
    			});
    		})
    	});
    </script>
</body>
</html>