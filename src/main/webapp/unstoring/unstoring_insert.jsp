<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/commonCSS.jsp"%>
<title>Insert title here</title>
<style>
#unstoring_memo {
	width: 100%;
	resize: none; /* 크기고정 */
	/*   resize: horizontal; // 가로크기만 조절가능 
	resize: vertical;  세로크기만 조절가능  */
}
</style> 

<%-- 엑셀 파일 업로드를 위한 JS 코드 --%>
<script type="text/javascript">
 function goUploadExcel(){
     var uploadForm = document.uploadForm;

     if( uploadForm.file1.value == "" ) {
         alert( "파일을 업로드해주세요." );
         return false;
     } else if( !checkFileType(uploadForm.file1.value) ) {
         alert( "엑셀파일만 업로드 해주세요." );
         return false;
     }

     if( confirm("업로드 하시겠습니까?") ) {
         uploadForm.action = "/unstoring/upload.do"; // upload.do => Front => Controller(오더업로드) => 로직 처리 후 => insert.jsp로 dispatch
         uploadForm.submit();
     }
 }

 function checkFileType( filePath ) {
     var fileFormat = filePath.toLowerCase();

     if( fileFormat.indexOf(".xls") > -1 ) return true;
     else return false;
 }
</script>
 
 <script>
 
 $(function(){
	/* var chk_insert = "${chk_insert}";
	if(chk_insert > 0){
		alert(chk_insert+'엑셀 파일 등록에 성공하였습니다.');
	}else{
		alert(chk_insert+'엑셀 파일 등록에 실패하였습니다.');
	} */
 });
 </script>
</head>
<body>
	<!-- 3. 그리고 그 msg 변수에 빈값을 넣어버려(빈값이면 출력 안하게 해놨으니까). scope는 session으로 해서 -->
	<div id="wrapper">
		<%@ include file="../common/nav.jsp"%>
		<c:set var="msg" value="" scope="session"></c:set>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp"%>

				<div class="container-fluid">
					<!-- empInsert.jsp 보고 따라함 -->
					<!-- 여기 안에 내용을 다 써야 한다는 소리구나 -->
					<form method="post" action="/unstoring/unstoringInsert.do">
						<!-- 
							★ 우선 방법1, 방법2 확정된게 아니라 입력 패턴은 넣지 않았음.
							★ 주문번호 : 자동생성 될 거라서 나중에 뺄 수도
							★ 주문일자, 출고일자 : 클릭하면 달력이 나오게 해서 직접 날짜 정할 수 있게 해주고 싶은데
							★ 관리자id : 로그인한 관리자 id 그대로 입력되게 할 거라서 나중엔 빼야할 듯 -->



						<!-- grid 시작 -->
						<div class="row">
							<div class="col-lg-2"></div>


							<div class="col-lg-8">
								<h1 class="h3 mb-2 text-gray-800">주문건 등록</h1>
								<p class="mb-4">
								<p>
									<i class="fas fa-exclamation-triangle"></i> 모든
									정보(성함/주소/주문일자/출고일자)를 입력해주세요.
								</p>
								</p>


								<!-- 1. 주문건 등록 양식 A -->
								<!-- DataTales Example -->
								<div class="card shadow mb-4">
									<div class="card-header py-3">
										<h6 class="m-0 font-weight-bold text-primary">주문건 등록 양식 A</h6>
									</div>
									<div class="card-body">
										<div class="table-responsive">
											<table class="table table-bordered" id="dataTable"
												width="100%" cellspacing="0">
												<thead>
													<tr>
														<th>Title</th>
														<th>Value</th>
														<th>Memo - 비고 입력란</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td><label for="customer_name">주문자 성함</label></td>
														<td><input name="customer_name" id="customer_name"
															type="text" required placeholder="주문자 성함 입력" autofocus></td>
														<td rowspan="7" style="text-align: center;"><textarea
																class="form-control" aria-label="With textarea"
																placeholder="내용을 입력해주세요" id="unstoring_memo" rows="13"></textarea>
														</td>
													</tr>
													<tr>
														<td><label for="customer_address">주문자 주소</label></td>
														<td><input name="customer_address"
															id="customer_address" type="text" required
															placeholder="주문자 주소 입력"></td>
													</tr>
													<tr>
														<td><label for="product_code">상품코드</label></td>
														<td><select name="product_code">
																<!-- List니까 forEach를 돌려서 VO 하나 하나 얻는 형태로 -->
																<c:forEach var="product" items="${productList}">
																	<option value="${product.product_code}">${product.product_code}
																		- ${product.product_name}</option>
																</c:forEach>
														</select></td>
													</tr>
													<tr>
														<td><label for="unstoring_quantity">주문수량</label></td>
														<td><input name="unstoring_quantity"
															id="unstoring_quantity" type="number" min="0" required
															placeholder="주문수량 입력"></td>
													</tr>
													<tr>
														<td><label for="order_register">주문일자</label></td>
														<td><input name="order_register" id="order_register"
															type="date" required placeholder="주문일자"></td>
													</tr>
													<!-- <tr>
														<td><label for="unstoring_date">출고일자</label></td>
														<td><input name="unstoring_date" id="unstoring_date"
															type="date" required placeholder="출고일자"></td>
													</tr> -->
													<tr>
														<td><label for="manager_id">담당자 ID</label></td>
														<td><input name="manager_id" id="manager_id"
															type="text" required readonly
															value="${managerUser.manager_id }"></td>
													</tr>

												</tbody>
											</table>
					</form>
												<div class="card-body">
													<div class="d-grid gap-2 d-md-flex justify-content-md-end">
														<button class="btn btn-primary me-md-2" type="submit"
															id="btnInsert">등록</button>
													</div>
												</div>
												</div>
												</div>
											<div class="col-lg-2">
											</div>
											</div>
								
								
											<hr>
								
								
											
											<p>
													<i class="fas fa-exclamation-triangle"></i> 주문건(Excel파일)을 업로드 하시고 등록 버튼을 눌러주십시오
												</p>
											<!-- 2. 엑셀파일 업로드 -->
											<div class="card shadow mb-4">
												<div class="card-header py-3" style="display:block-inline;">
													<h6 class="m-0 font-weight-bold text-primary">주문건 등록 양식 B</h6>
												</div>
			
												<div class="card-body">
															<form name="uploadForm" action="" method="post"
																onSubmit="return false;" encType="multipart/form-data">
															<input type="file" name="file1" />
															</form>
														    <!-- <button type="button" onclick="goUploadExcel();"
																	onkeypress="this.onclick();">등록</button> -->
															<div class="d-grid gap-2 d-md-flex justify-content-md-end">
																<button class="btn btn-primary me-md-2" type="button"
																		onclick="goUploadExcel()"
																		onkeypress="this.onclick();"
																		id="btnInsert">등록</button>
															</div>
			
												</div>
												<div class="col-lg-2">
												</div>
											</div>
											
											
										</div>
										<!-- 가운데 grid 끝 -->
									</div>
									<!-- grid 끝 -->
								
							</div>
						</div>
			<%@ include file="../common/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../common/commonETC.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
	
<script>
	// 용희 : '주문건 등록' 성공하면 알림창 표시
	$(document).ready(function(){
		// 2. 용희 : 등록 버튼 누르면 => 확인창 & 등록결과 유무 보여주기 
		$("#btnInsert").on("click", function(){
			var result = confirm('등록하시겠습니까?');
			
			if(result){
				var resultInsert = "${resultInsert}";
				if(resultInsert != 0){ // executeUpdate한 SQL문이 2개라서 1+1=2가 돼야 완전히 성공한 것
					                   // 하나라도 안되면 1-1=0이 됨.
					alert(' 주문 등록에 성공하였습니다.');
				}else{
					alert(' 주문 등록에 실패하였습니다.');
				}
			}else{
				
			}
		});
	});
</script>
</body>
</html>