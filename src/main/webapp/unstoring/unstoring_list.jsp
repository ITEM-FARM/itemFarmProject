<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/commonCSS.jsp"%>
<link href="/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
	<style>
		/* [태영] 테이블 마우스 hover시 background 색 변경 */
		#dataTable #datarow:hover{
			background-color: #dddfeb;
		}
		
		.selected{
			background-color: #dddfeb;
		}
		b{
			display: table-cell;
			padding-right: 1em;
		}
		strong{
			padding-right: 1em;
		}
		
	</style>
	
	<script>
		$(function(){
			$("#headrow > th").hover(function(){
				var index = $(this).index();
				$(this).addClass('selected');
				$("table tr>td:nth-child("+(index+1)+")").addClass('selected');
			},function(){
				var index = $(this).index();
				$(this).removeClass('selected');
				$("table tr>td:nth-child("+(index+1)+")").removeClass('selected');
			});
		});
		
	</script>	
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

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">주문건 조회</h1>
					<p class="mb-4">
						<c:if test="${managerUser != null && managerUser != ''}">
						# 페이지 설명 <br>
						(1) 송장입력 or 주문취소 버튼(radio)을 누르면 해당하는 값만 체크박스가 enabled 됩니다. <br>
						(2) 체크 후 저장버튼을 누르면 해당 로직이 실행됩니다. <br>
						(3) 주문번호를 누르면 '주문건 상세 페이지'로 이동합니다. <br>
						<a target="_blank" href="https://datatables.net">official DataTables documentation</a>.
						 </c:if>
						<p><i class="fas fa-exclamation-triangle"></i> 주문번호를 누르면 상세 조회가 가능합니다.</p> 
					</p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3" id="plz">
							<h6 class="m-0 font-weight-bold text-primary">주문건 조회 결과 - 총 ${totalCount }건</h6>
							
							<c:if test="${managerUser != null && managerUser != ''}">
							<hr>		
										
							<!-- 송장입력 / 송장저장 -->
							<span id="leftSpan" style="display:inline-block;">
							<a type="radio"
								id="btnInput"
								href="#"
								class="btn btn-success btn-icon-split"> <span
								class="icon text-white-50"> <i class="fas fa-check"></i></span>
								<span class="text">송장입력</span>
							</a> 
							<a type="button"
							   id="btnTrackingNumber" 
							   class="btn btn-secondary btn-icon-split"> 
							   <span class="icon text-white-50"> <i class="fas fa-arrow-right"></i>
							</span> <span class="text">입력저장</span>
							</a>
							</span>
							
							


							<!-- 주문취소 / 취소저장 -->
							<span id="rightSpan" style="display:inline-block; margin:0 5px;	float: right;">
							<a type="radio" id="btnCancel" href="#"
								class="btn btn-danger btn-icon-split"> <span
								class="icon text-white-50"> <i class="fas fa-trash"></i></span>
								<span class="text">주문취소</span>
							</a>
							<!-- href="javascript:cancel_order()"는 없어도 될 듯?? form submit으로 대체  -->
							<a type="button" id="btnCancelOrder"
								class="btn btn-secondary btn-icon-split"> <span
								class="icon text-white-50"> <i class="fas fa-arrow-right"></i>
							</span> <span class="text">취소저장</span>
							</a>
							</span>
							</c:if>

						</div>


						<div class="card-body">
							<div class="table-responsive">
							
								<!-- <label for="test">전체선택</label>
								<input type="checkbox" name="test" id="checkAll"> -->
								<!-- <input type="radio" name="testRadio" id="unCheckAll" value="전체해제"> -->

								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr id="headrow">
											<th>Index</th>
											<th>주문번호</th>
											<th>주문자 성함</th>
											<th>주문자 주소</th>
											<th>주문일자</th>
											<th>출고일자</th>
											<th>송장번호</th>
											<th>주문상태</th>
											<th>출고담당자</th>
											<th>비고</th>
										</tr>
									</thead> 
									<tbody>
										<%-- 용희: UnstoringListController에서 set한 걸 get한 데이터 --%>
										<c:forEach var="list" items="${unstoringList }" varStatus="status">
											<tr id="datarow">
												<td>
													<div class="form-check">
														<input class="form-check-input-${status.index }"
															type="checkbox" name="unstoringCheckBT"
															data-code="${list.unstoring_code }"
															data-cancel="${list.unstoring_code }" disabled>
														<!-- 송장입력 / 주문취소 checked 요소들을 구분해주기 위해 data 속성이름을 2개 줌 -->
														<label class="form-check-label text-secondary"
															for="flexCheckDefault"><h6>${status.count }</h6></label>
													</div>
                                        		</td>
												<!-- 은빈 -->
												<!-- 데이터 전송의 경우 VO의 toString을 data-tmp의 형태처럼 나오도록 수정해야 함 (companyVO 참고) -->
												<!-- data-tmp로 임시로 적었는데 여기의 data-@@와 jQuery의 data(@@)의 이름이 같아야 함 -->
												<%-- 
												용희 : 모달은.. 잠시 포기, 일단 redirect로 구현하겠음
												<td><a class="modal-link btn btn-icon-split" 
												       role="button" 
												       aria-haspopup="true" 
												       aria-expanded="false" 
												       data-toggle="modal" 
												       href="#" 
												       data-target="#unstoringDetailModal">${list.unstoring_code }
												</a>
												</td> --%>
												<td><a href="javascript:sendDataByRedirect('${list.unstoring_code }')">${list.unstoring_code }</a></td>
												<!-- data-target의 이름과 modal.jsp의 id가 같아야 함(현재 이름: connectModalName) -->
												<td>${list.customer_name }</td>
												<td>${list.customer_address }</td>
												<td>${list.order_register }</td>
												<td>${list.unstoring_date }</td>
												<td class="track">${list.tracking_number }</td>
												<%-- <td class="state" style="color:#0d6efdDD;">${list.unstoring_state}</td> --%>
												<c:choose>
													<c:when test="${list.unstoring_state == '출고완료' }">
														<td class="state" style="color: #0d6efdDD;">${list.unstoring_state}</td>
													</c:when>
													<c:when test="${list.unstoring_state == '주문취소' }">
														<td class="state" style="color: #dc3545DD;">${list.unstoring_state}</td>
													</c:when>
													<c:otherwise>
														<td class="state" style="color: #333333DD;">${list.unstoring_state}</td>
													</c:otherwise>
												</c:choose>
												<td>${list.manager_id }</td>
												<td>${list.unstoring_memo }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>


								<!-- JSON 데이터 보내기 위한 form -->
								<!-- 2-1. 송장번호 -->
								<form id="frm1" action="/unstoring/trackingNumberInput.do">
									<input type="hidden" id="jsonTrkNum" name="jsonTrkNum"> <!-- 정해준 name으로 자바에서 getParameter 하면 넘어감 -->
								</form>
								
								<!-- 2-2. 주문취소 -->
								<form id="frm2" action="/unstoring/cancelOrder.do">
									<input type="hidden" id="jsonCancel" name="jsonCancel">
								</form>
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


	<script>
		$(function() {
			var m = "${managerUser == '' || managerUser == null ? 0 : managerUser.manager_pw}";
			if(m == 0)
				return;
			
			var chkList = $("input[name=unstoringCheckBT]");	
			console.log(chkList, typeof(chkList));
			
			
			
			/* // 5. 전체선택 체크박스 (급히 추가)
			// (1) #checkAll 클릭
			$("#checkAll").click(function() {
				if ($(this).is(":checked:not(:disabled)")) {
					chkList.prop("checked", "true");
				} else{
					chkList.prop("checked", "false");
				} 
			}); */
			
			
			
			
			// 0. 용희 : 아무것도 체크 안하고 '저장버튼' 눌렀을 시 => alert 창 뜨는 기능.
			// 0-1. 송장저장
			$("#btnTrackingNumber").on("click", function() {
				//체크된 행이 없을 경우.
				if ($('table input:checkbox:checked').length == 0) {
					alert("송장번호를 입력할 행을 먼저 선택하여 주십시오.");
				}
			});

			// 0-2. 취소저장
			$("#btnCancelOrder").on("click", function() {
				//체크된 행이 없을 경우.
				if ($('table input:checkbox:checked').length == 0) {
					alert("주문취소할 행을 먼저 선택하여 주십시오.");
				}
			});

			// 1. 용희 : 송장번호, 주문취소 라디오 버튼 클릭시 => 조건에 충족되는 놈들만 enabled 되게끔 하는 기능
			// 1-1. 송장번호 라디오 버튼
			$("#btnInput")
					.on(
							"click",
							function() {
								$(".track").each(
										function(index, element) {

											var track = $(element).text();
											console.log(track);
											console.log(typeof (track));

											var selector = ".form-check-input-"
													+ index;
											console.log(selector);

											if (track == "") {
												$(selector).prop("disabled",
														false);
												console.log('if');
											} else {
												$(selector).prop("disabled",
														true);
												console.log('else');
											}
										});

								// 2. 용희 : 송장입력 및 주문취소 체크박스로 체크한 놈들 DB에 저장하기
								// 2-1. 송장번호 저장
								$("#btnTrackingNumber")
										.on(
												"click",
												function() {

													// 체크된 게 있을 때만 실행하게끔
													if ($('table input:checkbox:checked').length != 0) {
														// 관리자 비밀번호 체크 (by 은빈)
														var password = prompt(
																"관리자 확인",
																"비밀번호를 입력하세요");

														if (m != password
																|| password == null) {
															alert("비밀번호가 올바르지 않습니다.");
															return;
														} else { 
															// 자바쪽으로 json 형태로 보내야 할 듯.
															// 리스트 생성
															var testList = new Array();

															// 체크박스 중 checked된 것들에 한해서만 loop
															$(
																	'table input:checkbox:checked')
																	.each(
																			function(
																					index,
																					element) {

																				// checked의 code값 얻기
																				var code = $(
																						element)
																						.data(
																								"code");
																				console
																						.log('송장입력 checked된 체크박스 각각의 코드 값 : '
																								+ code);

																				var selector = ".form-check-input-"
																						+ index;
																				console
																						.log('셀렉터 '
																								+ selector);

																				// (1) 키:값 형태로 객체 만들기
																				var data = new Object(); // 객체 생성
																				data.number = code;

																				// (2) 리스트에 생성된 객체 삽입
																				testList
																						.push(data);
																			});

															// (3) 배열을 다시 한번 { }로 감싸주기
															var json = new Object();
															json.key = testList;

															// (4) 자바에서 getParameter 하기 위해 String 형태로 변환
															var jsonData = JSON
																	.stringify(json);
															console
																	.log(
																			jsonData,
																			typeof (jsonData));

															// Json타입의 데이터를 JSON.stringify() 를 이용해 문자열로 변환 후 폼의 요소에 저장
															$("#jsonTrkNum")
																	.val(
																			jsonData);

															var frm = $("#frm1");
															frm.submit();

															var resultTrkNum = "${resultTrkNum}";
															if (resultTrkNum > 0) { // update된 row의 수가 
																alert(resultTrkNum
																		+ '송장입력이 되었습니다.');
															} else {
																alert(resultTrkNum
																		+ '송장입력에 실패하였습니다.');
															}

														} // if else 끝
													} // if 끝
												});

							});

			// 1-2. 주문취소 라디오 버튼
			$("#btnCancel")
					.on(
							"click",
							function() {
								$(".state").each(
										function(index, element) {
											var state = $(element).text();
											console.log(state);

											var selector = ".form-check-input-"
													+ index;
											console.log(selector);

											if (state == "출고대기") {
												$(selector).prop("disabled",
														false);
												console.log('if');
											} else {
												$(selector).prop("disabled",
														true);
												console.log('else');
											}
										});

								// 2-2. 주문취소 저장
								$("#btnCancelOrder")
										.on(
												"click",
												function() {
													/* 이 자리에 alert를 두니까 => 주문취소 버튼 누르는 횟수만큼 alert 창이 뜨네... (지금 머리가 안 돌아가서 왜 그런질 모르겠네 ㅋㅋ)
													//체크된 행이 없을 경우.
													if ($('table input:checkbox:checked').length == 0) {
														alert("주문취소할 행을 먼저 선택하여 주십시오.");
													}
													 */

													// 체크된 게 있을 때만 실행하게끔
													if ($('table input:checkbox:checked').length != 0) {
														var password = prompt(
																"관리자 확인",
																"비밀번호를 입력하세요");

														if (m != password
																|| password == null) {
															alert("비밀번호가 올바르지 않습니다.");
															return;
														} else {
															// 자바쪽으로 json 형태로 보내야 할 듯.
															// 리스트 생성
															var testList = new Array();

															// 체크박스 중 checked된 것들에 한해서만 loop
															$(
																	'table input:checkbox:checked')
																	.each(
																			function(
																					index,
																					element) {

																				// checked의 code값 얻기
																				var cancel = $(
																						element)
																						.data(
																								"cancel");
																				console
																						.log('주문취소 checked된 체크박스 각각의 코드 값 : '
																								+ cancel);

																				var selector = ".form-check-input-"
																						+ index;
																				console
																						.log('셀렉터 '
																								+ selector);

																				// (1) 키:값 형태로 객체 만들기
																				var data = new Object(); // 객체 생성
																				data.number = cancel;

																				// (2) 리스트에 생성된 객체 삽입
																				testList
																						.push(data);
																			});

															// (3) 배열을 다시 한번 { }로 감싸주기
															var json = new Object();
															json.key = testList;

															// (4) 자바에서 getParameter 하기 위해 String 형태로 변환
															var jsonData = JSON
																	.stringify(json);
															console
																	.log(
																			jsonData,
																			typeof (jsonData));

															// Json타입의 데이터를 JSON.stringify() 를 이용해 문자열로 변환 후 폼의 요소에 저장
															$("#jsonCancel")
																	.val(
																			jsonData);

															var frm = $("#frm2");
															frm.submit();

															var resultCancel = "${resultCancel}";

															if (resultCancel > 0) {
																alert(resultCancel
																		+ '주문취소에 성공하였습니다.');
															} else {
																alert(resultCancel
																		+ '주문취소에 실패하였습니다.');
															}

														} // if, else 끝
													} // if 끝

												});
							});

		});

		// 3. 용희 : 주문건 상세조회 - 일단 redirect로 구현 (Modal 포기 ㅋㅋ)
		function sendDataByRedirect(number) {
			console.log('aa' + number);
			location.href = "/unstoring/unstoringTest.do?unstoring_code="
					+ number;
		}

		// 4. 용희 : 송장입력/주문취소의 결과 유무 보여주기
	</script>

</body>
</html>