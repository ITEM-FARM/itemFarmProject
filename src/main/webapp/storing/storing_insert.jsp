
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../common/commonCSS.jsp"%>
<title>입고 등록</title>
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
								class="btn my-2 my-sm-0 mx-2 bg-success text-white"
								value="발주서 불러오기" >
								
						</div>

						
						
					</form>
					<div id="showProduct" class=""></div>
					
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
  										<input class="form-check-input" type="checkbox" id="allChecking">
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
	<%@ include file="../common/commonETC.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
	
<script>
var outputBody = ''; //outputBody(한 row)
var listCount = 0; //
var outputArr = []; //outputArr (현 시점 outputList)
var outputCode = []; //outputCode (현 시점 outputCodeList)

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
	
	$('#searchProduct').on("click", function(){
		$.ajax({
			url: "../storing/storing_insert.do",
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
	
	$("#textForm, #numberForm").on("keyup", function(key){
		if(key.keyCode==13) {
			$('#searchProduct').trigger("click");
		}
	});
	
	
	$("#allChecking").on("click",function(){
		var checked = $('#allChecking').is(':checked');
		$('input:checkbox').prop('checked',checked);
	});
	
	
	$('#deleteProduct').on("click",function(){
		$($('input[name=checkOne]:checked').get().reverse()).each(function(){
			var checkedTd = $(this).val();
			var deleteTr = $("tr[id='" + checkedTd +"']");
			var idx = $("#" + checkedTd).find(".listCount").text();
			console.log(idx);
			outputArr.splice(idx-1,1);
			deleteTr.remove();
			showStoringList();
		});
	});
	
	$('#confirmProduct').on("click",function(){
		
		var params = [];
		
		$('input[name=checkOne]:checked').each(function(){
			var checkedTd = $(this).val();
			var confirmTr = $("tr[id='" + checkedTd +"']");
			var code = $("#" + checkedTd).find(".productCode").text();
			var quantity = $("#" + checkedTd).find(".storingQuantity").val();
			var param = {};
			param.product_code = code;
			param.storing_quantity = quantity;
	
			params.push(param);
		});
		
		
		/* $('.productCode').each(function(index,item){
			$(this).text();
		})
		 */
		
		
		 
		/* $.ajax({
			url: "../storing/storing_insert.do",
			method: "POST",
			data: {"mode":"confirmProduct","valueType":$('#inputType').val(),"selectValue1":$('#textForm').val(),"selectValue2":$('#numberForm').val()},
			success: function(r){
				$('#showProduct').html(r);
			},
			error: function(message){
				alert(message);
			}
		});	 */
	});
	
})

function storingQuantity(code, name, obj, count){  
	
		//이솔: 이미 존재하는 품목 수량 수정
		if(outputCode.includes(code)){
			alert('이미 입고 품목이 리스트에 존재합니다. 수량을 수정해주세요. ');
			return false;
		}
		
		outputCode.push(code);
	
		var quantity =  $("#quantity" + count).val();
		listCount++;
		var col = "chk" + listCount;
		var temp = `
			<tr id="${'${code}'}">
			    <td>
				    <div class="form-check"><input class="form-check-input text-center mx-0 my-2"  name="checkOne" type="checkbox" value="${'${code}'}" >
				    </div>
			    </td>
			    <td class="listCount"></td>
			    <td class="productCode">${'${code}'}</td>
			    <td>${'${name}'}</td>
			    <td>
			    	<input type="number" class="storingQuantity" class="form-control-sm border-secondary" value="${'${quantity}'}">
			    </td>
			    <td>???</td>
			    <td>???</td>
		    </tr>
		
		`;
		
		outputArr.push(temp);
		showStoringList();
};

function showStoringList(){
	outputBody = "";
	$.each(outputArr, function(index, value){
		var idx = value.indexOf('listCount');
		value = value.substring(0,idx+11)+ (index+1) + value.substring(idx+11);		 
		outputBody += value;
	});
	$('#storingList').html(outputBody);
	
}



</script>
 
</body>
</html>

