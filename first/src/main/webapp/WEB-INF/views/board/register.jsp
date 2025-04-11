<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> <!-- 시큐리티 -->
    
<%@include file="../includes/header.jsp" %>

<style>
.text {
	font-size: 16px;
	font-weight: bold;
	gap: 1px;
}

.btn-circle {
    width: 15px;   /* 버튼 크기 줄이기 */
    height: 15px;
    padding: 2px;  /* 내부 여백 줄이기 */
    font-size: 8px; /* 아이콘 크기 줄이기 */
    line-height: 0.8;  /* 텍스트 높이 조절 */
}

.upper {
	display: flex;
	align-items: center;
	gap: 2px;
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
                	<form role="form" action="/board/register" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                
                    <ul class="list-group">
  						<li class="list-group-item list-group-item-warning">
                            <span class="text">새 글 등록하기</span>
                        </li>
  						<li class="list-group-item">
                                        <div class="form-group">
                                            <label>제목</label>
                                            <input class="form-control" name='title' placeholder="제목을 작성하세요." required>
                                        </div>
                                        <div class="form-group">
                                            <label>내용</label>
                                            <textarea class="form-control" rows="7" name='content' placeholder="내용을 작성하세요." required></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label>글쓴이</label>
                                            <input class="form-control" name='writer'
                                            	value='<sec:authentication property="principal.username"/>' readonly="readonly">
                                        </div>
                        </li>
                        <li class="list-group-item list-group-item-warning">
                            <span class="text">첨부파일 등록</span>
                            <div class="uploadDiv">
    							<input type="file" id="file" name="uploadFile" multiple> <!-- input이 변경되는 것을 감지 -->
							</div>
                        </li>
                        <li class="list-group-item">
                            <div class="uploadResult">
                            	<ul> <!-- 동적추가 -->
                            	</ul>
    						</div>
                        </li>
                        <li class="list-group-item">
                            <button type="submit" class="btn btn-warning">등록</button>
                            <button type="button" class="btn btn-default" onclick="location.href='../board/list'">목록</button>
                        </li>
                        
                        <!-- /.list-group-item -->
                    </ul>
                    </form>
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
	      console.log("파일 정보:", jobj.data("filename"), jobj.data("uuid"), jobj.data("path"));
	      
	      console.dir(jobj);
	      console.log("-------------------------");
	      console.log(jobj.data("filename"));
	      
	      
	      str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
	      str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
	      
	    });
	    
	    console.log(str);
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
		  showUploadResult(result); //업로드 결과 처리 함수 

      },
      error: function(xhr, status, error) {
          console.log("파일 업로드 실패:", xhr.responseText); // ← 오류 메시지 확인
      }
    }); //$.ajax
});

function showUploadResult(uploadResultArr){
	console.log("파일 업로드 결과:", uploadResultArr)
    
    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
    
    var uploadUL = $(".uploadResult ul");
    
    var str ="";
    
    $(uploadResultArr).each(function(i, obj){
    	console.log("obj : " + obj);
    	
		if(obj.fileType){
			var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
			str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"' ><div>";
			str += "<div class='upper'>"
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/display?fileName="+fileCallPath+"' style='width:20px; height:20px;'>";
			str += "<span> "+ obj.fileName+"</span></div><hr style='margin-top: 10px; margin-bottom: 10px;'/>";
			str += "</div></li>";
		}else{
			var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
		    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
		      
			str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"' ><div>";
			str += "<div class='upper'>"
			str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='/resources/img/attach.png' style='width:20px; height:20px;'></a>";
			str += "<span> "+ obj.fileName+"</span></div><hr style='margin-top: 10px; margin-bottom: 10px;'/>";
			str += "</div></li>";
		}

    });
    
    uploadUL.append(str);
}

$(".uploadResult").on("click", "button", function(e){
	    
    console.log("delete file");
      
    var targetFile = $(this).data("file");
    var type = $(this).data("type");
    
    var targetLi = $(this).closest("li");
    
    $.ajax({
      url: '/deleteFile',
      data: {fileName: targetFile, type:type},
      beforeSend: function(xhr) {
          xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
      },

      dataType:'text',
      type: 'POST',
        success: function(result){
           alert(result);
           
           targetLi.remove();
         }
    }); //$.ajax  
});








</script>