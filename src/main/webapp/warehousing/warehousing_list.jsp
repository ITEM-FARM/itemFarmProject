<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
    <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<title>입출고내역조회</title>
	<style>
	#warehousingFilter {
		display: inline-block;
	}
	#dataTable #datarow:hover {
		background-color: #dddfeb;
	}
	.selected {
		background-color: #dddfeb;
	}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
					<h1 class="h3 mb-2 text-gray-800"><i class="fas fa-fw fa-table"></i>&nbsp;'${comName}' 입출고 내역 조회</h1>

                    <p><i class="fas fa-exclamation-triangle"></i> 기업의 입/출고 내역을 조회할 수 있습니다.</p>
		            
		            <!-- 은빈: post: 입출고 구분에 따른 필터링 -->
		            <form id="warehousingFilter" method="post" action="/warehousing/warehousingList.do">
		            	<label>
			            	<select id="warehousing-filter" name="warehousing-filter" class="custom-select custom-select-sm form-control form-control-sm">
			                	<option value="all" ${filter == "all" ? "selected" : ""}>전체보기</option>
			                    <option value="storing" ${filter == "storing" ? "selected" : ""}>입고</option>
			                    <option value="unstoring" ${filter == "unstoring" ? "selected" : ""}>출고</option>
			            	</select>
			            </label>
			            <button class="btn btn-primary btn-circle btn-sm"><i class="fa fa-search" aria-hidden="true"></i></button>                 
		            </form>
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">입출고 내역</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr id="headrow">
											<th>Index</th>
											<th>입/출고</th>
											<th>상품코드</th>
											<th>상품명</th>
											<th>발주서연동</th>
											<th>발주서번호</th>
											<th>입/출고날짜</th>
											<th>입/출고수량</th>
										</tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
											<th>Index</th>
											<th>입/출고</th>
											<th>상품코드</th>
											<th>상품명</th>
											<th>발주서연동</th>
											<th>발주서번호</th>
											<th>입/출고날짜</th>
											<th>입/출고수량</th>
										</tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach items="${warehousingList}" var="warehousing" varStatus="status">
											<tr id="datarow">
												<td>${status.count}</td>
												<td>${warehousing.warehousing_state}</td>
												<td>${warehousing.product_code}</td>
												<td>${warehousing.product_name}</td>
												<td>${warehousing.warehousing_state == "출고" ? "-" : warehousing.balju_code != null ? "O" : "X"}</td>
												<td>${warehousing.balju_code == null ? "-" : warehousing.balju_code}</td>
												<td><fmt:formatDate value="${warehousing.warehousing_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
												<td>${warehousing.warehousing_quantity}</td>
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
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
	<!-- Page level plugins -->
	<script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<!-- Page level custom scripts -->
	<script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
	<script>
	/*
	테이블 마우스 hover시 background 색 변경 (참고: balju.jsp)
	*/
	$("#headrow > th").hover(function(){
		var index = $(this).index();
		$(this).addClass('selected');
		$("table tr>td:nth-child("+(index+1)+")").addClass('selected');
	},function(){
		var index = $(this).index();
		$(this).removeClass('selected');
		$("table tr>td:nth-child("+(index+1)+")").removeClass('selected');
	});
	</script>
</body>
</html>