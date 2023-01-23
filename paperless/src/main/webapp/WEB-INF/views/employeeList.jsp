<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/mainCatagory.jsp" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>직원 검색</title>
      
      <script>
         // 웹 브라우저가 body 태그 안을 모두 읽어들인 후 실행할 자바스크립트 코딩 설정
         $(function(){
            
        	 $("#manager_li").addClass("focusCatagory");
        	 
            var formObj = $("[name=employeeSearchForm]");
            
            // 등록 버튼을 클릭하면 "/noticeRegForm.do" URL 주소로 접속
            $(".newRegBtn").bind("click",function() {
               document.employeeRegForm.submit();
            });

            // 검색 결과물이 출력되는 table 태그의 hover 이용하여 tr 태그 배경색 바꾸기
            $(".searchingResults").find("tr:eq(0)").nextAll().hover(
               <c:if test="${requestScope.employeeTotCnt != 0}">
               function(){
                  $(this).addClass("mouseOntrBgC");
               }
               , function(){
                  $(this).removeClass("mouseOntrBgC");
               }
               </c:if>
            );
            
            // 검색 조건 관련 입력 양식에 흔적 남기기
            <c:if test="${!empty param.keyword}">
               formObj.find(".keyword").val("${param.keyword}");
            </c:if>
             
            <c:if test="${!empty param.rowCntPerPage}">
               formObj.find(".rowCntPerPage").val("${param.rowCntPerPage}");
               $(".rowCntPerPage2").val("${param.rowCntPerPage}");
            </c:if>
            
            <c:if test="${!empty param.pageNoCntPerPage}">
               formObj.find(".pageNoCntPerPage").val("${param.pageNoCntPerPage}");
            </c:if>
         
            <c:if test="${!empty requestScope.selectPageNo}">
               formObj.find(".selectPageNo").val("${requestScope.selectPageNo}");
               
            </c:if>
            
            <c:forEach var="xxx" items="${paramValues.dept}">
               formObj.find(".dept").filter("[value='${xxx}']").prop("checked", true);
            </c:forEach>
            
            <c:forEach var="xxx" items="${paramValues.jikup}">
               formObj.find(".jikup").filter("[value='${xxx}']").prop("checked", true);
            </c:forEach>
            //------------------------------------
            // 만약 sort 라는 파라미터명에 파라미터값이 존재하면,
            //------------------------------------
            <c:if test="${!empty param.sort}">
               // class=sort 를 가진 hidden 태그의 value 값을 sort 라는 파라미터명에 파라미터값을 넣어주기
               formObj.find(".sort").val("${param.sort}");
               
               $(".sortHeader").each(function(i){
                  var thisObj = $(this);
                  var text = thisObj.text().trim();
                  text = text.replace("▲","").replace("▼","");
                  thisObj.text(text);
      
                  // sort 파라미터명의 파라미터값이 "readcount asc" 이고 i 번째 태그가 안고 있는 문자가 "조회수" 라면
                  if( "${param.sort}"=="readcount asc" && text=="조회수") {
                     // i 번째 태그가 안고 있는 문자 뒤에 "▲" 삽입
                     thisObj.append("▲")
                  }
                  else if( "${param.sort}"=="readcount desc" && text=="조회수") {
                     thisObj.append("▼")
                  }
                  else if( "${param.sort}"=="reg_date asc" && text=="작성일") {
                     thisObj.append("▲")
                  }
                  else if( "${param.sort}"=="reg_date desc" && text=="작성일") {
                     thisObj.append("▼")
                  }
               });
            </c:if>
         });
         
         function SearchReset(){
            $(".keyword").val("");
            $(".dept").prop("checked", false);
            $(".jikup").prop("checked", false);
         }
         
         function employeeSearch() {
            var formObj = $("[name=employeeSearchForm]");
            var keyword = formObj.find(".keyword").val();
            if(typeof(keyword) != "string") keyword = "";
            keyword = $.trim(keyword);
            $(".keyword").val(keyword);
            
            var rowCntPerPage = $(".rowCntPerPage2").val();
            $(".rowCntPerPage").val(rowCntPerPage);
            
            document.employeeSearchForm.submit();
         }
         
         function goEmployeeDetail(id){
            $("[name=employeeDetailForm] [name=id]").val(id);
            
            document.employeeDetailForm.submit();
         }
         
         function employeeSearchAll() {
            SearchReset();
            employeeSearch();
         }
         
         // [페이지 번호]를 클릭하면 호출되는 함수 선언
         function pageNoBtn(pageNo) {
            // class=selectPageNo 를 가진 입력양식에 선택한 페이지 번호를 value 값으로 삽입
            $(".selectPageNo").val(pageNo);
            employeeSearch();
         }
         
         </script>
   </head>
   <body>
      <div class="container" style="width: 800px">
         <h2 align="left">직원 목록</h2>
         <form name="employeeSearchForm" method="post" action="/employeeList.do">
         
            <table class="searchTable" style="width: 600px">
               <tr>
                  <th>소속부서</th>
                  <td>
                     <input type="checkbox" name="dept" class="dept pointer" value="2">인사부
                     <input type="checkbox" name="dept" class="dept pointer" value="3">영업부
                     <input type="checkbox" name="dept" class="dept pointer" value="4">관리부
                  </td>
               </tr>
               <tr>
                  <th>직급</th>
                  <td>
                     <input type="checkbox" name="jikup" class="jikup pointer" value="1">사장
                     <input type="checkbox" name="jikup" class="jikup pointer" value="2">부사장
                     <input type="checkbox" name="jikup" class="jikup pointer" value="3">전무
                     <input type="checkbox" name="jikup" class="jikup pointer" value="4">상무
                     <input type="checkbox" name="jikup" class="jikup pointer" value="5">이사
                     <input type="checkbox" name="jikup" class="jikup pointer" value="6">부장<br>
                     <input type="checkbox" name="jikup" class="jikup pointer" value="7">차장
                     <input type="checkbox" name="jikup" class="jikup pointer" value="8">과장
                     <input type="checkbox" name="jikup" class="jikup pointer" value="9">대리
                     <input type="checkbox" name="jikup" class="jikup pointer" value="10">주임
                     <input type="checkbox" name="jikup" class="jikup pointer" value="11">사원
                     <input type="checkbox" name="jikup" class="jikup pointer" value="12">인턴
                  </td>
               </tr>
               <tr>
                  <th>키워드</th>
                  <td><input type="text" name="keyword" class="keyword"  value=""  style="width: 95%"></td>
               </tr>
            </table>
            <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
            <input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="10">
            <input type="hidden" name="pageNoCntPerPage" class="pageNoCntPerPage" value="10">
            <input type="hidden" name="sort" class="sort">
            
            <div class="button_div">
               <input type="button" value="검색" class="reportSearchBtn" onClick="employeeSearch()">
               <input type="button" value="모두검색" class="reportSearchAllBtn" onClick="employeeSearchAll()">
               <input type="button" value="초기화" class="" onClick="SearchReset()">
            </div>
         </form><!-- employeeSearchForm -->
         
         <div class="search" style="width: 800px; margin: 20px auto;">
            <div class="search_inner">
               <div class="search_left" style="width: 150px;">
                  <form name="employeeRegForm" method="post" action="/employeeRegForm.do">
                     <input type="hidden" name="company_code" value="${requestScope.employeeDTO.company_code}"}> 
                        <input type="button" value="직원 추가" class="newRegBtn left">
                  </form>
               </div>
               
               <div class="search_right" style="width: 250px;">
                  <span>총 ${requestScope.employeeTotCnt} / ${requestScope.employeeAllTotCnt} 개</span>
                  &nbsp; &nbsp;
                  <select name="rowCntPerPage2" class="rowCntPerPage2 pointer" onChange="employeeSearch()">
                         <option value="10">10</option>
                         <option value="15">15</option>
                         <option value="20">20</option>
                     </select>개씩 보기
               </div><!-- search_right -->
               
               <div class="paging">
                  <c:if test="${requestScope.employeeTotCnt > 0}">
         
                     <span style="cursor:pointer" onClick="pageNoBtn(1);">[처음]</span>
                     <span style="cursor:pointer" onClick="pageNoBtn(${requestScope.pagingMap.selectPageNo}-1);">[이전]</span>
                     
                     <c:forEach var="no" begin="${requestScope.pagingMap.begin_pageNo_perPage}"
                                    end="${requestScope.pagingMap.end_pageNo_perPage}" step="1">
                        <c:if test="${requestScope.pagingMap.selectPageNo != no}">
                           <span style="cursor:pointer" onClick="pageNoBtn(${no});">[${no}]</span> &nbsp;
                        </c:if>
                        
                        <c:if test="${requestScope.pagingMap.selectPageNo == no}">
                           <b>${no} &nbsp;</b>
                        </c:if>
                     </c:forEach>
                     
                     <span style="cursor:pointer" onClick="pageNoBtn(${requestScope.pagingMap.selectPageNo}+1);">[다음]</span>
                     <span style="cursor:pointer" onClick="pageNoBtn(${requestScope.pagingMap.last_pageNo});">[마지막]</span>
                  </c:if>
               </div><!-- paging -->
               
               
            </div><!-- search_inner -->
         </div><!-- search -->
         
         <div class="searchingResults" style="width: 800px; margin: 0 auto;">
            <table>
               <tr>
                  <th style="width: 100px;">번호</th>
                  <th style="width: 150px;">사원명</th>
                  <th style="width: 150px;">직급</th>
                  <th style="width: 150px;">부서</th>
                  <th style="width: 200px;">전화번호</th>
               </tr>
               
               <c:if test="${requestScope.employeeTotCnt == 0}">
                  <tr><td colspan="7">조회 가능한 사원이 없습니다.</td></tr>
               </c:if>
                 
                 <c:forEach var="employee" items="${requestScope.employeeList}" varStatus="loopTagStatus">
                    <tr
                       bgcolor="${loopTagStatus.index%2==0?'white':'lightgray'}"
                       style="cursor:pointer"
                       onClick="goEmployeeDetail('${employee.id}')"
                    >
                       <td>${requestScope.pagingMap.serialNo - loopTagStatus.index}</td>
                        <td>
                        	<img class="emp_img" alt="사원사진" src="/img/basic.jpg">
                        	${employee.emp_name}
                       	</td>
                        <td>${employee.jikup_name}</td>
                        <td>${employee.dept_name}</td>
                        <td>${employee.phone_num}</td>
                    </tr>
                 </c:forEach>
            </table>
         </div><!-- searchingResults -->
         
         <form name="employeeDetailForm" method="post" action="/employeeDetail.do">
            <input type="hidden" name="id" value="">
         </form>
      </div><!-- container -->
   </body>
</html>