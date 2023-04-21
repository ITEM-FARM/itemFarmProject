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

					<!-- 데이터 전송의 경우 VO의 toString을 data-tmp의 형태처럼 나오도록 수정해야 함 (companyVO 참고) -->
					<!-- data-tmp로 임시로 적었는데 여기의 data-@@와 jQuery의 data(@@)의 이름이 같아야 함 -->
					<a data-tmp="'key':'데이터1','key2':'데이터2'" class="modal-link btn btn-icon-split" href="#" role="button" aria-haspopup="true" 
                            aria-expanded="false" data-toggle="modal" data-target="#connectModalName">모달</a> <!-- data-target의 이름과 modal.jsp의 id가 같아야 함(현재 이름: connectModalName) -->

				</div>
			</div>
			<%@ include file="../common/footer.jsp" %>
		</div>
	</div>

	<%@ include file="modal.jsp" %> <!-- 모달 파일 이름 변경하면 바꿔주세요 -->
	<%@ include file="../common/commonETC.jsp" %>
	<%@ include file="../common/commonJS.jsp" %>
	<script>
		$("#connectModalName").on("show.bs.modal", function (event) {
			var str = $(event.relatedTarget).data('tmp').split(",");
			
			var json = {};
			$.each(str, function (idx, item) {
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