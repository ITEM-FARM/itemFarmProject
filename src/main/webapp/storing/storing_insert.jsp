
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/commonCSS.jsp"%>
<title>Insert title here</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp"%>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp"%>
				
				<div class="container-fluid">
					
					<h2 class="text-center">입고등록</h2>
					<!-- 이솔: search form  -->
					<form class="form-inline justify-content-center my-5">

						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<input class="btn btn-outline-secondary dropdown-toggle"
									type="button" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false" id="searchDrop" value="통합검색"> 
								<div id="mytype" class="dropdown-menu">
									<a class="dropdown-item" href="#" data-value="searchTotal">통합검색</a> 
									<a class="dropdown-item" href="#" data-value="searchCode">상품코드</a> 
									<a class="dropdown-item" href="#" data-value="searchName">상품명</a>
								</div>
							</div>
							<input id="inputType" type="hidden" name="valueType"  >
							<input id="textForm" type="text" class="form-control"
								aria-label="Search input with dropdown button" name="selectValue1" placeholder="Search" />
							
							<input id="numberForm" type="number" class="form-control"
								aria-label="Search input with dropdown button" name="selectValue2" placeholder="Search" />	
							
							<input
								id="searchProduct" class="btn my-2 my-sm-0 mx-2 bg-primary text-white"
								type="button" id="form_submit" value="Search" /> 
							<input
								class="btn my-2 my-sm-0 mx-2 bg-success text-white text-center"
								value="발주서 불러오기"  data-toggle="modal" data-target="#detailModal" type="button">
								
						</div>

						
						
					</form>
					<div id="showProduct"></div>
					
					<div class="d-flex flex-row bd-highlight mb-3">
						<h4 class="mx-2">입고품목 리스트</h4>
						<input id="deleteProduct" class="btn  my-2 my-sm-0 mx-2 bg-danger text-white" type="button" value="삭제" />
						<input id="confirmProduct" class="btn my-2 my-sm-0 mx-2 bg-primary text-white" type="button" value="확정" />
					</div>
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">
									<div class="form-check px-0 mx-0 text-center">
  										<input class="form-check-input allChecking" type="checkbox" id="outAllChecking">
  										<label class="form-check-label" for="flexCheckDefault">
    										전체
  										</label>
									</div>
								</th>
								<th scope="col">#</th>
								<th scope="col">상품번호</th>
								<th scope="col">상품명</th>
								<th scope="col">입고건수</th>
								<th scope="col">발주서연동여부</th>
								<th scope="col">발주서번호</th>
							</tr>
						</thead>
						<tbody id="storingList"></tbody>
					</table>
					<p id="emptyProductList" class="text-center">입고할 품목을 추가해주세요. </p>
					<div class="mb-3">
  						<label for="storingMemo" class="form-label">입고 메모</label>
  						<textarea class="form-control" id="storingMemo" rows="3"></textarea>
					</div>

				</div>
			</div>
			<%@ include file="../common/footer.jsp"%>
		</div>
	</div>
	
	<%@ include file="baljuListModal.jsp" %>
	<%@ include file="../common/commonETC.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
	
<script>
var outputBody = ''; //outputBody(한 row)
var outputArr = []; //outputArr (현 시점 outputList)
var isSudongCode = []; //수동입고 시, 이미 상품 리스트에 상품 코드 있는지
var isBaljuCode = []; //발주서입고 시, 이미 상품 리스트에 발주서 번호 있는지


$(function(){
	$('#numberForm').hide();
	var valueType = "searchTotal";
	$('#inputType').attr('value',valueType);
	
	//var outputBody = '<tr class="text-center"><td colspan="6">입고할 품목을 추가해주세요. </td></tr>'
	//$('#storingList').html(outputBody);
	//console.log($('#storingList tr td').text());
	//$('#deleteProduct').hide();
	//if($('#storingList tr td').text()){
	//	$('#deleteProduct').show();
	//}
	
	//이솔: product 상품명, 상품코드 톻합검색
	$('#mytype a').on('click', function(){
		
		$('#searchDrop').val($(this).text());
		
		valueType = $(this).attr('data-value');
		$('#inputType').attr('value',valueType);
		
		if(valueType=="searchCode"){
			$('#numberForm').show(); 
			$('#textForm').hide();
		} else {
			$('#numberForm').hide();
			$('#textForm').show();
		} 
	
	});
	
	//상품 검색 AJAX
	$('#searchProduct').on("click", function(){
		$.ajax({
			url: "/storing/storing_insert.do",
			method: "POST",
			data: {"mode":"searchProduct","valueType":$('#inputType').val(),"selectValue1":$('#textForm').val(),"selectValue2":$('#numberForm').val()},
			success: function(r){
				$('#showProduct').html(r);
			},
			error: function(message){
				alert(message);
			}
		});	
	});
	
	//상품 검색 필터링 --> 엔터 시, 검색 트리거
	$("#textForm, #numberForm").on("keyup", function(key){
		if(key.keyCode==13) {
			$('#searchProduct').trigger("click");
		}
	});
	
	
	//체크박스 전체체크 --> 입고품목 리스트 + 발주서 불러오기 (전부 사용가능)
	$(".allChecking").on("click",function(){
		var checked ="";
		if($(this).attr('id')== 'modalAllChecking') {
			checked = $('#modalAllChecking').is(':checked');
			$("#here").find('input:checkbox').prop('checked',checked);
		} else {
			checked = $('#outAllChecking').is(':checked');
			$("#storingList").find('input:checkbox').prop('checked',checked);
		}
		
	
	});
	
	
	//입고 품목 리스트 확정 전, 리스트에서 삭제
	$('#deleteProduct').on("click",function(){
		$($('input[name=checkOne]:checked').get().reverse()).each(function(){
			var checkedTd = $(this).val();
			var deleteTr = $("tr[id='" + checkedTd +"']");
			var idx = $("#" + checkedTd).find(".listCount").text();
			outputArr.splice(idx-1,1);
			deleteTr.remove();
			showStoringList();
		});
	});
	
	
	//입고 품목 최종 확정 AJAX --> 상품 재고 증가
	$('#confirmProduct').on("click",function(){
		
		if(confirm("입고를 확정하시겠습니까? 확정된 입고 품목들은 수정할 수 없습니다. ")==false){
			return false;
		}
		
		var params = [];
		
		$('input[name=checkOne]:checked').each(function(){
			var checkedProduct = $(this).val();
			var productCode = $("#" + checkedProduct).find(".productCode").text();
			var quantity = $("#" + checkedProduct).find(".storingQuantity").val();
			var baljuCode = $("#" + checkedProduct).find(".baljuCode").text();
			var param = {};
			param.product_code = productCode;
			param.storing_quantity = quantity;
			param.balju_code = baljuCode;
	
			params.push(param);
		});
		
		console.log(params);
		if(params.length == 0){
			alert('입고 품목을 한 개 이상 체크해주세요. ');
			return false;
		}
		
		$.ajax({
			url:"/storing/storing_insert.do",
			data:{"mode":"storeProduct","storingList":JSON.stringify(params)},
			method:"post",
			success:(result,status,xhr)=>{
				
				//$("#here").html(result);
				//$("#exampleModalLabel").html("<span class='text-primary'>"+ $(this).text().trim() + "</span> 발주서 상세 조회");
			},
			error:(jqXHR, textStatus, errorThrown)=>{
				
			}
		});
		
		
	});
	
	//발주 리스트 AJAX
	$('input[data-target="#detailModal"]').click(function(){
		
		$('#modalAllChecking').prop('checked',false);
		$('#showBaljuProducts').empty();
		$.ajax({
			url:"/balju/baljuConfirmList.do",
			data:{"mode":"modalBaljuList"},
			method:"get",
			success:(result,status,xhr)=>{
				
				$("#here").html(result);
				$("#exampleModalLabel").html("<span class='text-primary'>"+ $(this).text().trim() + "</span> 발주서 상세 조회");
			},
			error:(jqXHR, textStatus, errorThrown)=>{
				
			}
		});
	});
	
	
	
	
})

//이솔: 발주서 연동입고 AJAX
function storeQuantity(){  
		 
	var params = [];
	 
	$('input[name=checkBaljuOne]:checked').each(function(){
		var checkedBalju = $(this).val();
		if(isBaljuCode.includes(checkedBalju)){
			alert('이미 발주서 번호가 리스트에 존재합니다. 다른 발주서를 선택해주세요.  ');
			return false;
		}
		params.push(checkedBalju);
	});

	
	
	$.ajax({
		url: "/balju/baljuDetailList.do",
		data: {"mode":"storeBaljuDetail","baljuCodeList": params.toString()},
		method: "post",
		success: function(result,status,xhr){

			var arr = JSON.parse(result).dataSet;
			
			$.each(arr,function(index,item){
				isBaljuCode.push(item["baljuCode"]);
				pushStoringList(item["productCode"],item["productName"], item["baljuQuantity"], item["baljuCode"]);
			});
			showStoringList();
		},
		error: function(message){
			alert(message);
		}
	});
	
};


//상품 입고하는 html 구문 만드는 작업 (수동입고 + 발주서입고)
function pushStoringList(productCode, productName, baljuAmount, baljuCode){	
	
	//수동입고 시, 이미 상품 리스트에 상품 코드 있는지
	if(isSudongCode.includes(productCode)){
		alert('이미 입고 품목이 리스트에 존재합니다. 수량을 수정해주세요. ');
		return false;
	}
	
	
	var sudongAmount =  $("#quantity" + baljuAmount).val();
	var quantity=``;
	var isForm = ``;
	
	
	if(baljuCode==null){
		quantity = `<input type="number" class="storingQuantity" class="form-control-sm border-secondary" value="${'${sudongAmount}'}">`;
		isForm = `수동입고`;
		baljuCode = "-";
		isSudongCode.push(productCode);
    }else{
    	quantity = `<input type="number" class="storingQuantity" class="form-control-sm border-secondary" value="${'${baljuAmount}'}">`;
    	isForm = `발주서입고`;
    }
	
	
	var temp = `
		<tr id="${'${productCode}'}">
		    <td>
			    <div class="form-check"><input class="form-check-input text-center mx-0 my-2"  name="checkOne" type="checkbox" value="${'${productCode}'}" >
			    </div>
		    </td>
		    <td class="listCount"></td>
		    <td class="productCode">${'${productCode}'}</td>
		    <td>${'${productName}'}</td>
		    <td>` 
		    + quantity +
		   `</td>
		    <td>`
		    + isForm +
		    `</td>
		    <td class="baljuCode">${'${baljuCode}'}</td>
	    </tr>
	
	`;
	
	outputArr.push(temp);
}


//이솔: 입고 품목 리스트(확정 전) 그리기->수동입고 + 발주서연동 입고
function showStoringList(){

	outputBody = "";
	$.each(outputArr, function(index, value){
		var idx = value.indexOf('listCount');
		value = value.substring(0,idx+11)+ (index+1) + value.substring(idx+11);		 
		outputBody += value;
	});
	$('#storingList').html(outputBody);
	
}


//발주서 품목 상세 AJAX
function searchBaljuProducts(code){
	
	$.ajax({
		url: "/balju/baljuDetailList.do",
		data: {"mode":"modalBaljuDetail","baljuCode": code},
		method: "get",
		success: function(result,status,xhr){
			$('#showBaljuProducts').html(result);
		},
		error: function(message){
			alert(message);
		}
	});
	
}


</script>
 
</body>
</html>

