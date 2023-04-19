<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body id="page-top">
<c:set value="${pageContext.request.requestURI}" var="path"/>
<c:set value="${fn:split(path, '/')[0]}" var="folder"/>
	<div id="wrapper">
	<!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="../">
                <div class="sidebar-brand-icon">
                    <i class="fas fa-warehouse"></i>
                </div>
                <div class="sidebar-brand-text mx-3">ITEM FARM</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item ">
                <a class="nav-link" href="../product/new.do">
                    <i class="fas fa-fw fa-briefcase"></i>
                    <span>상품관리</span></a>
            </li>
            
            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="../company/new.do">
                    <i class="fas fa-fw fa-city"></i>
                    <span>기업관리</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-barcode"></i>
                    <span>발주관리</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <a class="collapse-item" href="../balju/new.do">발주등록</a>
                        <a class="collapse-item" href="../balju/new.do">발주내역조회</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="../storing/new.do">
                    <i class="fas fa-fw fa-store"></i>
                    <span>입고관리</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

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
                        <a class="collapse-item" href="../unstoring/new.do">주문건등록</a>
                        <a class="collapse-item" href="../unstoring/new.do">주문건조회</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

             <!-- Nav Item - Dashboard -->
             <li class="nav-item">
                <a class="nav-link" href="../warehousing/new.do">
                    <i class="fas fa-fw fa-table"></i>
                    <span>입출고 내역 조회</span></a>
            </li>

             <!-- Divider -->
             <hr class="sidebar-divider">

             <!-- Nav Item - Dashboard -->
             <li class="nav-item">
                <a class="nav-link" href="../statistics/new.do">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>마케팅 리포트</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->
	</div>
	<script>
		var myFolder = "/" + $(location).attr("pathname").split("/")[1];
		$(".nav-item").each(function (idx, item) {
			var path1 = $(this).find("a").attr("href");
			var path2 = $(this).find("div:last").find("a").attr("href");
			console.log(myFolder == "");
			console.log(path1 + " " + path2);
			
			if(myFolder == "/") {
				$(this).removeClass("active");
			}
			else if(path1.includes(myFolder)) {
				$(this).addClass("active");
			}
			else if(path2 != undefined && path2.includes(myFolder)) {
				$(this).addClass("active");
			}
			else{
				$(this).removeClass("active");
			}
		});
	</script>
</body>
</html>