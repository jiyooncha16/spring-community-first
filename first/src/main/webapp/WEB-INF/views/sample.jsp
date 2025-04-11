<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> <!-- 시큐리티 -->
    
<%@include file="/WEB-INF/views/includes/header.jsp" %>

<style>
</style>

          <div class="row">
                <div class="col-lg-8">
                    <h1 class="page-header">회원가입</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-8">
                    <ul class="list-group">
  						<li class="list-group-item list-group-item-warning">
                            <span class="text">회원 정보 입력</span>
                        </li>
                        
  						<li class="list-group-item">
                                    <form role="form" action="/join" method="post" enctype="multipart/form-data">
                                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div class="row mb-3">
    										<label for="memberid" class="col-sm-2 col-form-label">아이디 *</label>
    										<div class="col-sm-10">
    											<div style="display:flex; align-items:center;">
      												<input type="text" class="form-control" id="memberid" name="memberid" required>
    												<button type="button" class="btn btn-default btn-checkid" style="margin-left:auto;">아이디 중복확인</button>
    											</div>
    											<ul id="checkidresult" style="margin-top: 5px; padding-left: 0;"></ul> <!-- 동적추가 -->
    										</div>
  										</div>
  										<div class="row mb-3">
    										<label for="memberpw" class="col-sm-2 col-form-label">비밀번호 *</label>
   			 								<div class="col-sm-10">
      											<input type="password" class="form-control" id="memberpw" name="memberpw"required>
    										</div>
  										</div>
  										<div class="row mb-3">
    										<label for="name" class="col-sm-2 col-form-label">이름 *</label>
   			 								<div class="col-sm-10">
      											<input type="text" class="form-control" id="name" name="name" required>
    										</div>
  										</div>
  										<div class="row mb-3">
    										<label class="col-sm-2 col-form-label" for="gender">성별</label>
    										<div class="col-sm-10">
    										<select class="form-select" id="gender" name="gender" style="padding: 6px 12px;">
      											<option selected>성별 선택</option>
      											<option value="1">남</option>
      											<option value="2">여</option>
    										</select>
    										</div>
    									</div>
    									<div class="row mb-3">
    										<label for="age" class="col-sm-2 col-form-label">나이</label>
   			 								<div class="col-sm-10">
      											<input type="number" class="form-control" id="age" name="age">
    										</div>
  										</div>
  										<div style="display:flex; align-items:center; flex-direction: column">
		                                	<button type="submit" class="btn btn-warning" disabled>가입하기</button>
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
  
</script>