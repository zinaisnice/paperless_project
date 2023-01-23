<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div style="display: none;">
	<input type="hidden" name="report_code" class="report_code" value="1">
	<input type="hidden" name="keyword" class="keyword" value="${param.keyword}">
	<input type="hidden" name="keyword1" class="keyword1" value="${param.keyword1}">
	<input type="hidden" name="keyword2" class="keyword2" value="${param.keyword2}">
	<input type="hidden" name="min_year" class="min_year" value="${param.min_year}" placeholder="min_year">
	<input type="hidden" name="min_month" class="min_month" value="${param.min_month}" placeholder="min_month">
	<input type="hidden" name="max_year" class="max_year" value="${param.max_year}" placeholder="max_year">
	<input type="hidden" name="max_month" class="max_month" value="${param.max_month}" placeholder="max_month">
	<input type="hidden" name="selectPageNo" class="selectPageNo" value="1"> <!-- 클릭한 페이지 번호 -->
	<input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="10"><!-- 한 화면에 보여지는 게시판 개수 -->
	
	
	<c:forEach var="xxx" items="${paramValues.date}">
		<input type="checkbox" name="date" class="date" value="${xxx}" checked>
	</c:forEach>
	
	<c:forEach var="xxx" items="${paramValues.type}">
		<input type="checkbox" name="type" class="type" value="${xxx}" checked>
	</c:forEach>
	
	<c:forEach var="xxx" items="${paramValues.approval}">
		<input type="checkbox" name="approval" class="approval" value="${xxx}" checked>
	</c:forEach>
	
</div>
