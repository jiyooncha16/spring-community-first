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
                    <h1 class="page-header">내 정보 수정하기</h1>
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
                
                    
                    <form role="form" action="/profileEdit" method="post" enctype="multipart/form-data">
                    <ul class="list-group" >
  						<li class="list-group-item list-group-item-warning">내 정보 수정하기</li>
  							<li class="list-group-item">
                                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div class="row mb-3">
    										<label for="memberid" class="col-sm-2 col-form-label">아이디 *</label>
    										<div class="col-sm-10">
    											<input type="text" class="form-control" id="memberid" name="memberid" value="${user.memberid}" readonly>
    										</div>
  										</div>
  										
  										<div class="row mb-3">
    										<label for="name" class="col-sm-2 col-form-label">이름 *</label>
   			 								<div class="col-sm-10">
      											<input type="text" class="form-control" id="name" name="name" value="${user.name}" required>
    										</div>
  										</div>
  										<div class="row mb-3">
    										<label class="col-sm-2 col-form-label" for="gender">성별</label>
    										<div class="col-sm-10">
    										<select class="form-select" id="gender" name="gender" style="padding: 6px 12px;">
    											<c:choose>
											    	<c:when test="${user.gender == 1}">
											    		<option value="0">성별 선택</option>
      													<option value="1" selected>남</option>
      													<option value="2">여</option>
											    	</c:when>
											    	<c:when test="${user.gender == 2}">
											    		<option value="0">성별 선택</option>
      													<option value="1">남</option>
      													<option value="2" selected>여</option>
      												</c:when>
											    	<c:otherwise>
											    		<option selected value="0">성별 선택</option>
      													<option value="1">남</option>
      													<option value="2">여</option>
      												</c:otherwise>
												</c:choose>
    										</select>
    										</div>
    									</div>
    									<div class="row mb-3">
    										<label for="age" class="col-sm-2 col-form-label">나이</label>
   			 								<div class="col-sm-10">
      											<input type="number" class="form-control" id="age" name="age" value="${user.age}">
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
  
  
//성별, 나이 미입력도 허용
$("form").on("submit", function(e) {
    let ageInput = $("#age");
    if (ageInput.val().trim() === "") {
        ageInput.val(0);
    }

    let genderInput = $("#gender");
    if (genderInput.val() === "성별 선택") {
        genderInput.val(0);
    }
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