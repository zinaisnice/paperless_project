<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/report_common.jsp" %>
<%@include file="/WEB-INF/views/mainCatagory.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="/css/dashBoard.css" rel="stylesheet">
		
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
		<script>
		
			$(function(){
				$("#dashboard_li").addClass("focusCatagory");
				
				var formObj = $("[name=chartDataSearchForm]");
				
				<c:if test="${!empty param.approvalCnt_year}">
					formObj.find(".approvalCnt_year").val("${param.approvalCnt_year}");
				</c:if>
				
				<c:if test="${!empty param.approvalState_reportCode}">
					formObj.find(".approvalState_reportCode").val("${param.approvalState_reportCode}");
				</c:if>
			
				<c:if test="${!empty param.approvalState_year}">
					formObj.find(".approvalState_year").val("${param.approvalState_year}");
				</c:if>
				
				<c:if test="${!empty param.approvalState_month}">
					formObj.find(".approvalState_month").val("${param.approvalState_month}");
				</c:if>
				
				<c:if test="${!empty param.typeNo_reportCode}">
					formObj.find(".typeNo_reportCode").val("${param.typeNo_reportCode}");
				</c:if>
			
				<c:if test="${!empty param.typeNo_year}">
					formObj.find(".typeNo_year").val("${param.typeNo_year}");
				</c:if>
			});
			
			function goDashBoard(){
				document.chartDataSearchForm.submit();
			}
			
			function goReportApproval(r_no, report_code){ // 결재/반려 화면으로 이동
				var formObj = $("[name=reportApprovalForm]");
				
				formObj.find(".r_no").val(r_no);
				formObj.find(".report_code").val(report_code);
				document.reportApprovalForm.submit();
	         }
			
			google.charts.load('current', {'packages':['line']}); // 꺾은 선 그래프
			google.charts.load('current', {'packages':['bar']}); // 막대 그래프
			google.charts.load('current', {'packages':['corechart']}); // 원형 그래프
			
			
			// 년도별 결재 횟수
			google.charts.setOnLoadCallback(reportApprovalCnt);
			// 월별 결재 상태
	      	google.charts.setOnLoadCallback(reportApprovalState);
			// 항목별 갯수
	      	google.charts.setOnLoadCallback(reportTypeNo);
			
			
	     	// 년도별 결재 횟수 (꺾은 선 그래프)
			function reportApprovalCnt(){
				
				var data = new google.visualization.DataTable();
				
				data.addColumn('string');
				data.addColumn('number', '일일');
				data.addColumn('number', '지출');
			    data.addColumn('number', '영업');
			    
			    //var dataRow = [];
			    
			    data.addRows([
			    	<c:forEach var="Cnt" items="${requestScope.ApprovalCnt}">
	                	["${Cnt.month}", ${Cnt.daily}, ${Cnt.expense}, ${Cnt.sales}],
	                </c:forEach>
			    ]);
			    
			    var options = {
			    		fontsize: 15
			    		, width: 480
			    		, height: 340
			    		, colors: [
			    			"rgb(209,240,158)"
			    			, "#548687"
			    			, "#9DC8C8"
			    		]
			    		, vAxis: {
			    			title: '횟수'
			    		}
			    }
			    
			    var chart = new google.charts.Line(document.getElementById('reportApprovalCnt_div'));
			    chart.draw(data, google.charts.Line.convertOptions(options));
			}
	     	
	     	
	     	// 월별 결재 상태 (막대 그래프)
	     	function reportApprovalState(){
	     		
	     		var data = google.visualization.arrayToDataTable([
	     			["결재상태", "개수", { role: "style" }]
	     			<c:forEach var="state" items="${requestScope.ApprovalState}" varStatus="loopTagStatus">
                		, ["${state.approval_name}", ${state.cnt}, "rgb(" + (209 - ${loopTagStatus.index} * 50) + ", "
										                					+ (240 - ${loopTagStatus.index} * 35) + ","
										                					+ (158 - ${loopTagStatus.index} * 8) + ")"]
	                </c:forEach>
	     		]);
	     		
	     		var view = new google.visualization.DataView(data);
	     		view.setColumns([
	     			0
	     			, 1
	     			, {
	     				calc: "stringify"
	     				, sourceColumn: 1
	     				, type: "string"
	     				, role: "annotation"
	     			}
	     			, 2
	     		])
	     		
	     		var options = {
	     				fontsize: 15
			    		, width: 490
			    		, height: 340
			    		, legend: { position: "none" }
	     		};
	     		
	     		
	     		var chart = new google.visualization.BarChart(document.getElementById('reportApprovalState_div'));
	            chart.draw(view, options);
	     	}
	     	
	     	// 업무구분별 갯수 (원형 그래프)
	     	function reportTypeNo(){
	     		
	     		var data = new google.visualization.DataTable();
	            data.addColumn('string', 'Topping');
	            data.addColumn('number', 'Slices');
	            data.addRows([
	                <c:forEach var="typecode" items="${requestScope.TypeNo}">
	                	["${typecode.type_name}", ${typecode.cnt}],
	                </c:forEach>
	            ]);
	            
	     		var options = {
	     				fontsize: 15
			    		, width: 490
			    		, height: 340
			    		, colors: [
			    			"rgb(183,223,154)"
			    			, "rgb(158,205,150)"
			    			, "rgb(133,187,146)"
			    			, "rgb(108,170,142)"
			    			, "rgb(84,151,138)"
			    			, "rgb(59,134,134)"
			    			, "rgb(34,116,130)"
			    			, "rgb(10,100,126)"
			    		]
	     		};
	     		
	     		var chart = new google.visualization.PieChart(document.getElementById('reportTypeNo_chart_div'));
	            chart.draw(data, options);
	     	}
		</script>
	</head>
	<body>
		<div class="container" style="width: 1100px;">
		
		<form name="chartDataSearchForm" method="post" action="/dashBoard.do">
		
			<div class="report_table">
				<div class="chart">
					<div class="chart_title">
						<div class="chart_title_info">
							<span>보고서 작성 횟수</span>
						</div>
						<div class="chart_select">
							<select name="approvalCnt_year" class="approvalCnt_year year" onchange="goDashBoard()">
							</select>년
						</div>
					</div><!-- chart_title -->
					<div id="reportApprovalCnt_div"></div><!-- reportApprovalCnt_div -->
				</div><!-- chart -->
			</div><!-- report_table -->
			
			
			
			<div class="report_table">
				<div class="chart">
					<div class="chart_title">
						<div class="chart_title_info">
							<span>등록한 보고서 결재 상태</span>
						</div>
						<div class="chart_select">
							<select name="approvalState_year" class="approvalState_year year" onchange="goDashBoard()">
							</select>년
							
							<select name="approvalState_month" class="approvalState_month month" onchange="goDashBoard()">
							</select>월
							
							<select name="approvalState_reportCode" class="approvalState_reportCode" onchange="goDashBoard()">
								<option value="1">일일</option>
								<option value="2">지출</option>
								<option value="3">영업</option>
							</select>
						</div>
					</div><!-- chart_title -->
					
					<div id="reportApprovalState_div"></div><!-- reportApprovalCnt_div -->
				</div><!-- chart -->
			</div><!-- report_table -->
			
			
			
			<div class="report_table">
				<div class="chart">
					<div class="chart_title">
						<div class="chart_title_info">
							<span>등록한 보고서 업무별 개수</span>
						</div>
						<div class="chart_select">
							<select name="typeNo_year" class="typeNo_year year" onchange="goDashBoard()">
							</select>년
							
							<select name="typeNo_reportCode" class="typeNo_reportCode" onchange="goDashBoard()">
								<option value="1">일일</option>
								<option value="2">지출</option>
								<option value="3">영업</option>
							</select>
						</div>
					</div><!-- chart_title -->
					
					<div id="reportTypeNo_chart_div"></div><!-- reportApprovalCnt_div -->
				</div><!-- chart -->
			</div><!-- report_table -->
			
			
			<div class="report_table">
				<div class="chart">
					<div class="chart_title">
						<div class="chart_title_info">
							<span>보고서 결재 요청 목록</span>
						</div>
					</div><!-- chart_title -->
					<c:if test="${requestScope.approvalListSize == 0}">
						<div id="noApprovalList">
							<span>결재 요청 목록이 없습니다.</span>
						</div>
					</c:if>
					<c:if test="${requestScope.approvalListSize != 0}">
						<div id="approval_List">
							<c:forEach var="approval" items="${requestScope.approvalList}">
								<div class="approval_info pointer" onClick="goReportApproval(${approval.r_no}, ${approval.report_code})">
									<div class="approval_info_left"><img class="emp_img" alt="사원사진" src="/img/${approval.emp_img}"></div>
									<div class="approval_info_right">
										<span>
											${approval.dept_name} ${approval.emp_name} ${approval.jikup_name}의<br>
											${approval.report_name}<c:if test="${approval.report_code != 4}">보고서</c:if> 결재 요청이 있습니다.
										</span><br>
										<span>
											<jsp:useBean id="sysdate" class="java.util.Date" />
	                  
					                        <fmt:parseNumber var="sysdate_N" value="${sysdate.time / (1000*60*60)}"  integerOnly="true" />   <!--  sysdate (Tue Dec 13 00:00:00 KST 2022)를 n시간으로 숫자형으로 -->
					                        
					                        
					                        <fmt:parseDate var="approval_time_D"  value="${approval.approval_time}" pattern="yyyy-MM-dd HH:mm:ss"/>         <!-- start_date를 String에서 날짜형으로 (Tue Dec 13 00:00:00 KST 2022)-->
					                        
					                        <fmt:parseNumber var="approval_time_N" value="${approval_time_D.time / (1000*60*60)}" integerOnly="true" /> <!-- start_date를 n시간으로, 날짜형에서 숫자형으로 (19337) -->               
					               
					                        <c:set var="xxx" value="${ (sysdate_N - approval_time_N  )   }"/>          <!--  시간 구하기 -->
					                        <c:set var="xxx_Day" value="${ ( sysdate_N - approval_time_N  )/24 }"/>      <!--  일 수 구하기 -->
					                        
					                        <fmt:parseNumber var="xxx_N" value="${  xxx +(1-(xxx%1))%1}"  type="number" />      <!--  소수점 올림 과정 -->
					                        <fmt:parseNumber var="xxx_DayN" value="${  xxx_Day +(1-(xxx_Day%1))%1}"  type="number" />   
					                        
					                        
					                        <c:if test="${ xxx_N >= 24 && xxx_DayN ==1}">
					                            ${ xxx_DayN } 일 전 
					                        </c:if>
					                        
					                        <c:if test="${ xxx_N >= 24 && xxx_DayN >1}">
					                            ${ xxx_DayN-1 } 일 전 
					                        </c:if>
					                        
					                        <c:if test="${ xxx_N < 24 && xxx_N != 0 }">
					                          ${ xxx_N } 시간 전
					                        </c:if>
					                        
					                        <c:if test="${ xxx_N == 0 && xxx_N < 24}">
					                          방금
					                        </c:if>
											
										</span>
									</div>
								</div>
							</c:forEach>
						</div><!-- approval_List -->
					</c:if>
				</div><!-- chart -->
			</div><!-- report_table -->
			</form><!-- chartDataSearchForm -->
			
			
	<form name="reportApprovalForm" method="post" action="/reportApproval.do"> <!-- 결재/반려 하는 창으로 이동 -->
		<input type="hidden" name="company_code" class="company_code" value="${requestScope.employeeDTO.company_code}">
		<input type="hidden" name="r_no" class="r_no">
		<input type="hidden" name="report_code" class="report_code">
	</form>
		</div><!-- container -->
	</body>
</html>