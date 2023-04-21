<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    	
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
	<title>Insert title here</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
					<h1 class="h3 mb-2 text-gray-800">상품 목록</h1>
                    
                    <!-- 
                    은빈: 상품 목록 조회
                    상품 코드, 상품명 누르면 수정 modal
                    상품 등록 modal(구현중)	
                    -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">📢상품을 선택하면 수정 페이지로 이동합니다.</h6>
                            <a class="modal-link btn btn-primary btn-icon-split" href="../companyInsert" role="button" aria-haspopup="true" 
                            aria-expanded="false" data-toggle="modal" data-target="#CompanyInsertModal">
                            	<span class="text">상품 등록</span>
                            </a>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
											<th>기업 코드</th>
											<th>기업명</th>
											<th>수수료</th>
											<th>수수료</th>
											<th>수수료</th>
											<th>수수료</th>
											<th>수수료</th>
											<th>수수료</th>
											<th>수수료</th>
											<th>활성화 상태</th>
										</tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
											<th>기업 코드</th>
											<th>기업명</th>
											<th>수수료</th>
											<th>활성화 상태</th>
										</tr>
                                    </tfoot>
                                    <tbody>
                                        <c:forEach items="${productList}" var="product">
											<tr class="companyRow">
												<td>
													<a data-company="${company}" data-id="${company.company_id}" class="modal-link" href="../companyDetail-id:${company.company_id}" role="button"
  				aria-haspopup="true" aria-expanded="false" data-toggle="modal" data-target="#CompanyModifyModal" >${product.product_name}</a>
												</td>
												<td>
													<a data-company="${company}" data-id="${company.company_id}" class="modal-link" href="../companyDetail-name:${company.company_name}" role="button"
  				aria-haspopup="true" aria-expanded="false" data-toggle="modal" data-target="#CompanyModifyModal" >${company.company_name}</a></td>
												<td>${company.company_commission}%</td>
												<td>${company.company_status == "Y".charAt(0) ? "활성" : "비활성"}</td> 
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
</body>
</html>