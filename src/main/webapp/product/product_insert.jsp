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
	<!-- 은빈: post: 상품 등록 modal -->
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
                	<form action="/product/productInsert.do" method="post" id="productInsertForm">
	                	<table>
	                		<tr>
	                			<th>상품명</th>
	                			<td><input type="text" id="product_name" name="product_name" required
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>카테고리</th>
	                			<td><input type="text" id="subcategory_name" name="subcategory_name" required
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>원가 (원)</th>
	                			<td><input type="number" id="product_cost" name="product_cost" required
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>판매가 (원)</th>
	                			<td><input type="number" id="product_price" name="product_price" required
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>재고</th>
	                			<td><input type="number" id="product_stock" name="product_stock" required
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>안전재고</th>
	                			<td><input type="number" id="product_safety" name="product_safety" required
	                			class="form-control bg-light border-0 small" aria-describedby="basic-addon2" data-siid="si_input_0"></td>
	                		</tr>
	                		<tr>
	                			<th>상태</th>
	                			<td>
	                				<label><input type="radio" id="product_statusY" name="product_status" value="Y" checked>활성</label>
	                				<label><input type="radio" id="product_statusN" name="product_status" value="N">비활성</label>
	                			</td>
	                		</tr>
	                	</table>
	                </form>
				</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">닫기</button>
                    <button id="productInsertBtn" class="btn btn-primary" type="submit" form="productInsertForm">등록</button>
                </div>
            </div>
        </div>
    </div>
    <script>
    $("#productInsertBtn").on("click", function() {
    	if(confirm("정말 등록하시겠습니까?") === true) {
    		return true;
    	} else {
    		return false;
    	}
    });
    </script>
</body>
</html>