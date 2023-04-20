
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
						<form class="form-inline justify-content-center my-5" method="post" action="../storing/storing_insert.do">
						
							<span class="mx-2">상품코드/명 검색: </span><input class="form-control mx-sm-2 " type="search"
								placeholder="Search" aria-label="Search" name="valueSelect">
							<button class="btn btn-outline-success my-2 my-sm-0 mx-2 bg-primary text-white"
								type="submit">Search</button>
							<button class="btn btn-outline-success my-2 my-sm-0 mx-2 bg-success text-white"
								type="submit">발주서 불러오기</button>
					
						</form>
						
						<!-- <form method="post" action="../storing/storing_insert.do" class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search ">
                        <div class="input-group ">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form> -->
				
				</div>
			</div>
			<%@ include file="../common/footer.jsp"%>
		</div>
	</div>
	<%@ include file="../common/commonETC.jsp"%>
	<%@ include file="../common/commonJS.jsp"%>
</body>
</html>