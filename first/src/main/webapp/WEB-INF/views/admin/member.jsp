<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> <!-- 시큐리티 -->
    
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<%@include file="/WEB-INF/views/admin/adminHeader.jsp" %>


<!-- 위에 회원수, 게시글수, 댓글수, 방문자수 기록  -->           
<!-- 1. 회원별 활동 : 아이디, 성별, 나이, 게시글수, 댓글수, 로그인횟수 // 아이디, 성별, 나이별로 조회 가능하도록-->
<!-- 1. 게시글별 현황 : bno, 조회수, 좋아요수, 댓글수 -->
<!-- 3. 일자별 현황 : 신규회원, 로그인수  -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <i class="fa fa-bar-chart-o fa-fw"></i> 회원 목록
                            <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                        Actions
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu pull-right" role="menu">
                                        <li><a href="#">전체</a>
                                        </li>
                                        <li><a href="#">이번 달 신규</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li><a href="#">Separated link</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div id="morris-area-chart"></div>
                            	<div class="table-responsive">
                                        <table class="table table-bordered table-hover table-striped" style="table-layout: fixed;">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center;">아이디</th>
                                                    <th style="text-align: center;">이름</th>
                                                    <th style="text-align: center;">성별</th>
                                                    <th style="text-align: center;">나이</th>
                                                    <th style="text-align: center;">게시글 수</th>
                                                    <th style="text-align: center;">댓글 수</th>
                                                    <th style="text-align: center;">가입일자</th>
                                                    <th style="text-align: center;">탈퇴 처리</th>
                                                </tr>
                                            </thead>
                                            <c:choose>
        										<c:when test="${empty user}">
            										<tr>
                										<td colspan="6" style="text-align: center; color: gray; padding: 20px;">회원이 존재하지 않습니다.</td>
            										</tr>
        										</c:when>
        										<c:otherwise>    
                                					<c:forEach items="${user}" var="user">
                                						<tr>
                                							<td style="text-align: center;"><c:out value="${user.memberid}" /></td>
                                							<td style="text-align: center;"><c:out value="${user.name}"/></a></td>
                                							<td style="text-align: center;">
                                							    <c:choose>
                                							        <c:when test="${user.gender == 1}">남</c:when>
                                							        <c:when test="${user.gender == 2}">여</c:when>
                                							        <c:otherwise>미입력</c:otherwise>
                                 							   </c:choose>
                                							</td>
                                							<td style="text-align: center;">
                                								<c:choose>
                                							        <c:when test="${not empty user.age}">
                                							        	<c:out value="${user.age}" />
                                							        </c:when>
                                							        <c:otherwise>미입력</c:otherwise>
                                 							   </c:choose>
                                 							</td>
                                							<td style="text-align: center;"><c:out value="${user.boardCnt}" /></td>
                                							<td style="text-align: center;"><c:out value="${user.replyCnt}" /></td>
                                							<td style="text-align: center;"><fmt:formatDate pattern="yyyy-MM-dd" value="${user.registerDate}" /></td>
                                							<td style="text-align: center;"><a href="/admin/deleteid" style="color:red;">탈퇴</a></td> <!-- 포스트 방식으로 수정하기 -->
                                						</tr>
                                					</c:forEach>
                                				</c:otherwise>
                             				</c:choose>
                                         </table>
                                      </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
            
<%@include file="/WEB-INF/views/includes/footer.jsp" %>

<script>

//Spring security csrf 토큰 설정
var csrfHeaderName ="${_csrf.headerName}"; 
var csrfTokenValue="${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options) { 
    xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
  }); 
  
</script>