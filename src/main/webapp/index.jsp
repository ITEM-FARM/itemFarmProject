
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
					<h1>첫 화면</h1>
						<hr>
						<p><a href="${pageContext.request.contextPath}/auth/login.jsp">로그인/로그아웃</a></p>
						<p><a href="${pageContext.request.contextPath}/balju/new.do">발주</a></p>
						<p><a href="${pageContext.request.contextPath}/company/new.do">기업</a></p>
						<p><a href="${pageContext.request.contextPath}/product/new.do">상품</a></p>
						<p><a href="${pageContext.request.contextPath}/statistics/new.do">통계</a></p>
						<p><a href="${pageContext.request.contextPath}/storing/new.do">입고</a></p>
						<p><a href="${pageContext.request.contextPath}/unstoring/new.do">출고</a></p>
						<p><a href="${pageContext.request.contextPath}/warehousing/new.do">입출고</a></p>
				</div>
			</div>
			<%@ include file="../common/footer.jsp" %>
		</div> 
	</div>
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
</body>
</html>