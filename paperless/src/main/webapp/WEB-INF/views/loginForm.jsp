<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/login_common.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>PAPERLESS</title>
		
		<script>
		$(function(){
			$("[name=reportListForm]").find(".report_code").val(1);
			
			$(".loginBtn").bind("click", function(){
				checkLoginForm();
			});
		});
		
		function checkLoginForm(){
			$.ajax({
				url:"/loginProc.do"
				, type:"post"
				, data:$("[name=loginForm]").serialize()
				, success:function(loginCnt){
					if(loginCnt == 1){
						document.dashboardForm.submit();
					}
					else{
						alert("아이디 또는 암호가 틀립니다.");
						$(".id").val("");
						$(".pwd").val("");
					}
				}
				,error:function(){
					alert("웹서버 접속 실패");
				}
			});
		}
		
		function goApprovalLineReg(){
			location.replace("/ApprovalLineReg.do");
		}
		</script>
	</head>
	<body>
		<div class="container">
			<div class="logo_div">
				<div class="logo_img">
					<img alt="" src="/img/logo.jpg">
				</div>
				<!-- <div class="logo">
					<span id="paper">PAPER</span><span id="less">LESS</span>
				</div> -->
			</div>
			
			<div class="login_form">
				<form name="loginForm">
					<div>
						<div class="row">
							<label><b>아이디</b></label>
						</div><!-- row -->
						<div class="row row_input">
							<div class="login_icon"><span class="glyphicon glyphicon-user"></span></div>
							<div class="login_input"><input type="text" name="id" class="id"></div>
						</div><!-- row -->
					</div>
					
					<div>
						<div class="row">
							<label><b>비밀번호</b></label>
						</div><!-- row -->
						<div class="row row_input">
							<div class="login_icon"><span class="glyphicon glyphicon-lock"></span></div>
							<div class="login_input"><input type="password" name="pwd" class="pwd"></div>
						</div><!-- row -->
					</div>
				</form>
			</div><!-- login_form -->
			
			<br>
			<div class="button_div">
				<input type="button" value="로그인" class="loginBtn">
				<!-- <input type="checkbox" name="is_login" class="is_login" value="yes" ${empty cookie.emp_no.value?'':'checked'}>아이디/암호 기억 -->
				<input type="button" value="회원 가입" style="background-color: white; color: gray; border-color: white;" onClick="goApprovalLineReg()">
			</div>
		</div><!-- container -->
	</body>
</html>