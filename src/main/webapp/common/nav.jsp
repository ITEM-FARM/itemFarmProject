<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body id="page-top">
	<div id="wrapper">
	<!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

			<!--  
			은빈: 로그인 별 nav 기능 설정
			1. 매니저 == null || 매니저 == ""
				1) 상품 관리
					- 상품 조회 (버튼 X)
				2) 출고 관리
					- 주문건 조회 (버튼 X)
				3) 입출고 내역 조회
				4) 마케팅 리포트
			2. 매니저 존재
				- 모든 기능 사용 가능
			-->
            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="../">
                <div class="sidebar-brand-icon">
                    <i class="fas fa-warehouse"></i>
                </div>
                <div class="sidebar-brand-text mx-3">ITEM FARM</div>
            </a>
            <hr class="sidebar-divider my-0">

			<c:if test="${managerUser != null && managerUser != ''}">
	            <!-- Nav Item - Dashboard -->
	            <li class="nav-item">
	                <a class="nav-link" href="../company/companyList.do">
	                    <i class="fas fa-fw fa-city"></i>
	                    <span>기업관리</span></a>
	            </li>
	            <hr class="sidebar-divider">
			</c:if>
				            
            <!-- Nav Item - Dashboard -->
            <li class="nav-item ">
                <a class="nav-link" href="../product/productList.do">
                    <i class="fas fa-fw fa-briefcase"></i>
                    <span>상품관리</span></a>
            </li>
            <hr class="sidebar-divider">

			<c:if test="${managerUser != null && managerUser != ''}">
	            <!-- Nav Item - Pages Collapse Menu -->
	            <li class="nav-item">
	                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
	                    aria-expanded="true" aria-controls="collapseTwo">
	                    <i class="fas fa-fw fa-barcode"></i>
	                    <span>발주관리</span>
	                </a>
	                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
	                    <div class="bg-white py-2 collapse-inner rounded">
	                        <a class="collapse-item" href="../balju/baljuCheckList.do">발주등록</a>
	                        <a class="collapse-item" href="../balju/baljuConfirmList.do">발주내역조회</a>
	                    </div>
	                </div>
	            </li>
	            <hr class="sidebar-divider">
	
	            <!-- Nav Item - Dashboard -->
	            <li class="nav-item">
	                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseThree"
	                    aria-expanded="true" aria-controls="collapseThree">
	                    <i class="fas fa-fw fa-industry"></i>
	                    <span>입고관리</span></a>
	                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordionSidebar">
	                    <div class="bg-white py-2 collapse-inner rounded">
	                        <a class="collapse-item" href="../storing/storing_insert.do">입고등록</a>
	                        <a class="collapse-item" href="../storing/storing_list.do">입고내역조회</a>
	                    </div>
	                </div>
	            </li>
	            <hr class="sidebar-divider">
			</c:if>

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fas fa-fw fa-truck"></i>
                    <span>출고관리</span>
                </a>
                <div id="collapseUtilities" class="collapse" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                    	<c:if test="${managerUser != null && managerUser != ''}">
                        <a class="collapse-item" href="../unstoring/unstoringInsert.do">주문건등록</a>
                        </c:if>
                        <a class="collapse-item" href="../unstoring/unstoringList.do">주문건조회</a>
                    </div>
                </div>
            </li>
            <hr class="sidebar-divider">

             <!-- Nav Item - Dashboard -->
             <li class="nav-item">
                <a class="nav-link" href="../warehousing/warehousingList.do">
                    <i class="fas fa-fw fa-table"></i>
                    <span>입출고 내역 조회</span></a>
            </li>
             <hr class="sidebar-divider">

             <!-- Nav Item - Dashboard -->
             <li class="nav-item">
                <a class="nav-link" href="/statistics/staticsHome.do">
                    <i class="fas fa-fw fa-chart-pie"></i>
                    <span>마케팅 리포트</span></a>
            </li>
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->
	</div>
	<script>
	/* 
	은빈: 주소창에서 얻은 경로에서 폴더만 받아와(myFolder) 
	nav와 연결된 링크(path1, path2)에 포함여부에 따라 클래스 추가 
	path2인 경우 dropdown이 유지되도록 클래스 추가
	*/
	var myFolder = "/" + $(location).attr("pathname").split("/")[1];
	$(".nav-item").each(function (idx, item) {
		var path1 = $(this).find("a").attr("href");
		var path2 = $(this).find("div:last").find("a").attr("href");

		if(myFolder == "/") {
			$(this).removeClass("active");
		}
		else if(path1.includes(myFolder)) {
			$(this).addClass("active");
		}
		else if(path2 != undefined && path2.includes(myFolder)) {
			$(this).addClass("active");
			$(this).find("a").removeClass("collapsed");
			$(this).find("a").attr("aria-expanded", true);
			$(this).find("div").addClass("show");
		}
		else{
			$(this).removeClass("active");
		}
	});
	</script>
</body>
</html>