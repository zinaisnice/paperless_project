<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 등록화면</title>
	
		<script>
			function regFormCheck() {
				if(confirm("공지사항을 등록하시겠습니까?") == false) return;
				
				$.ajax({
					url: "/noticeRegProc.do"
					,type: "post"
					,data:$("[name=noticeRegForm]").serialize()
					,success:function(json) {
						
						var msg = json["msg"];
						var noticeRegCnt = json["noticeRegCnt"];
						
						if( msg != "" ){
							alert(msg);
							return;
						}
						
						// 공지사항 입력 성공 행의 개수가 1이면, 즉 입력이 성공했으면
						if(msg == "" && noticeRegCnt == 1) {
							alert("공지사항 작성에 성공하였습니다.");
							location.replace("/noticeList.do");
						} else {
							alert("공지사항 작성에 실패하였습니다. ("+ json["msg"]+")" );
						}
					}
					, error:function() {
						alert("웹 서버 접속에 실패하였습니다.");
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
		<div class="container" style="width: 900px; margin-top: 100px;">
			<form name="noticeRegForm" method="post" action="">
				<h4> 공지사항 등록화면</h4>
				<table>
					<tr>
				        <th>작성자</th>
				        <td>${requestScope.employeeDTO.emp_name}</td>
				    </tr>
				    <tr>
				        <th>제목</th>
				        <td>
				        	<input name="title" class="title" size="45" maxlength="100" placeholder="제목을 입력해주세요.">
				        </td>
				    </tr>
				    <tr>
				     	<th>내용</th>
				     	<td>
				     		<textarea name="content" class="content" cols="70" rows="30" placeholder="내용을 입력해주세요."></textarea>
				     	</td>
				    </tr>
				</table>
				<input type="hidden" name="emp_no" value="${requestScope.employeeDTO.emp_no}"> <!-- 관리자번호 -->
				<input type="hidden" name="company_code" value="${requestScope.employeeDTO.company_code}">
				<input type="hidden" name="email" value="${requestScope.employeeDTO.email}"> <!-- 관리자이메일 -->
			</form><!-- noticeRegForm -->
			
			
			<br>
			<div class="button_div">
				<input type="button" value="등록" onClick="regFormCheck()">
				<input type="button" value="목록" onClick="goNoticeList()">
				<input type="button" value="초기화" >
			</div>
		</div><!-- container -->
	</body>
</html>