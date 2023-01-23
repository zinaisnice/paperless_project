<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/report_common.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>지출보고서 수정</title> 
        
        <script>
	        $(function(){
	        	$("[name=reportListForm]").find(".report_code").val(2);
	    		
	    		var expense_date = "${requestScope.reportDTO.expense_date}";
	    		expense_date = expense_date.substr(0,10);
	    		
	    		$(".expense_date").val(expense_date);
	    		$(".type_code").val(${requestScope.reportDTO.type_code});
	    		$(".method_code").val(${requestScope.reportDTO.method_code});
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
				formObj.find($("[name=approval_code]")).val(${requestScope.reportDTO.approval_code});
				
				var check = checkValue(2);
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
				var formObj = $('[name=reportUpForm]')
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
	                <b>지출 보고서 수정</b><br>
	                <span style="font-size: 10pt;"></span>
	            </div>
	            
	            <div class="emp_info right" style="font-size: 10pt;">
				    <span class="today"></span><br>
				    소속부서 : <span class="dept">${requestScope.employeeDTO.dept_name}</span><br>
				    <b><span class="emp">${requestScope.employeeDTO.emp_name}</span> <span class="jikup">${requestScope.employeeDTO.jikup_name}</span></b>
				</div>
				
		        <table>
					<tr> 
						<th>제목</th>
						<td><input type="text" name="title" class="title" value="${requestScope.reportDTO.title}"></td>
					</tr>
					<tr>
						<th>결제내역</th>
						<td style="height: 200px;"> 
							<table>
								<tr>
									<th>구분</th> <!-- 분야가 아니라 구분으로 변경-->
									<th>비용</th>
									<th>수단</th>
									<th>영수증번호</th>
									<th>지출일</th>
									<th>비고</th>
								</tr>
								<tr>
									<td style="padding: 5px;"><!-- 구분 -->
										<select name="type_code" class="type_code">    <!-- value 값 수정 -->
											<option value="">--------</option> 
											<option value="201">식대</option>
											<option value="202">회식</option>
											<option value="203">접대</option>
											<option value="204">비품</option>
											<option value="205">기자재</option>
											<option value="206">사무</option>
											<option value="207">교통</option>
											<option value="208">경조사</option>
											<option value="209">숙박</option>
											<option value="210">의류</option>
											<option value="211">도서</option>
											<option value="212">홍보</option>
											<option value="213">기타</option>
										</select> 
									</td>
									<td style="padding: 5px;"> <!-- 비용, 3자리 마다 , 찍히기 -->
										<input type="text" name="cost" size="8" value="${requestScope.reportDTO.cost}"> 원 
									</td>
									<td style="padding: 5px;"><!-- 지출 수단 -->
										<select name="method_code" class="method_code">
											<option value="">--------</option>
											<option value="1">회사카드</option>
											<option value="2">회사현금</option>
											<option value="3">개인카드</option>
											<option value="4">개인현금</option>
										</select>
									</td>
									<td style="padding: 5px;"><!-- 영수증번호 -->
										<input type="text" name="receipt_no" class="receipt_no" size="5" value="${requestScope.reportDTO.receipt_no}">
									</td>
									<td style="padding: 5px;"><!-- 지출일 -->
										<input type="date" name="expense_date" class="expense_date">
									</td>
									<td style="padding: 5px;"><!-- 비고 -->
										<input type="text" name="note" class="note" size="8" value="${requestScope.reportDTO.note}">
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<th>다음 결재자</th>  <!-- Q. 결재 책임자 한 명? -->
						<td> &nbsp;
							<select name="next_emp_no" class="next_emp_no">
								<option value="">----------</option>
	                        	<c:forEach var="superior" items="${requestScope.superior_List}">
	                        		<option value="${superior.emp_no}">${superior.name} ${superior.jikup}</option>
	                        	</c:forEach>
	                        </select>
	                        <input type="hidden" name="approval_line" class="approval_line" value="${requestScope.reportDTO.approval_line}">
						</td>
					</tr>
				</table>
				<input type="hidden" name="company_code" value="${requestScope.reportDTO.company_code}">
	            <input type="hidden" name="r_no" value="${requestScope.reportDTO.r_no}">
				<input type="hidden" name="report_no" value="${requestScope.reportDTO.report_no}">
				<input type="hidden" name="report_code" value="2"><!--보고서종류코드-->
	            <input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}"><!--작성사원코드-->
	            <input type="hidden" name="approval_code" value="1">
	            <input type="hidden" name="resignation_cnt" value="${requestScope.reportDTO.resignation_cnt}">
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