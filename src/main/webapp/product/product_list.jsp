<%@page import="model.CategoryService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
CategoryService categoryService = new CategoryService();
pageContext.setAttribute("categoryList", categoryService.categoryList());
pageContext.setAttribute("subcategoryList", categoryService.subcategoryList());
%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
    <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<title>상품조회</title>
	<style>
	#prodFilter {
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
					<h1 class="h3 mb-2 text-gray-800">'${comName}' 상품 목록</h1>
					
					<c:if test="${managerUser != null && managerUser != ''}">
					
                    <p>📢상품을 선택하면 수정 페이지로 이동합니다.</p>
                    <a class="modal-link btn btn-primary btn-icon-split btn-sm" href="../productInsert" role="button" aria-haspopup="true" 
		            	aria-expanded="false" data-toggle="modal" data-target="#ProductInsertModal">
		                <span class="text">상품 등록</span>
		            </a>
		            
		            </c:if>
		            
		            <!-- 은빈: post: 상품 상태에 따른 필터링 -->
		            <form id="prodFilter" method="post" action="/product/productList.do">
		            	<label>
			            	<select id="prodStatus-filter" name="prodStatus-filter" class="custom-select custom-select-sm form-control form-control-sm">
			                	<option value="all" ${filter == "all" ? "selected" : ""}>전체보기</option>
			                    <option value="Y" ${filter == "Y" ? "selected" : ""}>활성</option>
			                    <option value="N" ${filter == "N" ? "selected" : ""}>비활성</option>
			            	</select>
			            </label>
			            <button class="btn btn-primary btn-circle btn-sm"><i class="fa fa-search" aria-hidden="true"></i></button>                 
		            </form>
                    <!-- 
                    은빈: 상품 목록 조회
                    상품 코드, 상품명 누르면 수정 modal
                    상품 등록 modal(구현중)	
                    -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">상품 목록</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr id="headrow">
											<th>Index</th>
											<th>상품 코드</th>
											<th>상품명</th>
											<th>카테고리</th>
											<th>원가 (원)</th>
											<th>판매가 (원)</th>
											<th>재고</th>
											<th>안전재고</th>
											<th>등록일</th>
											<th>상태</th>
											<th>상품 담당자</th>
										</tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                        	<th>Index</th>
											<th>상품 코드</th>
											<th>상품명</th>
											<th>카테고리</th>
											<th>원가 (원)</th>
											<th>판매가 (원)</th>
											<th>재고</th>
											<th>안전재고</th>
											<th>등록일</th>
											<th>상태</th>
											<th>상품 담당자</th>
										</tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach items="${productList}" var="product" varStatus="status">
											<tr id="datarow">
												<td>${status.count}</td>
												<td>
													<a data-product="${product}" class="modal-link" href="../productDetail-code:${product.product_code}" role="button"
  				aria-haspopup="true" aria-expanded="false" data-toggle="modal" data-target="#ProductModifyModal" >${product.product_code}</a></td>
												<td>
													<a data-product="${product}" class="modal-link" href="../productDetail-name:${product.product_name}" role="button"
  				aria-haspopup="true" aria-expanded="false" data-toggle="modal" data-target="#ProductModifyModal" >${product.product_name}</a></td>
												<td>${product.subcategory_name}</td>
												<td><fmt:formatNumber value="${product.product_cost}"></fmt:formatNumber></td>
												<td><fmt:formatNumber value="${product.product_price}"></fmt:formatNumber></td>
												<td>${product.product_stock}</td>
												<td>${product.product_safety}</td>
												<td><fmt:formatDate value="${product.product_regdate}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
												<td>${product.product_status == "Y".charAt(0) ? "활성" : "비활성"}</td>
												<td>${product.manager_name}</td> 
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
	
	<c:if test="${managerUser != null && managerUser != ''}">
	<%@ include file="product_modify.jsp" %>
	<%@ include file="product_insert.jsp" %>
	</c:if>

	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
	<!-- Page level plugins -->
	<script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<!-- Page level custom scripts -->
	<script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
	<script>
	/*
	은빈: modal 창으로 객체 전달
	- show.bs.modal: modal 창이 보일 때
	- $(event.relatedTarget).data(OO): data-OO로 지정한 속성을 콤마로 구분해 가져옴
	- $.each(): 가져온 속성을 json 객체로 생성
	- for(let key in json): 각 input에 데이터 부여
	- $.each($(".company_status"): 데이터에 따라 체크 상태 변화
	*/
		$("#ProductModifyModal").on("show.bs.modal", function (event) {
			var str = $(event.relatedTarget).data('product').split(",");
			
			var json = {};
			$.each(str, function (idx, item) {
				var value = item.split(" : ");
				json[value[0]] = value[1];
			});
			
			for(let key in json) {
				var id = "#"+key.replaceAll("'", "");
				
				if(id.includes("category")) {
					$("#selectedModifyCategory").attr("value", json[key]);
				}
				else if(!id.includes("status")) {
					$(id).attr("value", json[key]);
				} 
				else {
					if(json[key] == "Y") {
						$("#product_statusN").removeAttr("checked");
						$("#product_statusY").attr("checked", "");
					} else {
						$("#product_statusY").removeAttr("checked");
						$("#product_statusN").attr("checked", "");
					}
				}
			}
		});
	</script>
	<script>
	/*
	테이블 마우스 hover시 background 색 변경 (참고: balju.jsp)
	*/
	var m = "${managerUser}";
	console.log(m);
	if(m != null && m != "") {
		console.log("매니저 있어");
	}
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