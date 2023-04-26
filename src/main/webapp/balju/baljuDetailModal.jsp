<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>발주 아이템 상세 보기</title>

</head>
<body>
	<!-- 태영 : 발주 상세 모달창-->
	 <div class="modal fade" id="detailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">발주서 상세 조회</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                	<table class="table table-bordered table-sm table-hover" id="dataTable" width="100%" cellspacing="0">
					  <thead>
					  	<tr>
					  		<th>Index</th>
					  		<th>상품코드</th>
					  		<th>상품명</th>
					  		<th>발주수량</th>
					  	</tr>
					  </thead>
					  <tbody id="here">
					  	<tr>
					  		<td>test</td>
					  		<td>test</td>
					  		<td>test</td>
					  		<td>test</td>
					  	</tr>
					  </tbody>
					</table>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" type="button" data-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>