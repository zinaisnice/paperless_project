<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>직원 추가</title>
      
      <script>
      function goEmployeeReg(){
         
         var formObj = $("[name=employeeRegForm]");
         
         var emp_name = formObj.find(".emp_name").val();
         if(typeof(emp_name)!="string") emp_name="";
         emp_name = $.trim(emp_name);
         formObj.find(".emp_name").val(emp_name);
            if(new RegExp('^[가-힣]{2,7}$').test(emp_name) == false) {
                alert("이름을 입력해주세요");
                formObj.find(".emp_name").val("");
                formObj.find(".emp_name").focus();
                return;
            }
            
            var id = formObj.find(".id").val();
         if(typeof(id)!="string") id="";
         id = $.trim(id);
         formObj.find(".id").val(id);
            if(new RegExp('^[a-z0-9]{2,10}$').test(id) == false) {
                alert("아이디는 영소문 또는 숫자로 구성되고 2-10자 입력 해야합니다.");
                formObj.find(".id").val("");
                formObj.find(".id").focus();
                return;
            }
            
            var pwd = formObj.find(".pwd").val();
         if(typeof(pwd)!="string") pwd="";
         pwd = $.trim(pwd);
         formObj.find(".pwd").val(pwd);
            if(new RegExp('^[a-z0-9]{3,8}$').test(pwd) == false) {
                alert("비밀번호는 영소문 또는 숫자로 구성되고 3-8자 입력 해야합니다.");
                formObj.find(".pwd").val("");
                formObj.find(".pwd").focus();
                return;
            }
            
            var email = formObj.find(".email").val();
         if(typeof(email)!="string") email="";
         email = $.trim(email);
         formObj.find(".email").val(email);
            if(new RegExp('^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$').test(email) == false) {
                alert("올바른 이메일 형식을 입력해주세요.");
                formObj.find(".email").val("");
                formObj.find(".email").focus();
                return;
            }
            
            var phone_num = formObj.find(".phone_num").val();
         if(typeof(phone_num)!="string") phone_num="";
         phone_num = $.trim(phone_num);
         formObj.find(".phone_num").val(phone_num);
            if(new RegExp(/^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/).test(phone_num) == false) {
                alert("핸드폰 번호는 '-'를 넣어서 입력해주세요.");
                formObj.find(".phone_num").val("");
                formObj.find(".phone_num").focus();
                return;
            }
         
         if(confirm("직원 추가하시겠습니까?") == false) return;
         
         $.ajax({
            url:"/employeeRegProc.do"
            , type:"post"
            , data:$("[name=employeeRegForm]").serialize()
            , success:function(regCnt){
               if(regCnt == 1){
                  alert("직원 추가 완료");
                  document.employeeList.submit();
               }
               else{
                  alert(regCnt);
               }
            }
         });
      }
      </script>
      
		<style>
			th{
				width: 100px;
			}
		</style>
   </head>
   <body>
      <div class="container" style="margin-top: 100px; width: 900px;">
         <div>
            <h4>[직원 추가]</h4>
         </div>
         <form name="employeeRegForm">
            <table>
               <tr>
                  <th>사 번</th>
                  <td></td>
                  <th>이 름</th>
                  <td><input type="text" name="emp_name" class="emp_name" value=""></td>
               </tr>
               <tr>
                  <th>아이디</th>
                  <td><input type="text" name="id" class="id" value=""></td>
                  <th>비밀번호</th>
                  <td><input type="text" name="pwd" class="pwd" value=""></td>
               </tr>
               <tr>
                  <th>직 급</th>
                  <td>
                     <select name="jikup_code">
                        <option value="1">사장</option>
                        <option value="2">부사장</option>
                        <option value="3">전무</option>
                        <option value="4">상무</option>
                        <option value="5">이사</option>
                        <option value="6">부장</option>
                        <option value="7">차장</option>
                        <option value="8">과장</option>
                        <option value="9">대리</option>
                        <option value="10">주임</option>
                        <option value="11">사원</option>
                        <option value="12">인턴</option>
                     </select>
                  </td>
                  <th>부 서</th>
                  <td>
                     <select name="dept_code">
                        <option value="2">인사부
                        <option value="3">영업부
                        <option value="4">관리부
                     </select>
                  </td>
               </tr>
               <tr>
                  <th>이메일</th>
                  <td><input type="text" name="email" class="email" value=""></td>
                  <th>전화번호</th>
                  <td><input type="text" name="phone_num" class="phone_num" value=""></td>
               </tr>
            </table>
            <input type="hidden" name="company_code" class="company_code" value="${requestScope.company_code}">
         </form><!-- employeeRegForm -->
         
         <div class="button_div">
            <input type="button" value="추가" onClick="goEmployeeReg()">
            <input type="button" value="목록" onClick="goEmployeeList()">
         </div>
      </div><!-- container -->
   </body>
</html>