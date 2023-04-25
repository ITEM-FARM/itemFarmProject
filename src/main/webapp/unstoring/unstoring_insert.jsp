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


						<!-- Page Heading -->
						<h1 class="h3 mb-2 text-gray-800">주문건 등록</h1>
						<p class="mb-4">
							# 페이지 설명 <br>
							(1) 주문건을 등록하는 페이지입니다. 일단 방법 1로 구현, 방법 2(엑셀파일 업로드 기능 + 데이터 DB insert)는 미루겠음 <br> 
							(2) 통계 페이지 다 구축되고 여유가 있으면 하는 걸로?? <br>
							<a target="_blank" href="https://chobopark.tistory.com/246">방법 2 관련 구글링 링크</a>.
							<p><i class="fas fa-exclamation-triangle"></i> 모든 정보(성함/주소/주문일자/출고일자)를 입력해주세요.</p>
						</p>
						
						<!-- DataTales Example -->
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">주문건 등록 양식</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered" id="dataTable" width="100%"
										cellspacing="0">
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
												<td rowspan="7" style="text-align: center;">
													<textarea class="form-control" aria-label="With textarea"
														placeholder="내용을 입력해주세요" id="unstoring_memo" rows="15" ></textarea>
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
														<c:forEach var="detail" items="${detailList}">
															<option value="${detail.product_code}">${detail.product_code} - ${detail.product_name}</option>
														</c:forEach>
													</select>
												</td>
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
											<tr>
												<td><label for="unstoring_date">출고일자</label></td>
												<td><input name="unstoring_date" id="unstoring_date"
													type="date" required placeholder="출고일자"></td>
											</tr>
											<tr>
												<td><label for="manager_id">담당자 ID</label></td>
												<td><input name="manager_id" id="manager_id"
													type="text" required readonly value="${magID }"></td>
											</tr>

										</tbody>
									</table>
									<div class="card-body">
										<div class="d-grid gap-2 d-md-flex justify-content-md-end">
											<button class="btn btn-primary me-md-2" type="button"
												id="ConfirmBT">확정</button>
										</div>
										<div>
											<input id="btnInsert" type="submit" value="등록">
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<%@ include file="../common/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../common/commonETC.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
<script>
	// 용희 : '주문건 등록' 성공하면 알림창 표시

	/* //1. EmpInsert컨트롤러에서 set한 msg(입력성공/입력실패)를 여기서 받아서  
	var msg = "${result}";
	if (msg == 1) {
		alert(msg); // 2. 화면에 출력
		msg = null;
	} */
	
	
	$(document).ready(function(){
		// 1. EmpInsert컨트롤러에서 set한 msg(입력성공/입력실패)를 여기서 받아서  
		var msg = "${result}";
		if (msg == 2) {
			alert(msg); // 2. 화면에 출력
			msg = null;
		}else{
			alert(msg);
		}
		
		
		// 2. 등록 버튼 누르면 => 확인창 뜨게끔 
		$("#btnInsert").on("click", function(){
			var result = confirm('등록하시겠습니까?');
			
			if(result){
				// form 양식 action 주기 (예전에 했던 예제들 찾아보면 이거 있을 듯)
			}else{
				
			}
		});
		
		
		// 용희 : 확정 버튼을 누르면 => form 양식 입력되게끔 (ref. 태영's balju.jsp) 
		$('#ConfirmBT').on("click", ()=>{
			var obj = {};
			obj["balju_memo"] = $('#balju_memo').val()
			arr.push(obj);
			console.log(arr);
			$.ajax({
				url:"baljuConfirmList.do",
				headers: {'Content-Type': 'application/json'},
				data:{ baljuCheckList: arr},
				method:"post",
				success:(result,status,xhr)=>{
					console.log("textStatus", status);
				},
				error:(jqXHR, textStatus, errorThrown)=>{
					console.log("textStatus", textStatus);
				}
			});
		});
		
	});
</script>
</body>
</html>