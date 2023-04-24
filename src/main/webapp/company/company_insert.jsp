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
	<!-- 은빈: 기업 등록 modal -->
	<div class="modal fade" id="CompanyInsertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">기업 등록</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                	<form action="/company/companyInsert.do" method="post" id="companyInsertForm">
	                	<table>
	                		<tr>
	                			<th>기업명</th>
	                			<td><input type="text" id="company_name" name="company_name" 
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>비밀번호</th>
	                			<td><input type="text" id="company_pw" name="company_pw" 
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>수수료(%)</th>
	                			<td><input type="number" id="company_commission" name="company_commission" step="0.1"
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>상태</th>
	                			<td>
	                				<label><input type="radio" id="company_statusY" name="company_status" value="Y" checked>활성</label>
	                				<label><input type="radio" id="company_statusN" name="company_status" value="N">비활성</label>
	                			</td>
	                		</tr>
	                	</table>
	                </form>
				</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
                    <button class="btn btn-primary" type="submit" form="companyInsertForm">등록</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>