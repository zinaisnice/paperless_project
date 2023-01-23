<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link href="/css/common.css" rel="stylesheet">
<link href="/css/mainCatagory.css" rel="stylesheet">

<script>
	function goDashboard(){
		document.dashboardForm.submit();
	}
	function goNoticeList(){
		location.replace("/noticeList.do");
	}
	
	function goReportList(report_code){
		reset();
		$("[name=reportListForm]").find(".report_code").val(report_code);
		document.reportListForm.submit();
	}
	
	function goPlannerList(){
		location.replace("/plannerList.do");
	}
	
	function goMyPage(){
		location.replace("/myPage.do");
	}
	
	function goEmployeeList(){
		location.replace("/employeeList.do");
	}
	
	function goApprovalLineList(){
		location.replace("/approvalLineList.do");
	}
	
	function logout(){
		if(confirm("로그아웃 하시겠습니까?") == false) return;
		location.replace("/loginout.do");
	}
	
</script>


<div class="mainCatagory">
	
	<ul class="main_ul">
		<li id="logo">
			<img alt="로고" src="/img/logo.jpg" style="width:100%;">
		</li>
		
		<li id="reportList">
			<span onclick="goReportList(1)">보고서결재</span>
			<ul class="sub_ul">
				<li>
					<span onclick="goReportList(1)">일일 보고서</span>
				</li>
				<li>
					<span onclick="goReportList(2)">지출 보고서</span>
				</li>
				<li>
					<span onclick="goReportList(3)">영업 보고서</span>
				</li>
				<li>
					<span onclick="goReportList(4)">휴가원</span>
				</li>
			</ul>
		</li>
		
		<li id="notice_li">
			<span onclick="goNoticeList()">공지사항</span>
		</li>
		
		<li id="dashboard_li">
			<span onclick="goDashboard()">대시보드</span>
		</li>
		      
		<li id="planner_li">
			<span onclick="goPlannerList()">일정관리</span>
		</li>
		
		<li id="mypage_li">
			<span onclick="goMyPage()">내정보</span>
		</li>
		
		<c:if test="${requestScope.employeeDTO.role == 'MANAGER'}">
		<li id="manager_li">
			<span onclick="">회사 관리</span>
			<ul class="sub_ul">
				<li>
					<span onclick="goEmployeeList()">직원 관리</span>
				</li>
				<li>
					<span onclick="goApprovalLineList()">결재 라인 관리</span>
				</li>
			</ul>
		</li>
		</c:if>
		<c:if test="${requestScope.employeeDTO.role == 'USER'}">
			<li id="user">
				<span></span>
			</li>
		</c:if>
		<li id="logout">
			<span onclick="logout()">
				${requestScope.employeeDTO.emp_name} ${requestScope.employeeDTO.dept_name}<br>
				로그아웃
			</span>
		</li>
	</ul>
</div><!-- mainCatagory -->

   <!-- 테이블 width="890px;" 로 하고 작업할것-->