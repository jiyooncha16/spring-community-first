<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> <!-- 시큐리티 -->
    
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<%@ page isELIgnored="false" %>
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
                    <h1 class="page-header">내 정보</h1>
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
                
                    
                    <form role="form" action="/join" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <ul class="list-group" >
  						<li class="list-group-item list-group-item-warning">내 정보</li>
  							<li class="list-group-item">
                                        <div class="row mb-3">
    										<label for="memberid" class="col-sm-2 col-form-label">아이디 </label>
    										<div class="col-sm-10 memberid" id="memberid">
    											<sec:authentication property="principal.username"/>
    										</div>
  										</div>
  										<div class="row mb-3">
    										<label for="name" class="col-sm-2 col-form-label">이름 </label>
   			 								<div class="col-sm-10 name" id="name">
   			 									<c:out value="${user.name}"/>
    										</div>
  										</div>
  										<div class="row mb-3">
    										<label class="col-sm-2 col-form-label" for="gender">성별 </label>
    										<div class="col-sm-10 gender" id="gender">
    											<c:choose>
											    	<c:when test="${user.gender == 1}">남</c:when>
											    	<c:when test="${user.gender == 2}">여</c:when>
											    	<c:otherwise>미입력</c:otherwise>
												</c:choose>
    										</div>
    									</div>
    									<div class="row mb-3">
    										<label for="age" class="col-sm-2 col-form-label">나이 </label>
   			 								<div class="col-sm-10 age" id="age">
   			 									<c:choose>
             										<c:when test="${user.age == 0}">미입력</c:when>
             										<c:otherwise>
                 										<c:out value="${user.age}" />
             										</c:otherwise>
         										</c:choose>
    										</div>
  										</div>
  										<div style="display:flex; align-items:center; flex-direction: row; justify-content: center; gap:10px;">
		                                	<button type="button" class="btn btn-warning" onclick="location.href='/profileEdit'">정보 수정하기</button>
		                                	<button type="button" class="btn btn-warning" onclick="location.href='/passwordEdit'">비밀번호 수정하기</button>
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
            
            <!-- Modal 모달창 처리 -->
                            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                            <h4 class="modal-title" id="myModalLabel">처리완료</h4>
                                        </div>
                                        <div class="modal-body">완료되었습니다.<div class="modal-footer">
                                            <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

            
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
	 
<!-- result를 Modal 모달창으로 보여주기 위한 자바스크립트 -->
$(document).ready(function() {
	var result = '<c:out value="${result}"/>';
	console.log("result :" + result);
	checkModal(result);
	history.replaceState({},null,null);
	function checkModal(result){
		if (result==='' || history.state) {
			console.log('result 값이 없음');
			return;
		}
		
		if (result == 1) {
			$(".modal-body").html("비밀번호 변경이 완료되었습니다.");
		}
		
		$("#myModal").modal("show");
	}
}); 







</script>