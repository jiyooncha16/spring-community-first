<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> <!-- 시큐리티 -->
    
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<style>
.center-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 80vh; /* 화면 높이 기준 가운데 */
    flex-direction: column;
    text-align: center;
}
.go {
    background-color: #e3d5ca;
    padding: 30px 100px;
    border-radius: 10px;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
}
.go a {
    display: block;
    margin: 10px 0;
    font-size: 16px;
    text-decoration: none;
    color: black;
}
</style>

	<div class="container center-wrapper">
    	<h2 class="page-header">회원가입을 축하합니다! 로그인 후 이용해 주세요.</h1>
    	<div class="go">
        	<div class="searchid"><a href="/loginPage"><i class="fa fa-user fa-fw"></i> 로그인 바로가기</a></div>
        	<hr>
        	<div class="boardList"><a href="/board/list"><i class="fa fa-pencil-square-o fa-fw"></i> 일반게시판 바로가기</a></div>
    	</div>
	</div>
</div>
<!-- /#page-wrapper -->
            
<%@include file="/WEB-INF/views/includes/footer.jsp" %>
</script>