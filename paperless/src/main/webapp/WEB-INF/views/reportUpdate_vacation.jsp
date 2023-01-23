<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/report_common.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title> 휴가원 </title>
        
        <script>
	        $(function(){
	    		$("[name=reportListForm]").find(".report_code").val(4);
	    		
	    		var start_date = "${requestScope.reportDTO.start_date}";
				var end_date = "${requestScope.reportDTO.end_date}";
				var start_day = start_date.substr(0,10); 
				var end_day = end_date.substr(0,10); 
				var start_time = start_date.substr(11,);
				var end_time = end_date.substr(11,);
				
				$(".start_day").val(start_day);
				$(".end_day").val(end_day);
				$(".start_time").val(start_time);
				$(".end_time").val(end_time);
				$("[name=type_code]").each(function(){
					if($(this).val() == ${requestScope.reportDTO.type_code}) {
						$(this).prop("checked", true);
					}
				});
				
				<c:if test="${requestScope.reportDTO.resignation_cnt == 0 or requestScope.nextEmpNo != requestScope.employeeDTO.emp_no}">
					$(".next_emp_no").val(${requestScope.nextEmpNo});
				</c:if>
				
				$("[name=reportUpForm]").find(".next_emp_no").change(function(){
					var selectObj = $(this);
					var choicedVal = selectObj.val();
					var approval_line = "";
					
					<c:forEach var="superior" items="${requestScope.superior_List}">
	            		if(choicedVal == ${superior.emp_no}){
	            			approval_line = approval_line + "${superior.line_no}";
	            		}
	            	</c:forEach>
	            	$(".approval_line").val(approval_line);
				});
	    	});
			
	        function goReportUp(){
				var formObj = $('[name=reportUpForm]');
				var start_day = formObj.find($(".start_day")).val();	
				var end_day = formObj.find($(".end_day")).val();	
				var start_time = formObj.find($(".start_time")).val();
				var end_time = formObj.find($(".end_time")).val();
				
				var start_date = start_day + " " + start_time;
				var end_date = end_day + " " + end_time;
				
				formObj.find($("[name=start_date]")).val(start_date);
				formObj.find($("[name=end_date]")).val(end_date);
				formObj.find($("[name=approval_code]")).val(${requestScope.reportDTO.approval_code});
				
				var check = checkValue(4);
				if(check == 1) return;
				
				if(confirm("보고서 수정하시겠습니까?") == false) return;
				
				$.ajax({
					url:"/reportUpProc.do"
					, type:"post"
					, data:$("[name=reportUpForm]").serialize()
					, success:function(regCnt){
						if(regCnt == 1){
							alert("보고서 수정 완료");
							document.reportListForm.submit();
						}
						else{
							alert(regCnt);
						}
					}
				});
			}
			
			function goReApproval(){
				var formObj = $('[name=reportUpForm]');
				var start_day = formObj.find($(".start_day")).val();	
				var end_day = formObj.find($(".end_day")).val();	
				var start_time = formObj.find($(".start_time")).val();
				var end_time = formObj.find($(".end_time")).val();
				
				var start_date = start_day + " " + start_time;
				var end_date = end_day + " " + end_time;
				
				formObj.find($("[name=start_date]")).val(start_date);
				formObj.find($("[name=end_date]")).val(end_date);
				formObj.find($("[name=approval_code]")).val(2);
								
				if(confirm("보고서 재결재 올리시겠습니까?") == false) return;
				
				
				$.ajax({
					url:"/reportReApprovalProc.do"
					, type:"post"
					, data:$("[name=reportUpForm]").serialize()
					, success:function(regCnt){
						if(regCnt == 1){
							alert("보고서 재결재 올리기 완료");
							document.reportListForm.submit();
						}
						else{
							alert(regCnt);
						}
					}
				});
			}
		</script>
    </head>
    <body>
        <div class="container">
        	<form name="reportUpForm" method="post" action="">
        		<div class="report_type">
	                <b>휴가원 수정</b>
	            </div>
	            
				<table>
					<tr>
						<th>성 명</th>
						<td>${requestScope.employeeDTO.emp_name}</td>
						
						<th>직 급</th>
						<td>${requestScope.employeeDTO.jikup_name}</td>
						<th>연락처</th>
						<td>${requestScope.employeeDTO.phone_num}</td>
					</tr>
					<tr>
						<th>구 분</th>
						<td colspan="3">
							<input type="radio" name="type_code" value="401">연차
							<input type="radio" name="type_code" value="402">반차
							<input type="radio" name="type_code" value="403">병가
							<input type="radio" name="type_code" value="404">경조사
							<input type="radio" name="type_code" value="405">기타
						</td>
						<th>다음 결재자</th>
	                    <td style="min-width: 70px;">
	                        <select name="next_emp_no" class="next_emp_no">
	                        	<option value="">----------</option>
	                        	<c:forEach var="superior" items="${requestScope.superior_List}">
	                        		<option value="${superior.emp_no}">${superior.name} ${superior.jikup}</option>
	                        	</c:forEach>
	                        </select>
	                        <input type="hidden" name="approval_line" class="approval_line" value="${requestScope.reportDTO.approval_line}">
	                    </td>
					</tr>
					<tr>
						<th>일 시</th>  
						<td colspan="5">
							<input type="date" class="start_day"> <input type="time" class="start_time">
							~
							<input type="date" class="end_day"> <input type="time" class="end_time">
						</td>
					</tr>
					<tr>
						<th>사 유</th>
						<td colspan="5">
							<textarea name="content" class="content" cols="70" rows="5"></textarea>
						</td>
					</tr>
					<tr> 
						<td colspan="6" style="text-align: center;">
							<p>위와 같은 사유로 인하여 휴가를 신청하오니 허가하여 주시기 바랍니다.</p>
							<br><br>
							<p class="today"></p>
							<br><br>
							<p class="right">신청자 : ${requestScope.employeeDTO.emp_name}</p>
							<br><br>
							<h2>${requestScope.employeeDTO.company_name}</h2>
						</td>
					</tr>
				</table>
				<input type="hidden" name="company_code" value="${requestScope.reportDTO.company_code}">
	            <input type="hidden" name="r_no" value="${requestScope.reportDTO.r_no}">
				<input type="hidden" name="report_no" value="${requestScope.reportDTO.report_no}">
				<input type="hidden" name="report_code" value="4"><!--보고서종류코드-->
	            <input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}"><!--작성사원코드-->
	            <input type="hidden" name="title" value="휴가원">
	            <input type="hidden" name="approval_code" value="1">
	            <input type="hidden" name="resignation_cnt" value="${requestScope.reportDTO.resignation_cnt}">
	            <input type="hidden" name="start_date" value="">
	            <input type="hidden" name="end_date" value="">
	        </form><!-- reportRegForm -->
	        
	        <br>
			<div class="button_div">
				<input type="button" value="수정" onClick="goReportUp()">
				<c:if test="${requestScope.reportDTO.resignation_cnt > 0
							and requestScope.nextEmpNo == requestScope.employeeDTO.emp_no}">
					<input type="button" value="재결재" onClick="goReApproval()">
				</c:if>
				<input type="button" value="목록" onClick="goReportList()">
				<input type="button" value="초기화" onClick="reset()">
			</div>
        </div><!-- container -->
    </body>
</html>