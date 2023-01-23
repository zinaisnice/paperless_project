<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/report_common.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>보고서</title>
		
        <script>
	        $(function(){
				$("[name=reportListForm]").find(".report_code").val(3);
				
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
				var start_day = $(".start_day").val();
				var end_day = $(".end_day").val();
				var start_time = $(".start_time").val();
				var end_time = $(".end_time").val();
				
				var start_date = start_day + " " + start_time;
				var end_date = end_day + " " + end_time;
				
				$("[name=start_date]").val(start_date);
				$("[name=end_date]").val(end_date);
				
				var check = checkValue(3);
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
				});
			}
		</script>
	</head>
	<body>
		<div class="container">
			<form name="reportRegForm" method="post" action="">
				<div class="report_type">
	                <b>영업 보고서 등록</b><br>
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
						<th>구분</th>
						<td>
							<select name="type_code" class="type_code">
								<option value="">----------</option>
								<option value="301">영업자관리</option>
								<option value="302">수금</option>
								<option value="303">회의</option>
								<option value="304">거래처확보</option>
								<option value="305">기타</option>
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
						<th>만난 사람</th>
						<td colspan="3">
							<table>
								<tr>
									<th style="width: 100px;">회사이름</th>
									<th style="width: 100px;">이름</th>
									<th style="width: 100px;">직급</th>
									<th style="width: 100px;">전화번호</th>
								</tr>
								<tr>
									<td style="width: 100px; padding: 5px;"><input type="text" name="sales_company" class="sales_company" size="10" value=""></td>
									<td style="width: 100px; padding: 5px;"><input type="text" name="sales_name" class="sales_name" size="10" value=""></td>
									<td style="width: 100px; padding: 5px;"><input type="text" name="sales_jikup" class="sales_jikup" size="10" value=""></td>
									<td style="width: 100px; padding: 5px;"><input type="text" name="sales_phone" class="sales_phone" size="10" value=""></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<th>방문시간</th>
						<td colspan="3">
							<input type="date" class="start_day"> <input type="time" class="start_time">
							~
							<input type="date" class="end_day"> <input type="time" class="end_time">
						</td>
					</tr>
					<tr>
						<th>영업 내용</th>
						<td colspan="3">
							<textarea name="sales_content" class="sales_content" rows="15" cols="70" maxlength="500"></textarea>
						</td>
					</tr>
					<tr>
						<th>영업 성과</th>
						<td colspan="3">
							<textarea name="sales_result" class="sales_result" rows="15" cols="70" maxlength="500"></textarea>
						</td>
					</tr>
				</table>
				<input type="hidden" name="company_code" value="${requestScope.employeeDTO.company_code}">
				<input type="hidden" name="report_code" value="3"><!--보고서종류코드-->
	            <input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}"><!--작성사원코드-->
	            <input type="hidden" name="approval_code" value="1">
	            <input type="hidden" name="resignation_cnt" value="0">
	            <input type="hidden" name="start_date" value="">
	            <input type="hidden" name="end_date" value="">
			</form>
			
			
			<br>
			<div class="button_div">
				<input type="button" value="등록" onClick="goReportReg()">
				<input type="button" value="목록" onClick="goReportList()">
				<input type="button" value="초기화" onClick="reset()">
			</div>
		</div><!-- container -->
	</body>
</html>