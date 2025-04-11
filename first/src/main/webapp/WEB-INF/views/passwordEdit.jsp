<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> <!-- 시큐리티 -->
    
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<style>
.row {
	margin: 20px;
}
.text {
	font-size: 16px;
	font-weight: bold;
	gap: 1px;
}

</style>

          <div class="row">
                <div class="col-lg-8">
                    <h1 class="page-header">비밀번호 수정하기</h1>
                    <!-- 아이디 비밀번호 이름 성별 나이 -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-8">
                
                <sec:authorize access="isAuthenticated()">
                	
  						<div class="row align-items-start" style="text-align:center; font-weight:bold;">
    						<div class="col-md-4"><a href="/profile" style="color:black;">내 정보</a></div>
	    					<div class="col-md-4"><a href="/myboard" style="color:black;">내 게시물</a></div>
	    					<div class="col-md-4"><a href="/myreply" style="color:black;">내 댓글</a></div>
  						</div>         
                
                    
                    <form role="form" action="/passwordEdit" method="post" enctype="multipart/form-data">
                    <ul class="list-group" >
  						<li class="list-group-item list-group-item-warning">비밀번호 수정하기</li>
  							<li class="list-group-item">
                                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        
  										<div class="row mb-3">
    										<label for="memberpw" class="col-sm-2 col-form-label">새 비밀번호</label>
   			 								<div class="col-sm-10">
      											<input type="password" class="form-control" id="memberpw" name="memberpw" required>
    										</div>
  										</div>
  										
  										<div style="display:flex; align-items:center; justify-content: center;">
		                                	<button type="submit" class="btn btn-warning" style="margin-right:10px;">수정하기</button>
		                                	<button type="button" class="btn btn-secondary" onclick="location.href='/profile'">취소하기</button>
		                                </div>
                        			</li>
                        <!-- /.list-group-item -->
                    </ul>
                    <!-- /.list-group -->
                    </form>
                    </sec:authorize>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            
<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<script>

//Spring security csrf 토큰 설정
var csrfHeaderName ="${_csrf.headerName}"; 
var csrfTokenValue="${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options) { 
    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
  }); 
  
  
//아이디 중복확인 버튼 클릭 시
$(document).on("click", ".btn-checkid", function() {
	event.preventDefault();
	 console.log("아이디 중복확인 중 ... ");
	 
	 var memberid = $('#memberid').val();
	 let checkidresult = $("#checkidresult");
	 
	 console.log("현재 입력한 아이디:", memberid);
	 
	 if (memberid === null || memberid.length < 1) {
		 alert("아이디가 입력되지 않았습니다.");
		 return;
	 }
	 
	 if (memberid.length <= 4) {
		 checkidresult.empty();
    	 checkidresult.append("아이디를 5글자 이상 입력해주세요.");
		 return;
	 }
	 
	 $.ajax({
         url: "/checkid",  
         method: "post",
         contentType: "application/x-www-form-urlencoded; charset=UTF-8",
         data: { memberid:memberid },
         success: function(result) {
             console.log('아이디 중복 확인 결과 : ' + result);
             if (result == 1) {
            	 console.log('중복되는 아이디입니다. 아이디를 변경해주세요.');
            	 checkidresult.empty();
            	 checkidresult.append("중복되는 아이디입니다. 아이디를 변경해주세요.");
            	 $(".btn.btn-warning").prop("disabled", true);
             } else if (result == 0) {
            	 console.log('사용 가능한 아이디입니다.');
            	 checkidresult.empty();
            	 checkidresult.append("사용 가능한 아이디입니다.");
            	 $(".btn.btn-warning").prop("disabled", false);
             }
         },
         error: function(xhr, status, error) {
             console.error("아이디 중복확인 요청 실패:", status, error);
         }
	 });
});
	 
	 







</script>