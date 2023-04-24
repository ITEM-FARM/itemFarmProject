<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table {
	margin: 0px auto;
}
td {
	padding: 10px 10px;
}
label {
	padding: 0px 10px;
}
</style>
</head>
<body>

	<div class="modal fade" id="unstoringDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">주문번호 상세 조회</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                	                	
                	<!-- Page Heading -->
                    <!-- <h1 class="h3 mb-2 text-gray-800">Tables</h1> -->
                    <p class="mb-4"> 
                    	<!-- <a target="_blank" href="https://datatables.net">official DataTables documentation</a> -->
                    </p>

                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">주문번호: ${modalTest }</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                    <thead>
                                        <tr>
                                            <th>상품코드</th>
                                            <th>상품명</th>
                                            <th>주문수량</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                     	<!-- core 태그를 써야 할까 / 아니면 그냥 json 파싱해서 가져오면 될까 -->
                                        <tr>
                                            <td>Tiger Nixon</td>
                                            <td>System Architect</td>
                                            <td>Edinburgh</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
				</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
                    <!-- <button class="btn btn-primary" type="submit">등록</button> -->
                </div>
            </div>
        </div>
    </div>
</body>
</html>