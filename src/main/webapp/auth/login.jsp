<%@page import="util.MysqlUtil"%>

<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>

    <title>로그인</title>

    <style>
    	.login-type-grid > span {
    		margin-right: 20px;
    	}
    	
    	.bg-login-image {
    		background-image: url("/img/login.png") !important;
    		background-size: 
    	}
    	
    	.login-box{
    		padding-left: 3rem !important;
    		padding-right: 3rem !important;
    		padding-top: 7rem !important;
    		padding-bottom: 7rem !important;
    	}
    </style>
    
   

</head>

 



<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="login-box">
                                    <div class="text-center">
                                        <h1 class="h2 text-gray-900 mb-4">LOGIN</h1>
                                    </div>
                                    <form class="user" method="post" action="<%=request.getContextPath() %>/auth/loginCheck.do">
                                    	<div class="form-group">
                                    		<div class="login-type-grid">
	                                    		<span class="text-primary">로그인 유형</span>
	                                    		<div class="form-check form-check-inline">
												  <input class="form-check-input" type="radio" name="logintype" id="manager" value="manager" checked="checked">
												  <label class="form-check-label" for="manager">3PL</label>
												</div>
												<div class="form-check form-check-inline">
												  <input class="form-check-input" type="radio" name="logintype" id="company" value="company">
												  <label class="form-check-label" for="company">기업</label>
												</div>
											</div>
                                    	</div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                id="inputID" name="inputID"
                                                placeholder="아이디를 입력해주세요.">
                                        </div>
                                        <p id="here" class="text-warning text-xs form-group"></p>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                id="inputPW" name="inputPW" placeholder="비밀번호를 입력해주세요.">
                                        </div>

                                        <button type="submit" class="btn btn-primary btn-user btn-block">
                                            Login
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
	 <script>
    $(function(){
    	var companyUser = "${companyUser}";
    	var managerUser = "${managerUser}";
		
    	if(managerUser=="FAIL"){
    		alert("매니저 로그인에 실패하였습니다. 다시 시도해주세요.");
    		<c:set var="managerUser" value="${null}" scope="session"/>
    	}
    	
    	if(companyUser == "N"){
    		//alert("비활성화된 기업입니다. 관리자에게 문의하세요.")
    		$("#here").html("<i class='fas fa-exclamation-triangle'></i> 비활성화된 기업입니다. 관리자에게 문의하세요.");
    		<c:set var="companyUser" value="${null}" scope="session"/>
    	}else if(companyUser=="FAIL" ){
    		alert("기업 로그인에 실패하였습니다. 다시 시도해주세요.");
    		<c:set var="companyUser" value="${null}" scope="session"/> 
    	}
    });
    </script>
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
</body>
</html>