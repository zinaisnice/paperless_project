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
            $("[name=reportListForm]").find(".report_code").val(${requestScope.reportDTO.report_code});
            
            $(".resignation").hide();
            
            if(${requestScope.no_next == 1}){
               $("[name=approval_code]").val(4);
               $("[name=next_emp_no]").val(${requestScope.reportDTO.emp_no});
            }
            
            $("[name=division]").change(function(){
               $("[name=no_next]").prop("checked", false);
               
               if($("[name=division]:checked").val() == "resignation"){ // 반려 선택
                  $(".resignation").show();
                  $(".next").hide();
                  $("[name=approval_code]").val(3);
                  $("[name=next_emp_no]").val(${requestScope.reportDTO.emp_no});
               } 
                  
               
               if($("[name=division]:checked").val() == "approval") { // 결재 선택
                  $(".resignation").hide();
                  $(".next").show();
                  if(${requestScope.no_next == 0}){
               	 	$("[name=approval_code]").val(2);
                  	$("[name=next_emp_no]").val(${requestScope.superior.emp_no});
                  }
                  
                  if(${requestScope.no_next == 1}){
                     $("[name=approval_code]").val(4);
                     $("[name=next_emp_no]").val(${requestScope.reportDTO.emp_no});
                  }
               }
            });
            
         }); //function(){}
            
         
         function goReportUpForm(){
            if(confirm("보고서 수정하시겠습니까?") == false) return;
            document.reportUpForm.submit();
         }
         
         function goReportDelForm(){
            if(confirm("보고서 삭제하시겠습니까?") == false) return;
            $.ajax({
               url:"/reportDelProc.do"
               , type:"post"
               , data:$("[name=reportDelForm]").serialize()
               , success:function(regCnt){
                  if(regCnt == 2){
                     alert("보고서 삭제 완료");
                     document.reportListForm.submit();
                  }
                  else{
                     alert("웹 서버 접속 실패");
                  }
               }
            });
         }
         
         function goReportApproval(){ // 결재/반려 화면으로 이동
            document.reportApprovalForm.submit();
         }
         
         function goReportApprovalForm(){ // 결재/반려 하기
            
            if($("[name=division]:checked").val() == "resignation"){
               var resignation_contentObj = $(".resignation_content");
               var resignation_content = resignation_contentObj.val();
               if( typeof(resignation_content) != "string" ) resignation_content = "";
               resignation_content = $.trim(resignation_content);
               resignation_contentObj.val(resignation_content);
               if(new RegExp(/^[\w\s가-힣]{10,50}$/).test(resignation_content) == false){ 
                  alert("반려 내용은 특수문자제외 10~50자로 입력해야합니다.");
                  resignation_contentObj.val("");
                  return;
               }
            }
            
            var last = (${requestScope.no_next == 1})? "최종" : ""; 
            var division = $("[name=division]:checked").val() == "resignation" ? '반려':'결재';
            
            if(confirm(last + division + "하시겠습니까?") == false) return;
            $.ajax({
               url:"/reportApprovalProc.do"
               , type:"post"
               , data:$("[name=reportApprovalProcForm]").serialize()
               , success:function(regCnt){
                  if(regCnt == 1){
                     alert( division + " 완료");
                     document.reportListForm.submit();
                  }
                  else{
                     alert("웹 서버 접속 실패" + regCnt);
                  }
               }
            });
         }
      </script>
   </head>
   <body>
      <div class="container">
         <div class="left report_type" style="text-align: center;">
            <c:if test="${requestScope.reportDTO.report_code == 1}">
               <b>일일 보고서</b><br>
               <span style="font-size: 10px;">DAILY WORK LOG</span>
            </c:if>
            <c:if test="${requestScope.reportDTO.report_code == 2}">
               <b>지출 보고서</b>
            </c:if>
            <c:if test="${requestScope.reportDTO.report_code == 3}">
               <b>영업 보고서</b>
            </c:if>
            <c:if test="${requestScope.reportDTO.report_code == 4}">
               <b>휴가원</b>
            </c:if>
         </div>
         
         <div class="right">${requestScope.reportDTO.company_code}-${requestScope.reportDTO.report_code}-${requestScope.reportDTO.report_no}</div>
         
         <div>
            <table>
               <tr>
                  <th>제목</th>
                  <td colspan="5"  style="width: 800px;">${requestScope.reportDTO.title}</td>
               </tr>
               
               <tr>
                  <th>업무 구분</th>
                  <td>${requestScope.reportDTO.type_name}</td>
                  <th>일시</th>
                  <td colspan="3">
                     <c:if test="${requestScope.reportDTO.report_code != 2}">
                        <span class="start_date">${requestScope.reportDTO.start_date}</span>
                        ~ 
                        <span class="end_date">${requestScope.reportDTO.end_date}</span>
                     </c:if>
                     <c:if test="${requestScope.reportDTO.report_code == 2}">
                        <span class="start_date">${requestScope.reportDTO.expense_date}</span>
                     </c:if>
                  </td>
               </tr>
               <tr>
                  <th>성 명</th>
                  <td style="width: 200px;">
                     <img class="emp_img" alt="사원사진" src="/img/${requestScope.reportDTO.emp_img}">
                     ${requestScope.reportDTO.emp_name}
                  </td>
                  <th>직 급</th>
                  <td style="width: 200px;">${requestScope.reportDTO.jikup_name}</td>
                  <th>연락처</th>
                  <td style="width: 250px;">${requestScope.reportDTO.phone_num}</td>
               </tr>
               
               <!-- 일일 보고서 -->
               <c:if test="${requestScope.reportDTO.report_code == 1}">
                  <tr style="height: 200px;">
                     <th>업무 내용</th>
                     <td colspan="5" style="text-align:left;">${requestScope.reportDTO.content}</td>
                  </tr>
               </c:if>
               
               <!-- 지출 보고서 -->
               <c:if test="${requestScope.reportDTO.report_code == 2}">
                  <tr>
                     <th>지출 비용</th>
                     <td>${requestScope.reportDTO.cost}</td>
                     <th>지출 수단</th>
                     <td>${requestScope.reportDTO.method_name}</td>
                     <th>영수증 번호</th>
                     <td>${requestScope.reportDTO.receipt_no}</td>
                  </tr>
                  <tr>
                     <th>비고</th>
                     <td colspan="5">${requestScope.reportDTO.note}</td>
                  </tr>
               </c:if>
               
               <!-- 영업 보고서 -->
               <c:if test="${requestScope.reportDTO.report_code == 3}">
               <tr>
                  <td colspan="6">
                     <table>
                        <tr>
                           <th>회사이름</th>
                           <th>이름</th>
                           <th>직급</th>
                           <th>전화번호</th>
                        </tr>
                        <tr>
                           <td>${requestScope.reportDTO.sales_company}</td>
                           <td>${requestScope.reportDTO.sales_name}</td>
                           <td>${requestScope.reportDTO.sales_jikup}</td>
                           <td>${requestScope.reportDTO.sales_phone}</td>
                        </tr>
                     </table>
                  </td>
               </tr>
               <tr>
                  <th>영업 내용</th>
                  <td colspan="5" style="height: 200px;">${requestScope.reportDTO.sales_content}</td>
               </tr>
               <tr>
                  <th>영업 성과</th>
                  <td colspan="5" style="height: 200px;">${requestScope.reportDTO.sales_result}</td>
               </tr>
               <tr>
                  
               </tr>
               </c:if>
               
               <!-- 휴가원 -->
               <c:if test="${requestScope.reportDTO.report_code == 4}">
                  <tr>
                     <th>사 유</th>
                     <td colspan="5" style="height: 200px;">
                        ${requestScope.reportDTO.content}
                     </td>
                  </tr>
                  <tr> 
                     <td colspan="6" style="text-align: center;">
                        <p>위와 같은 사유로 인하여 휴가를 신청하오니 허가하여 주시기 바랍니다.</p>
                        <br>
                        <p class="today"></p>
                        <br>
                        <p class="right">신청자 : ${requestScope.employeeDTO.emp_name}</p>
                        <br>
                        <h2>${requestScope.reportDTO.company_name}</h2>
                     </td>
                  </tr>
               </c:if>
               
               <!-- 다음 결재자의 결재/반려 창에서 보이는 -->
               <c:if test="${requestScope.division == 'approval'}"> 
                  <form name="reportApprovalProcForm" method="post" action="/reportApprovalProc.do">
                     <tr>
                        <th>결재 / 반려</th>
                        <td colspan="3">
                           <input type="radio" name="division" class="division" value="approval" checked>결재
                           <input type="radio" name="division" class="division" value="resignation">반려
                        </td>
                        
                        <th>다음 결재자</th>
                        <td>
                           <div class="next">
                              <c:if test="${requestScope.no_next == 1}">
                                 다음 결재자 없음
                                 <input type="hidden" name="next_emp_no" class="next_emp_no" value="${requestScope.reportDTO.emp_no}">
                              </c:if>
                              <c:if test="${requestScope.no_next == 0}">
                                 ${requestScope.superior.name} ${requestScope.superior.jikup}
                                 <input type="hidden" name="next_emp_no" class="next_emp_no" value="${requestScope.superior.emp_no}">
                              </c:if>
                              
                           </div>
                        </td>
                     </tr>
                     
                     <tr class="resignation">
                        <th>반려 사유</th>
                        <td colspan="5"><textarea name="resignation_content" class="resignation_content" rows="30" cols="70"></textarea></td>
                     </tr>
                     
                     <input type="hidden" name="approval_code" value="2">
                     <input type="hidden" name="r_no" value="${requestScope.reportDTO.r_no}">
                     <input type="hidden" name="company_code" value="${requestScope.reportDTO.company_code}">
                     <input type="hidden" name="report_code" value="${requestScope.reportDTO.report_code}">
                     <input type="hidden" name="report_no" value="${requestScope.reportDTO.report_no}">
                     <input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}">
                     <input type="hidden" name="resignation_cnt" value="${requestScope.reportDTO.resignation_cnt}">
                     <input type="hidden" name="no_next" class="no_next" value="${requestScope.no_next}">
                  </form>
               </c:if>
               
               <tr> <!-- 결재 정보 -->
                  <td colspan="6">
                        <table style="width: 900px;">
                           <tr>
                              <th style="width: 80px;">결재순서</th>
                              <th style="width: 200px;">결재자명</th>
                              <th style="width: 110px;">부서명</th>
                              <th style="width: 110px;">직 책</th>
                              <th style="width: 150px;">결재여부</th>
                              <th style="width: 250px;">결재일</th>
                              <c:if test="${requestScope.reportDTO.resignation_cnt != 0}">
                                 <th>반려사유</th>
                              </c:if>
                           </tr>
                           <c:forEach var="approval" items="${requestScope.approval_List}" varStatus="loopTagStatus">
                              
                              <tr>
                                 <td>
                                    ${loopTagStatus.index + 1}
                                 </td>
                                 <td>
                                    <img class="emp_img" alt="사원사진" src="/img/${approval.emp_img}">
                                    ${approval.emp_name}
                                 </td>
                                 <td>
                                    ${approval.dept_name}
                                 </td>
                                 <td>
                                    ${approval.jikup_name}
                                 </td>
                                 <td>
                                    ${approval.approval}
                                 </td>
                                 <td>
                                    <c:if test="${approval.approval_code != 1}">
                                    ${approval.approval_time}
                                    </c:if>
                                 </td>
                                 <c:if test="${requestScope.reportDTO.resignation_cnt != 0}">
                                    <td>${approval.resignation_content}</td>
                                 </c:if>
                              </tr>
                              
                              <c:if test="${approval.approval == '반려'}">
                              <tr>
                                 <th>결재순서</th>
                                 <th>결재자명</th>
                                 <th>부서명</th>
                                 <th>직책</th>
                                 <th>결재여부</th>
                                 <th>결재일</th>
                                 <c:if test="${requestScope.reportDTO.resignation_cnt > 0}">
                                 <th>반려사유</th>
                                 </c:if>
                              </tr>
                              </c:if>
                           </c:forEach>
                        </table>
                  </td>
               </tr>
            </table>
         </div><!-- main_table -->
         
         <br>
         <div class="button_div">
            <!-- 보고서 상세페이지 -->
            <c:if test="${requestScope.division == 'detail'}">
               
               <!-- 반려횟수0번 / 1번이라도 상사가 결재진행시 수정 불가 안내 문구 출력 -->
               <c:if test="${requestScope.reportDTO.resignation_cnt == 0
                        and requestScope.reportDTO.approval_code == 1
                        and requestScope.employeeDTO.emp_no == requestScope.reportDTO.emp_no
                        and requestScope.approvalListSize > 2}">
                  <h1>결재되어 수정이 불가능합니다.</h1>
               </c:if>
               
               <!-- 현재 보고서가 결재라인 1번까지 올라가 최종결재된 보고서 안내 문구 출력 -->
               <c:if test="${requestScope.reportDTO.approval_code == 4}">
               <h1>최종 결재 완료된 보고서입니다.</h1>
               </c:if>
               
               <!-- 보고서 작성자가 보고서 등록 후 바로 다음 결재자(상사)가 결재 전까지 보고서 수정 삭제 가능 -->
               <c:if test="${requestScope.employeeDTO.emp_no == requestScope.reportDTO.emp_no
                        and requestScope.approvalListSize == 2}">
                  <input type="button" value="수정" onClick="goReportUpForm()">
                  <c:if test="${requestScope.reportDTO.resignation_cnt == 0}">
                  <input type="button" value="삭제" onClick="goReportDelForm()">
                  </c:if>
               </c:if>
               
               <!-- 보고서 결재해야하는 다음결재자(상사)가 결재/반려하는 페이지로 이동 가능 -->
               <c:if test="${requestScope.employeeDTO.emp_no == requestScope.nextEmpNo 
                        and requestScope.employeeDTO.emp_no != requestScope.reportDTO.emp_no}">
                  <input type="button" value="결재/반려" onClick="goReportApproval()">
               </c:if>
               
               <!-- 반려된 보고서를 보고서 작성자가 수정만 할지 재결재를 올릴지 선택가능한 수정페이지로 이동 -->
               <c:if test="${requestScope.reportDTO.approval_code == 3
                        and requestScope.employeeDTO.emp_no == requestScope.reportDTO.emp_no}">
                  <input type="button" value="수정/재결재" onClick="goReportUpForm()">
               </c:if>
               
               <input type="button" value="목록" onClick="goReportList()">
            </c:if>
            
            
            
            <!-- 보고서 결재 반려하는 페이지 -->
            <c:if test="${requestScope.division == 'approval'}">
               <input type="button" value="결재/반려 등록" onClick="goReportApprovalForm()">
               <input type="button" value="목록" onClick="goReportList()">
            </c:if>
         </div><!-- button_div -->
         
      </div><!-- container -->
      <form name="reportUpForm" method="post" action="/reportUp.do">
         <input type="hidden" name="company_code" class="company_code" value="${requestScope.reportDTO.company_code}">
         <input type="hidden" name="r_no" class="r_no" value="${requestScope.reportDTO.r_no}">
         <input type="hidden" name="report_code" class="report_code" value="${requestScope.reportDTO.report_code}">
      </form>
      <form name="reportDelForm" method="post" action="/reportDelProc.do">
         <input type="hidden" name="company_code" class="company_code" value="${requestScope.reportDTO.company_code}">
         <input type="hidden" name="r_no" class="r_no" value="${requestScope.reportDTO.r_no}">
         <input type="hidden" name="report_code" class="report_code" value="${requestScope.reportDTO.report_code}">
      </form>
      <form name="reportApprovalForm" method="post" action="/reportApproval.do"> <!-- 결재/반려 하는 창으로 이동 -->
         <input type="hidden" name="company_code" class="company_code" value="${requestScope.reportDTO.company_code}">
         <input type="hidden" name="r_no" class="r_no" value="${requestScope.reportDTO.r_no}">
         <input type="hidden" name="report_code" class="report_code" value="${requestScope.reportDTO.report_code}">
      </form>
   </body>
</html>