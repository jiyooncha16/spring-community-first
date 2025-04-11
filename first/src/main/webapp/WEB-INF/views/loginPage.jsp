<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Login - First Community</title>

    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<style>
.join-searchid {
	display: flex; /* 요소들을 가로로 정렬 */
    align-items: center; /* 세로 정렬 */
    justify-content: space-around; /* 양쪽 정렬 */
}
</style>


    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title" style="text-align: center;">로그인</h3>
                        <!-- <p>로그아웃 파라미터 값: ${param.logout}</p> -->
                    </div>
                    <div class="panel-body">
                        <form role="form" method="post" action="/login">
                            <fieldset>
                                <div class="form-group"> <!-- 내 db명과는 상관없이 username, password로 설정해야 파라미터 수집 됨. -->
                                    <input class="form-control" placeholder="아이디" name="username" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호" name="password" type="password" value="">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="remember" type="checkbox" value="로그인 상태 유지">
										로그인 상태 유지
                                    </label>
                                </div>
                                <button type="submit" class="btn btn-success btn-block" style="margin-bottom:10px;">
            						로그인
        						</button>
        						<div class="join-searchid">
        							<div class="join"><a href="/join" style="color:black;">
        								회원가입</a>
                        			</div>
                        			<div class="searchid"><a href="/searchid" style="color:black;">
        								아이디 찾기</a>
                        			</div>
                        			<div class="home"><a href="/" style="color:black;">
        								홈 화면</a>
                        			</div>
                        		</div>
                            </fieldset>
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                         </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- jQuery -->
    <script src="/resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>


<script>

$(".button-success").on("click", function(e){
	e.preventDefault();
	$("form").submit();
});

</script>

<c:if test="${param.logout}">
		<script>
		//$(document).ready(function(){
		window.onload = function() {
			console.log("로그아웃");
			alert("로그아웃되었습니다.");
		};
		</script>
</c:if>


</body>

</html>
