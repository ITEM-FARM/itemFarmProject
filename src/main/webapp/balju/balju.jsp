<%@page import="util.MysqlUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>����</h1>
	<hr>
	<a href="${pageContext.request.contextPath}/">Ȩ</a>
	
	<%
		Connection conn = MysqlUtil.getConnection();
		out.println(conn);
		
		
	%>
</body>
</html>