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
                    
                    <div class="row justify-content-center">
                    	<div class="col-xl-9 mb-4">
                    		<div class="row">
                    		
                    			<div class="col-lg-4 align-self-center">
		                    		<div class="card shadow mb-4">
		                                
		                                	<a href="#CategoryCard" class="d-block card-header py-3" data-toggle="collapse"
		                                    role="button">
		                                    	<h6 class="m-0 font-weight-bold text-primary">DAILY REPORT</h6>
		                                    </a>
		                                
		                                <div class="collapse show" id="CategoryCard">
		                                <div class="card-body">
		                                    <div class="text-center">
		                                        <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;"
		                                            src="/img/undraw_growth_analytics_re_pyxf.svg" alt="...">
		                                    </div>
		                                </div>
		                                <div class="card-footer">
		                                	바로가기
		                                </div>
		                                </div>
		                            </div>			
                    			</div>
                    			
                    			<div class="col-lg-4">
		                    		<div class="card shadow mb-4">
		                                
		                                	<a href="#CategoryCard" class="d-block card-header py-3" data-toggle="collapse"
		                                    role="button">
		                                    	<h6 class="m-0 font-weight-bold text-primary">CATEGORY REPORT</h6>
		                                    </a>
		                                
		                                <div class="collapse show" id="CategoryCard">
		                                <div class="card-body">
		                                    <div class="text-center">
		                                        <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;"
		                                            src="/img/undraw_growth_analytics_re_pyxf.svg" alt="...">
		                                    </div>
		                                </div>
		                                <div class="card-footer">
		                                	바로가기
		                                </div>
		                                </div>
		                            </div>			
                    			</div>
                    			
                    			<div class="col-lg-4">
		                    		<div class="card shadow mb-4">
		                                
		                                	<a href="#CategoryCard" class="d-block card-header py-3" data-toggle="collapse"
		                                    role="button">
		                                    	<h6 class="m-0 font-weight-bold text-primary">PRODUCT REPORT</h6>
		                                    </a>
		                                
		                                <div class="collapse show" id="CategoryCard">
		                                <div class="card-body">
		                                    <div class="text-center">
		                                        <img class="img-fluid px-3 px-sm-4 mt-3 mb-4" style="width: 25rem;"
		                                            src="/img/undraw_growth_analytics_re_pyxf.svg" alt="...">
		                                    </div>
		                                </div>
		                                <div class="card-footer">
		                                	바로가기
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
	
	</script>
</body>
</html>