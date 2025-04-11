<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>My Community</title>

	
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        
    <!-- Bootstrap Core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    
    
    <!-- datepicker-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"/></script>

	<!-- datepicker 한글-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/locales/bootstrap-datepicker.ko.min.js"/></script>

    

    <!-- MetisMenu CSS -->
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- DataTables CSS -->
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <!-- DataTables Responsive CSS -->
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    
    <!-- Bootstrap Icons CDN 추가 -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    
    

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/"  style="color: black;">My Community</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#"  style="color: black;">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="/profile"><i class="fa fa-user fa-fw"></i> Profile</a>
                        </li>
                        <li class="divider"></li>
                        <!-- 로그인되었을 때 : logout -->
                        	<sec:authorize access="isAuthenticated()">
                        	<li><a href="/logoutPage"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        	</li>
                        	</sec:authorize>
                        <!-- 로그인 안 되었을 때 : login -->
                        	<sec:authorize access="isAnonymous()">
                        	<li><a href="/join"><i class="fa fa-user-plus fa-fw"></i> Join</a>
                        	</li>
                        	<li><a href="/loginPage"><i class="fa fa-sign-out fa-fw"></i> Login</a>
                        	</li>
                        	</sec:authorize>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                     <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <li>
                            <a href="#" style="color: black;font-weight:bold;"><i class="fa fa-lock fa-fw"></i> 관리자<span class="fa arrow"></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="/admin/main" style="color: black;font-weight:bold;"> 관리자 메인</a>
                                </li>
                                <li>
                                    <a href="/admin/member" style="color: black;font-weight:bold;"> 회원 관리</a>
                                </li>
                            </ul>
                        </li>
                     </sec:authorize>
                     <sec:authorize access="isAuthenticated()">
                        <li>
                            <a href="#" style="color: black;font-weight:bold;"><i class="fa fa-user fa-fw"></i> 마이페이지<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="/profile" style="color: black;font-weight:bold;"> 내 정보</a>
                                </li>
                                <li>
                                    <a href="/profileEdit" style="color: black;font-weight:bold;"> 내 정보 수정하기</a>
                                </li>
                                <li>
                                    <a href="/passwordEdit" style="color: black;font-weight:bold;"> 비밀번호 수정하기</a>
                                </li>
                            </ul>
                        </li>
                     </sec:authorize>
                     <sec:authorize access="isAnonymous()">
                     	<li>
                            <a href="/loginPage" style="color: black;font-weight:bold;"><i class="fa fa-user fa-fw"></i> 로그인</a>
                        </li>
                        <li>
                            <a href="/join" style="color: black;font-weight:bold;"><i class="fa fa-user-plus fa-fw"></i> 회원가입</a>
                        </li>
                     </sec:authorize>
                        <li>
                            <a href="/board/list" style="color: black;font-weight:bold;"><i class="fa fa-pencil-square-o fa-fw"></i> 일반게시판</a>
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>
        
        

        <div id="page-wrapper">