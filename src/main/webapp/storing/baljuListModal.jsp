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
					  		<th scope="col">
								<div class="form-check px-0 mx-0 text-center">
  									<input class="form-check-input allChecking" type="checkbox" id="modalAllChecking">
  									<label class="form-check-label" for="flexCheckDefault">
    									전체
  									</label>
								</div>
							</th>
					  		<th>#</th>
		                    <th>발주서번호</th>
		                    <th>발주날짜</th>
		                    <th>발주담당자</th>
		                    <th>비고</th>
					  	</tr>
					  </thead>
					  <tbody id="here">
					  	<tr>
					  		<td>test</td>
					  		<td>test</td>
					  		<td>test</td>
					  		<td>test</td>
					  		<td>test</td>
					  	</tr>
					  </tbody>
					</table>
					<div id="showBaljuProducts"></div>
                </div>
                <div class="modal-footer">
                	<button id="" class="btn btn-success" type="button" 
                	onclick="$('input[name=checkBaljuOne]:checked').length==0?alert('발주서를 한 개 이상 체크해주세요. '):storeQuantity()" data-dismiss="modal">등록</button>
                    <button class="btn btn-primary" type="button" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>