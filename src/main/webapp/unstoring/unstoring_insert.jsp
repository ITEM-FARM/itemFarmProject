<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/commonCSS.jsp"%>
<title>Insert title here</title>
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
		if (msg == 1) {
			alert(msg); // 2. 화면에 출력
			msg = null;
		}
		
		
		// 2. 등록 버튼 누르면 => 확인창 뜨게끔 
		$("#btnInsert").on("click", function(){
			var result = confirm('등록하시겠습니까?');
			
			if(result){
				// form 양식 action 주기 (예전에 했던 예제들 찾아보면 이거 있을 듯)
			}else{
				
			}
		});
		
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
						<!-- <table>
							★ 우선 방법1, 방법2 확정된게 아니라 입력 패턴은 넣지 않았음.
							★ 주문번호 : 자동생성 될 거라서 나중에 뺄 수도
							★ 주문일자, 출고일자 : 클릭하면 달력이 나오게 해서 직접 날짜 정할 수 있게 해주고 싶은데
							★ 관리자id : 로그인한 관리자 id 그대로 입력되게 할 거라서 나중엔 빼야할 듯
							<tr>
								<td><label for="unstoring_code">주문 번호</label></td>
								<td><input name="unstoring_code" id="unstoring_code"
									type="text" required placeholder="주문번호 입력" autofocus></td>
							</tr>
							<tr>
								<td><label for="customer_name">주문자 성함</label></td>
								<td><input name="customer_name" id="customer_name"
									type="text" required placeholder="주문자 성함 입력"></td>
							</tr>
							<tr>
								<td><label for="customer_address">주문자 주소</label></td>
								<td><input name="customer_address" id="customer_address"
									type="text" required placeholder="주문자 주소 입력"></td>
							</tr>
							<tr>
								<td><label for="order_register">주문 일자</label></td>
								<td><input name="order_register" id="order_register"
									type="date" required placeholder="주문일자"></td>
							</tr>
							<tr>
								<td><label for="unstoring_date">출고 일자</label></td>
								<td><input name="unstoring_date" id="unstoring_date"
									type="date" required placeholder="출고일자"></td>
							</tr>
							<tr>
								<td><label for="unstoring_memo">주문 메모</label></td>
								<td><input name="unstoring_memo" id="unstoring_memo"
									type="text" placeholder="주문메모 입력"></td>
							</tr>
							<tr>
								<td><label for="manager_id">출고 관리자 id</label></td>
								<td><input name="manager_id" id="manager_id" type="text"
									required placeholder="출고관리자id 입력"></td>
							</tr>
							<tr style="text-align: center;">
								<td colspan="2"><input type="submit" value="등록"></td>
							</tr>
						</table> -->
						<!-- Basic Card Example -->


						<!-- Page Heading -->
						<h1 class="h3 mb-2 text-gray-800">주문건 등록</h1>
						<p class="mb-4">
							주문건을 등록하는 페이지입니다. 일단 방법 1로 구현했구요. <br> 방법 2(엑셀파일 업로드 기능 +
							데이터 DB insert)는 나중에 할 예정 <br> <a target="_blank"
								href="https://chobopark.tistory.com/246">방법 2 관련 구글링 링크</a>.
						</p>

						<!-- DataTales Example -->
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">등록 양식</h6>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table table-bordered" id="dataTable" width="100%"
										cellspacing="0">
										<thead>
											<tr>
												<th>Name</th>
												<th>Position</th>
											</tr>
										</thead>
										<tfoot>
										</tfoot>
										<tbody>
											<tr>
												<th><label for="unstoring_code">주문 번호</label></th>
												<th><input name="unstoring_code" id="unstoring_code"
													type="text" required placeholder="주문번호 입력" autofocus></th>
											</tr>
											<tr>
												<td><label for="customer_name">주문자 성함</label></td>
												<td><input name="customer_name" id="customer_name"
													type="text" required placeholder="주문자 성함 입력"></td>
											</tr>
											<tr>
												<td><label for="customer_address">주문자 주소</label></td>
												<td><input name="customer_address"
													id="customer_address" type="text" required
													placeholder="주문자 주소 입력"></td>
											</tr>
											<tr>
												<td><label for="order_register">주문 일자</label></td>
												<td><input name="order_register" id="order_register"
													type="date" required placeholder="주문일자"></td>
											</tr>
											<tr>
												<td><label for="unstoring_date">출고 일자</label></td>
												<td><input name="unstoring_date" id="unstoring_date"
													type="date" required placeholder="출고일자"></td>
											</tr>
											<tr>
												<td><label for="unstoring_memo">주문 메모</label></td>
												<td><input name="unstoring_memo" id="unstoring_memo"
													type="text" placeholder="주문메모 입력"></td>
											</tr>
											<tr>
												<td><label for="manager_id">출고 관리자 id</label></td>
												<td><input name="manager_id" id="manager_id"
													type="text" required placeholder="출고관리자id 입력"></td>
											</tr>

										</tbody>
										<tr style="text-align: center;">
											<td colspan="2"><input id="btnInsert" type="submit" value="등록">
													        </td>
										</tr>
									</table>
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
</body>
</html>