<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/mainCatagory.jsp" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>직원 상세 정보</title>
		
		<script>
			$(function(){
				$(".emp_img").error(function(){
					$(".emp_img").attr("src", "/img/basic.jpg");
				});
				
				<c:if test="${requestScope.role == 'MANAGER'}">
					$("#manager_li").addClass("focusCatagory");
				</c:if>
				
				<c:if test="${requestScope.role == 'USER'}">
					$("#mypage_li").addClass("focusCatagory");
				</c:if>
				
				
				<c:if test="${requestScope.role == 'MANAGER'}">
					$("[name=jikup_code]").val(${requestScope.empDTO.jikup_code});
					$("[name=dept_code]").val(${requestScope.empDTO.dept_code});
					$("[name=pwd]").val("${requestScope.empDTO.pwd}");
					$("[name=email]").val("${requestScope.empDTO.email}");
					$("[name=phone_num]").val("${requestScope.empDTO.phone_num}");
				</c:if>
				
				<c:if test="${requestScope.role == 'USER'}">
					$("[name=jikup_code]").val(${requestScope.employeeDTO.jikup_code});
					$("[name=dept_code]").val(${requestScope.employeeDTO.dept_code});
					$("[name=pwd]").val("${requestScope.employeeDTO.pwd}");
					$("[name=email]").val("${requestScope.employeeDTO.email}");
					$("[name=phone_num]").val("${requestScope.employeeDTO.phone_num}");
				</c:if>
			});
			
			function goEmployeeUpdate(){
				var formObj = $("[name=employeeUpForm]");
				
				var emp_name = formObj.find(".emp_name").val();
				var regExp = new RegExp(/^[가-힣]{2,7}$/);
				if( regExp.test(emp_name)==false ){
					alert("이름을 입력해주세요");
					formObj.find(".emp_name").val("");
					return;
				}
				
				
				
				/*
				var pwd = formObj.find(".newPwd").val();
				var regExp = new RegExp(/^[a-z0-9]{3,8}$/);
				if( regExp.test(pwd)==false ){
					alert("암호는 영소문 또는 숫자로 구성되고 3-8자 입력 해야합니다.");
					formObj.find(".newPwd").val("");
					return;
				}
				*/
				var newPwd = formObj.find(".newPwd").val();			// 추가
				var regExp = new RegExp(/^[a-z0-9]{3,8}$/);
				if( regExp.test(newPwd) == false ){
					if(newPwd == "") {
						
					} else {
						alert("새 비밀번호를 입력해주세요.");
						formObj.find(".newPwd").val("");
						return;
					}
				}
				
				var pwdCheck = formObj.find(".pwdCheck").val();		// 추가
                if(pwdCheck != newPwd) {
                   alert("새 비밀번호와 다릅니다. 다시 입력해주세요.");
                   formObj.find(".pwdCheck").val("");
                   return;
                }
				
				var email = formObj.find(".email").val();
				var regExp = new RegExp('^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$');
				if( regExp.test(email)==false ){
					alert("올바른 이메일 형식을 입력해주세요.");
					formObj.find(".email").val("");
					return;
				}
				
				var phone_num = formObj.find(".phone_num").val();
		        var regExp = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/;
		        if( regExp.test(phone_num)==false ){
		           alert("전화번호는  - 을 포함해서 작성해주세요.");
		           formObj.find(".phone_num").val("");
		           return;
		        }
		        
				if(confirm("직원 정보를 수정하시겠습니까?") == false) return;
				
				$.ajax({
					url:"/employeeUpProc.do"
					, type:"post"
					, data:$("[name=employeeUpForm]").serialize()
					, success:function(UpCnt){
						if(UpCnt == 1){
							alert("직원 정보 수정 완료");
							document.GoemployeeListForm.submit();
						}
						else{
							alert(UpCnt);
						}
					}
				});
			}
			
			function goEmployeeUpdate_Mypage(){
				var formObj = $("[name=employeeUpForm]");
				
				/*
				var pwd = formObj.find(".pwd").val();				// 변경
				if(${requestScope.employeeDTO.pwd} != pwd) {
					alert("비밀번호가 다릅니다. 다시 입력해주세요.");
					formObj.find(".pwd").val("");
					return;
				}
				
				 if( regExp.test(pwd) == false ){
					var regExp = new RegExp(/^[a-z0-9]{3,8}$/);
					formObj.find(".pwd").val("");
					return;
				} */
				
				var newPwd = formObj.find(".newPwd").val();			// 추가
				var regExp = new RegExp(/^[a-z0-9]{3,8}$/);
				if( regExp.test(newPwd) == false ){
					if(newPwd == "") {
						
					} else {
						alert("새 비밀번호를 입력해주세요.");
						formObj.find(".newPwd").val("");
						return;
					}
				}
				
				var pwdCheck = formObj.find(".pwdCheck").val();		// 추가
                if(pwdCheck != newPwd) {
                   alert("새 비밀번호와 다릅니다. 다시 입력해주세요.");
                   formObj.find(".pwdCheck").val("");
                   return;
                }
				
				var email = formObj.find(".email").val();
				var regExp = new RegExp('^[a-z0-9]+@[a-z]+\.[a-z]{2,3}$');
				if( regExp.test(email)==false ){
					alert("올바른 이메일 형식을 입력해주세요.");
					formObj.find(".email").val("");
					return;
				}
				
				var phone_num = formObj.find(".phone_num").val();
		        var regExp = /^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/;
		        if( regExp.test(phone_num)==false ){
		           alert("전화번호는  - 을 포함해서 작성해주세요.");
		           formObj.find(".phone_num").val("");
		           return;
		        }
		        
				if(confirm("내 정보를 수정하시겠습니까?") == false) return;
				if(newPwd!="") formObj.find(".pwd").val(newPwd);		// 추가
				
				
				$.ajax({
					url:"/myEmployeeUpProc.do"
					, type:"post"
					, data:$("[name=employeeUpForm]").serialize()
					, success:function(UpCnt){
						if(UpCnt == 1){
							alert("내 정보 수정 완료");
							document.myPageForm.submit();
						}
						else{
							alert(UpCnt);
						}
					}
				});
			}
		</script>
	</head>
	<body>
		<div class="container" style="width:800px">
			<div>
				<h4>[직원 정보]</h4>
			</div>
			<form name="employeeUpForm">
				<table class="empInfoTable">
					<tr>
							<c:if test="${requestScope.role == 'MANAGER'}">		<!-- 위치 변경함 -->
							<td rowspan="9" style="width:400px">
								<img class="emp_img" alt="사원사진" src="/img/basic.jpg" style="width:270px; height: 330px;">
							</c:if>
							
							<c:if test="${requestScope.role == 'USER'}">
							<td rowspan="9" style="width:400px">
								<img class="emp_img" alt="사원사진" src="/img/basic.jpg" style="width:270px; height: 330px;">
							</c:if>
							
						</td>
						<th>이 름</th>
						<td>
							<c:if test="${requestScope.role == 'MANAGER'}">
								<input type="text" name="emp_name" class="emp_name" value="${requestScope.empDTO.emp_name}">
							</c:if>
							
							<c:if test="${requestScope.role == 'USER'}">
								${requestScope.employeeDTO.emp_name}
							</c:if>
						</td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<c:if test="${requestScope.role == 'MANAGER'}">
								${requestScope.empDTO.id}
							</c:if>
							
							<c:if test="${requestScope.role == 'USER'}">
								${requestScope.employeeDTO.id}
							</c:if>
						</td>
					</tr>
					<!-- <tr>
						<th>비밀번호</th>
						<td>
							<input type="password" name="pwd" class="pwd" value="">	
						</td>
					</tr> -->
														<!-- 추가함 -->
					<tr>
						<th>새 비밀번호</th>
						<td>
							<input type="password" name="newPwd" class="newPwd" value="">				
						</td>
					</tr>
					<tr>
						<th>비밀번호확인</th>
						<td>
							<input type="password" name="pwdCheck" class="pwdCheck" value="">				
						</td>
					</tr>
					
					<tr>
						<th>직 급</th>
						<td>
							<c:if test="${requestScope.role == 'MANAGER'}">
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
							</c:if>
							<c:if test="${requestScope.role == 'USER'}">
								${requestScope.employeeDTO.jikup_name}
							</c:if>
						</td>
					</tr>
					<tr>
						<th>부 서</th>
						<td>
							<c:if test="${requestScope.role == 'MANAGER'}">
							<select name="dept_code">
								<option value="2">인사부
								<option value="3">영업부
								<option value="4">관리부
							</select>
							</c:if>
							<c:if test="${requestScope.role == 'USER'}">
								${requestScope.employeeDTO.dept_name}
							</c:if>
						</td>
					</tr>
					<tr>
						<th>이메일</th>
						<td>
							<input type="text" name="email" class="email" value="">
						</td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td>
							<input type="text" name="phone_num" class="phone_num" value="">
						</td>
					</tr>
				</table>
				<c:if test="${requestScope.role == 'MANAGER'}">
					<input type="hidden" name="emp_no" class="emp_no" value="${requestScope.empDTO.emp_no}">
				</c:if>
				
				<c:if test="${requestScope.role == 'USER'}">
					<input type="hidden" name="emp_no" class="emp_no" value="${requestScope.employeeDTO.emp_no}">
				</c:if>
				
			</form><!-- employeeRegForm -->
			
			<div class="button_div">
				<c:if test="${requestScope.role == 'MANAGER'}">
					<input type="button" value="수정" onClick="goEmployeeUpdate()">
					<input type="button" value="목록" onClick="goEmployeeList()">
				</c:if>
				<c:if test="${requestScope.role == 'USER'}">
					<input type="button" value="수정" onClick="goEmployeeUpdate_Mypage()">
				</c:if>
				
			</div>
			
			<form name="employeeDetailForm" method="post" action="/employeeDetail.do">
				<input type="hidden" name="id" value="${requestScope.empDTO.id}">
			</form>
			<form name="myPageForm" method="post" action="/myPage.do">
				<input type="hidden" name="id" value="${requestScope.employeeDTO.id}">
			</form>
			
			<form name="GoemployeeListForm" method="post" action="/employeeList.do">
				
			</form>
		</div><!-- container -->
	</body>
</html>