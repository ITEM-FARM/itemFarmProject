
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>ITEM FARM</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <%@ include file="../common/commonCSS.jsp" %>
	<style>
	#carouselExampleAutoplaying {
		margin: auto;
		width: 100%;
		height: 450px;
	}
	.carousel-item {
		width: 100%;
		height: 450px;
	}
	.d-block {
		width: 100%;
		height: 100%;
		/* object-fit: cover; */
	}
	
	#index-content {
		padding: 0px 24px;
		text-align: center
	}
	h1 {
		margin: 50px 0px 30px 0px;
		color: rgb(66,104,214);
	}
	.circle-container {
		margin: 20px auto;
	}
	.circle {
		width: 150px;
		height: 150px;
		border: 1px solid;
		border-color: rgb(133,135,150);
		border-radius: 100px;
		margin: 5px auto;
		background: no-repeat center;
		background-size: 70%;
	}
	#product-service {
		background-image: url("/img/product.png"); 
	}
	#balju-service {
		background-image: url("/img/balju.png");
	}
	#storing-service {
		background-image: url("/img/storing.png");
	}
	#unstoring-service {
		background-image: url("/img/unstoring.png");
	}
	
	#ty-img {
		background-image: url("/img/ty.jpg");
		background-size: 100%
	}
	#yh-img {
		background-image: url("/img/yh.jpg");
		background-size: 100%
	}
	#eb-img {
		background-image: url("/img/eb.jpg");
		background-size: 100%
	}
	#ls-img {
		background-image: url("/img/ls.jpg");
		background-size: 100%
	}
	</style>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid" style="padding: 0px;">
					<!-- image slide -->
					<div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-inner">
					    	<div class="carousel-item active">
					      		<img src="/img/1.jpg" class="d-block w-100" alt="farm1">
					    	</div>
						    <div class="carousel-item">
						      	<img src="/img/2.jpg" class="d-block w-100" alt="farm2">
						    </div>
						    <div class="carousel-item">
						      	<img src="/img/3.png" class="d-block w-100" alt="farm3">
						    </div>
						    <div class="carousel-item">
						      	<img src="/img/4.png" class="d-block w-100" alt="item1">
						    </div>
						    <div class="carousel-item">
						      	<img src="/img/5.png" class="d-block w-100" alt="item2">
						    </div>
					 	</div>
					  	<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
					   		<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    	<span class="visually-hidden">Previous</span>
					  	</button>
					  	<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
					    	<span class="carousel-control-next-icon" aria-hidden="true"></span>
					    	<span class="visually-hidden">Next</span>
					  	</button>
					</div>
					
					<div id="index-content">
						<!-- service contents -->
						<div class="circle-container">
							<h1>ITEM FARM's Service</h1>
							<div class="container text-center">
								<div class="row align-items-center">
							    	<div class="col service-list">
							      		<div class="circle" id="product-service"></div>
							      		<span>상품</span>
							    	</div>
							    	<div class="col service-list">
							      		<div class="circle" id="balju-service"></div>
							      		<span>발주</span>
							    	</div>
							    	<div class="col service-list">
							      		<div class="circle" id="storing-service"></div>
							      		<span>입고</span>
							    	</div>
							    	<div class="col service-list">
							      		<div class="circle" id="unstoring-service"></div>
							      		<span>출고</span>
							    	</div>
							  	</div>
							</div>
						</div>
						
						<!-- special service -->
						<h1>ITEM FARM's Special</h1>
						<div class="d-flex">
							<div class="p-2 w-50 text-center"><img src="/img/statistic.png" width="300"></div>
						  	<div class="p-2 w-50 text-left align-self-center">
						  		<p>일별 매출 통계</p>
						  		<p>카테고리별 매출 통계</p>
						  		<p>상품별 매출 통계</p>
						  	</div>
						</div>
						
						<hr>
						
						
						<div class="circle-container">
							<h1>Contributors</h1>
							<div class="container text-center">
								<p><i class="fas fa-exclamation-triangle"></i> 이름을 누르면 github 페이지로 이동합니다.</p>
								<div class="row align-items-center">
							    	<div class="col service-list">
							      		<div class="circle" id="ty-img"></div>
							      		<div>
							      			<a class="mr-2 d-none d-lg-inline text-gray-600" href="https://github.com/teon98" target="_blank">
							      				<img src="/img/github.png" width="20"> <span>강태영</span></a>
							      		</div>
							    	</div>
							    	<div class="col service-list">
							      		<div class="circle" id="yh-img"></div>
							      		<div>
							      			<a class="mr-2 d-none d-lg-inline text-gray-600" href="https://github.com/djdjdddd" target="_blank">
							      				<img src="/img/github.png" width="20"> <span>김용희</span></a>
							      		</div>
							    	</div>
							    	<div class="col service-list">
							      		<div class="circle" id="eb-img"></div>
							      		<div>
							      			<a class="mr-2 d-none d-lg-inline text-gray-600" href="https://github.com/svbean77" target="_blank">
							      				<img src="/img/github.png" width="20"> <span>오은빈</span></a>
							      		</div>
							    	</div>
							    	<div class="col service-list">
							      		<div class="circle" id="ls-img"></div>
							      		<div>
							      			<a class="mr-2 d-none d-lg-inline text-gray-600" href="https://github.com/leessol" target="_blank">
							      				<img src="/img/github.png" width="20"> <span>이솔</span></a>
							      		</div>
							    	</div>
							  	</div>
							</div>
						</div>
												
					</div>
				</div>
			</div>
			<%@ include file="../common/footer.jsp" %>
		</div> 
	</div>
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
</body>
</html>