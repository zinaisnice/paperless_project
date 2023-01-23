<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>ApprovalLineReg</title>
      
      <script>
      
         function checkApprovalLine() {
            
            var len = $("table > tbody tr").length;
            var emp_name = "";
            var id = "";
            var pwd = "";
            var jikup_code = "";
            var dept_code = "";
            var email = "";
            var phone_num = "";
            
            // 유효성 체크
            var company_name = $(".company_name").val();
            if( typeof(company_name) != "string" ) company_name = "";
                  company_name = $.trim(company_name);
                  $( ".company_name").val(company_name);
                  if(new RegExp(/^[가-힣]{2,10}$/).test(company_name) == false){
                     alert("회사이름은 특수문자제외 2~10자로 입력해야합니다.");
                     $( ".company_name").val("");
                     $( ".company_name").focus();
                     return;
               }
                  
            for(var i = 1; i <= len; i++){
               var name1 = $("#" + i + " .name").val();
               if( typeof(name1) != "string" ) name1 = "";
               name1 = $.trim(name1);
               $("#"+ i +" .name").val(name1);
               if(new RegExp('^[가-힣]{2,7}$').test(name1) == false) {
                   alert("이름을 입력해주세요");
                   $("#"+ i +" .name").val("");
                   $("#"+ i +" .name").focus();
                   return;
               }

               var id1 = $("#"+ i +" .id").val();
                    if( typeof(id1) != "string" ) id1 = "";
                    id1 = $.trim(id1);
                    $("#"+ i +" .id").val(id1);
                    if(new RegExp('^[a-z0-9]{2,10}$').test(id1) == false) {
                        alert("아이디는 영소문 또는 숫자로 구성되고 2-10자 입력 해야합니다.");
                        $("#"+ i +" .id").val("");
                        $("#"+ i +" .id").focus();
                        return;
                    }
               
                    
                    var pwd1 = $("#"+ i +" .pwd").val();
                    if( typeof(pwd1) != "string" ) pwd1 = "";
                    pwd1 = $.trim(pwd1);
                    $("#"+ i +" .pwd").val(pwd1);
                    if(new RegExp('^[a-z0-9]{3,8}$').test(pwd1)==false) {
                       alert("비밀번호는 영소문 또는 숫자로 구성되고 3-8자 입력 해야합니다.");
                       $("#"+ i +" .pwd").val("");
                       $("#"+ i +" .pwd").focus();
                       return;
                    }
                    
                    var pwdCheck1 = $("#"+ i +" .pwdCheck").val();
                    if( typeof(pwdCheck1) != "string" ) pwdCheck1 = "";
                    if(pwdCheck1 != pwd1) {
                       alert("비밀번호가 다릅니다. 다시 입력해주세요.");
                       $("#"+ i +" .pwdCheck").focus();
                       return;
                    }
                    
                    var jikup_code1 = $("#"+ i +" .jikup_code").val();
                    if(jikup_code1 == "") {
                       alert("직급을 선택해주세요.");
                       $("#"+ i +" .jikup_code").focus();
                       return;
                    }
                    
                    var dept_code1 = $("#"+ i +" .dept_code").val();
                    if(dept_code1 == "") {
                       alert("부서를 선택해주세요.");
                       $("#"+ i +" .dept_code").focus();
                       return;
                    }
                    
                    var email1 = $("#"+ i +" .email").val();
                    if( typeof(email1) != "string" ) email1 = "";
                    email1 = $.trim(email1);
                    $("#"+ i +" .email").val(email1);
                    if(new RegExp('^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$').test(email1) == false) {
                       alert("올바른 이메일 형식을 입력해주세요.");
                       $("#"+ i +" .email").val("");
                       $("#"+ i +" .email").focus();
                       return;
                    }
                    
                    var phone_num1 = $("#"+ i +" .phone_num").val();
                    if( typeof(phone_num1) != "string" ) phone_num1 = "";
                    phone_num1 = $.trim(phone_num1);
                    $("#"+ i +" .phone_num").val(phone_num1);
                    if(new RegExp(/^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/).test(phone_num1) == false){
                        alert("핸드폰 번호는 '-'를 넣어서 입력해주세요.");
                        $("#"+ i +" .phone_num").val("");
                        $("#"+ i +" .phone_num").focus();
                        return;
                    }
            } // for
            
            if(len < 2){
               alert("결재라인은 최소 2명 이상 입력해주셔야합니다.");
               addItem();
               return;
            }
            
            for(var i = 1; i <= len; i++){
               var tr = $("table > tbody tr:nth-child("+ i +")");
               emp_name =  emp_name + tr.find(".name").val() + ",";
               id = id + tr.find(".id").val() + ",";
               pwd = pwd + tr.find(".pwd").val() + ",";
               jikup_code = jikup_code + tr.find(".jikup_code").val() + ",";
               dept_code = dept_code + tr.find(".dept_code").val() + ",";
               email = email + tr.find(".email").val() + ",";
               phone_num = phone_num + tr.find(".phone_num").val() + ",";
            }
            
            var formObj = $("[name=approvalLineReg]");
            formObj.find("[name=emp_name]").val(emp_name);
            formObj.find("[name=id]").val(id);
            formObj.find("[name=pwd]").val(pwd);
            formObj.find("[name=jikup_codeList]").val(jikup_code);
            formObj.find("[name=dept_codeList]").val(dept_code);
            formObj.find("[name=email]").val(email);
            formObj.find("[name=phone_num]").val(phone_num);
            
            
            $.ajax({
               url:"/ApprovalLineProc.do"
               , type:"post"
               , data:$("[name=approvalLineReg]").serialize()
               , success:function(UpCnt){
                  if(UpCnt == 1){
                     alert("직원 등록 완료");
                  }
                  else if(UpCnt == -1){
                     alert("이미 등록되어 있는 회사명입니다.");
                  }
                  else if(UpCnt == -2){
                     alert("회사 등록 실패");
                  }
                  else if(UpCnt == -3){
                     alert("회사 매니져 등록 실패");
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
        	 
        	 if(len == 13){
        		 alert("한 결재라인의 최대 인원 수는 12명입니다.");
        		 return;
        	 }
        	 
        	 var lastJikup = $("#" + (len - 1) + " .jikup_code").val();
        	 if(lastJikup == 12){
        		 alert("마지막 사원의 직급이 인턴이므로 더이상 인원을 추가할 수 없습니다.");
        		 return;
        	 }
        	 
             var append_tr = $("#addtr").html();
             append_tr = replaceAll(append_tr, 'ttr', 'tr');
             append_tr = replaceAll(append_tr, 'ttd', 'td');
             append_tr = append_tr.replace(/index/g, len);
             $("table > tbody").append(append_tr);
             
             changeJikup();
        }

         function deleteItem(obj){
        	var len = $("table > tbody tr").length;
            var tr = $(obj).closest("tr");
            
           	var tr_id = tr.attr("id");
            if(tr_id == 1 && len == 1) return;
            
            tr.remove();
            replaceOrder();
            changeJikup();
         }
         
         function changeJikup(){
        	 var len = $("table > tbody tr").length;
        	 
        	 if(len == 1) return;
        	 
        	 var Jikup = $("#addtr .jikup_code").html();
        	 var JikupList = Jikup.split("</option>");
        	 
        	 var first = $("#1 .jikup_code").val();
    		 $("#1 .jikup_code").html(Jikup);
    		 $("#1 .jikup_code").val(first);
        	 
        	 for(var i = 2; i <= len; i++){
        		 var choiced = Number($("#" + (i - 1)).find(".jikup_code").val()) + 1;
        		 
        		 var nextOrder = JikupList[0];
        		 for(var j = choiced; j <= 12; j++){
        			 nextOrder = nextOrder + JikupList[j];
        		 }
        		 
        		 var choiced1 = $("#" + i).find(".jikup_code").val();
        		 $("#" + i + " .jikup_code").html(nextOrder);
        		 $("#" + i + " .jikup_code").val(choiced1);
        	 }
         }
         
         function goLoginForm(){
            location.replace("/loginForm.do");
         }
         
      </script>
      <style>
      	th {
      		padding: 10px 0;
      	}
      	td {
      		padding: 10px 5px;
      	}
      </style>
   </head>
   
   <body>
      <div class="container" style="width: 1200px; margin-top: 100px">
         <form name="approvalLineReg">
            <h3>회사명 <input type="text" name="company_name" class="company_name"></h3> <!-- 회사명 최대 8글자 -->
            <input type="hidden" name="emp_name">
            <input type="hidden" name="id">
            <input type="hidden" name="pwd">
            <input type="hidden" name="jikup_codeList">
            <input type="hidden" name="dept_codeList">
            <input type="hidden" name="email">
            <input type="hidden" name="phone_num">
         </form><!-- approvalLineReg -->
            
            <table>
               <thead>
                  <tr>
                     <th style="width: 50px;">순서</th>
                     <th style="width: 100px;">이름</th>
                     <th style="width: 100px;">아이디</th>
                     <th style="width: 100px;">비밀번호</th>
                     <th style="width: 100px;">비밀번호 확인</th>
                     <th style="width: 80px;">직급</th>
                     <th style="width: 80px;">부서</th>
                     <th style="width: 130px;">이메일</th>
                     <th style="width: 130px;">전화번호</th>
                     <th style="width: 30px;"></th>
                  </tr>
               </thead>
               <tbody>
                  <tr id="1">
                     <td>1</td>
                     <td><input class="name" size="10" value=""></td>
                     <td><input type="text" class="id" size="10" value=""></td>
                     <td><input type="password" class="pwd" size="10" value=""></td>
                     <td><input type="password" class="pwdCheck" size="10" value=""></td>
                     <td>
                        <select class="jikup_code" onchange="changeJikup();" style="width: 75px;">
                           <option value="">선택</option>
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
                     <td>
                     <select class="dept_code">
                        <option value="">선택</option>
                        <option value="2">인사부</option>
                        <option value="3">영업부</option>
                        <option value="4">관리부</option>
                     </select>
                     </td>
                     <td><input type="text" class="email" size="15" value=""></td>
                     <td><input type="text" class="phone_num" size="15" value="" placeholder="010-0000-0000"></td>
                     <td style="padding: 0 10px 0 0;">
                        <button onclick="deleteItem(this)"><span class="glyphicon glyphicon-minus"></span></button>
                     </td>
                  </tr>
               </tbody>
               
            </table>
            
            
            <div id="addtr" style=" display: none;">
               <ttr id="index">
                  <ttd>index</ttd>
                  <ttd><input class="name" size="10" value=""></ttd>
                  <ttd><input type="text" class="id" size="10" value=""></ttd>
                  <ttd><input type="password" class="pwd" size="10" value=""></ttd>
                  <ttd><input type="password" class="pwdCheck" size="10" value=""></ttd>
                  <ttd>
                     <select class="jikup_code" onchange="changeJikup();" style="width: 75px;">
                        <option value="">선택</option>
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
                  </ttd>
                  <ttd>
                  <select class="dept_code">
                     <option value="">선택</option>
                     <option value="2">인사부</option>
                     <option value="3">영업부</option>
                     <option value="4">관리부</option>
                  </select>
                  </ttd>
                  <ttd><input type="text" class="email" size="15" value=""></ttd>
                  <ttd><input type="text" class="phone_num" size="15" value="" placeholder="010-0000-0000"></ttd>
                  <ttd style="padding: 0 10px 0 0;">
                     <button onclick="deleteItem(this)"><span class="glyphicon glyphicon-minus"></span></button>
                  </ttd>
               </ttr>
            </div>
            
            
            <div class="button_div">
               <input type="button" value="인원 추가" onClick="addItem()">
               <input type="button" value="결재라인등록" onClick="checkApprovalLine()">
                 <input type="button" value="화면닫기" onClick="goLoginForm()">
            </div>
      </div><!-- container -->
   </body>
</html>