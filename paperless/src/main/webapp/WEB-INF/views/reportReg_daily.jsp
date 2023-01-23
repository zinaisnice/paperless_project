<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/report_common.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>일일보고서 등록</title>
        
		<script>
			$(function(){
				$("[name=reportListForm]").find(".report_code").val(1);
				
				$("[name=reportRegForm]").find(".next_emp_no").change(function(){
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
			
			function goReportReg(){
				var today = $(".date_today").val();				
				var start_time = $(".start_time").val();
				var end_time = $(".end_time").val();
				var start_date = today + " " + start_time;
				var end_date = today + " " + end_time;
				
				$("[name=start_date]").val(start_date);
				$("[name=end_date]").val(end_date);
				
				var check = checkValue(1);
				if(check == 1) return;
				
				if(confirm("보고서 등록하시겠습니까?") == false) return;
				
				$.ajax({
					url:"/reportRegProc.do"
					, type:"post"
					, data:$("[name=reportRegForm]").serialize()
					, success:function(regCnt){
						if(regCnt == 1){
							alert("보고서 등록 완료");
							document.reportListForm.submit();
						}
						else{
							alert(regCnt);
						}
					}
					, error:function(){
						alert("웹 서버 접속 실패");
					}
				});
			}
		</script>
    </head>
    <body>
        <div class="container">
	        <form name="reportRegForm" method="post" action="">
	            <div class="report_type">
	                <b>일일 보고서 등록</b><br>
	                <span style="font-size: 10pt;">DAILY WORK LOG</span>
	            </div>
	            
	            <div class="emp_info right" style="font-size: 10pt;">
				    <span class="today"></span><br>
				    소속부서 : <span class="dept">${requestScope.employeeDTO.dept_name}</span><br>
				    <b><span class="emp">${requestScope.employeeDTO.emp_name}</span> <span class="jikup">${requestScope.employeeDTO.jikup_name}</span></b>
				</div>
				
	            <table>
	                <tr>
	                	<th>제목</th>
	                	<td colspan="3"><input type="text" name="title" class="title" value=""></td>
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
	                        <select name="next_emp_no" class="next_emp_no">
	                        	<option value="">----------</option>
	                        	<c:forEach var="superior" items="${requestScope.superior_List}">
	                        		<option value="${superior.emp_no}">${superior.name} ${superior.jikup}</option>
	                        	</c:forEach>
	                        </select>
	                        <input type="hidden" name="approval_line" class="approval_line">
	                    </td>
	                </tr>
	                <tr>
	                    <th>업무 내용</th>
	                    <td colspan="3">
	                        <textarea name="content" class="content" rows="15" cols="70" maxlength="500"></textarea>
	                    </td>
	                </tr>
	                <tr>
	                    <th>시간</th>
	                    <td colspan="3">
	                    	<input type="date" class="date_today">
	                        <input type="time" class="start_time"> ~ <input type="time" class="end_time"> <!-- value="00:00" -->
	                    </td>
	                </tr>
	            </table>
	            <input type="hidden" name="company_code" value="${requestScope.employeeDTO.company_code}">
	            <input type="hidden" name="report_code" value="1"><!--보고서종류코드-->
	            <input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}"><!--작성사원코드-->
	            <input type="hidden" name="approval_code" value="1">
	            <input type="hidden" name="resignation_cnt" value="0">
	            <input type="hidden" name="start_date" value="">
	            <input type="hidden" name="end_date" value="">
			</form><!-- reportRegForm -->
			
			
			<br>	
			<div class="button_div">
				<input type="button" value="등록" onClick="goReportReg()">
				<input type="button" value="목록" onClick="goReportList()">
				<input type="button" value="초기화"  onClick="reset()">
			</div>
        </div><!-- container -->
    </body>
</html>