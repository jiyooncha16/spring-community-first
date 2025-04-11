<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> <!-- 시큐리티 -->
    
<%@include file="../includes/header.jsp" %>

<style>
.container {
    display: flex; /* 요소들을 가로로 정렬 */
    align-items: center; /* 세로 정렬 */
    justify-content: space-between; /* 양쪽 정렬 */
    width: 100%; /* 전체 너비 사용 */
    gap: 10px; /* 요소 사이 간격 */
    font-size: 14px;
    padding: 0;
    margin: 0;
    
}

.left-content {
	display: flex; /* 왼쪽 정렬 */
	align-items: center; /* 세로 정렬 */
	gap: 5px; /* 요소 사이 간격 */
	font-weight: bold;
	font-size: 18px;
	margin-top:0;
	margin-bottom:0;
}

.right-content {
	margin-left: auto;/* 자동 여백 추가하여 오른쪽 정렬 */
	align-items: center;
	font-size: 14px;
}

.form-group-b {
	margin-top:0;
	margin-bottom:0;
}

.form-group {
    margin: 10px 0;
}

.content-group {
    margin: 30px 0; /* 불필요한 여백 제거 */
}

.btn-list {
	display: flex; /* 요소들을 가로로 정렬 */
    align-items: center; /* 세로 정렬 */
    justify-content: space-between; /* 양쪽 정렬 */
}
.heartbtn {
    background-color: white;
    color: #f57a69;
    font-size: 15px;
    font-weight: bold;
    padding: 5px 10px;
    
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 50%;
    
    border-color: #f57a69; /* 테두리 제거 */
    border-radius: 6px; /* 둥근 사각형 모양 */
    cursor: pointer; /* 포인터 커서 */
    transition: background-color 0.3s ease; /* 호버 시 부드러운 전환 */
}

.heartbtn:hover {
    background-color: #f57a69;
    color: white;
}

.heartbtn i {
    font-size: 15px;
    line-height: 1;
    vertical-align: middle;
}

.buttons {
	display: flex;
	gap: 5px;
}
.ms-3{
	padding: 10px;
}

.card.bg-light {
	display: flex;
}

.text-replyer {
	flex : 10%;
	min-width: 10%;
	margin-right: 10px;
}

.text-reply {
	flex : 80%;
	min-width: 80%;
}

.button-reply {
	padding: 10px 0px;
}

.button-reply .btn {
	display: flex;
	margin-left: auto;
}

#replyList { /* #은 id, .는 class */
    padding: 0;
    margin: 0;
    width: 100%;
}

#replyList li {
    width: 100%;
    display: block; /* li가 블록 요소로 작동하도록 설정 */
}

.replyer-replyDate {
	display: flex;
}

.replyer {
	margin-right: auto;
	padding: 10px;
	font-weight: bold;
	font-size: 15px;
}
.replyDate{
	padding: 10px;
}
 .reply-content {
 	padding: 10px;
 }
 
 .reply-modify-btns {
 	display: flex;
 	width: 100%;
 	padding: 10px;
 	justify-content: flex-end
 }
 
 .save-edit {
 	margin-right: 10px;
 }
 
  .button-page-wrapper {
 	display: flex;
 	width: 100%;
 	justify-content: center;
 	padding: 10px;
 	
 }
 
 .button-page {
 	display: flex;
 	justify-content: center;
 	
 }
 
 .reply-listing {
 	display: flex;
 	width: 100%;
 	justify-content: center;
 }
 
 .replyListBtn {
 	width: 100%;
 }
 
 ul {
    padding: 0;  /* 기본 padding 제거 */
    margin: 0;   /* 필요하면 margin도 제거 */
    list-style: none;  /* 리스트 스타일 제거 */
}

.upper {
	display: inline-flex;
	align-items: center;
	gap: 2px;
}
 
.downloadbtn {
	color:black;
	width:20px; 
	height:20px; 
	font-size:10px;
	margin-right: 5px;
	
	display: inline-flex;
	justify-content: center;
	align-items: center;
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
  					<li class="list-group-item list-group-item-warning" style="padding-top:5px; padding-bottom:5px;">
  					<div class="container">
						<div class="left-content">
                        	<div class="form-group-b" data-number="${postNumber}">
                            	<div id="post-number"></div>
                            </div>
                            <div class="form-group-b" data-title="${postTitle}">
                                 <div id="post-title"></div>
                            </div>
                        </div>
                        <div class="right-content">
                            <div class="form-group" data-writer="${postWriter}">
                                  <div id="post-writer"></div>
                            </div>
                        </div>
                    </div>
					</li>
  					<li class="list-group-item">
                         <div class="content-group" data-content="${postContent}">
                            <div id="post-content"></div>
                        </div>
                    </li>
                    <li class="list-group-item btn-list">
                    	<span>
                    		<button type='button' class='btn heartbtn'>
                    			<i class='bi bi-heart' style="font-weight: bold;"></i>&nbsp;&nbsp;
                    			<span> 0</sapn>
                    		</button>
						</span>
                        <span class="buttons">
                        	<!-- 사용자=작성자인 경우에만 수정삭제 버튼 보이도록 처리 / 매번 principal 쓰는 귀찮음 처리 -->
                        	<sec:authentication property="principal" var="p"/>
		                        <sec:authorize access="isAuthenticated()">
		                        <c:if test="${p.username eq postWriter }">
                            <button type="button" class="btn btn-warning" onclick="location.href='../board/modify?bno=${postNumber}';">수정</button>
                            <button type="button" class="btn btn-danger btn-delete">삭제</button>
                            	</c:if>
                            	</sec:authorize>
                            <button type="button" class="btn btn-default" onclick="location.href='../board/list';">목록</button>
                        </span>
                    </li>
                    <li class="list-group-item list-group-item-warning" style="display:flex; align-items:center">
                        <strong>첨부파일 [</strong><ul id="attachListCnt" style="font-weight: bold;"></ul><strong>]</strong>
                    </li>
                    <li class="list-group-item">
                        <ul id="attachList">
                        </ul>
                    </li>
                    
                    
                    
                    
                    <!-- Comments section-->
                    <li class="list-group-item list-group-item-warning">
                        <div class="reply">
                        	<strong>댓글<c:out value=" [${result.replyCnt}]"/></strong>
                        </div>
                    </li>
                    
                    <li class="list-group-item" style="width: 100%">
                   <sec:authorize access="isAnonymous()">
                    <span>로그인한 사용자만 댓글 작성이 가능합니다.</span>
                   </sec:authorize>
                   <sec:authorize access="isAuthenticated()">
                    <form role="form" action="/reply/register?bno=${postNumber}" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <div class="replys" style="width: 100%">
                        <!-- Comment form-->
                        <div class="card bg-light" style="width: 100%">
                            <div class="text-replyer">
                              	<label for="form-control">작성자명</label>
                            	<input class="form-control" name='replyer' 
                            		value='<sec:authentication property="principal.username"/>' readonly="readonly"></input>
                            </div>
                            <div class="text-reply">
                            	<label for="form-control">댓글</label>
                            	<textarea class="form-control" rows="4" name='reply' placeholder="댓글을 남겨보세요."></textarea>
                           	</div>
                       	 </div>
                            <div class="button-reply">
                           		<button type="submit" class="btn btn-warning">댓글 등록하기</button>
                        	</div>
                        </div>
                      </form>
                     </sec:authorize>
                      </li>     
                    <!-- 댓글 -->
                    <ul id="replyList"></ul>
                    <ul id="replyListBtn"></ul>
                    <!-- <div class="button-page-wrapper">
        				<button type="button" class="btn btn-warning button-page">
            				댓글 더보기
        				</button>
        			</div>  -->
					
                    
                    
                    
                    
                    
                             
                    	<!-- <section class="mb-5" style="width: 100%;">
                                <div class="d-flex mb-4">
                                    <div class="flex-shrink-0">
                                    	<!-- 프로필 사진 추가
                                    </div>
                                    <div class="ms-3">
                                        <div class="fw-bold"><i class="bi bi-person-circle"></i> 지윤이</div>
                                        사랑해요 ^^
                                     </div>
                                </div>   
                                
                                <div class="d-flex mb-4">
                                    <div class="flex-shrink-0">
                                    	<!-- 프로필 사진 추가
                                    </div>
                                    <div class="ms-3">
                                        <div class="fw-bold"><i class="bi bi-person-circle"></i> 서윤이</div>
                                       	메롱이
                                     </div>
                                </div> 
                                
                                <div class="d-flex mb-4">
                                    <div class="flex-shrink-0">
                                    	<!-- 프로필 사진 추가
                                    </div>
                                    <div class="ms-3">
                                        <div class="fw-bold"><i class="bi bi-person-circle"></i> 다윤이</div>
                                        나도메롱이
                                     </div>
                                 </div>
                            </section> -->
                    
                    
				</ul>
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
                                    <!-- /.modal-body -->
                                </div>
                                <!-- /.modal-content -->
                            </div>
                            <!-- /.modal-dialog -->
                            
                        </div>
                        <!-- /.modal fade -->
            
<%@include file="../includes/footer.jsp" %>  


<script type="text/javascript">
$(document).ready(function() {
    var result = "${number}";
    console.log("result number: " + result);
    checkModal(result);
    function checkModal(result){
    	if (result !== "" && result !== null && !isNaN(result)) {
        $(".modal-body").html("게시글 " + result + "번 처리가 완료되었습니다.");
        $("#myModal").modal("show");
    	}
    }
    
    $(document).on("keyup", function(e) {
        if (e.key === "Enter" || e.keyCode === 13) {
            if ($("#myModal").hasClass("in") || $("#myModal").is(":visible")) {
                $("#myModal").modal("hide");
            }
        }
    });
});
</script>

<script>
//게시글 번호를 출력
    const postNumber = document.querySelector('.form-group-b').getAttribute('data-number');
    document.getElementById('post-number').textContent = '#${postNumber} : ';
    
// 제목을 화면에 출력 (post 방식 아님. 게시글 post)
    const postTitle = document.querySelector(".form-group-b").getAttribute("data-title");
    document.getElementById("post-title").textContent = '${postTitle} [${result.replyCnt}] ';
// 작성자명을 화면에 출력
    const postWriter = document.querySelector(".form-group").getAttribute("data-writer");
    document.getElementById("post-writer").textContent = '작성자 : ${postWriter}';

 // 내용을 화면에 출력
     const postContent = document.querySelector(".content-group").getAttribute("data-content");
     document.getElementById("post-content").innerHTML = postContent.replace(/\n/g, "<br>");  // 엔터가 인식이 안 되므로 replace

     
//csrf 토큰 관련 : 아래 ajaxSend 함수를 추가해놓기만 해도 모든 ajax 전송 시 csrf 토큰을 같이 전송하도록 세팅
     var replyer = null;
	<sec:authorize access="isAuthenticated()">
     	replyer = '<sec:authentication property="principal.username"/>';
 	</sec:authorize>
 	
     var csrfHeaderName ="${_csrf.headerName}"; 
     var csrfTokenValue="${_csrf.token}";
     
     $(document).ajaxSend(function(e, xhr, options) { 
         xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
       }); 

 </script>


<script>
// 게시글 삭제 버튼 클릭 이벤트
$(document).on("click", ".btn-delete", function() {
	 console.log("삭제 요청");
	// 삭제 확인 메시지
	if (confirm("정말로 삭제하시겠습니까?")) {
	 
    const urlParams = new URLSearchParams(window.location.search);
    const bno = urlParams.get("bno");

    $.ajax({
        url: "/board/remove",
        method: "GET",
        data: { bno: bno },
        success: function(response) {
       	 	console.log("삭제 완료");
       	 	alert("게시글이 삭제되었습니다.");
       		location.href = "/board/list";
        },
        error: function(xhr, status, error) {
            console.error("삭제 실패:", status, error);
        }
    });
    
	} else {
       // 취소 클릭 시 아무 것도 하지 않음
       console.log("삭제 취소");
   }
});


//댓글
<sec:authorize access="isAuthenticated()">
	var loggedInUser = "<sec:authentication property='principal.username' />";
</sec:authorize>
<sec:authorize access="isAnonymous()">
	var loggedInUser = "";
</sec:authorize>
console.log("현재 로그인한 사용자: " + loggedInUser);
     
     $(document).ready(function() {
    	    console.log("댓글 리스트 띄우기");

    	    const urlParams = new URLSearchParams(window.location.search);
    	    let bno = urlParams.get("bno");
    	    let page = urlParams.get("page");

    	    if (!bno) {
    	        console.error("bno 값이 없습니다.");
    	        return;
    	    }
    	    if (!page) {
    	        page=1;
    	    }
    	    page = parseInt(page);  // page가 없으면 기본값 1

    	    console.log("현재 bno 값:", bno);
    	    console.log("현재 page 값:", page);

    	    let replyList = $("#replyList"); 
    	    let replyListBtn = $("#replyListBtn"); 

    	    // 댓글 로드 함수 (기존 댓글 유지)
    	    function loadReplies(currentPage, maxPage) {
    	    	
    	    	if (currentPage > maxPage) return; // 모든 페이지 로딩 완료 시 종료
    	    	
    	        $.ajax({
    	            url: "/reply/list",  
    	            method: "GET",
    	            contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    	            data: { bno: bno, page: currentPage },
    	            success: function(replies) {
    	                console.log('페이지 ' + currentPage + ' 댓글 로드 완료:', replies);

    	                // 댓글이 없을 경우 처리 (첫 페이지에만 적용)
    	                if (replies.length === 0 && page === 1) {
    	                    replyList.append('<li class="list-group-item" style="width: 100%"><div class="reply-listing">댓글이 없습니다.</div></li>');
    	                } else {
    	                    replies.forEach(function(reply) {
    	                        let timestamp = reply.replyDate;
    	                        let date = new Date(timestamp);

    	                        let listItem =
    	                            '<li class="list-group-item" style="width: 100%" data-rno="'+reply.rno+'" data-original-text="' + reply.reply + '">'
    	                        	+'<div class="reply-item"><div class="replyer-replyDate">'
    	                            + '<div class="replyer"><i class="bi bi-person-circle" style="margin-right: 10px;"></i>'
    	                            + reply.replyer + '</div>'
    	                            + '<div class="replyDate">' + date.toLocaleString();
    	                            
    	                           
    	                     	if (loggedInUser === reply.replyer) {
            						listItem +=
                						'<i class="bi bi-pencil-square edit-reply" style="color: orange; margin-left: 10px"></i>'
                						+ '<i class="bi bi-x-octagon-fill delete-reply" style="color: red; margin-left: 10px"></i>';
        						}
    	                     	
    	                     	listItem +=
    	                            '</div></div><div class="reply-content" style="width: 100%">' + reply.reply + '</div></div></li>';
    	                        
    	                        replyList.append(listItem);
    	                        
    	                    });
    	                }
    	                loadReplies(currentPage + 1, maxPage);
    	            },
    	            error: function(xhr, status, error) {
    	                console.error("AJAX 요청 실패:", status, error);
    	            }
    	        });
    	    }
    	    loadReplies(1, page);
    	    replyListBtn.append('<div class="button-page-wrapper">' + 
			'<button type="button" class="btn btn-warning button-page">댓글 더보기</button></div>');
    	});

  // 댓글 추가 목록 버튼 클릭 이벤트
     $(document).on("click", ".button-page", function() {
    	 event.preventDefault();
    	 console.log("추가 댓글 페이지 요청");
    	 
    	 const urlParams = new URLSearchParams(window.location.search);
 	    console.log("url: " + urlParams);
         let bno = urlParams.get("bno");
         let page = urlParams.get("page");
         
         if (!bno) {
             console.error("bno 값이 없습니다.");
         }
         
         if (!page) {
         	page = 1;
         }
         
         
         
         bno = parseInt(bno, 10);
         page = parseInt(page, 10);
         

  	    console.log("현재 bno 값:", bno);
  	    console.log("현재 page 값:", page);
  	    
        page = page + 1;
       
 	    console.log("현재 bno 값:", bno);
 	    console.log("현재 page+1 값:", page);
 	    
   	   	let button = $(this);
 	    
   	   	$.ajax({
 	        url: "/reply/list",  // 서버에서 댓글 데이터를 요청
 	        method: "GET",
 	        data: { bno: bno, page:page },
 	        success: function(replies) {
 	            console.log("댓글 리스트 응답:", replies);  // 응답을 콘솔에 출력

 	            let replyList = $("#replyList");  // 기존 댓글리스트
 	            //replyList.empty();  // 기존의 댓글 리스트를 초기화하지않음.

 	            // 댓글이 없을 경우 처리
 	            if (replies.length === 0) {
 	            	let listItem ='<li class="list-group-item" style="width: 100%"><div class="reply-listing">추가로 불러올 댓글이 없습니다.</div></li>';
	                replyList.append(listItem);
	                button.attr("disabled", true);
 	            } else {
 	                // 댓글이 있을 경우, 댓글 항목을 추가
 	                replies.forEach(function(reply) {
 	                    let timestamp = reply.replyDate;
 	                    let date = new Date(timestamp);

 	                    // 댓글 항목 구조
 	                    let listItem =
 	                        '<li class="list-group-item" style="width: 100%" data-rno="'+reply.rno+'" data-original-text="' + reply.reply + '"><div class="reply-item"><div class="replyer-replyDate">'
 	                        + '<div class="replyer"><i class="bi bi-person-circle" style="margin-right: 10px;""></i>'
 	                        + reply.replyer + '</div>'
 	                        + '<div class="replyDate">' + date.toLocaleString();
 	                        
                    	if (loggedInUser === reply.replyer) {
   						listItem +=
       						'<i class="bi bi-pencil-square edit-reply" style="color: orange; margin-left: 10px"></i>'
       						+ '<i class="bi bi-x-octagon-fill delete-reply" style="color: red; margin-left: 10px"></i>';
						}
                    	
                    	listItem +=
                           '</div></div><div class="reply-content" style="width: 100%">' + reply.reply + '</div></div></li>';
                       
                       replyList.append(listItem);
 	                });
 	            // URL의 page 값 업데이트 (URL 변경 없이 유지)
 	               history.replaceState(null, "", '?bno='+ bno + '&page=' + page);
 	            }
 	        }, //에러
 	        error: function(xhr, status, error) {
 	            console.error("AJAX 요청 실패:", status, error);
 	        }
 	    });
 	});
     
     // 수정 버튼 클릭 이벤트
     $(document).on("click", ".edit-reply", function() {
    	 console.log("수정 요청");
         let listItem = $(this).closest("li"); //수정 중 수정버튼 비활성화
         
         if (listItem.attr("data-editing") === "true") {
             console.log("이미 수정 중입니다.");
             return; // 수정 중이면 함수 종료
         }
         
         let replyContent = listItem.find(".reply-content");
         let currentText = replyContent.text();
         
         if (!listItem.attr("data-original-text")) {
             listItem.attr("data-original-text", currentText);
         }
         
         let editForm =
             '<textarea class="form-control edit-text">' + currentText + '</textarea>'
             + '<div class="reply-modify-btns">'
             + '<button class="btn btn-warning save-edit">수정</button>'
             + '<button class="btn btn-danger cancel-edit">취소</button>'
             + '</div>'
         ;
         listItem.attr("data-editing", "true");
         replyContent.html(editForm);

     });
     
  // 취소 버튼 클릭 시 원래대로 복구
     $(document).on("click", ".cancel-edit", function() {
    	 console.log("수정 취소");
         let listItem = $(this).closest("li");
         let replyContent = listItem.find(".reply-content");
         let originalText = listItem.attr("data-original-text");
         
         listItem.attr("data-editing", "false");//수정 끝 - 수정버튼 활성화
         
         replyContent.html(originalText);
     });

     // 저장 버튼 클릭 시 AJAX 요청으로 수정
     $(document).on("click", ".save-edit", function() {
    	 
         let listItem = $(this).closest("li");
         const urlParams = new URLSearchParams(window.location.search);
         const bno = urlParams.get("bno");
         let rno = listItem.attr("data-rno");
         let newReply = listItem.find(".edit-text").val();
         
         listItem.attr("data-editing", "false"); //수정 끝 - 수정버튼 활성화
         
         $.ajax({
             url: "/reply/modify",
             method: "POST",
             data: { bno: bno, rno: rno, newReply: newReply },
             success: function(response, status, xhr) {
            	 console.log("응답 상태:", xhr.status);
                 console.log("응답 텍스트:", xhr.responseText);
                if (xhr.responseURL && xhr.responseURL.includes("/loginPage")) {
                    alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
                    window.location.replace("/loginPage");
                } else {
                    console.log("수정 내용 저장");
                    alert("댓글이 수정되었습니다.");
                    listItem.find(".reply-content").html(newReply);
                }
             },
             error: function(xhr, status, error) {
                 console.error("댓글 수정 실패:", status, error);
             }
         });
     });
     
  // 삭제 버튼 클릭 이벤트
     $(document).on("click", ".delete-reply", function() {
    	 console.log("삭제 요청");
    	// 삭제 확인 메시지
    	if (confirm("정말로 삭제하시겠습니까?")) {
    	 
    	 let listItem = $(this).closest("li");
         const urlParams = new URLSearchParams(window.location.search);
         const bno = urlParams.get("bno");
         let rno = listItem.attr("data-rno");

         $.ajax({
             url: "/reply/remove",
             method: "GET",
             data: { bno: bno, rno: rno },
             success: function(response) {
            	 console.log("삭제 완료");
            	 alert("댓글이 삭제되었습니다.");
                 location.reload();  // 새로고침을 통한 업데이트
             },
             error: function(xhr, status, error) {
                 console.error("댓글 삭제 실패:", status, error);
             }
         });
         
    	} else {
	        // 취소 클릭 시 아무 것도 하지 않음
	        console.log("삭제 취소");
	    }
     });
  
  	//게시물 첨부파일 불러오기
     $(document).ready(function(){
    	  
    	  (function(){
    		const urlParams = new URLSearchParams(window.location.search);
    		const bno = urlParams.get("bno");
    	    //var bno = '<c:out value="${board.bno}"/>';
    	    $.getJSON("/board/getAttachList", {bno: bno}, function(data){
    	    	
    	    	var str = "";
                var cnt = data.length;
    	    	
    	    	if (!data || data.length === 0) {
                    str = "<li>첨부파일이 없습니다.</li>";
                    $("#attachList").html(str);
         	       	$("#attachListCnt").html("<li>0</li>");
                    return;
    	    	}
    	    	
    	    	
    	       
    	       $.each(data, function(i, file) {
    	    	 // 공통 추가
    	    	 str += "<li data-path='"+file.uploadPath+"' data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"' data-type='"+file.fileType+"' ><div>";
    	         
    	         if(file.fileType){//image type
    	           	var fileCallPath =  encodeURIComponent(file.uploadPath+ "/s_"+file.uuid +"_"+file.fileName);
    	         	
    	           	str += "<div class='upper'><a href='/download?file=" + file.uploadPath + "/" + file.uuid + "_" + file.fileName + "'>";
    	           	str += "<button type='button' class='btn btn-secondary btn-circle downloadbtn'><i class='bi bi-download' style='font-weight: bold;'></i></button><br></a>";
    	           	str += "<img src='/display?fileName="+fileCallPath+"' style='width:20px; height:20px; margin-right: 5px;'>";
    	           	str += "<span> "+ file.fileName+"</span><br/></div>";
    	           
    	         } else {  //일반 file
    	        	str += "<div class='upper'><a href='/download?file=" + file.uploadPath + "/" + file.uuid + "_" + file.fileName + "'>";
     	           	str += "<button type='button' class='btn btn-secondary btn-circle downloadbtn'><i class='bi bi-download' style='font-weight: bold;'></i></button><br></a>";
    	           	str += "<img src='/resources/img/attach.png' style='width:20px; height:20px; margin-right: 5px;'>";
    	           	str += "<span> "+ file.fileName+"</span><br/></div>";
    	         }
    	         
    	         str += "<hr style='margin-top: 10px; margin-bottom: 10px;'></div></li>";
    	       });
    	       
    	       $("#attachList").html(str);
    	       
    	       var cnt = data.length;
    	       $("#attachListCnt").html(cnt);
    	       
    	     });//end getjson
    	  })();//end function
    	  
    	  
    	  //미리보기 처리?
    	  $(".uploadResult").on("click","li", function(e){
    	      
    	    console.log("view image");
    	    
    	    var liObj = $(this);
    	    
    	    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
    	    
    	    if(liObj.data("type")){
    	      showImage(path.replace(new RegExp(/\\/g),"/"));
    	    }else {
    	      //download 
    	      self.location ="/download?fileName="+path
    	    }
    	    
    	    
    	  });
    	  
    	  function showImage(fileCallPath){
    		    
    	    alert(fileCallPath);
    	    
    	    $(".bigPictureWrapper").css("display","flex").show();
    	    
    	    $(".bigPicture")
    	    .animate({width:'100%', height: '100%'}, 1000);
    	    
    	  }

    	  $(".bigPictureWrapper").on("click", function(e){
    	    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
    	    setTimeout(function(){
    	      $('.bigPictureWrapper').hide();
    	    }, 1000);
    	  });

    	  
    	});

</script>