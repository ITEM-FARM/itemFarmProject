
<%@page import="util.MysqlUtil"%>

<%@page import="java.sql.Connection"%>
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
					<h1>hihi</h1>
          
          	<a href="${pageContext.request.contextPath}/">홈</a>
	
            <%
              Connection conn = MysqlUtil.getConnection();
              out.println(conn);


            %>
				</div>
			</div>
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
	<%@ include file="../common/commonBtn.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
</body>
</html>