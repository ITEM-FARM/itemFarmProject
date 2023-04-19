<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
    <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<title>전체기업조회</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
					<h1 class="h3 mb-2 text-gray-800">ITEM FARM에 등록된 기업 목록</h1>
                    
                    <!-- 
                    은빈: 기업 목록 조회
                    	기업 코드, 기업명 누르면 수정 modal(구현중)
                    -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">📢기업을 선택하면 수정 페이지로 이동합니다.<h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
											<th>기업 코드</th>
											<th>기업명</th>
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
                                        <c:forEach items="${companyList}" var="company">
											<tr class="companyRow">
												<td>
													<a data-companyid="${company.company_id}" class="nav-link" href="#" role="button"
  				aria-haspopup="true" aria-expanded="false" data-toggle="modal" data-target="#CompanyModifyModal" >${company.company_id}</a>
												</td>
												<td>
													<a data-companyid="${company.company_id}" class="nav-link" href="#" role="button"
  				aria-haspopup="true" aria-expanded="false" data-toggle="modal" data-target="#CompanyModifyModal" >${company.company_name}</a></td>
												<td>${company.company_commission}%</td>
												<td>${company.company_status == "Y".charAt(0) ? "활성" : "비활성"}</td> 
											</tr>
											<%@ include file="company_modify.jsp" %>
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
	<%@ include file="../common/commonBtn.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
	<!-- Page level plugins -->
	<script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<!-- Page level custom scripts -->
	<script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
	<script>
		/* $(".companyRow").on("click", function () {
			alert("기업 ${company.company_id} 누름");
		}); */
	</script>
</body>
</html>