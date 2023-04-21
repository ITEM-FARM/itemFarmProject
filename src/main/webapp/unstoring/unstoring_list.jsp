<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/commonCSS.jsp"%>
<link href="/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<title>Insert title here</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp"%>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp"%>

				<div class="container-fluid">
					<!-- empSelect.jsp 보고 따라함 -->
					<!-- 여기 안에 내용을 다 써야 한다는 소리구나 -->
					<h1>주문건 조회 페이지</h1>
					<%-- <form method="get" action="">
						<table class="table table-hover">
							<thead>
								<tr>
									<!-- 순서 칼럼 1개 + VO 칼럼 9개 -->
									<th>순서</th>
									<th>주문번호</th>
									<th>주문자 성함</th>
									<th>주문자 주소</th>
									<th>주문일자</th>
									<th>출고일자</th>
									<th>송장번호</th>
									<th>주문상태</th>
									<th>출고담당자</th>
									<th>주문메모(비고)</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="list" items="${unstoreList }" varStatus="status">
								<tr>
									<td>${status.count }</td>
									<td>${list.unstore_code }</td>
									<td>${list.customer_name }</td>
									<td>${list.customer_address }</td>
									<td>${list.order_register }</td>
									<td>${list.unstore_date }</td>
									<td>${list.tracking_number }</td>
									<td>${list.unstore_status }</td>
									<td>${list.manager_id }</td>
									<td>${list.unstore_memo }</td>
								</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<tr>
									<td>tfoot 테스트</td>
								</tr>
							</tfoot>
						</table>

					</form> --%>
					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">Tables</h1>
					<p class="mb-4">
						DataTables is a third party plugin that is used to generate the
						demo table below. For more information about DataTables, please
						visit the <a target="_blank" href="https://datatables.net">official
							DataTables documentation</a>.
					</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">DataTables
								Example</h6>
						</div>


						<div class="card-body">
							<div class="table-responsive">

								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>순서</th>
											<th>주문번호</th>
											<th>주문자 성함</th>
											<th>주문자 주소</th>
											<th>주문일자</th>
											<th>출고일자</th>
											<th>송장번호</th>
											<th>주문상태</th>
											<th>출고담당자</th>
											<th>주문메모(비고)</th>
											<th>송장버튼</th>
											<th>취소버튼</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="list" items="${unstoringList }"
											varStatus="status">
											<tr>
												<td>${status.count }</td>
												<!-- 은빈 -->
												<!-- 데이터 전송의 경우 VO의 toString을 data-tmp의 형태처럼 나오도록 수정해야 함 (companyVO 참고) -->
												<!-- data-tmp로 임시로 적었는데 여기의 data-@@와 jQuery의 data(@@)의 이름이 같아야 함 -->
												<td><a data-tmp="'key':'데이터1','key2':'데이터2'"
													class="modal-link btn btn-icon-split" href="#"
													role="button" aria-haspopup="true" aria-expanded="false"
													data-toggle="modal" data-target="#unstoringModal">${list.unstoring_code }
												</a>
												</td>
												<!-- data-target의 이름과 modal.jsp의 id가 같아야 함(현재 이름: connectModalName) -->
												<td>${list.customer_name }</td>
												<td>${list.customer_address }</td>
												<td>${list.order_register }</td>
												<td>${list.unstoring_date }</td>
												<td>${list.tracking_number }</td>
												<td>${list.unstoring_state }</td>
												<td>${list.manager_id }</td>
												<td>${list.unstoring_memo }</td>

												<!-- 송장입력 버튼을 누르면 => 비어있던 송장번호(tracking_number)를 요놈으로 update -->
												<td><c:if test="${list.unstoring_state == '출고대기' }">
														<a type="button"
															href="javascript:tracking_number_input(${list.unstoring_code })"
															class="btn btn-success btn-icon-split"
															data-input="${list.unstoring_code }"> <span
															class="icon text-white-50"> <i
																class="fas fa-check"></i></span> <span class="text">송장입력</span>
														</a>
													</c:if></td>

												<!-- 주문취소 버튼을 누르면 => 주문번호(unstoring_code)를 가져가서 그 놈의 주문상태(unstoring_state)를 바꿔줘야 하니까 -->
												<td><c:if test="${list.unstoring_state == '출고대기' }">
														<a type="button"
															href="javascript:cancel_order(${list.unstoring_code })"
															class="btn btn-danger btn-icon-split"
															data-del="${list.unstoring_code }"> <span
															class="icon text-white-50"> <i
																class="fas fa-trash"></i></span> <span class="text">주문취소</span>
														</a>
													</c:if></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%@ include file="../common/footer.jsp"%>
		</div>
	</div>
  
	<%@ include file="/unstoring/unstoring_modal.jsp"%>
	<%@ include file="../common/commonETC.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
	<!-- Page level plugins -->
	<script
		src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<!-- Page level custom scripts -->
	<script
		src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>


	<!-- 송장입력 및 주문취소 버튼 누르면 => ajax로 해당 로직 처리하게끔 하는 JS 코드 -->
	<script>
		// 1. 송장입력 => ★고민: 이것도 포맷이 있는데... 이걸 어떻게 적용하지??
		function tracking_number_input(unstoring_code) {
			// ★★★ 송장번호 입력도 모달창으로 구현할까??
			alert("tracking_number_input 함수가 실행됨");
			var tracking_number = prompt('송장번호 입력');
			location.href = "/unstoring/trackingNumberInput.do?unstoring_code="
					+ unstoring_code + "&tracking_number=" + tracking_number; // get 요청이니까
		}

		// 2. 주문취소
		function cancel_order(unstoring_code) {
			alert("tracking_number_input 함수가 실행됨");
			var result = "${result}";
			location.href = "/unstoring/cancelOrder.do?unstoring_code="
					+ unstoring_code;

			if (result == 1) {
				alert('주문취소에 성공하였습니다');
			} else {
				alert('주문취소에 실패하였습니다');
			}
		}

		// 3. 
		function unstoring_detail() {
			alert('테스트');
			$.ajax({
				url : "/unstoring/unstoringDetail.do",
				method : "GET",
				success : function() {

				},
				error : function() {

				}
			});
		}

		// 2. 주문취소 (ajax로 한 코드 => but, ajax는 새로고침이 안되서 일단 폐기)

		/* function cancel_order(unstoring_code) {
			var result = "${result}";
			$.ajax({
				url : "/unstoring/cancelOrder.do",
				type : "get", // 일단 GET
				data : {"unstoring_code" : unstoring_code}, // 데이터로 넘겨줄 name과 value를 정해준 거구나 {"name" : value}
										                    // $(this).attr("data-del") 이건 왜 안되지??
				success : function() {
					if (result == 1) {
						alert('주문취소에 성공하였습니다');
					}
				},
				error : function() {
					alert('주문취소에 실패하였습니다');
				}
			});
			console.log($(".btn.btn-danger.btn-icon-split").attr("data-del"));
			alert($(".btn.btn-danger.btn-icon-split").attr("data-del"));
		} */
	</script>
	<script>
		// 은빈 : json 객체 모달로 전송
		$("##unstoringModal").on("show.bs.modal", function(event) {
			var str = $(event.relatedTarget).data('tmp').split(",");

			var json = {};
			$.each(str, function(idx, item) {
				var value = item.split(":");
				json[value[0]] = value[1];
				// id를 value[0], value를 value[1]
				// ex) <input id=value[0] value=value[1]>
				$("#exampleModalLabel").html(value[1]);
			});

			/* 
			// json의 key는 'key'로 따옴표 존재, 따라서 #key로 써서 jQuery 쓰기 위해 변수 id 생성		
			for(let key in json) {
				var id = "#"+key.replaceAll("'", "");
				$(id).attr("value", json[key]);
			}
			 */
		});
	</script>
</body>
</html>