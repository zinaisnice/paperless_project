<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- JSP 페이지에서 사용할 [사용자 정의 태그]의 한 종류인 [JSTL의 C 코어 태그]를 사용하겠다고 선언 -->
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="/js/jquery-1.11.0.min.js"></script>
<link href="/css/common.css" rel="stylesheet">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet">


<script>
	$(function(){
		$(".emp_img").error(function(){
			$(".emp_img").attr("src", "/img/basic.jpg");
		});
		
		var today = new Date();
		var today_year = today.getFullYear();
		var today_month = today.getMonth() + 1;
		var today_date = today.getDate();
		
		today_year = (today_year < 10)? '0' + today_year : today_year;
		today_month = (today_month < 10)? '0' + today_month : today_month;
		today_date = (today_date < 10)? '0' + today_date : today_date;
		var today_day = today_year + "-" + today_month + "-" + today_date;
		var today_day2 = today_year + "년  " + today_month + "월  " + today_date + "일";
		
    	$(".today").append(today_day2);
    	$(".date_today").val(today_day);
    	
    	var yearObj = $(".year");
		var monthObj = $(".month");
		
		yearObj.append(addOption(today_year - 20, 1, today_year));
		monthObj.append(addOption(1, 1, 12));
	});
	
	var reportFormObj = $("[name=reportListForm]");
	<c:if test="${!empty param.selectPageNo}">
		reportFormObj.find(".selectPageNo").val("${param.selectPageNo}");
	</c:if>
	<c:if test="${!empty param.rowCntPerPage}">
		reportFormObj.find(".rowCntPerPage").val("${param.rowCntPerPage}");
	</c:if>
	
	<c:if test="${!empty param.report_code}">
		reportFormObj.find(".report_code").val("${param.report_code}");
	</c:if>
	<c:forEach var="xxx" items="${paramValues.type}">
		SearchreportFormObj.find(".type").filter("[value='${xxx}']").prop("checked", true);
	</c:forEach>
	
	<c:forEach var="xxx" items="${paramValues.approval}">
		SearchreportFormObj.find(".approval").filter("[value='${xxx}']").prop("checked", true);
	</c:forEach>
	
	<c:if test="${!empty param.report_code}">
		reportFormObj.find(".report_code").val("${param.report_code}");
	</c:if>
	
	
	
	var dashboardFormObj = $("[name=dashboardForm]");
	<c:if test="${!empty param.approvalCnt_year}">
		dashboardFormObj.find(".approvalCnt_year").val("${param.approvalCnt_year}");
	</c:if>
	
	<c:if test="${!empty param.approvalState_report_type}">
		dashboardFormObj.find(".approvalState_report_type").val("${param.approvalState_report_type}");
	</c:if>
	
	<c:if test="${!empty param.approvalState_year}">
		dashboardFormObj.find(".approvalState_year").val("${param.approvalState_year}");
	</c:if>
	
	<c:if test="${!empty param.approvalState_month}">
		dashboardFormObj.find(".approvalState_month").val("${param.approvalState_month}");
	</c:if>

	<c:if test="${!empty param.typeNo_report_type}">
		dashboardFormObj.find(".typeNo_report_type").val("${param.typeNo_report_type}");
	</c:if>
	
	<c:if test="${!empty param.typeNo_year}">
		dashboardFormObj.find(".typeNo_year").val("${param.typeNo_year}");
	</c:if>
	
	function goReportList(){
		document.reportListForm.submit();
	}
	
	function goNoticeList(){
		document.noticeListForm.submit();
	}
	
	function goEmployeeList(){
		document.employeeListForm.submit();
	}
	
	function reset(){
		// 보고서 부분 초기화
		$(".title").val("");
		$(".type_code").val("");
		$(".next_emp_no").val("");
		$(".content").val("");
		$(".date_today").val("");
		$(".start_time").val("");
		$(".end_time").val("");
		$(".expense_date").val("");
		$(".cost").val("");
		$(".method_code").val("");
		$(".receipt_no").val("");
		$(".note").val("");
		$(".sales_content").val("");
		$(".sales_result").val("");
		$(".sales_company").val("");
		$(".sales_name").val("");
		$(".sales_jikup").val("");
		$(".sales_phone").val("");
		
		// 검색 부분 초기화
		$("[name=min_year]").val("");
		$("[name=min_month]").val("");
		$("[name=max_year]").val("");
		$("[name=max_month]").val("");
		$("[name^=keyword]").val("");
		$(".date").prop("checked", false);
		$(".type").prop("checked", false);
		$(".approval").prop("checked", false);
	}
	
	function addOption(start, add, end){
		var option = "<option value=''>------</option>";
		
		for(var i = start; i <= end; i += add){
			if(i < 10) option += "<option value='0" + i + "'>0" + i + "</option>";
			else option += "<option value='" + i + "'>" + i + "</option>";
		}
		
		return option;
	}
</script>

<form name="dashboardForm" method="post" action="/dashBoard.do">
	<input type="hidden" name="approvalCnt_year" class="approvalCnt_year" value="2022">
	<input type="hidden" name="approvalState_reportCode" class="approvalState_reportCode" value="1">
	<input type="hidden" name="approvalState_year" class="approvalState_year " value="2022">
	<input type="hidden" name="approvalState_month" class="approvalState_month" value="12">
	<input type="hidden" name="typeNo_reportCode" class="typeNo_report_type" value="1">
	<input type="hidden" name="typeNo_year" class="typeNo_year" value="2022">
</form>

<form name="reportListForm" method="post" action="/reportList.do">
	<%@include file="/WEB-INF/views/moveData.jsp" %>
</form>

<form name="noticeListForm" method="post" action="/noticeList.do">
	<%@include file="/WEB-INF/views/moveData.jsp" %>
</form>
<form name="plannerListForm" method="post" action="/plannerList.do">
	<%@include file="/WEB-INF/views/moveData.jsp" %>
</form>
<form name="employeeListForm" method="post" action="/employeeList.do">
	<%@include file="/WEB-INF/views/moveData.jsp" %>
</form>