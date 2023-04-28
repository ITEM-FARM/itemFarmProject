<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">LOGOUT</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">정말 로그아웃 하시겠습니까? <br> 맞다면 "Logout" 버튼을 눌러주세요.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a id="btnLogout" class="btn btn-primary" href="#" >Logout</a>
                </div>
            </div>
        </div>
    </div>
    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    
    <script>
    $(function(){
    	$("#btnLogout").on("click",function(){
    		$.ajax({
    			url:"<%=request.getContextPath()%>/auth/logout.do",
    			success:(result,status,xhr)=>{
					console.log("textStatus", result);
					location.href="<%=request.getContextPath()%>/auth/loginCheck.do";
				},
				error:(jqXHR, textStatus, errorThrown)=>{
					console.log("textStatus", textStatus);
				}
    		})	
    	});
    });
    </script>
</body>
</html>