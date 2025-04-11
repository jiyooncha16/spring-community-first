<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
    
<%@include file="../includes/header.jsp" %>

<style>
#regbtn {
    height: 36px; /* 버튼 높이 고정 */
    padding: 5px 12px; /* 내부 여백 */
    font-size: 14px; /* 글자 크기 조정 */
    line-height: normal; /* 기본 줄 높이 유지 */
    align-self: center; /* 버튼을 개별적으로 중앙 정렬 */
}

.text {
	font-size: 16px;
	font-weight: bold;
}

.pagination justify-content-center {
	display: flex;
	width: 100%;
	margin: auto;
}
.paging {
	padding: 0;
}
	
.regbtn-and-paging {
	display: flex;
    justify-content: space-between;
}

.keyword {
	width: 150px;
	border-radius: 5px 0 0 5px;
	
}

.search-btn {
	color: #fcf8e3;
	background-color: gray;
	border-color: gray;
	border-radius: 0 5px 5px 0;
}

.search {
	display: flex;
	justify-content: flex-end;
}






/* 📌 페이지네이션 전체 컨테이너 */
.pagination {
    display: flex; /* 가로 정렬 */
    justify-content: center; /* 중앙 정렬 */
    padding: 0px 10px; /* 양옆 여백 추가 */
}

/* 📌 개별 페이지 버튼 스타일 */
.pagination .page-link {
    color: #000; 
  	background-color: #fff;
  	border: 1px solid #ccc; 
}

/* 📌 현재 선택된 페이지 (active) 스타일 */
.page-item.active .page-link {
    z-index: 1;
 	color: #555;
 	font-weight:bold;
 	background-color: #ccc !important; /*왜 안 될까?*/
 	border-color: #ccc;
}

/* 📌 페이지 번호 기본 스타일 */
.pagination .paginate_button a {
    color: #000;
}

/* 📌 페이지 번호에 마우스를 올렸을 때 (hover) */
.pagination .paginate_button a:hover {
    color: #000;
  	background-color: #fafafa; 
  	border-color: #ccc;
}

/* 📌 비활성화된 버튼 스타일 */
.pagination .disabled .page-link {
    color: #ccc !important; /* 흐린 회색 글자 */
    background-color: #f8f9fa !important; /* 배경 밝은 회색 */
    border-color: #ddd !important; /* 테두리 회색 */
    pointer-events: none; /* 클릭 불가능 */
}

/* 📌 '처음' & '마지막' 페이지 버튼 스타일 */
.pagination .page-first .page-link,
.pagination .page-last .page-link {
    /*font-weight: bold; /* 글자를 두껍게 */
}

/* 📌 이전 & 다음 버튼 스타일 */
.pagination .page-button-previous .page-link,
.pagination .paginate_button.next .page-link {
    font-size: 16px; /* 글자 크기 키우기 */
}


</style>


            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">일반게시판</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                	<ul class="list-group">
                        
                       
                            <table style="width="100%";" class="table table-hover">
                                <thead>
                                    <tr class="warning">
                                        <th style="text-align: center; width: 7%;">번</th>
                                        <th style="text-align: center; width: 50%;">제목</th>
                                        <th style="text-align: center; width: 13%;">작성자</th>
                                        <th style="text-align: center; width: 10%;">작성일</th>
                                        <th style="text-align: center; width: 10%;">조회수</th>
                                        <th style="text-align: center; width: 10%;">좋아요<i class="bi bi-hand-thumbs-up-fill"></i></th>
                                    </tr>
                                </thead>
                            <c:choose>
        						<c:when test="${empty list}">
            						<tr>
                						<td colspan="6" style="text-align: center; color: gray; padding: 20px;">게시물이 존재하지 않습니다.</td>
            						</tr>
        						</c:when>
        						<c:otherwise>    
                                <c:forEach items="${list}" var="board">
                                	<tr>
                                		<td style="text-align: center;"><c:out value="${board.bno}" /></td>
                                		<td style="color: gray;">
                                			<a style="color: black;" href='../board/get?bno=${board.bno}&page=1'>
                                			<c:out value="${board.title}"/></a>
                                			<c:out value="[${board.replyCnt}]" /></td>
                                		<td style="text-align: center;"><c:out value="${board.writer}" /></td>
                                		<td style="text-align: center;"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.boardDate}" /></td>
                                		<td style="text-align: center;"><c:out value="${board.hitCnt}" /></td>
                                		<td style="text-align: center;"><c:out value="${board.boardLike}" /></td>
                                	</tr>
                                </c:forEach>
                                </c:otherwise>
                             </c:choose>
                            </table>
                                
                             
                             <form role="form" action="/board/list" method="get">
                             <div class="search">
                             	<input class="form-control keyword" name='keyword' value="${keyword}"></input>
                             	<button type="submit" class="btn search-btn">검색</button>
                             </div>
                             </form>
                             
                                
                             <div class="regbtn-and-paging">
                                <button id="regbtn" class="btn btn-warning" onclick="location.href='/board/register'">새 글 등록하기</button>
                                
                                <!-- 페이징 -->
                                <div class="paging" style="text-align:right;">
                                <ul class="pagination justify-content-center">
    								<!-- 처음 페이지로 이동 -->
   									<li class="page-first">
       									<a class="page-link" href="?pageNum=1&keyword=${keyword}">처음</a>
    								</li>

    								<!-- 이전 페이지 -->
    								<c:if test="${pageMaker.prev}">
    									<li class="page-button-previous ${pageMaker.prev ? '' : 'disabled'}" aria-label="Previous">
        									<a href="?pageNum=${pageMaker.startPage -1}&keyword=${keyword}"><span aria-hidden="true">&laquo;</span></a>
    									</li>
    								</c:if>

								    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
										<li class="paginate_button  ${pageMaker.cri.pageNum == num ? 'active':''} " pagination-active-color="#ffc107">
											<a href="?pageNum=${num}&keyword=${keyword}">${num}</a>
										</li>
									</c:forEach>

									<c:if test="${pageMaker.next}">
										<li class="paginate_button next ${pageMaker.next ? '' : 'disabled'}" aria-label="Next">
											<a href="?pageNum=${pageMaker.endPage +1 }&keyword=${keyword}"><span aria-hidden="true">&raquo;</span></a>
										</li>
									</c:if>


								    <!-- 마지막 페이지로 이동 -->
								    <li class="page-last">
								        <a class="page-link" href="?pageNum=${pageMaker.realEnd}&keyword=${keyword}">마지막</a>
								    </li>
								    
								</ul>
                                </div>
                             </div>  
                            
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
                                    <!-- /.modal-body -->
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                            
                        </div>
                        <!-- /.modal fade -->
                   
                   
                   
                    </ul>
                </div>
               <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            

            
<%@include file="../includes/footer.jsp" %>



<script type="text/javascript">


//Spring security csrf 토큰 설정
var csrfHeaderName ="${_csrf.headerName}"; 
var csrfTokenValue="${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options) { 
  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
}); 

<!-- result를 Modal 모달창으로 보여주기 위한 자바스크립트 -->
$(document).ready(function() {
	var result = '<c:out value="${result}"/>';
	console.log("result :" + result);
	checkModal(result);
	history.replaceState({},null,null);
	function checkModal(result){
		if (result==='' || history.state) {
			return;
		}
		
		if (parseInt(result) > 0) {
			$(".modal-body").html("게시글 "+parseInt(result)+"번이 등록되었습니다.");
		}
		
		$("#myModal").modal("show");
	}
});
</script>