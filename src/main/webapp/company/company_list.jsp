<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
    <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<title>전체기업조회</title>
<style>

</style>
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
                    기업 코드, 기업명 누르면 수정 modal
                    기업 등록 modal(구현중)	
                    -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">📢기업을 선택하면 수정 페이지로 이동합니다.</h6>
                            <a class="modal-link btn btn-primary btn-icon-split" href="../companyInsert" role="button" aria-haspopup="true" 
                            aria-expanded="false" data-toggle="modal" data-target="#CompanyInsertModal">
                            	<span class="text">기업 등록</span>
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
													<a data-company="${company}" data-id="${company.company_id}" class="modal-link" href="../companyDetail-id:${company.company_id}" role="button"
  				aria-haspopup="true" aria-expanded="false" data-toggle="modal" data-target="#CompanyModifyModal" >${company.company_id}</a>
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

	<%@ include file="company_modify.jsp" %>
	<%@ include file="company_insert.jsp" %>

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
		$("#CompanyModifyModal").on("show.bs.modal", function (event) {
			var str = $(event.relatedTarget).data('company').split(",");
			
			var json = {};
			$.each(str, function (idx, item) {
				var value = item.split(":");
				json[value[0]] = value[1];
			});
			
			for(let key in json) {
				var id = "#"+key.replaceAll("'", "");
				
				if(!id.includes("status")) {
					$(id).attr("value", json[key]);
					
					if(id.includes("name")) {
						$("#exampleModalLabel").html(json[key] + " 정보 수정");
					}
				}else {
					if(json[key] == "Y") {
						$("#company_statusN").removeAttr("checked");
						$("#company_statusY").attr("checked", "");
					} else {
						$("#company_statusY").removeAttr("checked");
						$("#company_statusN").attr("checked", "");
					}
				}
			}
		});
	</script>
</body>
</html>