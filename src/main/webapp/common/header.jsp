<%@page import="vo.CompanyVO"%>

<%@page import="java.util.List"%>
<%@page import="model.CompanyService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
  
<%
CompanyService service = new CompanyService();
List<CompanyVO> companyList = service.companyList("all");
pageContext.setAttribute("lookUpList", companyList);
%>

<!DOCTYPE html>
<html>
<head>
<style>
#select-box {
	height: 150px;
	overflow-y: scroll;
}
.activeColor {
	color: rgb(47, 217, 0);
}
</style>
</head>
<body id="page-top">
	<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
		<!-- Sidebar Toggle (Topbar) -->
 		<button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
  			<i class="fa fa-bars"></i>
		</button>
		
		<!-- Topbar Navbar -->
		<ul class="navbar-nav ml-auto">
			<!-- 
			은빈: 로그인별 header 아이콘 설정
			1. comId != null
				1) 매니저 로그인인 경우
					- 매니저 로그인 정보
					- 기업 정보
					- 조회 기업 변경
					- 로그아웃
				2) 기업 로그인인 경우
					- 기업 정보
					- 로그아웃
			2. comId == null
				- 로그인
			-->
			<c:if test="${comId != null}">
				<c:if test="${managerUser != null && managerUser != ''}">
					<li class="nav-item no-arrow">
						<div class="nav-link">
							<i class="fas fa fa-user fa-0.5x activeColor" aria-hidden="true"></i>	
							<span class="mr-2 d-none d-lg-inline text-gray-600 small">&nbsp ${managerUser.manager_name}</span>
						</div>
					</li>
					<div class="topbar-divider d-none d-sm-block"></div>
				</c:if>
			
				<li class="nav-item no-arrow">
					<div class="nav-link">	
						<i class="fas fa fa-building fa-0.5x activeColor" aria-hidden="true"></i>
						<span class="mr-2 d-none d-lg-inline text-gray-600 small">&nbsp ${comName}</span>
					</div>
				</li>	
				<div class="topbar-divider d-none d-sm-block"></div>
			
				<c:if test="${managerUser != null && managerUser != ''}">
					<li class="nav-item no-arrow dropdown">
						<a class="nav-link dropdown-toggle" href="#" role="button" id="dropdownMenuLink"
		  				data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
		 					<i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
		        	        <span class="mr-2 d-none d-lg-inline text-gray-600 small">조회 기업 변경</span>
		       	     	</a>
		       	     	<div id="select-box" class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
							<div class="dropdown-header">기업 목록</div>
							<c:forEach items="${lookUpList}" var="look" varStatus="status">
								<a class="dropdown-item company-list-item" data-comId="${look.company_id}" 
								data-comName="${look.company_name}">${look.company_id}: ${look.company_name}</a>
							</c:forEach>
						</div>
					</li>
					<div class="topbar-divider d-none d-sm-block"></div>
				</c:if>
				
				<li class="nav-item no-arrow">
					<a class="nav-link" href="#" role="button" aria-haspopup="true" aria-expanded="false"
						data-toggle="modal" data-target="#logoutModal"> 
						<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> 
						<span class="mr-2 d-none d-lg-inline text-gray-600 small">Logout</span>
					</a>
				</li>
			</c:if>
			
			<c:if test="${comId == null}">
				<li class="nav-item no-arrow">
					<a class="nav-link" href="/auth/LoginCheck.do"> 
						<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> 
						<span class="mr-2 d-none d-lg-inline text-gray-600 small">Login</span>
					</a>
				</li>
			</c:if>
		</ul>
	</nav>
	<script>
	$(".company-list-item").on("click", function() {
		var comId = $(this).attr("data-comId");
		var comName = $(this).attr("data-comName");

		$.ajax({
			url : "/session.do",
			data : {
				"comId" : comId,
				"comName" : comName
			},
			success : function(result) {
				$(location).attr("href", $(location).attr("pathname"));
			},
			error : function(message) {
				alert(message);
			}
		});
	});
	</script>
</body>
</html>
