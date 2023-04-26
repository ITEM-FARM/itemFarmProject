<%@page import="vo.CompanyVO"%>

<%@page import="java.util.List"%>
<%@page import="model.CompanyService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>      
<%
CompanyService service = new CompanyService();
pageContext.setAttribute("lookUpList", service.companyList("all"));
%>
<!DOCTYPE html>
<html>
<head>
<style>
#select-box {
	height: 150px;
	overflow-y: scroll;
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

			<!-- Nav Item - User Information -->
			<div class="topbar-divider d-none d-sm-block"></div>
			<li class="nav-item no-arrow"><a class="nav-link" href="#"
				role="button" aria-haspopup="true" aria-expanded="false"
				data-toggle="modal" data-target="#logoutModal"> <i
					class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i> <span
					class="mr-2 d-none d-lg-inline text-gray-600 small">Logout</span>
			</a>
		</ul>
	</nav>
	<script>
		$(".dropdown-item").on("click", function() {
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
