
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
					<form class="form-inline justify-content-center my-5" method="post"
						action="../storing/storing_insert.do" >

						<div class="input-group mb-3">
							<div class="input-group-prepend">
								<button class="btn btn-outline-secondary dropdown-toggle"
									type="button" data-toggle="dropdown" aria-haspopup="true"
									aria-expanded="false" id="searchDrop">통합검색</button>
								<div id="mytype" class="dropdown-menu">
									<a class="dropdown-item" href="#" data-value="searchTotal">통합검색</a> 
									<a class="dropdown-item" href="#" data-value="searchCode">상품코드</a> 
									<a class="dropdown-item" href="#" data-value="searchName">상품명</a>
									<!-- <div role="separator" class="dropdown-divider"></div>
									<a class="dropdown-item" href="#"></a> -->
									
								</div>
							</div>
							<input id="inputType" type="hidden" name="valueType">
							<input id="textForm" type="text" class="form-control"
								aria-label="Search input with dropdown button" name="selectValue1" placeholder="Search" />
							
							<input id="numberForm" type="number" class="form-control"
								aria-label="Search input with dropdown button" name="selectValue2" placeholder="Search" />	
							
							<button
								class="btn btn-outline-success my-2 my-sm-0 mx-2 bg-primary text-white"
								type="submit" id="form_submit">Search</button>
							<button
								class="btn btn-outline-success my-2 my-sm-0 mx-2 bg-success text-white"
								type="submit">발주서 불러오기</button>
						</div>

					</form>
					
					<c:forEach items="${productList}" var ="product">
						<ul>
						<li>${product.product_code}</li>
						<li>${product.product_name}</li>
						<li>${product.product_stock}</li>
						<li>${product.product_safety}</li>
						</ul>
					</c:forEach>
				</div>
			</div>
			<%@ include file="../common/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../common/commonETC.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
<script>
$(document).ready(function(){
	$('#numberForm').hide();
	var valueType = "";
	$('#mytype a').on('click', function(){
		$('#searchDrop').text($(this).text());
		
		valueType = $(this).attr('data-value');
		console.log(valueType);
		$('#inputType').attr('value',valueType);
		console.log($('#inputType').attr('value'));
		
		if(valueType=="searchCode"){
			$('#numberForm').show();
			$('#textForm').hide();
		} else {
			$('#numberForm').hide();
			$('#textForm').show();
		} 
 
	});

	
})

</script>
</body>
</html>