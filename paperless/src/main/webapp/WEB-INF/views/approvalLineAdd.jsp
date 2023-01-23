<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>결재라인 추가</title>
      
      <script>
         
         function deptChange(i){
            var trObj = $("#" + i);
            var deptObj = trObj.find(".dept");
            var choicedVal = deptObj.val();
            var empObj = trObj.find(".name_jikup");
            var empadd = "<option value=''>------------</option>";
            
            <c:forEach var="emp" items="${requestScope.allEmployeeList}">
               if(i != 1) {
                  var superiorJikup = $("#" + (i - 1)).find(".jikup_code").val();
                  if(choicedVal == ${emp.dept_code} && superiorJikup < ${emp.jikup_code}){
                     empadd = empadd + "<option value = '${emp.emp_no}'> ${emp.emp_name} ${emp.jikup_name}</option>"
                  }
               }else {
                  if(choicedVal == ${emp.dept_code}){
                     empadd = empadd + "<option value = '${emp.emp_no}'> ${emp.emp_name} ${emp.jikup_name}</option>"
                  }
               }
               
            </c:forEach>
            empObj.html(empadd);
         }
         
         function nameChange(i){
            var trObj = $("#" + i);
            var empObj = trObj.find(".name_jikup");
            var choicedVal = empObj.val();
            var emailObj = trObj.find(".email");
            var phone_numObj = trObj.find(".phone_num");
            var jikupCode = 0;
            var emailVal = "";
            var phone_numVal = "";
            
            <c:forEach var="emp" items="${requestScope.allEmployeeList}">
               if(choicedVal == ${emp.emp_no}){
                  jikupCode = ${emp.jikup_code};
                  emailVal = emailVal + "<span>${emp.email}</span>";
                  phone_numVal = phone_numVal + "<span>${emp.phone_num}</span>"
               }
            </c:forEach>
            
            trObj.find(".jikup_code").val(jikupCode);
            emailObj.html(emailVal);
            phone_numObj.html(phone_numVal);
            
         }
         
         function checkApprovalLine() {
            
            var len = $("table > tbody tr").length;
            var emp_no = "";
            
            //행별 유효성 for문 시작
            for(var i = 1; i <= len; i++){
               var tr = $("table > tbody tr:nth-child("+ i +")");
               emp_no =  emp_no + tr.find(".name_jikup").val() + ",";
               
                var dept1 = $("#"+ i +" .dept").val();
                       if(dept1 == "") {
                          alert("부서를 선택해주세요.");
                          
                          return;
                       }
                     
                     
                     
                       var name_jikup1 = $("#"+ i +" .name_jikup").val();
                       if(name_jikup1 == "") {
                          alert("직급을 선택해주세요.");
                          
                          return;
                       }
                       
            }
            //for문 끝
            
            //최소결재 갯수
            if(len < 2){
                   alert("결재라인은 최소 2명 이상 입력해주셔야합니다.");
                   addItem(); //행추가 
                   return;
                }
            
            
            
            var formObj = $("[name=approvalLineAdd]");
            formObj.find("[name=emp_noList]").val(emp_no);
            
            
            $.ajax({
               url:"/ApprovalLineAddProc.do"
               , type:"post"
               , data:$("[name=approvalLineAdd]").serialize()
               , success:function(UpCnt){
                  if(UpCnt == 1){
                     alert("결재라인 추가 완료");
                     location.replace("/approvalLineList.do");
                  }
                  else{
                     alert(UpCnt);
                  }
               }
            });
            
         } //checkApprovalLine
         
         
         function replaceAll(str, ostr, rstr){
            if(str == undefined) return str;
            return str.split(ostr).join(rstr);
         }
         
         function replaceOrder(){
            var len = $("table > tbody tr").length;
            for(var i = 1; i <= len; i++){
               $("table > tbody tr:nth-child("+ i +")").attr("id", i);
               $("table > tbody tr:nth-child("+ i + ") td:first-child").text(i);
            }
         }
         
         function addItem(){
     	 	var len = $("table > tbody tr").length + 1;
			var append_tr = $("#addtr").html();
			append_tr = replaceAll(append_tr, 'ttr', 'tr id="'+ len + '"');
			append_tr = replaceAll(append_tr, 'ttd', 'td');
			append_tr = append_tr.replace(/index/g, len);
			$("table > tbody").append(append_tr);
         }
         
         function deleteItem(obj){
            var tr = $(obj).closest("tr");
            tr.remove();
            replaceOrder();
         }
         
         function goApprovalLineList(){
            location.replace("/approvalLineList.do");
         }
         
      </script>
      <style>
         .
      </style>
   </head>
   
   <body>
      <div class="container">
         <form name="approvalLineAdd">
            <input type="hidden" name="company_code" value="${requestScope.employeeDTO.company_code}">
            <input type="hidden" name="emp_noList">
         </form><!-- approvalLineReg -->
            
            <h2>결재라인 추가</h2>
            <table>
               <thead>
                  <tr>
                     <th style="width: 80px;">순서</th>
                     <th style="width: 150px;">부서</th>
                     <th style="width: 250px;">이름 직급</th>
                     <th style="width: 250px;">이메일</th>
                     <th style="width: 250px;">전화번호</th>
                     <th style="width: 80px"></th>
                  </tr>
               </thead>
               <tbody>
                  <tr id="1">
                     <td>1</td>
                     <td>
                        <select class="dept" onchange="deptChange(1);">
                           <option value="">------------</option>
                           <!--<c:forEach var="dept" items="${requestScope.deptList}">
                              <option value="${dept.dept_code}"> ${dept.dept_name}
                           </c:forEach>-->
                           <option value="2">인사부</option>
                           <option value="3">영업부</option>
                           <option value="4">관리부</option>
                        </select>
                     </td>
                     <td>
                        <select class="name_jikup" onchange="nameChange(1);">
                           <option value="">------------</option>
                        </select>
                     </td>
                     <td class="email"></td>
                     <td class="phone_num"></td>
                     <td style="width: 80px;">
                        <button onclick="deleteItem(this)"><span class="glyphicon glyphicon-minus"></span></button>
                        <input type="hidden" class="jikup_code">
                     </td>
                  </tr>
               </tbody>
               
            </table>
            
            
            <div id="addtr" style=" display: none;">
               <ttr id="index">
                     <ttd>index</ttd>
                     <ttd>
                        <select class="dept" onchange="deptChange(index);">
                           <option value="">------------</option>
                           <option value="2">인사부</option>
                           <option value="3">영업부</option>
                           <option value="4">관리부</option>
                        </select>
                     </ttd>
                     <ttd>
                        <select class="name_jikup" onchange="nameChange(index);">
                           <option value="">------------</option>
                        </select>
                     </ttd>
                     <ttd class="email"></ttd>
                     <ttd class="phone_num"></ttd>
                     <ttd style="width: 80px;">
                        <button onclick="deleteItem(this)"><span class="glyphicon glyphicon-minus"></span></button>
                        <input type="hidden" class="jikup_code">
                     </ttd>
                  </ttr>
            </div>
            
            
            <div class="button_div">
               <input type="button" value="인원 추가" onClick="addItem()">
               <input type="button" value="결재라인추가" onClick="checkApprovalLine()">
                 <input type="button" value="화면닫기" onClick="goApprovalLineList()">
            </div>
      </div><!-- container -->
   </body>
</html>