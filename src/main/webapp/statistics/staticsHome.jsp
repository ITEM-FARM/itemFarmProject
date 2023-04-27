<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    	
<!DOCTYPE html>
<html>
<head>
    <%@ include file="../common/commonCSS.jsp" %>
	<title>Insert title here</title>
</head>
<body>
	<div id="wrapper">
		<%@ include file="../common/nav.jsp" %>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<%@ include file="../common/header.jsp" %>
				
				<div class="container-fluid">
					<!-- Page Heading -->
                    <div class="align-items-center mb-4 ">
                        <h1 class="h3 mb-0 text-gray-800"><i class="fas fa-fw fa-chart-area"></i>마케팅 리포트 홈</h1>
                    </div>
                    
                    <div class="row justify-content-center align-items-center">
                    	<div class="col-xl-9 mb-4">
                    		<div class="row">
                    		
                    			<div class="col-lg-4 " >
		                    		<div id="daily" class="card mb-4">
		                                
		                                	<a href="#dailyreport" class="d-block card-header py-3" data-toggle="collapse"
		                                    role="button" style="background:#198754">
		                                    	<h6 class="m-0 font-weight-bold" style="color:white">DAILY REPORT</h6>
		                                    </a>
		                                
		                                <div class="collapse show" id="dailyreport">
		                                <div class="card-body">
		                                    <div class="text-center">
		                                        <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 270px; height: 150px;"
		                                            src="/img/undraw_schedule_re_2vro.svg" alt="...">
		                                    </div>
		                                </div>
		                                <div class="card-footer text-secondary" style="background:#A3CFBB; color:#051B11">
		                                	일별 매출현황 보러가기→
		                                </div>
		                                </div>
		                            </div>			
                    			</div>
                    			
                    			<div class="col-lg-4" >
		                    		<div id="category" class="card mb-4">
		                                
		                                	<a href="#categoryreport" class="d-block card-header py-3" data-toggle="collapse"
		                                    role="button" style="background:#ffc107">
		                                    	<h6 class="m-0 font-weight-bold text-dark" >CATEGORY REPORT</h6>
		                                    </a>
		                                
		                                <div class="collapse show" id="categoryreport">
		                                <div class="card-body">
		                                    <div class="text-center">
		                                        <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 270px; height: 150px;"
		                                            src="/img/undraw_web_shopping_re_owap.svg" alt="...">
		                                    </div>
		                                </div>
		                                <div class="card-footer text-secondary" style="background:#FFE69C;">
		                                	카테고리별 매출현황 보러가기→
		                                </div>
		                                </div>
		                            </div>			
                    			</div>
                    			
                    			<div class="col-lg-4" >
		                    		<div id="product" class="card mb-4" >
		                                
		                                	<a href="#productreport" class="d-block card-header py-3" data-toggle="collapse"
		                                    role="button" style="background:#d63384">
		                                    	<h6 class="m-0 font-weight-bold text-light">PRODUCT REPORT</h6>
		                                    </a>
		                                
		                                <div class="collapse show" id="productreport">
		                                <div class="card-body">
		                                    <div class="text-center">
		                                        <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 270px; height: 150px;"
		                                            src="/img/undraw_gift_re_qr17.svg" alt="...">
		                                    </div>
		                                </div>
		                                <div class="card-footer" style="background:#EFADCE">
		                                	상품별 매출현황 보러가기→
		                                </div>
		                                </div>
		                            </div>			
                    			</div>
                    			
                    		</div>
                    
                    </div>
                    
				</div>
				<div class="row justify-content-center">
                    	<div class="col-xl-9 mb-4">
                    		<div class="card mb-4">
		                    <a href="#introduce" class="d-block card-header py-3" data-toggle="collapse" role="button" style="background:#0D6EFD;">
		                       <h6 class="m-0 font-weight-bold" style="color:#FFFFFF">INTRODUCE</h6></a>
		                       <div class="collapse show" id="introduce">
		                       <div class="card-body">
		                       <div class="row">
		                       		<div class="col d-flex justify-content-center" >
		                       			<img width="70%" class="img-fluid px-3 px-sm-4 mt-3 mb-4" src="/img/undraw_predictive_analytics_re_wxt8 (1).svg" alt="...">
		                       		</div>
		                       		<div class="col d-flex flex-column justify-content-between">
		                       		<p style="font-size:18px;" >
		                       			<span class="text-primary" style="font-size:35px">ITEM FARM </span> &nbsp;은 고객사의 물류 관리에서 더 나아가
		                       			<span class="text-primary">일별, 카테고리별, 상품별</span>로 매입/매출/순수익 현황을 보여주어
		                       			마케팅에 활용할 수 있도록 서비스를 제공하고 있습니다.
		                       		</p>
		                       		<p class="text-primary">확인하고 싶은 카테고리를 선택하세요!</p>
		                       		</div>
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
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
	
	
	<script>
		$(function(){
			
			$("#daily").hover(function(){
				$(this).addClass("shadow");
			},function(){
				$(this).removeClass("shadow");
			});
			
			$("#product").hover(function(){
				$(this).addClass("shadow");
			},function(){
				$(this).removeClass("shadow");
			});
			
			$("#category").hover(function(){
				$(this).addClass("shadow");
			},function(){
				$(this).removeClass("shadow");
			});
		});
	</script>
</body>
</html>