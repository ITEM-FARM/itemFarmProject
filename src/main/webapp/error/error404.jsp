<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    	
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
	<title>404error</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
					<!-- 404 Error Text -->
                    <div class="text-center">
                        <div class="error mx-auto" data-text="404">404</div>
                        <p class="lead text-gray-800 mb-5">Page Not Found</p>
                        <p class="text-gray-500 mb-0">죄송합니다. 요청하신 페이지는 찾을 수 없는 페이지입니다.</p>
                        <a href="/">&larr; Back to Dashboard</a>
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