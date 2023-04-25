<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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

	<!-- id와 modalPage.jsp의 data-target이 같아야 함 (현재 이름: connectModalName) -->

	<div class="modal fade" id="connectModalName" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">제목</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                	내용
				</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
                    <button class="btn btn-primary" type="submit">등록</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>