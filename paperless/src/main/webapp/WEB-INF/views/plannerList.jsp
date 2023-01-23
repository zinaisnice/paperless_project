<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/mainCatagory.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Calendar</title>
		
		<!-- bootstrap 4 -->
	    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

	
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

	    
	    
		<!-- fullcalendar css -->
		<script src="/js/main.js"></script>
		<script src='/js/ko.js'></script>
		<link href='/css/main.css' rel='stylesheet'>
		
		
		<script>
		$(function(){
			$("#planner_li").addClass("focusCatagory");
		});
		
		document.addEventListener('DOMContentLoaded', function(){

			var calendarEl = document.getElementById('calendar');
			
			// 캘린더 생성시 몇가지 옵션 주기
			var calendar = new FullCalendar.Calendar(calendarEl, {
				
				// 초기 로드 될 때 보이는 캘린더 화면 ( 초기설정: 달)
				initialView: 'dayGridMonth' 
				
				// 일정 추가 버튼
				, customButtons: {	
				    myCustomButton: {
				      text: '일정 추가',
				      click: function() {
				        $("#addPlanModal").modal("show");
				      }
				    }
				  } // customButtons
				
				  
				// 헤더 부분에 표시할 툴 바 left,cendter,right 구조 정의
				, headerToolbar: {
					// 가장 왼쪽에 '< > 오늘' 버튼 배치 & myCustomButton 버튼 추가
					left: 'prev,next today myCustomButton'
					//  중간에 title 배치 
					, center: 'title'
					// 오른쪽엔 dayGridMonth형태, week 형태, day 형태 버튼 배치
					, right: 'dayGridMonth,timeGridWeek,timeGridDay'
				}
				  
				  
				//시작시간, 끝나는 시간 다 보이게 하기
				, displayEventEnd: {
		            month: false
		            , basicWeek: true
		            , "default": true
	        	}
				
				//일정이 너무 많으면 more버튼으로 일정확인
				, dayMaxEventRows: true 
				
				// 현재 시간 마크
				, nowIndicator: true 
				
				// 한국어로 나오게하는 옵션달기
				, locale: 'ko'	
				
				// 수정가능 여부 주기
				, editable: true	
						
				, events : [ 
							<c:forEach var="plan" items="${requestScope.planList}" varStatus="loopTagStatus">
							  { 
								id   : '${plan.plan_no}'
							    , title: '${plan.plan_name}'
							    , start:  '${plan.plan_start_date}'
							    , end :   '${plan.plan_end_date}' 
							  },
							</c:forEach>
				         	]	

				
				// 캘린더 내부 이벤트(등록된 일정) 클릭시 발생 이벤트
				, eventClick : function(eventClickInfo){	
							
					var formObj = $("[name='planForm']");		// updelPlanForm 객체 얻기
					var thisEvent = eventClickInfo.event;			// 이벤트 객체 얻기 	
					var plan_no = thisEvent.id;					// PLAN_NO 
					var plan_name = thisEvent.title;			// PLAN_NAME
					var start = thisEvent.start;	// PLAN_START_DATE
					var end = thisEvent.end;			// PLAN_END_DATE
					start = start.toLocaleString("ko-kr");
					end = end.toLocaleString("ko-kr");
					
					//-----------------updelPlanModal의 hidden태그에 값 넣기 
					formObj.find("#plan_no").val(plan_no);
					formObj.find("#plan_name").val(plan_name);
					formObj.find("#plan_start_date").val(start);
					formObj.find("#plan_end_date").val(end);
					//------------------------------------------------
					
					/* 값 잘 들어갔나 확인
					console.log(formObj.find("#PLAN_NO").val() )
					console.log(formObj.find("#PLAN_NAME").val())
					console.log(formObj.find("#PLAN_START_DATE").val()  )
					console.log(formObj.find("#PLAN_END_DATE").val() )
					*/
					
					//------------------------- 모달 화면에 해당 일정 내용 넣어주기
					$("#title").html(plan_name);
					$("#start").html(start);
					$("#end").html(end);
					//---------------------------------------
					
					$("#infoPlanModal").modal("show");		
				}
				, selectable: true // 달력일자 드래그 설정 가능
				, select: function(arg) {	// 캘린더에서 드래그시 이벤트 발생
						
					var formObj = $("[name=addPlanForm]");
					var start = new Date(arg.start);
					var end = new Date(arg.end);
					
					var start_month= (start.getMonth() < 10)? "0" + (start.getMonth() + 1) : (start.getMonth() + 1);
					var start_date= (start.getDate() < 10)? "0" + start.getDate() : start.getDate();
					var start_day = start.getFullYear() + "-" + start_month + "-" + start_date;
					
					var end_month= (end.getMonth() < 10)? "0" + (end.getMonth() + 1) : (end.getMonth() + 1);
					var end_date= (end.getDate() < 10)? "0" + end.getDate() : end.getDate();
					var end_day = end.getFullYear() + "-" + end_month + "-" + end_date;
					
					var start_Hour = (start.getHours() < 10)? "0" + start.getHours() : start.getHours();
					var start_Minute = (start.getMinutes() < 10)? "0" + start.getMinutes() : start.getMinutes();
					var start_Second = (start.getSeconds() < 10)? "0" + start.getSeconds() : start.getSeconds();
					var start_time = start_Hour + ":" + start_Minute + ":" + start_Second;
					
					var end_Hour = (end.getHours() < 10)? "0" + end.getHours() : end.getHours();
					var end_Minute = (end.getMinutes() < 10)? "0" + end.getMinutes() : end.getMinutes();
					var end_Second = (end.getSeconds() < 10)? "0" + end.getSeconds() : end.getSeconds();
					var end_time = end_Hour + ":" + end_Minute + ":" + end_Second;
					
					
					formObj.find("#start_day").val(start_day);
					formObj.find("#end_day").val(end_day);
					formObj.find("#start_time").val(start_time);
					formObj.find("#end_time").val(end_time);
					$("#addPlanModal").modal("show");
					
					$("#cancle").bind("click",function(){
						formObj.find("[name=plan_name]").val("");
						formObj.find("#start_day").val("");
						formObj.find("#end_day").val("");
						formObj.find("#start_time").val("");
						formObj.find("#end_time").val(""); 
					})		 
				}	// 드래그 이벤트 종료
				
				
				, eventChange: function(arg){
					var formObj = $("[name=updatePlanForm]");
					var thisEvent = arg.event; 	
					var plan_no = thisEvent.id; 
					var plan_name = thisEvent.title;
					var start = thisEvent.start;
					var end = thisEvent.end;
					
					start = start.toLocaleString("ko-kr");
					end = end.toLocaleString("ko-kr");
					
					formObj.find("#plan_no").val(plan_no);
					formObj.find("#plan_name").val(plan_name);
					formObj.find("#plan_start_date").val(start);
					formObj.find("#plan_end_date").val(end);
					
					if(confirm("일정 수정하시겠습니까?") == false) return;
					
					$.ajax({
						url : "/updatePlanProc.do"
						, type: "post"
						, data: $("[name=updatePlanForm]").serialize()
						, success: function(planUpCnt){
							if(planUpCnt == 1){
								alert("수정되었습니다. ")
								location.replace("/plannerList.do");
							}
							else{
								alert(planUpCnt);
							}
						}
						, error : function(){
							console.log("서버 접속 실패");
						}	
					});	
				}
			}); // FullCalendar.Calendar

			calendar.render();
			
			// 일정등록 모달창에서 추가 버튼 눌렀을 때
			$("#addCalendar").bind("click",function(){
				
				var formObj = $("[name=addPlanForm]");
				
				var plan_nameObj = formObj.find("[name=plan_name]");
				var plan_name = plan_nameObj.val();
				
				if( typeof(plan_name) != "string" ) plan_name = "";
				plan_name = $.trim(plan_name);
				plan_nameObj.val(plan_name);
				
				if( plan_name.length > 15 ){
					alert("일정 내용은 1~15자까지 입력 해야합니다.");
					if( confirm("15자까지 잘라내어 재 입력할까요?") ){
						plan_nameObj.val(plan_name.substring(0, 15));
					}else{
						plan_nameObj.val("");
					}
					return;
				}  
				else if(plan_name.length == 0 ){
					alert("일정 내용은 1~15자까지 입력 해야합니다.");
					return;
				}
				
				if( plan_name.toUpperCase().indexOf(("<script>").toUpperCase()) >= 0 ){
					alert("일정 내용에 <script>  는 사용할 수 없습니다.");
					plan_nameObj.val("");
					return;
				}
				
				
				var start_day = formObj.find("#start_day").val();
				var end_day = formObj.find("#end_day").val();
				var start_time = formObj.find("#start_time").val();
				var end_time = formObj.find("#end_time").val();
				
				if(start_day == ""){
					alert("시작 날짜를 선택해주세요.");
					return;
				}
				
				if(start_time == ""){
					alert("시작 시간을 선택해주세요.");
					return;
				}
				
				if(end_day == ""){
					alert("종료 날짜를 선택해주세요.");
					return;
				}
				
				if(end_time == ""){
					alert("종료 시간을 선택해주세요.");
					return;
				}
				
				var start_date = start_day + " " + start_time;
				var end_date = end_day + " " + end_time;
				
				if(start_date > end_date){
					alert("시작 날짜보다 종료날짜가 빠르면 안됩니다.");
					formObj.find("#end_day").val("");
					formObj.find("#end_time").val("");
					return;
				}
				
				$("[name=plan_start_date]").val(start_date);
				$("[name=plan_end_date]").val(end_date);
				
				
				if(confirm("일정 등록하시겠습니까?") == false) return;
				
				$.ajax({
					url: "/planRegProc.do"
					, type: "post"
					, data: $("[name=addPlanForm]").serialize()
					, success: function(planRegCnt){
						if(planRegCnt == 1){
						alert("일정이 등록되었습니다")
						location.replace("/plannerList.do");
					} else {
						alert("일정 등록 실패하였습니다. (" + json["msg"] + ")");
					}
				
				}
				,error:function(){
					alert("에이잭스 통신 실패");
				}
				
				}); // ajax
			
			}); // ("#addCalendar").bind("click")
				
			
			$("#deletePlan").bind("click",function(){
				
				if(confirm("삭제하시겠습니까?") == false) return;
				
				$.ajax({
					url : "/delPlanProc.do"
					, type : "post"
					, data: $("[name=planForm]").serialize()
					, success: function(planDelCnt){
						if(planDelCnt == 1){
							alert("삭제되었습니다. ")
							location.replace("/plannerList.do");
						}
					}
					, error : function(){
						console.log("서버 접속 실패");
					}	
				});
			}); // ("#deletePlan").bind("click"
		}); //document.addEventListener
		
		</script>
	
	</head>
	<body>
	<div class="container" style="padding-top: 50px; width: 1000px;">
	
		<!-- 달력이 들어갈 자리 -->
		<div id='calendar'></div> 
		
		<form name="addPlanForm">
			<div class="modal fade" id="addPlanModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
					
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div><!-- modal-header -->
						
						
						<div class="modal-body">
							<div class="form-group">
								<label for="taskId" class="col-form-label">일정 내용</label>
								<input type="text" class="form-control"  name="plan_name">
								<label for="taskId" class="col-form-label">시작 날짜</label>
								<input type="date" class="form-control" id="start_day"><input type="time" class="form-control" id="start_time">
								<label for="taskId" class="col-form-label">종료 날짜</label>
								<input type="date" class="form-control" id="end_day"><input type="time" class="form-control" id="end_time">
							</div>
							<input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}">
							<input type="hidden" name="plan_start_date">
							<input type="hidden" name="plan_end_date">
						</div><!-- modal-body -->
						
						
						<div class="modal-footer">
							<button type="button" class="btn btn-warning" id="addCalendar">추가</button>
							<button type="button" class="btn btn-secondary" id="cancle" data-dismiss="modal" id="sprintSettingModalClose">취소</button>
						</div><!-- modal-footer -->
						
					</div><!-- modal-content -->
				</div><!-- modal-dialog -->
			</div><!-- addPlanModal -->
		</form><!-- addPlanForm -->
		
		
		
		
		<form name="planForm" >
			<div class="modal fade" id="infoPlanModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">일정 보기</h5>
							<button type="button" class="close" data-dismiss="modal" aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div><!-- modal-header -->
						
						
						<div class="modal-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th>일정 내용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td id="title"></td>
									</tr>
									<tr>
										<th>시작 날짜</th>
									</tr>
									<tr>
										<td id="start"></td>
									</tr>
									<tr>
										<th>종료 날짜</th>
									</tr>
									<tr>
										<td id="end"></td>
									</tr>
								</tbody>
							</table>
							<input type="hidden" id="plan_no" name="plan_no">
							<input type="hidden" id="plan_name" name="plan_name">
							<input type="hidden" id="plan_start_date" name="plan_start_date">
							<input type="hidden" id="plan_end_date" name="plan_end_date">
							<input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}">
						</div><!-- modal-body -->
						
						
						<div class="modal-footer">
							<button type="button" class="btn btn-warning" id="deletePlan"> 일정 삭제</button>
							<button type="button" class="btn btn-secondary"  data-dismiss="modal">취소</button>
						</div><!-- modal-footer -->
					</div><!-- modal-content -->
				</div><!-- modal-dialog -->
			</div><!-- updelPlanModal -->
		</form><!-- updelPlanForm -->
		
		<form name="updatePlanForm">
			<input type="hidden" id="plan_no" name="plan_no">
			<input type="hidden" id="plan_name" name="plan_name">
			<input type="hidden" id="plan_start_date" name="plan_start_date">
			<input type="hidden" id="plan_end_date" name="plan_end_date">
			<input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}">
		</form>
	</div><!-- container -->
	</body>
</html>