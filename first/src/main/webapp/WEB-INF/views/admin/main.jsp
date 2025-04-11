<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- jstl의 출력을 적용할 수 있는 태그 라이브러리 -->
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- jstl의 포맷을 적용할 수 있는 태그 라이브러리 -->
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %> <!-- 시큐리티 -->
    
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<%@include file="/WEB-INF/views/admin/adminHeader.jsp" %>

<style>
.datepicker-days td.day,
.datepicker-days th {
  text-align: center !important;
  vertical-align: middle;
}

.datepicker {
  font-family: 'Helvetica', 'Arial', sans-serif;
  font-size: 13px;
  z-index: 1050 !important; /* 모달보다 위에 보이도록 */
}

/* 📌 날짜 셀: 정렬, 간격 */
.datepicker-days table {
  table-layout: fixed;
  border-collapse: collapse;
}
.datepicker-days th,
.datepicker-days td.day {
  width: 36px;
  height: 36px;
  text-align: center;
  vertical-align: middle;
  padding: 0;
  box-sizing: border-box;
}

/* 📌 요일 스타일 */
.datepicker-days th {
  font-weight: bold;
  color: #555;
}

/* 📌 날짜 hover 효과 */
.datepicker-days td.day:hover {
  background-color: #f0f8ff;
  border-radius: 4px;
  box-shadow: inset 0 0 4px rgba(0,0,0,0.1);
  cursor: pointer;
  transition: all 0.2s ease-in-out;
}

/* 📌 오늘 날짜 표시 */
.datepicker-days td.today {
  background-color: #d9edf7 !important;
  border-radius: 4px;
  color: #31708f !important;
  font-weight: bold;
}

/* 📌 선택된 날짜 */
.datepicker-days td.active,
.datepicker-days td.active:hover {
  background-color: #337ab7 !important;
  color: white !important;
  font-weight: bold;
  border-radius: 4px;
}

/* 📌 비활성 날짜 (예: 지난 달 or 다음 달) */
.datepicker-days td.old,
.datepicker-days td.new {
  color: #ccc;
}

/* 📌 비활성 날짜2 (설정된 날짜) */
.datepicker-days td.disabled,
.datepicker-days td.disabled:hover {
  color: #ccc !important;           /* 연한 회색 텍스트 */
  background-color: #f9f9f9 !important; /* hover 방지 */
  cursor: not-allowed;
  pointer-events: none;
}

/* 📌 네비게이션 화살표 hover */
.datepicker .prev:hover,
.datepicker .next:hover {
  background-color: #eee;
  cursor: pointer;
}
</style>

<!-- 위에 회원수, 게시글수, 댓글수, 방문자수 기록  -->           
<!-- 1. 회원별 활동 : 아이디, 성별, 나이, 게시글수, 댓글수, 로그인횟수 // 아이디, 성별, 나이별로 조회 가능하도록-->
<!-- 1. 게시글별 현황 : bno, 조회수, 좋아요수, 댓글수 -->
<!-- 3. 일자별 현황 : 신규회원, 로그인수  -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default" style="width:100%;">
                        <div class="panel-heading" style="font-weight:bold; height: 50px; display: flex; align-items: center;">
                            <i class="fa fa-bar-chart-o fa-fw" style="margin-right:10px;"></i> 회원 분석
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        
                        <div class="row" style="overflow: hidden;">
                        	<div style="width:49%;float:left;margin-left:2%;">
                        		<div style="font-weight:bold; margin-bottom:5px;">
                        			<i class="fa fa-user"></i> 나이대별 통계
                        		</div>
    							<div style="margin-bottom:20px; display: flex; justify-content: center; align-items: center;">
      								<canvas id="myChart-age"></canvas>
    							</div>
    						</div>
    						<div style="width:49%;float:right;">
    							<div style="font-weight:bold; margin-bottom:5px;">
    								<i class="fa fa-user"></i> 성별 통계
    							</div>
    							<div style="margin-bottom:20px; display: flex; justify-content: center; align-items: center;">
      								<canvas id="myChart-gender"></canvas>
    							</div>
    						</div>
  						</div>
                        
                                      <!-- 나이대별 -->
                                      <div class="table-responsive" style="width:49%; float:left">
                                        <table class="table table-bordered table-hover table-striped" style="table-layout: fixed;">
                                            
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center;">나이대</th>
                                                    <th style="text-align: center;">회원 수</th>
                                                    <th style="text-align: center;">비율</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:choose>
        										<c:when test="${empty age}">
            										<tr>
                										<td colspan="6" style="text-align: center; color: gray; padding: 20px;">회원이 존재하지 않습니다.</td>
            										</tr>
        										</c:when>
        										<c:otherwise>    
                                					<c:forEach items="${age}" var="age">
                                						<tr>
                                							<td style="text-align: center;"><c:out value="${age.age}"/></td>
                                							<td style="text-align: center;"><c:out value="${age.count}"/></td>
                                							<td style="text-align: center;"><c:out value="${age.ratio}%" /></td>
                                							
                                						</tr>
                                					</c:forEach>
                                				</c:otherwise>
                             				</c:choose>
                             				</tbody>
                                         </table>
                                      </div>
                                      <!-- 성별 별 -->
                            	<div class="table-responsive" style="width:49%; float:right">
                                        <table class="table table-bordered table-hover table-striped" style="table-layout: fixed;">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center;">성별</th>
                                                    <th style="text-align: center;">회원 수</th>
                                                    <th style="text-align: center;">비율</th>
                                                </tr>
                                            </thead>
                                            <c:choose>
        										<c:when test="${empty gender}">
            										<tr>
                										<td colspan="6" style="text-align: center; color: gray; padding: 20px;">회원이 존재하지 않습니다.</td>
            										</tr>
        										</c:when>
        										<c:otherwise>    
                                					<c:forEach items="${gender}" var="gender">
                                						<tr>
                                							<td style="text-align: center;">
                                								<c:choose> 
                                									<c:when test="${gender.gender==1}">남성</c:when> 
                                									<c:when test="${gender.gender==2}">여성</c:when>
                                									<c:otherwise>미입력</c:otherwise> 
                                								</c:choose> 
                                							</td>
                                							<td style="text-align: center;"><c:out value="${gender.count}"/></td>
                                							<td style="text-align: center;"><c:out value="${gender.ratio}%" /></td>
                                							
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
                    
                    <div class="panel panel-default" style="width:49%;float:left;">
                        <div class="panel-heading" style="font-weight:bold; height: 50px; display: flex; align-items: center; justify-content: space-between;">
                            <div style="display: flex; align-items: center;">
                            	<i class="fa fa-bar-chart-o fa-fw" style="margin-right:10px;"></i> 회원별 활동 통계
                            </div>	
                            <div class="input-group" style="width:200px; display:flex; vertical-align: middle; margin-left:10px;">
     							<input type="text" id="searchmember" class="searchmember form-control" placeholder="회원 아이디">
     							<button class="btn btn-default" type="button" id="btn-member-search" style="display: flex; align-items: center; justify-content: center;">
     							<i class="fa fa-search" style="vertical-align: middle;"></i></button>
							</div>
 
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        			<div class="table-responsive">
                                        <table class="table table-bordered table-hover table-striped">
                                        	<tbody>
                                        		<tr>
                                        			<th style="width:20%; text-align: center;">검색 대상</th>
                                        			<th style="width:80%; text-align: center; font-weight:normal; background-color:white;" id="searched-id">아이디를 입력해주세요.</th>
                                        		</tr>
                                        	</body>
                                        </table>
                                        
                                        <table class="table table-bordered table-hover table-striped" style="table-layout: fixed;">
                                            <div style="font-weight:bold; margin-bottom:5px;"> <i class="fa fa-search"></i> 게시글 활동</div>
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center; width:20%;">글 번호</th>
                                                    <th style="text-align: center; width:50%;">게시글</th>
                                                    <th style="text-align: center; width:30%;">게시일자</th>
                                                </tr>
                                            </thead>
                                            <tbody class="boardListResult">
                             				</tbody>
                                         </table>
                                         
                                         <table class="table table-bordered table-hover table-striped" style="table-layout: fixed;">
                                        <div style="font-weight:bold; margin-bottom:5px;"> <i class="fa fa-search"></i> 댓글 활동</div>
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center; width:20%;">댓글번호</th>
                                                    <th style="text-align: center; width:50%;">댓글</th>
                                                    <th style="text-align: center; width:30%;">댓글일자</th>
                                                </tr>
                                            </thead>
                                            <tbody class="replyListResult">
                             				</tbody>
                                         </table>
                                      </div>
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                    
                    
                    
                    <div class="panel panel-default" style="width:49%;float:left;margin-left:2%;">
                        <div class="panel-heading" style="font-weight:bold; height: 50px;">
                        
                        	<div style="display: flex; align-items: center; justify-content: space-between; width: 100%;">
                        	
                        		<div><i class="fa fa-bar-chart-o fa-fw" style="margin-right:10px;"></i> 기간별 활동 통계</div>
                        		
                            	<div style="display: flex; align-items: center; justify-content:flex-end; width: 60%;">
                            	<!-- <input type="text" id="datePicker" class="form-control" value="2022-12-15"> -->
                             	<div class="input-group" style="width:150px; display:flex; vertical-align: middle;  margin-right:10px;">
     								<input type="text" id="startDate" class="form-control datepicker startDate" placeholder="시작 일자">
     								<span class="input-group-addon" style="display: flex; align-items: center; justify-content: center;"><i class="fa fa-calendar-check-o" style="vertical-align: middle;"></i></span>
								</div>
								
								<span> ~ </span>
								
								<div class="input-group" style="width:150px; display:flex; vertical-align: middle; margin-left:10px;">
     								<input type="text" id="endDate" class="form-control datepicker endDate" placeholder="끝 일자">
     								<span class="input-group-addon" style="display: flex; align-items: center; justify-content: center;"><i class="fa fa-calendar-check-o" style="vertical-align: middle;"></i></span>
								</div>
								<button type="button" id="btn-search" class="btn btn-secondary btn-search" style="margin-left:10px; border-color:gray; font-weight:bold;">검색</button>
								</div>
								
							</div>
							
                            <!-- <div class="pull-right">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                                        Actions
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu pull-right" role="menu">
                                        <li><a href="#">Action</a>
                                        </li>
                                        <li><a href="#">Another action</a>
                                        </li>
                                        <li><a href="#">Something else here</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li><a href="#">Separated link</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>  -->
                            
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-12">
                                	
                        		<!-- 차트 -->
                        		<div style="margin-bottom:20px; display: flex; justify-content: center; align-items: center;">
      									<canvas id="myChart-duration" height="300"></canvas>
    							</div>
    							
    							<!-- 표 -->
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-hover table-striped" style="table-layout: fixed;">
                                            <thead>
                                                <tr>
                                                    <th style="text-align: center;">일자</th>
                                                    <th style="text-align: center;">신규회원</th>
                                                    <th style="text-align: center;">게시글</th>
                                                    <th style="text-align: center;">댓글</th>
                                                </tr>
                                            </thead>
                                            <tbody class="searchTableBody">
                                                <!-- "<c:choose><c:when test="${empty result}"><tr>";
                								+= "<td colspan="6" style="text-align: center; color: gray; padding: 20px;">기록이 존재하지 않습니다.</td>";
            									+= "</tr></c:when><c:otherwise>";
            									+= "<c:forEach items="${result}" var="result"><tr>";
                                				+= "<td style="text-align: center;"><c:out value="${result.date}"/></td>";
                                				+= "<td style="text-align: center;"><c:out value="${result.join}"/></td>";
                                				+= "<td style="text-align: center;"><c:out value="${result.board}"/></td>";
                                				+= "<td style="text-align: center;"><c:out value="${result.reply}"/></td>";
                                				+= "</tr></c:forEach></c:otherwise></c:choose>"; -->
                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- /.table-responsive -->
                                </div>
                                <!-- /.col-lg-4 (nested) -->
                            </div>
                            <!-- /.row -->
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

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

    <script>
    // 10대이하 ~60대 이상
    const ageLabels = [
        <c:forEach var="item" items="${age}" varStatus="status">
            "${item.age}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
	//실제 값
    const ageCounts = [
        <c:forEach var="item" items="${age}" varStatus="status">
            ${item.count}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    
    
        var ctx = document.getElementById("myChart-age").getContext("2d");
        var myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ageLabels,
                datasets: [{
                    label: '회원 수',
                    data: ageCounts,
                    backgroundColor: ["#d9ed92", "#99d98c", "#52b69a", "#168aad", "#1e6091", "#184e77"]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom', // ← 범례를 아래로
                        labels: {
                       	   usePointStyle: true,
                           pointStyle: 'circle'
                        }
                    }
                }
            }
        });
    </script>
    
    <script>
 	// 남성 여성
    const genderLabels = [
    <c:forEach var="item" items="${gender}" varStatus="status">
        "${item.gender == 1 ? '남성' : item.gender == 2 ? '여성' : '미입력'}"<c:if test="${!status.last}">,</c:if>
    </c:forEach>
	];
	//실제 값
    const genderCounts = [
        <c:forEach var="item" items="${gender}" varStatus="status">
            ${item.count}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
	
        var ctx = document.getElementById("myChart-gender").getContext("2d");
        var myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: genderLabels,
                datasets: [{
                    label: '회원 수',
                    data: genderCounts,
                    backgroundColor: ["#2a9d8f", "#e76f51"]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom', // ← 범례를 아래로
                        labels: {
                            usePointStyle: true,
                            pointStyle: 'circle'
                        }
                    }
                }
            }
        });
    </script>


<script>
$(function(){
	const today = new Date(); // 오늘 날짜
	today.setHours(0, 0, 0, 0);
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setHours(0, 0, 0, 0);
    sevenDaysAgo.setDate(today.getDate() - 10); // 10일 전
    console.log("today:" + today);
    console.log("ago:" + sevenDaysAgo);
    const minDate = new Date('2025-03-11'); // 선택 가능한 최소일자

    // 시작일자 datepicker 설정
    $('.startDate').datepicker({
        startDate: minDate,
        endDate: today,
        todayHighlight: true,
        autoclose: true,
        format: "yyyy-mm-dd",
        language: "ko"
    }).datepicker('update', sevenDaysAgo); // 기본값 적용

    // 종료일자 datepicker 설정
    $('.endDate').datepicker({
        startDate: minDate,
        endDate: today,
        todayHighlight: true,
        autoclose: true,
        format: "yyyy-mm-dd",
        language: "ko"
    }).datepicker('update', today); // 기본값 적용
    
    
  	//페이지 진입 시
    $('.btn-search').click();
});


//기간 검색 버튼 클릭 시
$(document).on("click", ".btn-search", function() {
	 //event.preventDefault();
	 console.log("통계 기간 검색 중 ... ");
	 
	 var startDate = $('.startDate').val();
	 var endDate = $('.endDate').val();
	 
	 console.log("시작일자:", startDate);
	 console.log("끝일자:", endDate);
	 
	 if (startDate === null || startDate.length < 1) {
		 $('.datepicker').datepicker("setStartDate", "2025-03-11");
		 return;
	 }
	 
	 if (endDate === null || endDate.length < 1) {
		 $('.datepicker').datepicker("setEndDate", new Date());
		 return;
	 }
	 
	 $.ajax({
       url: "/admin/searchDuration",  
       method: "post",
       contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       data: { startDate:startDate, endDate:endDate },
       success: function(result) {
    	   //표 작업
           console.log('시작일 설정완료 : ' + startDate);
           console.log('종료일 설정완료 : ' + endDate);
           console.log('서버응답 : ' + result);
           
           let str = "";

           if (result.length === 0) {
               str += '<tr>';
               str += '<td colspan="6" style="text-align: center; color: gray; padding: 20px;">기록이 존재하지 않습니다.</td>';
               str += '</tr>';
           } else {
               result.forEach(function(item) {
                   str += '<tr>';
                   str += '<td style="text-align: center;">' + item.day + '</td>';
                   str += '<td style="text-align: center;">' + item.newjoin + '</td>';
                   str += '<td style="text-align: center;">' + item.board + '</td>';
                   str += '<td style="text-align: center;">' + item.reply + '</td>';
                   str += '</tr>';
               });
           }

           $(".searchTableBody").html(str);
           
           //차트 작업
				const trimmedResult = result.slice(0, -1); // 마지막 요소 제거
        	    const labels = trimmedResult.map(item => item.day); // <-- X축 라벨
        	    const newJoinData = trimmedResult.map(item => item.newjoin);
        	    const boardData = trimmedResult.map(item => item.board);
        	    const replyData = trimmedResult.map(item => item.reply);

        	    const ctx = document.getElementById("myChart-duration").getContext("2d");
        	    if (window.myLineChart) window.myLineChart.destroy();

        	    window.myLineChart = new Chart(ctx, {
        	        type: 'line',
        	        data: {
        	            labels: labels, // 여기가 x축
        	            datasets: [
        	                {
        	                    label: '신규 가입자',
        	                    data: newJoinData,
        	                    borderColor: '#e76f51',
        	                    backgroundColor: '#e76f51',
        	                    tension: 0.3,
        	                },
        	                {
        	                    label: '게시글 수',
        	                    data: boardData,
        	                    borderColor: '#e9c46a',
        	                    backgroundColor: '#e9c46a',
        	                    tension: 0.3
        	                },
        	                {
        	                    label: '댓글 수',
        	                    data: replyData,
        	                    borderColor: '#264653',
        	                    backgroundColor: '#264653',
        	                    tension: 0.3
        	                }
        	            ]
        	        },
        	        options: {
        	            responsive: true,
        	            maintainAspectRatio: false,
        	            plugins: {
        	                legend: {
        	                    position: 'bottom',
        	                    labels: {
        	                      	   usePointStyle: true,
        	                           pointStyle: 'circle'
        	                    }
        	                }
        	            },
        	            scales: {
        	                y: {
        	                    beginAtZero: true,
        	                    ticks: {
        	                        stepSize: 1
        	                    }
        	                }
        	            }
        	        }
        	    });
       },
       error: function(xhr, status, error) {
           console.error("기간 검색 요청 실패:", status, error);
       }
	 });
});


//회원 검색 버튼 클릭 시
$(document).on("click", "#btn-member-search", function() {
	 //event.preventDefault();
	 console.log("회원 활동 검색 중 ... ");
	 
	 var memberid = $('.searchmember').val();
	 
	 console.log("검색할 회원:", memberid);
	 
	 $.ajax({
       url: "/admin/searchById",  
       method: "post",
       contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       data: { memberid:memberid },
       success: function(result) {
           console.log("Board List", result.boardList);
           console.log("Reply List", result.replyList);
           
           let str = "";
           let strr = "";
           
			//BoardList
           if (!result.boardList || result.boardList.length === 0) {
               str += '<tr>';
               str += '<td colspan="6" style="text-align: center; color: gray; padding: 20px;">기록이 존재하지 않습니다.</td>';
               str += '</tr>';
           } else {
               result.boardList.forEach(function(item) {

                   
                   let timestamp = item.boardDate;
                   let date = new Date(timestamp);
                   
                   str += '<tr>';
                   str += '<td style="text-align: center;">' + item.bno + '</td>';
                   str += '<td style="text-align: center;">'
                   str += '<a href="/board/get?bno=' + item.bno +'&page=1" style="color: inherit;">' + item.title + '</a></td>';
                   str += '<td style="text-align: center;">' + date.toLocaleString() + '</td>';
                   str += '</tr>';
               });
           }
			
           if (!result.replyList || result.replyList.length === 0) {
               strr += '<tr>';
               strr += '<td colspan="6" style="text-align: center; color: gray; padding: 20px;">기록이 존재하지 않습니다.</td>';
               strr += '</tr>';
           } else {
               result.replyList.forEach(function(item) {
            	   
                   let timestamp = item.replyDate;
                   let date = new Date(timestamp);
                   
                   strr += '<tr>';
                   strr += '<td style="text-align: center;">' + item.rno + '</td>';
                   strr += '<td style="text-align: center;">'
                   strr += '<a href="/board/get?bno=' + item.bno +'&page=1" style="color: inherit;">' + item.reply + '</a></td>';
                   strr += '<td style="text-align: center;">' + date.toLocaleString() + '</td>';
                   strr += '</tr>';
               });
           }

           $(".boardListResult").html(str);
           $(".replyListResult").html(strr);
           $("#searched-id").html(memberid);
       },
       error: function(xhr, status, error) {
           console.error("회원 검색 요청 실패:", status, error);
       }
	 });
});
</script>
