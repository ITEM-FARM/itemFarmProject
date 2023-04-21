
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
								id="productSearch" class="btn btn-outline-success my-2 my-sm-0 mx-2 bg-primary text-white"
								type="button" id="form_submit" value="Search" /> 
							<input
								class="btn btn-outline-success my-2 my-sm-0 mx-2 bg-success text-white"
								value="발주서 불러오기" >
								
						</div>

						
						
					</form>
					<div id="productShow" class=""></div>

					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">#</th>
								<th scope="col">상품번호</th>
								<th scope="col">상품명</th>
								<th scope="col">입고건수</th>
								<th scope="col">발주서연동여부</th>
								<th scope="col">발주서번호</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">1</th>
								<td>Mark</td>
								<td>Otto</td>
								<td>@mdo</td>
								<td>Otto</td>
								<td>@mdo</td>
							</tr>	
						</tbody>
					</table>

				</div>
			</div>
			<%@ include file="../common/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../common/commonETC.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
<script>
$(function(){
	$('#numberForm').hide();
	var valueType = "searchTotal";
	$('#inputType').attr('value',valueType);
	var outputBody = '';
	
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
	
	$('#productSearch').on("click", function(e){
		$.ajax({
			url: "../storing/storing_insert.do",
			method: "POST",
			data: {"valueType":$('#inputType').val(),"selectValue1":$('#textForm').val(),"selectValue2":$('#numberForm').val()},
			success: function(r){
				//var datas = JSON.parse(r);
				//var productList = datas.productList;
				
				$('#productShow').html(r);
				var ss="${productList[0].product_name}";
				console.log("ddd"+ss);
				
			},
			error: function(message){
				alert(message);
			}
		});	
	});
	
	$("#textForm, #numberForm").on("keyup", function(key){
		if(key.keyCode==13) {
			$('#productSearch').trigger("click");
		}
	});
	
	//$('#storingCount').on("click",function(){
	/*
		alert("aaa");
		var tabletag='<table class="table table-hover">';
		var outputHead = '<thead><tr><th scope="col">#</th><th scope="col">상품번호</th><th scope="col">상품명</th><th scope="col">입고건수</th><th scope="col">발주서연동여부</th><th scope="col">발주서번호</th></tr></thead>';
		outputBody += '<tbody><th>1</th><td>' + '</td></tbody>';
		$('#searchDrop').val($(this).attr("value"));*/
		/* 
		<tbody>
		<tr>
			<th>1</th>
			<td>Mark</td>
			<td>Otto</td>
			<td>@mdo</td>
			<td>Otto</td>
			<td>@mdo</td>
		</tr>	</tbody> */

		//productShow storingCount
		//tabletag += '</table>';
	//});
 	
	
})
function f_storingCount(code, name, obj, count){  
	var quantity =  $("#quantity" + count).val();
	console.log(code, name, obj, quantity);
}
</script>
</body>
</html>

