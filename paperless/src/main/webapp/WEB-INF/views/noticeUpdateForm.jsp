<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/mainCatagory.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항 수정</title>
		
		<script>
			// 수정 관련 유효성 체크, 비동기 방식으로 웹 서버에 접속하는 함수 선언
			function goNoticeUp() {
				if(confirm("공지사항을 수정하시겠습니까?") == false) return;
				
				$.ajax({
					url : "/noticeUpProc.do"
					, type : "post"
					,data: $("[name=noticeUpForm]").serialize()
					, success:function(json){
		
						var msg = json["msg"];
						var noticeUpCnt = json["noticeUpCnt"];
		
						if( msg != "" ){
							alert(msg);
							return;
						}
						
						if(msg == "" && noticeUpCnt == 1 ){
							alert("공지사항 수정 완료");
							document.noticeListForm.submit();
						}else if(msg == "" && noticeUpCnt == 0 ){
							alert("이미 삭제된 게시물입니다.");
							document.noticeListForm.submit();
						}
					}
					, error : function(request, status, error){
						alert("웹 서버 접속에 실패하였습니다.");
				        console.log("code: " + request.status);
				        console.log("message: " + request.responseText);
				        console.log("error: " + error);
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
			<form name="noticeUpForm">
				<h4 align="left"> 공지사항 수정</h4>
				<table>
					<tr>
						<th>작성자</th>
						<td>${requestScope.employeeDTO.emp_name}</td>
					</tr>
					<tr>
						<th>제목</th>
						<td><input name="title" class="title" size="45" maxlength="100" value="${requestScope.noticeDTO.title}"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
							<textarea name="content"  class="content" cols="70" rows="30">${requestScope.noticeDTO.content}</textarea>
						</td>
					</tr>
				</table>
				<input type="hidden" name="n_no" value="${requestScope.noticeDTO.n_no}">
			</form><!-- noticeUpForm -->
			
			<br>
			<div class="button_div">
				<input type="button" value="수정" onClick="goNoticeUp()">      
				<input type="button" value="목록" onClick="goNoticeList()">
			</div>
		</div><!-- container -->
	</body>
</html>