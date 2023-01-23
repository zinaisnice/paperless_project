<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/WEB-INF/views/common.jsp" %>
<%@include file="/WEB-INF/views/mainCatagory.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항</title>
		
		<script>
			// 웹 브라우저가 body 태그 안을 모두 읽어들인 후 실행할 자바스크립트 코딩 설정
			$(function () {
				$("#notice_li").addClass("focusCatagory");
				
				// 등록 버튼을 클릭하면 "/noticeRegForm.do" URL 주소로 접속
				$(".newRegBtn").bind("click",function() {
					document.noticeRegForm.submit();
				});	
				
				// 검색 결과물이 출력되는 table 태그의 hover 이용하여 tr 태그 배경색 바꾸기
				$(".searchingResults").find("tr:eq(0)").nextAll().hover(
					<c:if test="${requestScope.noticeTotCnt != 0}">
					function(){
						$(this).addClass("mouseOntrBgC");
					}
					, function(){
						$(this).removeClass("mouseOntrBgC");
					}
					</c:if>
				);
				
				// class=sortHeader 를 가진 태그에 클릭이벤트가 발생하면 실행할 자바스크립트 코딩 설정
				$(".sortHeader").click(function(){
					var thisObj = $(this);
					var text = thisObj.text().trim();
					if( text == "조회수") {
						$(".sort").val( "readcount asc" )
					}
					else if( text == "조회수▲") {
						$(".sort").val( "readcount desc" )
					}
					else if( text == "조회수▼") {
						$(".sort").val( "" )
					}
					else if( text == "작성일") {
						$(".sort").val( "reg_date asc" )
					}
					else if( text == "작성일▲") {
						$(".sort").val( "reg_date desc" )
					}
					else if( text == "작성일▼") {
						$(".sort").val( "" )
					}
					
					$(".noticeSearchBtn").click();
				});
				
				
				// 검색 조건 관련 입력 양식에 흔적 남기기
				var formObj = $("[name=noticeSearchForm]");
				<c:if test="${!empty param.keyword1}">
					formObj.find(".keyword1").val("${param.keyword1}");
				</c:if>
				
				<c:if test="${!empty param.keyword2}">
					formObj.find(".keyword2").val("${param.keyword2}");
				</c:if>
				
				<c:if test="${!empty param.andOr}">
					formObj.find(".andOr").val("${param.andOr}");
				</c:if>
				 
				<c:if test="${!empty param.rowCntPerPage}">
					formObj.find(".rowCntPerPage").val("${param.rowCntPerPage}");
					$(".rowCntPerPage2").val("${param.rowCntPerPage}");
				</c:if>
				
				<c:if test="${!empty param.pageNoCntPerPage}">
					formObj.find(".pageNoCntPerPage").val("${param.pageNoCntPerPage}");
				</c:if>
				
				<c:forEach var="xxx" items="${paramValues.date}">
					formObj.find(".date").filter("[value='${xxx}']").prop("checked",true);
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
					})
				</c:if>
			});
			
			
			function goNoticeDetail(n_no) {
				$("[name=noticeDetailForm]").find("[name=n_no]").val(n_no);
				document.noticeDetailForm.submit();
			}
			
			function noticeSearch() {
				var formObj = $("[name=noticeSearchForm]");
				var keyword1 = formObj.find(".keyword1").val();
				
				if(typeof(keyword1) != "string") keyword1 = "";
				keyword1 = $.trim(keyword1);
				$(".keyword1").val(keyword1);
				
				var keyword2 = formObj.find(".keyword2").val();
				if(typeof(keyword2) != "string") keyword2 = "";
				keyword2 = $.trim(keyword2);
				$(".keyword2").val(keyword2);
				
				var rowCntPerPage = $(".rowCntPerPage2").val();
				$(".rowCntPerPage").val(rowCntPerPage);
				
				document.noticeSearchForm.submit();
			}
			
			
			function noticeAllSearch() {
				$(".keyword1").val("");
				$(".keyword2").val("");
				$(".andOr").val("and");
				
				$(".date").prop("checked",false);
				
				$(".noticeSearchBtn").click();
			}
			
			// [페이지 번호]를 클릭하면 호출되는 함수 선언
			function pageNoBtn(pageNo) {
				// class=selectPageNo 를 가진 입력양식에 선택한 페이지 번호를 value 값으로 삽입
				$(".selectPageNo").val(pageNo);
				noticeSearch();
			}
		</script>
	</head>
	<body>
		<div class="container">
		
		<h2 align="left"> 공지사항</h2>
		<form name="noticeSearchForm" method="post" action="/noticeList.do">
			<table class="searchTable" style="width: 750px;">
			    <tr>
			        <th style="width: 150px;">키워드</th>
			        <td>
			        	<input type="text" name="keyword1" class="keyword1" value="" placeholder="검색어1">
			        	<select name="andOr" class="andOr" style="margin: 0 10px;">
			                <option value="and">and</option>
			                <option value="or">or</option>
			            </select>
			            <input type="text" name="keyword2" class="keyword2" value="" placeholder="검색어2">
				        <input type="checkbox" name="date" class="date" value="-1" style="margin-left: 10px;">어제
				        <input type="checkbox" name="date" class="date" value="-0" style="margin-left: 10px;">오늘
			        </td>
			    </tr>
			</table><!-- searchTable -->
			<input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
			<input type="hidden" name="rowCntPerPage" class="rowCntPerPage" value="10">
			<input type="hidden" name="pageNoCntPerPage" class="pageNoCntPerPage" value="10">
			<input type="hidden" name="sort" class="sort">
			
			<div class="button_div">
				<input type="button" value="검색" class="noticeSearchBtn" onClick="noticeSearch();">
		        <input type="button" value="모두검색" class="noticeAllSearchBtn" onClick="noticeAllSearch();">
			</div>
			</form><!-- noticeSearchForm -->
			
			
			<div class="search" style="width: 800px; margin: 20px auto;">
					<div class="search_left" style="width: 100px;">
						<form name="noticeRegForm" method="post" action="/noticeRegForm.do">
							<c:if test="${requestScope.employeeDTO.role == 'MANAGER'}"> 
				            	<input type="button" value="등록" class="newRegBtn left">
				           	</c:if>
				           	<c:if test="${requestScope.employeeDTO.role != 'MANAGER'}"> 
				            	<div>&nbsp;</div>
				           	</c:if>
						</form>
					</div>
					
					
					<div class="search_right">
						<span>총 ${requestScope.noticeTotCnt} / ${requestScope.noticeAllTotCnt} 개</span>
						&nbsp; &nbsp;
						<select name="rowCntPerPage2" class="rowCntPerPage2 pointer" onChange="noticeSearch();">
			                <option value="10">10</option>
			                <option value="15">15</option>
			                <option value="20">20</option>
			            </select>개씩 보기
					</div><!-- search_right -->
					
					
					<div class="paging">
						<c:if test="${requestScope.noticeTotCnt > 0}">
			
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
			</div><!-- search -->
			
			
			<div class="searchingResults" style="width: 800px; margin: 0 auto;">
				<table>
		        	<tr style="height: 40px;">
			            <th style="width: 80px;">글번호</th>
			            <th>제목</th>
			            <th style="width: 150px;">글쓴이</th>
			            
			            <c:if test="${requestScope.employeeDTO.role == 'MANAGER'}">  
			            	<th><span style="cursor:pointer;" name="readcount" class="sortHeader" style="width: 80px;">조회수</span> </th>
			            	<th><span style="cursor:pointer;" name="reg_date" class="sortHeader" style="width: 200px;">작성일</span></th>
			           	</c:if>
			           	
			           	<c:if test="${requestScope.employeeDTO.role == 'USER'}"> 
			           		<th style="width: 80px;">조회수</th>
			           		<th style="width: 200px;">작성일</th>
			           	</c:if>
			        </tr>
			        
			        <c:if test="${requestScope.noticeTotCnt == 0}">
						<tr><td colspan="5">조회 가능한 공지사항이 없습니다.</td></tr>
					</c:if>
			        
			        <c:forEach var="notice" items="${requestScope.noticeList}" varStatus="loopTagStatus">
			        	<tr
			        		bgcolor="${loopTagStatus.index % 2 == 0?'white':'lightgray'}"
			        		style="cursor:pointer"
			        		onClick="goNoticeDetail(${notice.n_no})"
			        	>
			        		<td>${requestScope.pagingMap.serialNo - loopTagStatus.index}</td>	
			            	<td>${notice.title}</td>
			            	<td>${notice.emp_name}</td>
			            	<td>${notice.readcount}</td>
			            	<td>${notice.reg_date}</td>
			        	</tr>
			        </c:forEach>
				</table>
			</div><!-- searchingResults -->
			
			<form name="noticeDetailForm" method="post" action="/noticeDetail.do">
				<input type="hidden" name="n_no">
			</form>
		</div><!-- container -->
	</body>
</html>