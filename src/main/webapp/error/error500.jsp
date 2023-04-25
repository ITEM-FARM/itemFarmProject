<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>    	
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
	<title>500error</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
					<!-- 500 Error Text -->
                    <div class="text-center">
                        <div class="error mx-auto" data-text="500">500</div>
                        <p class="lead text-gray-800 mb-5"><%=exception.getMessage()%></p>
                        <p class="text-gray-500 mb-0">죄송합니다. 페이지를 처리하는 동안 오류가 발생했습니다.</p>
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