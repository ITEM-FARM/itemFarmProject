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
	<!-- 은빈: 상품 등록 modal -->
	<div class="modal fade" id="ProductInsertModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">'${comName}' 상품 등록</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                	<form action="/company/companyInsert.do" method="post" id="companyInsertForm">
	                	<table>
	                		<tr>
	                			<th>상품 코드</th>
	                			<td><input type="number" id="product_code" name="product_code" value="10000"
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>상품명</th>
	                			<td><input type="text" id="product_name" name="product_name" 
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>카테고리</th>
	                			<td><input type="text" id="subcategory_name" name="subcategory_name" value="select로"
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>원가</th>
	                			<td><input type="number" id="product_cost" name="product_cost"
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>판매가</th>
	                			<td><input type="number" id="product_price" name="product_price"
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>재고</th>
	                			<td><input type="number" id="product_stock" name="product_stock"
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>안전재고</th>
	                			<td><input type="number" id="product_safety" name="product_safety"
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>등록일</th>
	                			<td><input type="text" id="product_regdate" name="product_regdate" value="오늘 날짜 자동"
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>상태</th>
	                			<td>
	                				<label><input type="radio" id="product_statusY" name="product_status" value="Y">활성</label>
	                				<label><input type="radio" id="product_statusN" name="product_status" value="N">비활성</label>
	                			</td>
	                		</tr>
	                		<tr>
	                			<th>상품 담당자</th>
	                			<td><input type="text" id="manager_id" name="manager_id" value="로그인한 관리자 자동"
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
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