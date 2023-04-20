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
    <!-- Custom styles for this page -->
    <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
	<title>Insert title here</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
				<!-- [태영] Start : Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">신한 DS 발주 등록</h1>
          		<!-- [태영] End : Page Heading  -->
          		
          		<!-- [태영] Table영역 -->
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                        	<th></th>
                                            <th>상품코드</th>
                                            <th>상품명</th>
                                            <th>현재재고</th>
                                            <th>안전재고</th>
                                            <th>발주수량</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${baljuchecklist}" var="bal">
                                        	<tr>
                                        		<td><input type="checkbox"/></td>
                                        		<td>${bal.product_code}</td>
                                        		<td>${bal.product_name}</td>
                                        		<td>${bal.product_stock}</td>
                                        		<td>${bal.product_safety}</td>
                                        		<td>${bal.order_quantity}</td>
                                        	</tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
				</div>
			</div>
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>
	<%@ include file="../common/commonBtn.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
	
	<!-- Page level plugins -->
    <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
	
</body>
</html>