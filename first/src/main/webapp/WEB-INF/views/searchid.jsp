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
                <div class="col-lg-12">
                    <h1 class="page-header">아이디 찾기</h1>
                    <!-- 아이디 비밀번호 이름 성별 나이 -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-6">
                    <ul class="list-group">
  						<li class="list-group-item list-group-item-warning">
                            <span class="text">정보 입력하기</span>
                        </li>
                        
  						<li class="list-group-item">
                                    <form role="form" action="/searchid" method="post" enctype="multipart/form-data">
                                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
  										<div class="row mb-3">
    										<label for="name" class="col-sm-2 col-form-label">이름</label>
   			 								<div class="col-sm-10">
      											<input type="text" class="form-control" id="name" name="name" required>
    										</div>
  										</div>
  										
  										<div style="display:flex; align-items:center; flex-direction: column">
		                                	<button type="submit" class="btn btn-warning btn-searchid">아이디 찾기</button>
		                                	<br/>
		                                	<ul id="searchidresult" style="padding:0;"></ul> <!-- 동적추가 -->
		                                </div>
                        			</form>
                        		</li>
                        <!-- /.list-group-item -->
                    </ul>
                    <!-- /.list-group -->
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
$(document).on("click", ".btn-searchid", function() {
	event.preventDefault();
	 console.log("아이디 찾기 중 ... ");
	 
	 var name = $('#name').val();
	 var number = $('#number').val();
	 let searchidresult = $("#searchidresult");
	 
	 console.log("현재 입력한 이름:", name);
	 
	 if (name === null || name.length < 1) { //number도 추가
		 alert("아이디가 입력되지 않았습니다.");
		 return;
	 }
	 
	 $.ajax({
         url: "/searchid",  
         method: "post",
         contentType: "application/x-www-form-urlencoded; charset=UTF-8",
         data: { name:name }, //number:number
         success: function(result) {
             console.log('아이디 찾기 결과 : ' + result);
             if (!result) {
            	 console.log('해당하는 계정이 없습니다. 입력하신 정보를 재확인해 주세요.');
            	 searchidresult.empty();
            	 searchidresult.append("해당하는 계정이 없습니다. 입력하신 정보를 재확인해 주세요.");
             } else {
            	 console.log('결과가 있습니다.');
            	 searchidresult.empty();
            	 searchidresult.append("고객님의 아이디는 " + result + "입니다.");
             }
         },
         error: function(xhr, status, error) {
             console.error("아이디 찾기 요청 실패:", status, error);
         }
	 });
});
	 
	 







</script>