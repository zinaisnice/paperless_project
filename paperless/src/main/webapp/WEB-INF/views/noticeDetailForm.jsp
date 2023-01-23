<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/mainCatagory.jsp" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>공지사항 상세화면</title>
      
      <script>
         function goNoticeUp() {
            if(confirm("공지사항을 수정하시겠습니까?") == false) return;
            document.noticeUpForm.submit();
         }
         
         function goNoticeDel() {
            if(confirm("공지사항을 삭제하시겠습니까?") == false) return;
            $.ajax({
               url:"/noticeDelProc.do"
               , type:"post"
               , data:$("[name=noticeDelForm]").serialize()
               , success:function(DelCnt){
                  if(DelCnt == 1){
                     alert("공지사항 삭제 완료");
                     document.noticeListForm.submit();
                  }
                  else if(DelCnt == 0){
                     alert("이미 삭제된 게시물입니다.");
                     document.noticeListForm.submit();
                  }
               }
               ,error: function (request, status, error) {
                  alert("웹 서버 접속에 실패하였습니다.");
                    console.log("code: " + request.status)
                    console.log("message: " + request.responseText)
                    console.log("error: " + error);
                }
               
            });
         }
         
         function goNoticeDetail(n_no){
            $("[name=noticeDetailForm]").find("[name=n_no]").val(n_no);
            document.noticeDetailForm.submit();
         }
      </script>
   
   </head>
   <body>
      <div class="container">
         <h4>공지사항 상세화면</h4>
         <table>
             <tr>
                 <th width="250px">글 번호</th>
                 <td> ${requestScope.noticeDTO.company_code}-${requestScope.noticeDTO.notice_no} </td>
                 <th width="250px">조회수</th>
                 <td> ${requestScope.noticeDTO.readcount} </td>
             </tr>
             <tr>
                  <th width="250px"> 이전글 </th>
                 <td > ${requestScope.noticeDTO.emp_name} </td>
                  <th width="250px"> 다음글 </th>
                 <td> ${requestScope.noticeDTO.reg_date} </td>
             </tr>
             <tr>
                 <th>글 제목</th>
                 <td colspan="3"> ${requestScope.noticeDTO.title}</td>
             </tr>
             <tr>
                 <th>글 내용</th>
                 <td colspan="3" style="height: 300px;"> ${requestScope.noticeDTO.content} </td>
             </tr> 
         </table>
         
         <div class="button_div">
            <c:if test="${requestScope.employeeDTO.role == 'MANAGER'}">
               <input type="button" value="수정" onClick="goNoticeUp()">
               <input type="button" value="삭제" onClick="goNoticeDel()">
            </c:if>
            <input type="button" value="목록" onClick="goNoticeList()">
         </div>
         
         <table>
            <c:if test="${!empty requestScope.beforeNoticeDTO}">
            <tr>
               <th width="100px"> 이전글 </th>
               <td class="pointer" onClick="goNoticeDetail(${requestScope.beforeNoticeDTO.n_no})"> ${requestScope.beforeNoticeDTO.title}</td>
            </tr>
            </c:if>
            <c:if test="${!empty requestScope.afterNoticeDTO}">
            <tr>
               <th width="100px"> 다음글 </th>
               <td class="pointer" onClick="goNoticeDetail(${requestScope.afterNoticeDTO.n_no})"> ${requestScope.afterNoticeDTO.title}</td>
            </tr>
            </c:if>
         </table>
         
      </div><!-- container -->
      <form name="noticeUpForm" method="post" action="/noticeUp.do">
         <input type="hidden" name="n_no" value="${requestScope.noticeDTO.n_no}">
      </form>
      <form name="noticeDelForm" method="post" action="/noticeDelProc.do">
         <input type="hidden" name="n_no" value="${requestScope.noticeDTO.n_no}">
      </form>
      <form name="noticeDetailForm" method="post" action="/noticeDetail.do">
         <input type="hidden" name="n_no">
      </form>
   </body>
</html>