
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
	<title>ITEM FARM</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
					<h1>Welcome!</h1>
					<hr>
					<div>이미지 슬라이드</div>
					
					<div>
						<ul>
							<li>상품</li>
							<li>발주</li>
							<li>입고</li>
							<li>출고</li>
						</ul>
					</div>
					
					<div>
						<img src="img.png">
						<a href="#">마케팅 페이지로 이동</a>
					</div>
					
					<hr>
					
					<div>
						<ul>
							<li>강태영</li>
							<li>김용희</li>
							<li>오은빈</li>
							<li>이솔</li>
						</ul>
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