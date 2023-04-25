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
	<!-- 은빈: 기업 정보 수정 modal -->
	<div class="modal fade" id="CompanyModifyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"></h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                	<form action="/company/companyModify.do" method="post" id="companyModifyForm">
	                	<table>
	                		<tr>
	                			<th>기업 코드</th>
	                			<td><input type="number" id="company_id" name="company_id" readonly
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>기업명</th>
	                			<td><input type="text" id="company_name" name="company_name" required
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>비밀번호</th>
	                			<td><input type="text" id="company_pw" name="company_pw" required
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>수수료 (%)</th>
	                			<td><input type="number" id="company_commission" name="company_commission" step="0.01" required
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>상태</th>
	                			<td>
	                				<label><input type="radio" id="company_statusY" name="company_status" value="Y">활성</label>
	                				<label><input type="radio" id="company_statusN" name="company_status" value="N">비활성</label>
	                			</td>
	                		</tr>
	                	</table>
	                </form>
				</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
                    <button id="companyModifyBtn" class="btn btn-primary" type="submit" form="companyModifyForm">수정</button>
                </div>
            </div>
        </div>
    </div>
    <script>
    $("#companyModifyBtn").on("click", function () {
    	var password = prompt("관리자 확인", "비밀번호를 입력하세요");
    	
    	if("${managerUser.manager_pw}" === password) {
    		return true;
    	} else if(password === null) {
    		
    	} else {
    		alert("비밀번호가 올바르지 않습니다.");
    	}

    	return false;
    });
    </script>
</body>
</html>