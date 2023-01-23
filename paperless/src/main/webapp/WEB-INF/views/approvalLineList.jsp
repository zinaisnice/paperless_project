<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/mainCatagory.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>결재라인</title>
		
		<script>
		$(function(){
			$("#manager_li").addClass("focusCatagory");
		});
		
		function goApprovalLineReg(){
			location.replace("/ApprovalLineAdd.do");
		}
		</script>
	</head>
	<body>
		<div class="container" style="width: 880px;">
			<h2>결재 라인 관리</h2>
			
			<table>
				<c:forEach var="lineNo" items="${requestScope.ApprovalLineNo}">
				<tr>
					<th rowspan="${lineNo.line_person + 1}" style="width: 80px;"> ${lineNo.line_no} </th>
					<th style="width: 80px;">순서</th>
					<th style="width: 100px;">사원명</th>
					<th style="width: 100px;">직급</th>
					<th style="width: 100px;">부서</th>
					<th style="width: 150px;">전화번호</th>
				</tr>
					<c:forEach var="lineInfo" items="${requestScope.ApprovalLineInfo}" varStatus="loopTagStatus">
						<c:if test="${lineNo.line_no == lineInfo.line_no}">
							<tr>
								<td>${lineInfo.order_no}</td>
								<td>${lineInfo.emp_name}</td>
								<td>${lineInfo.jikup}</td>
								<td>${lineInfo.dept}</td>
								<td>${lineInfo.phone_num}</td>
							</tr>
						</c:if>
					</c:forEach>
				</c:forEach>
			</table>
			
			<div class="button_div">
				<input type="button" value="결재라인 추가" onClick="goApprovalLineReg()">
			</div>
		</div><!-- container -->
	</body>
</html>