<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
    
<%@include file="../includes/header.jsp" %>

<style>

.panel-heading {
	width: 100%;
}
.form-group-disabled {
	display: flex; /* 요소들을 가로로 정렬 */
    align-items: center; /* 세로 정렬 */
    justify-content: space-between; /* 양쪽 정렬 */
    gap: 10px; /* 요소 사이 간격 */
    width: 100%;
    margin-bottom: 10px;
}

.form-group-number {
	width:49%;
}
.form-group-writer {
	width:49%;
}


.upper {
	display: flex;
	align-items: center;
	gap: 2px;
}

.btn-circle {
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
  						<li class="list-group-item list-group-item-warning">
                            <strong><span class="text">글 수정하기</span></strong>
                        </li>
                        
  						<li class="list-group-item">
                        	<form role="form" action="/board/modify" method="post">
                        	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    	<div class="form-group-disabled">
                                    		<div class="form-group-number">
                                            	<label>글 번호</label>
                                            	<input class="form-control" name='bno' id='post-number' value="${postNumber}" readonly>
                                        	</div>
                                        	<div class="form-group-writer">
                                            	<label>글쓴이</label>
                                            	<input class="form-control" name='writer' id='post-writer' value="${postWriter}" readonly>
                                        	</div>
                                    	</div>
                                    	
                                        <div class="form-group">
                                            <label>제목</label>
                                            <input class="form-control" name='title' id='post-title' value="${postTitle}" required>
                                        </div>
                                        <div class="form-group">
                                            <label>내용</label>
                                            <textarea class="form-control" rows="10" name='content' id='post-content' required>${postContent}</textarea>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-warning">수정</button>
                                        <button type="button" class="btn btn-default" onclick="location.href='../board/list'">목록</button>
                            </form>
                        <li class="list-group-item"><strong>첨부파일</strong>
                        	 <div class="uploadDiv">
    							<input type="file" name="uploadFile" multiple> <!-- input이 변경되는 것을 감지 -->
							</div>
                        </li>
                        <li class="list-group-item">
                        	<div class="uploadResult">
  	    	                    <ul> <!-- 동적추가 -->
    	                        </ul>
    	                    </div>
                        </li>
                        <!-- /.list -->
                    </ul>
                    <!-- /.list-group -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->

            
<%@include file="../includes/footer.jsp" %>  



<script>


//Spring security csrf 토큰 설정
var csrfHeaderName ="${_csrf.headerName}"; 
var csrfTokenValue="${_csrf.token}";
$(document).ajaxSend(function(e, xhr, options) { 
  xhr.setRequestHeader(csrfHeaderName, csrfTokenValue); 
}); 

//게시글 번호를 출력
    const postNumber = document.querySelector('.form-group-number').getAttribute('data-post-number');
    document.getElementById('post-number').textContent = '${postNumber}';
    
// 제목을 화면에 출력 (post 방식 아님. 게시글 post)
    const postTitle = document.querySelector(".form-group").getAttribute("data-title");
    document.getElementById("post-title").textContent = '${postTitle}';
// 내용을 화면에 출력
    const postContent = document.querySelector(".form-group").getAttribute("data-content");
    document.getElementById("post-content").textContent = '${postContent}'; 
// 작성자명을 화면에 출력
    const postWriter = document.querySelector(".form-group-writer").getAttribute("data-writer");
    document.getElementById("post-writer").textContent = '${postWriter}';

    
  	//게시물 첨부파일 불러오기
    $(document).ready(function(){
   	  
   	  (function(){
   		const urlParams = new URLSearchParams(window.location.search);
   		const bno = urlParams.get("bno");
   	    //var bno = '<c:out value="${board.bno}"/>';
   	    $.getJSON("/board/getAttachList", {bno: bno}, function(data){
   	       
   	       var str = "";
   	       
   	       $.each(data, function(i, file) {
   	    	 // 공통 추가
   	    	 str += "<li data-path='"+file.uploadPath+"' data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"' data-type='"+file.fileType+"' ><div>";
   	    	
   	         if(file.fileType){//image type
   	           	var fileCallPath =  encodeURIComponent(file.uploadPath+ "/s_"+file.uuid +"_"+file.fileName);
 				str += "<div class='upper'>"
 				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
 				str += "<img src='/display?fileName="+fileCallPath+"' style='width:20px; height:20px;'>";
 				str += "<span> "+ file.fileName+"</span></div>";
   	         } else {  //일반 file
   	        	var fileCallPath =  encodeURIComponent( file.uploadPath+"/"+ file.uuid +"_"+file.fileName);			      
   			    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
   			    str += "<div class='upper'>"
   				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
   				str += "<img src='/resources/img/attach.png' style='width:20px; height:20px;'>";
   				str += "<span> "+ file.fileName+"</span></div>";
   	         }
   	         
   	         str += "<hr style='margin-top: 10px; margin-bottom: 10px;'></div></li>";
   	       });
   	       
   	       $(".uploadResult ul").html(str);
   	       
   	     });//end getjson
   	  })();//end function
    });    
    
    
    
    
    
    
  //등록 버튼 클릭 시
    $(document).ready(function(e){
    	var formObj = $("form[role='form']");
    	$("button[type='submit']").on("click", function(e){
    		e.preventDefault();
    		console.log("submit clicked");
    		
    		if (!formObj[0].checkValidity()) {
  		      formObj[0].reportValidity(); // 에러 메시지를 사용자에게 보여줌
  		      return;
  		    }
    		
    		var str = "";
    		
    	    
    	    $(".uploadResult ul li").each(function(i, obj){
    	      
    	      var jobj = $(obj);
    	      console.log("-------------------------");
    	      console.log("파일 정보:", jobj.data("filename"), jobj.data("uuid"), jobj.data("path"));
    	      console.log(jobj.data("filename"));
    	      console.log("-------------------------");
    	      
    	      //attachList[] : 화면에 있는 첨부파일 목록
    	      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
    	      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
    	      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
    	      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
    	      
    	      console.log("폼 데이터:", str);
    	    });
    	    formObj.append(str).submit();
    	    
    	  });
    });

    // 파일확장자 및 크기 제한
    var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
    var maxSize = 5242880; //5MB

    function checkExtension(fileName, fileSize){
      
      if(fileSize >= maxSize){
        alert("파일 사이즈 초과");
        return false;
      }  
      if(regex.test(fileName)){
        alert("해당 종류의 파일은 업로드할 수 없습니다.");
        return false;
      }
      return true; //둘 다 괜찮으면 true 리턴
    }

    //file 변동 감지 시
    var csrfTokenVaule = "${_csrf.token}";
	var csrfHeaderName = "${_csrf.headerName}";
    $("input[type='file']").change(function(e){
        var formData = new FormData();
        var inputFile = $("input[name='uploadFile']");
        var files = inputFile[0].files;
        
        for(var i = 0; i < files.length; i++){

          if(!checkExtension(files[i].name, files[i].size) ){
            return false;
          }
          formData.append("uploadFile", files[i]);
        }
        
        $.ajax({
          url: '/upload',
          processData: false, 
          contentType: false,
          beforeSend: function(xhr) {
              xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
          },
          data:formData,
          type: 'POST',
          dataType:'json',
            success: function(result){
              console.log(result); 
    		  showUploadResult(result); //업로드 결과 처리 함수 (하단)

          },
          error: function(xhr, status, error) {
              console.log("파일 업로드 실패:", xhr.responseText);
          }
        }); //$.ajax
    });
    
    
  	//게시물 첨부파일 불러오기
   // $(document).ready(function(){
   	  
   	  //(function(){
   		//const urlParams = new URLSearchParams(window.location.search);
   		//const bno = urlParams.get("bno");
   	    /////var bno = '<c:out value="${board.bno}"/>';
   	    //$.getJSON("/board/getAttachList", {bno: bno}, function(data){
   	    //	showUploadResult(data);
   		// }); // end getjson
    // })(); // end function
 // });
  	
  	
  	
function showUploadResult(uploadResultArr) {  
		console.log("파일 업로드 결과:", uploadResultArr);
    	if(!uploadResultArr || uploadResultArr.length == 0){ return; }
    	var uploadUL = $(".uploadResult ul");
   	    var str = "";
   	    
   	 		$(uploadResultArr).each(function(i, file){
   	 			
   	    	 console.log("file : " + file);
   	    	 str += "<li data-path='"+file.uploadPath+"' data-uuid='"+file.uuid+"' data-filename='"+file.fileName+"' data-type='"+file.fileType+"' ><div>";
   	    	
   	         if(file.fileType){//image type
   	           	var fileCallPath =  encodeURIComponent(file.uploadPath+ "/s_"+file.uuid +"_"+file.fileName);
 				str += "<div class='upper'>"
 				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
 				str += "<img src='/display?fileName="+fileCallPath+"' style='width:20px; height:20px;'>";
 				str += "<span> "+ file.fileName+"</span></div>";
   	         } else {  //일반 file
   	        	var fileCallPath =  encodeURIComponent( file.uploadPath+"/"+ file.uuid +"_"+file.fileName);			      
   			    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
   			    str += "<div class='upper'>"
   				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
   				str += "<img src='/resources/img/attach.png' style='width:20px; height:20px;'>";
   				str += "<span> "+ file.fileName+"</span></div>";
   	         }
   	         
   	         str += "<hr style='margin-top: 10px; margin-bottom: 10px;'></div></li>";
   	       });
   	       
   	       uploadUL.append(str);
   	       
}

$(".uploadResult").on("click", "button", function(e){
	    
        console.log("delete file");
          
        var targetFile = $(this).data("file");
        var type = $(this).data("type");
        var targetLi = $(this).closest("li");
        
        targetLi.remove(); // 화면에서만 지움 (실제로 서버에서 지우지 않음)
});
</script>