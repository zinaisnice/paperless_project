<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/report_common.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>일일보고서 수정</title>
        
		<script>
			$(function(){
				
				$("[name=reportListForm]").find(".report_code").val(1);
				
				var start_time = "${requestScope.reportDTO.start_date}";
				var end_time = "${requestScope.reportDTO.end_date}";
				var report_date = start_time.substr(0,10); 
				start_time =  start_time.substr(11,);
				end_time =  end_time.substr(11,);
				
				$(".type_code").val("${requestScope.reportDTO.type_code}");
				$(".report_date").val(report_date);
				$(".start_time").val(start_time);
				$(".end_time").val(end_time);
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
				var report_date = formObj.find($(".report_date")).val();				
				var start_time = formObj.find($(".start_time")).val();
				var end_time = formObj.find($(".end_time")).val();
				
				var start_date = report_date + " " + start_time;
				var end_date = report_date + " " + end_time;
				
				formObj.find($("[name=start_date]")).val(start_date);
				formObj.find($("[name=end_date]")).val(end_date);
				formObj.find($("[name=approval_code]")).val(${requestScope.reportDTO.approval_code});
				
				var check = checkValue(1);
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
				var report_date = formObj.find($(".report_date")).val();				
				var start_time = formObj.find($(".start_time")).val();
				var end_time = formObj.find($(".end_time")).val();
				
				var start_date = report_date + " " + start_time;
				var end_date = report_date + " " + end_time;
				
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
	                <b>일일 보고서 수정</b><br>
	                <span style="font-size: 10pt;">DAILY WORK LOG</span>
	            </div>
	            
	            <div class="emp_info right" style="font-size: 10pt;">
				    <span class="today"></span><br>
				    소속부서 : <span class="dept">${requestScope.reportDTO.dept_name}</span><br>
				    <b><span class="emp">${requestScope.reportDTO.emp_name}</span> <span class="jikup">${requestScope.reportDTO.jikup_name}</span></b>
				</div>
				
	            <table>
	                <tr>
	                	<th>제목</th>
	                	<td colspan="3"><input type="text" name="title" class="title" value="${requestScope.reportDTO.title}"></td>
	                </tr>
	                <tr>
	                    <th>업무 구분</th>
	                    <td style="min-width: 70px;">
	                        <select name="type_code" class="type_code">
	                        	<option value="">----</option>
	                        	<option value="101">행정</option>
	                        	<option value="102">사무</option>
	                        	<option value="103">구매</option>
	                        	<option value="104">접대</option>
	                        	<option value="105">회계</option>
	                        	<option value="106">기타</option>
	                        </select>
	                    </td>
	                    <th>다음 결재자</th>
	                    <td style="min-width: 70px;">
	                    	<c:if test="${requestScope.reportDTO.resignation_cnt != 0 }">
	                    		${requestScope.superior.name} ${requestScope.superior.jikup}
	                    		<input type="hidden" name="next_emp_no" value="${requestScope.superior.emp_no}">
	                    	</c:if>
	                    	
							<c:if test="${requestScope.reportDTO.resignation_cnt == 0 }">
		                        <select name="next_emp_no" class="next_emp_no">
		                        	<option value="">----------</option>
			                        	<c:forEach var="superior" items="${requestScope.superior_List}">
			                        		<option value="${superior.emp_no}">${superior.name} ${superior.jikup}</option>
			                        	</c:forEach>
		                        	
		                        </select>
		                        <input type="hidden" name="approval_line" class="approval_line" value="${requestScope.reportDTO.approval_line}">
	                        </c:if>
	                    </td>
	                </tr>
	                <tr>
	                    <th>업무 내용</th>
	                    <td colspan="3">
	                        <textarea name="content" class="content" rows="15" cols="70" maxlength="500">${requestScope.reportDTO.content}</textarea>
	                    </td>
	                </tr>
	                <tr>
	                    <th>시간</th>
	                    <td colspan="3">
	                    	<input type="date" class="report_date">
	                        <input type="time" class="start_time"> ~ <input type="time" class="end_time"> <!-- value="00:00" -->
	                    </td>
	                </tr>
	            </table>
	            <input type="hidden" name="company_code" value="${requestScope.reportDTO.company_code}">
	            <input type="hidden" name="r_no" value="${requestScope.reportDTO.r_no}">
	            <input type="hidden" name="report_no" value="${requestScope.reportDTO.report_no}">
	            <input type="hidden" name="report_code" value="1"><!--보고서종류코드-->
	            <input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}"><!--작성사원코드-->
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