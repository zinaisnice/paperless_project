<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/report_common.jsp" %>
<%@include file="/WEB-INF/views/mainCatagory.jsp" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>보고서</title>
      <script>
      $(function(){
    	 $("#reportList").addClass("focusCatagory");
    	  
         $(".reportRegBtn").bind("click", function(){
            document.reportRegForm.action="/reportRegForm.do";
            document.reportRegForm.submit();
         });
         
         $(".searchingResults").find("tr:eq(0)").nextAll().hover(
            <c:if test="${requestScope.reportTotCnt != 0}">
            function(){
               $(this).addClass("mouseOntrBgC");
            }
            , function(){
               $(this).removeClass("mouseOntrBgC");
            }
            </c:if>
         );
         
         var SearchformObj = $("[name=reportSearchForm]");
         
         <c:if test="${!empty param.report_code}">
            SearchformObj.find(".report_code").val("${param.report_code}");
         </c:if>
         
         <c:if test="${!empty param.min_year}">
            SearchformObj.find(".min_year").val("${param.min_year}").prop("checked", true);
         </c:if>
         
         <c:if test="${!empty param.min_month}">
            SearchformObj.find(".min_month").val("${param.min_month}").prop("checked", true);
         </c:if>
         
         <c:if test="${!empty param.max_year}">
            SearchformObj.find(".max_year").val("${param.max_year}").prop("checked", true);
         </c:if>
         
         <c:if test="${!empty param.max_month}">
            SearchformObj.find(".max_month").val("${param.max_month}").prop("checked", true);
         </c:if>
         
         <c:forEach var="xxx" items="${paramValues.type}">
            SearchformObj.find(".type").filter("[value='${xxx}']").prop("checked", true);
         </c:forEach>
         
         <c:forEach var="xxx" items="${paramValues.approval}">
            SearchformObj.find(".approval").filter("[value='${xxx}']").prop("checked", true);
         </c:forEach>
         
         <c:if test="${!empty param.keyword}">
            SearchformObj.find(".keyword").val("${param.keyword}");
         </c:if>
         
         
         <c:if test="${!empty param.rowCntPerPage}">
            SearchformObj.find(".rowCntPerPage").val("${param.rowCntPerPage}");
            $(".rowCntPerPage2").val("${param.rowCntPerPage}");
         </c:if>
         
         <c:if test="${!empty param.pageNoCntPerPage}">
            SearchformObj.find(".pageNoCntPerPage").val("${param.pageNoCntPerPage}");
         </c:if>
         
         <c:if test="${param.report_code == 1 or param.report_code == 0}">
            $("h2").text("일일 보고서");
            $("[name=reportRegForm]").find("[type=button]").val("일일 보고서 등록");
         </c:if>
         <c:if test="${param.report_code == 2}">
            
            $("h2").append("지출 보고서");
            $("[name=reportRegForm]").find("[type=button]").val("지출 보고서 등록");
         </c:if>
         <c:if test="${param.report_code == 3}">
            $("h2").append("영업 보고서");
            $("[name=reportRegForm]").find("[type=button]").val("영업 보고서 등록");
         </c:if>
         <c:if test="${param.report_code == 4}">
            $("h2").append("휴가원");
            $("[name=reportRegForm]").find("[type=button]").val("휴가원 등록");
         </c:if>
      
      }); // $(function(){})
      
      function reportSearch(){
         var formObj = $("[name=reportSearchForm]");
         
         var keyword = formObj.find(".keyword").val();
         if(typeof(keyword) != "string") keyword = "";
         keyword = $.trim(keyword);
         $(".keyword").val(keyword);
         
         var rowCntPerPage = $(".rowCntPerPage2").val();
         $(".rowCntPerPage").val(rowCntPerPage);
         
         document.reportSearchForm.submit();
      }
      
      function reportSearchAll(){
         reset();
         reportSearch();
      }
      
      function goReportDetailForm(r_no){
         $("[name=reportDetailForm] [name=r_no]").val(r_no);
         
         document.reportDetailForm.submit();
      }
      
      function pageNoBtn(pageNo){
         $("[name=selectPageNo]").val(pageNo);
         reportSearch();
      }
      
      function checkYMRange(){
         var formObj = $("[name=reportSearchForm]");
         var min_yearObj = formObj.find("[name=min_year]");
         var min_monthObj = formObj.find("[name=min_month]");
         var max_yearObj = formObj.find("[name=max_year]");
         var max_monthObj = formObj.find("[name=max_month]");
         
         var min_yearVal = min_yearObj.val();
         var min_monthVal = min_monthObj.val();
         var max_yearVal = max_yearObj.val();
         var max_monthVal = max_monthObj.val();
         
         if(min_yearVal == "" && min_monthVal != ""){
            alert("년도를 먼저 선택해주세요.");
            min_monthObj.val("");
            return;
         }
         
         if(max_yearVal == "" && max_monthVal != ""){
            alert("년도를 먼저 선택해주세요.");
            max_monthObj.val("");
            return;
         }
         
         if(min_yearVal != "" && min_monthVal == ""){
            min_monthObj.val("01").prop("selected", true);
            min_monthVal = "01";
         }
         
         if(max_yearVal != "" && max_monthVal == ""){
            max_monthObj.val("12").prop("selected", true);
            max_monthVal = "12";
         }
         
         
         if(min_yearVal != "" && min_monthVal != "" && max_yearVal != "" && max_monthVal != ""){
            if(min_yearVal + min_monthVal > max_yearVal + max_monthVal){
               alert("기간을 다시 설정해주세요.");
               max_yearObj.val("");
               max_monthObj.val("");
            }
         }
         
         var min_date = min_yearVal + min_monthVal + "01";
         var max_date = "";
         
         if(max_monthVal == 2) max_date += max_yearVal + max_monthVal + "28";
         if(max_monthVal == 1 || max_monthVal == 3 || max_monthVal == 5 || max_monthVal == 7 
               || max_monthVal == 8 || max_monthVal == 10 || max_monthVal == 12) max_date += max_yearVal + max_monthVal + "31";
         if(max_monthVal == 4 || max_monthVal == 6 || max_monthVal == 9 || max_monthVal == 11) max_date += max_yearVal + max_monthVal + "30";
         
         formObj.find(".min_date").val(min_date);
         formObj.find(".max_date").val(max_date);
         
      }
      </script>
   </head>
   <body>
      <div class="container">
         <h2 class="left"></h2>
         <form name="reportSearchForm" method="post" action="/reportList.do">
            <table class="searchTable" style="width: 700px;">
               <tr>
                  <th>업무일</th>
                  <td>
                     <span class="min_date">
                        <select name="min_year" class="year min_year" onChange="checkYMRange()"></select>년
                        <select name="min_month" class="month min_month" onChange="checkYMRange()"></select>월
                     </span>
                     ~
                     <span class="max_date">
                        <select name="max_year" class="year max_year" onChange="checkYMRange()"></select>년
                        <select name="max_month" class="month max_month" onChange="checkYMRange()"></select>월
                     </span>
                  </td>
               </tr>
               
               <tr>
                  <th>업무분야</th>
                  <td>
                     <c:if test="${param.report_code == 1}">
                        <input type="checkbox" name="type" class="type pointer" value="101">행정
                        <input type="checkbox" name="type" class="type pointer" value="102">사무
                        <input type="checkbox" name="type" class="type pointer" value="103">구매
                        <input type="checkbox" name="type" class="type pointer" value="104">접대
                        <input type="checkbox" name="type" class="type pointer" value="105">회계
                        <input type="checkbox" name="type" class="type pointer" value="106">기타
                     </c:if>
                     <c:if test="${param.report_code == 2}">
                        <input type="checkbox" name="type" class="type pointer" value="201">식대
                        <input type="checkbox" name="type" class="type pointer" value="202">회식
                        <input type="checkbox" name="type" class="type pointer" value="203">접대
                        <input type="checkbox" name="type" class="type pointer" value="204">비품
                        <input type="checkbox" name="type" class="type pointer" value="205">기자재
                        <input type="checkbox" name="type" class="type pointer" value="206">사무<br>
                        <input type="checkbox" name="type" class="type pointer" value="207">교통
                        <input type="checkbox" name="type" class="type pointer" value="208">경조사
                        <input type="checkbox" name="type" class="type pointer" value="209">숙박
                        <input type="checkbox" name="type" class="type pointer" value="210">의류
                        <input type="checkbox" name="type" class="type pointer" value="211">도서
                        <input type="checkbox" name="type" class="type pointer" value="212">홍보
                        <input type="checkbox" name="type" class="type pointer" value="213">기타
                     </c:if>
                     <c:if test="${param.report_code == 3}">
                        <input type="checkbox" name="type" class="type pointer" value="301">영업자관리
                        <input type="checkbox" name="type" class="type pointer" value="302">수금
                        <input type="checkbox" name="type" class="type pointer" value="303">회의
                        <input type="checkbox" name="type" class="type pointer" value="304">거래처확보
                        <input type="checkbox" name="type" class="type pointer" value="305">기타
                     </c:if>
                     <c:if test="${param.report_code == 4}">
                        <input type="checkbox" name="type" class="type pointer" value="401">연차
                        <input type="checkbox" name="type" class="type pointer" value="402">반차
                        <input type="checkbox" name="type" class="type pointer" value="403">병가
                        <input type="checkbox" name="type" class="type pointer" value="404">경조사
                        <input type="checkbox" name="type" class="type pointer" value="405">기타
                     </c:if>
                  </td>
               </tr>
               
               <tr>
                  <th>결재여부</th>
                  <td>
                     <input type="checkbox" name="approval" class="approval pointer" value="1">결재대기
                     <input type="checkbox" name="approval" class="approval pointer" value="2">결재완료
                     <input type="checkbox" name="approval" class="approval pointer" value="3">반려
                     <input type="checkbox" name="approval" class="approval pointer" value="4">최종결재
                  </td>
               </tr>
               
               <tr>
                  <th>키워드</th>
                  <td><input type="text" name="keyword" class="keyword" value=""></td>
               </tr>
            </table>
            <input type="hidden" name="report_code" class="report_code" value="1">
            <input type="hidden" name="selectPageNo" class="selectPageNo" value="1"> <!-- 클릭한 페이지 번호 -->
            <input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="10"><!-- 한 화면에 보여지는 게시판 개수 -->
            <input type="hidden" name="pageNoCntPerPage" class="pageNoCntPerPage" value="10"> <!-- 한 화면에 보여지는 페이지 번호의 개수 -->
            
            
            <div class="button_div">
               <input type="button" value="검색" class="reportSearchBtn" onClick="reportSearch()">
               <input type="button" value="모두검색" class="reportSearchAllBtn" onClick="reportSearchAll()">
               <input type="button" value="초기화" class="" onClick="reset()">
            </div>
         </form><!-- reportSearchForm -->
         
         <div class="search">
            <div class="search_inner">
               <div class="search_left">
	               <c:if test="${requestScope.employeeDTO.role != 'MANAGER'}"> 
	                  <form name="reportRegForm" method="post">
	                     <input type="hidden" name="report_code" value="${param.report_code}" class="report_code">
	                     <input type="button" value="" class="reportRegBtn left" onClick="reportRegBtn()">
	                  </form>
	               </c:if>
               </div>
               
               <div class="search_right">
                  <span>[검색 총 개수] : ${requestScope.reportTotCnt}개</span>
                  &nbsp; &nbsp;
                  <select name="rowCntPerPage2" class="rowCntPerPage2 pointer" onchange="reportSearch()">
                     <option value="5">5</option>
                     <option value="10">10</option>
                     <option value="15">15</option>
                     <option value="20">20</option>
                  </select>개씩 보기
               </div><!-- search_right -->
               
               <div class="paging">
                  <c:if test="${requestScope.reportTotCnt > 0}">
                     
                     <span class="pointer" onclick="pageNoBtn(1);">[처음]</span>
                     <span class="pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo} - 1);">[이전]</span>
                     
                     <c:forEach var="no" begin="${requestScope.pagingMap.begin_pageNo_perPage}"
                                    end="${requestScope.pagingMap.end_pageNo_perPage}" step="1">
                        <c:if test="${requestScope.pagingMap.selectPageNo == no}">
                           <b>${no}&nbsp;</b>
                        </c:if>
                        <c:if test="${requestScope.pagingMap.selectPageNo != no}">
                           <span class="pointer" onclick="pageNoBtn(${no});">[${no}]</span>&nbsp;
                        </c:if>
                     </c:forEach>
                     
                     <span class="pointer" onclick="pageNoBtn(${requestScope.pagingMap.selectPageNo} + 1);">[다음]</span>
                     <span class="pointer" onclick="pageNoBtn(${requestScope.pagingMap.last_pageNo});">[마지막]</span>
                  </c:if>
               </div><!-- paging -->
               
            </div><!-- search_inner -->
         </div><!-- search -->
         
         <div class="searchingResults">
            <table>
               <tr>
                  <th id="no" style="width: 100px;"><span class="">번호</span></th>
                  <th style="width: 200px;"><span class="">작성자</span></th>
                  <th style="width: 150px;"><span class="">업무분야</span></th>
                  <th><span class="">업무내용</span></th>
                  <th width="200px"><span class="">결재여부</span></th>
                  <th class="date" style="width: 150px;"><span class="">결재/보류일</span></th>
                  <th class="date" style="width: 300px;"><span class="">날짜</span></th>
               </tr>
               
               <c:if test="${requestScope.reportTotCnt == 0}">
                  <tr><td colspan="7">조회 가능한 보고서가 없습니다.</td></tr>
               </c:if>
               
               <c:forEach var="report" items="${requestScope.reportList}" varStatus="loopTagStatus">
                  <tr bgcolor="${loopTagStatus.index % 2 == 0?'white':'lightgray'}"
                  		class="pointer" onClick="goReportDetailForm(${report.r_no})">
                     <td>
                        ${requestScope.pagingMap.serialNo - loopTagStatus.index}
                     </td>
                     <td>
                        <img class="emp_img" alt="사원사진" src="/img/basic.jpg">
                        ${report.emp_name}
                     </td>
                     <td >
                        ${report.type_name}
                     </td>
                     <td>
                        ${report.title}
                     </td>
                     <td >
                        ${report.approval}
                     </td>
                     <td>
                     
                        <jsp:useBean id="sysdate" class="java.util.Date" />
                  
                        <fmt:parseNumber var="sysdate_N" value="${sysdate.time / (1000*60*60)}"  integerOnly="true" />   <!--  sysdate (Tue Dec 13 00:00:00 KST 2022)를 n시간으로 숫자형으로 -->
                        <fmt:parseDate var="approval_time_D"  value="${report.approval_time}" pattern="yyyy-MM-dd HH:mm:ss"/>         <!-- start_date를 String에서 날짜형으로 (Tue Dec 13 00:00:00 KST 2022)-->
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
                        
                     </td>
                     <td>
                        <c:if test="${param.report_code != 2}">
                           ${report.start_date} <br>~ ${report.end_date}
                        </c:if>
                        <c:if test="${param.report_code == 2}">
                           ${report.expense_date}
                        </c:if>
                     </td>
                  </tr>
               </c:forEach>
            </table>
         </div><!-- reportList -->
         
         <form name="reportDetailForm" method="post" action="/reportDetail.do">
            <input type="hidden" name="company_code" value="${requestScope.employeeDTO.company_code}">
            <input type="hidden" name="r_no" value="">
            <input type="hidden" name="report_code" value="${param.report_code}">
            <%@include file="/WEB-INF/views/moveData.jsp" %>
         </form>
      </div><!-- container -->
   </body>
</html>