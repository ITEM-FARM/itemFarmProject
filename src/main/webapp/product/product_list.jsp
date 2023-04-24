<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
    <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<title>상품조회</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
					<h1 class="h3 mb-2 text-gray-800">'${comName}' 상품 목록</h1>
                    
                    <!-- 
                    은빈: 상품 목록 조회
                    상품 코드, 상품명 누르면 수정 modal
                    상품 등록 modal(구현중)	
                    -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">📢상품을 선택하면 수정 페이지로 이동합니다.</h6>
                            <div>
                            	<a class="modal-link btn btn-primary btn-icon-split" href="../productInsert" role="button" aria-haspopup="true" 
		                           aria-expanded="false" data-toggle="modal" data-target="#ProductInsertModal">
		                            <span class="text">상품 등록</span>
		                        </a>
		                        <label>
		                            <select id="prodStatus-filter" name="prodStatus-filter" class="custom-select custom-select-sm form-control form-control-sm">
		                            	<option value="all">전체보기</option>
		                            	<option value="Y">활성</option>
		                            	<option value="N">비활성</option>
		                            </select>
		                        </label>
                            </div>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
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
                                    <tbody id="table-body">
                                        <c:forEach items="${productList}" var="product">
											<tr>
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
	
	<%@ include file="product_modify.jsp" %>
	<%@ include file="product_insert.jsp" %>

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
				
				if(!id.includes("status")) {
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
	
	$("#prodStatus-filter").on("change", function() {
		$.ajax({
			url: $(location).attr("pathname"),
			method: "post",
			data: {"filter":$(this).val()},
			success: function(result) {
				$("#table-body").html(result);
			}
		});
	});
	</script>
</body>
</html>