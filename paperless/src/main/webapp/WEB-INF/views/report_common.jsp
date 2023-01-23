<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="/css/report_common.css" rel="stylesheet">

<script>

	$(function(){
		var moneyObj = $(".money");
		moneyObj.keyup(function(){
			var money = $(this).val();
			var num ="";
			for(var i = 0; i < money.length; i++){
				var str = money.charAt(i);
				if(new RegExp(/^[0-9]{1}$/).test(str)) num = num + str;
			}
			
			while(num.length >= 2 && num.indexOf("0") == 0){
				num = num.substring(1);
			}
			
			while(num.length > 7){
				num = num.substring(0,7);
			}
			
			var result = "";
			var arr = num.split("");
			var cnt = 0;
			for(var i = arr.length - 1; i >= 0; i--){
				cnt++;
				if(cnt % 3 == 0 && i != 0){
					arr[i] = "," + arr[i];
				}
			}
			result = arr.join("");
			$(this).val(result);
		}); // moneyObj.keyup
	});
	
	
	function checkValue(type){
	      
	      
		   
	      if(type == 1 || type == 2 || type == 3){   
	         var titleObj = $(".title");
	         var title = titleObj.val();
	         if( typeof(title) != "string" ) title = "";
	         title = $.trim(title);
	         titleObj.val(title);
	         if(new RegExp(/^[\w\s가-힣.]{2,10}$/).test(title) == false){
	            alert("제목은 2~10자로 입력해야합니다.");
	            titleObj.val("");
	            return 1;
	         }
	      }   
	      
	      if(type == 1 || type == 2 || type == 3){
	         var type_code = $("[name=type_code]").val();
	         if(type_code == ""){
	            alert("업무 구분을 선택해주세요.");
	            return 1;
	         }
	      }
	      
	      
	      var next_emp_no = $(".next_emp_no").val();
	      if(next_emp_no == ""){
	         alert("다음 결재자를 선택해주세요.");
	         return 1;
	      }
	      
	      // 일일 보고서
	      
	      if(type == 1){
	         var date = $("[type=date]").val();
	         if(date == ""){
	            alert("업무 날짜를 선택해주세요.");
	            return 1;
	         }
	         
	         var start_time = $(".start_time").val();
	         if(start_time == ""){
	            alert("업무 시작 시간을 선택해주세요.");
	            return 1;
	         }
	         
	         var end_time = $(".end_time").val();
	         if(end_time == ""){
	            alert("업무 종료 시간을 선택해주세요.");
	            return 1;
	         }
	      
	         if(start_time > end_time){
	            alert("업무 시작 시간보다 종료 시간이 빠를 수 없습니다.");
	            $(".end_time").val("");
	            return 1;
	         }
	         
	         /// 
	         var today = new Date();
	         var today_year = today.getFullYear();
	         var today_month = today.getMonth() + 1;
	         var today_date = today.getDate();
	         
	         //------------------------------
	         
	         today_year = (today_year < 10)? '0' + today_year : today_year;
	         today_month = (today_month < 10)? '0' + today_month : today_month;
	         today_date = (today_date < 10)? '0' + today_date : today_date;
	         var today_day = today_year + "-" + today_month + "-" + today_date;
	         
	         if( date > today_day ){
	            alert("해당 업무 시작 날짜가 유효하지 않습니다.  현재 날짜 혹은 이전 날짜를 선택해주십시오.");
	            $("[type=date]").val("");
	            return 1;
	         }
	         
	         ///
	         var contentObj = $(".content");
	         var content = contentObj.val();
	         if( typeof(content) != "string" ) content = "";
	         content = $.trim(content);
	         contentObj.val(content);
	         if(new RegExp(/^[\w\s가-힣.]{2,300}$/).test(content) == false){
	            alert("업무 내용은 1~300자로 입력해야합니다.");
	            contentObj.val("");
	            return 1;
	         }
	      }
	      
	      // 지출 보고서
	      if(type == 2){
	         var cost = $(".cost").val();
	         if(cost == ""){
	            alert("비용을 입력해주세요.");
	            return 1;
	         }
	         
	         var method_code = $(".method_code").val();
	         if(method_code == ""){
	            alert("지출 수단을 선택해주세요.");
	            return 1;
	         }
	         
	         var receipt_noObj = $(".receipt_no");
	         var receipt_no = receipt_noObj.val();
	         if( typeof(content) != "string" ) content = "";
	         receipt_no = $.trim(receipt_no);
	         receipt_noObj.val(receipt_no);
	         if(receipt_no == ""){
	            alert("영수증 번호를 입력해주세요.");
	            return 1;
	         }
	         if(new RegExp(/^[0-9]{1,10}$/).test(receipt_no) == false){
	            alert("영수증 번호는 숫자만 입력가능합니다.");
	            receipt_noObj.val("");
	            return 1;
	         }
	         
	         var expense_date = $(".expense_date").val();
	         if(expense_date == ""){
	            alert("지출일을 선택해주세요.");
	            return 1;
	         }
	         
	         /// 
	         var today = new Date();
	         var today_year = today.getFullYear();
	         var today_month = today.getMonth() + 1;
	         var today_date = today.getDate();
	         
	         //------------------------------
	         
	         today_year = (today_year < 10)? '0' + today_year : today_year;
	         today_month = (today_month < 10)? '0' + today_month : today_month;
	         today_date = (today_date < 10)? '0' + today_date : today_date;
	         var today_day = today_year + "-" + today_month + "-" + today_date;
	         
	         if( expense_date > today_day ){
	            alert("해당 지출일이 유효하지 않습니다. 현재 날짜 혹은 이전 날짜를 선택해주십시오.");
	             $(".expense_date").val("");
	            return 1;
	         }
	         
	        
	         
	         var noteObj = $(".note");
	         var note = noteObj.val();
	         if( typeof(note) != "string" ) note = "비고없음";
	         note = $.trim(note);
	         noteObj.val(note);
	         /*
	         if(new RegExp(/^[\w\s가-힣.,]{1,30}$/).test(음표) == false){
	            alert("비고는 1~30자로 입력해야합니다.");
	            noteObj.val("");
	            return 1;
	         }
	         */
	         
	      }
	      
	      
	      // 영업 보고서
	      if(type == 3){
	         var sales_companyObj = $(".sales_company");
	         var sales_company = sales_companyObj.val();
	         if( typeof(sales_company) != "string" ) sales_company = "";
	         sales_company = $.trim(sales_company);
	         sales_companyObj.val(sales_company);
	         if(new RegExp(/^[\w\s가-힣]{2,10}$/).test(sales_company) == false){
	            alert("회사이름은 특수문자제외 2~10자로 입력해야합니다.");
	            sales_companyObj.val("");
	            return 1;
	         }
	         
	         var sales_nameObj = $(".sales_name");
	         var sales_name = sales_nameObj.val();
	         if( typeof(sales_name) != "string" ) sales_name = "";
	         sales_name = $.trim(sales_name);
	         sales_nameObj.val(sales_name);
	         if(new RegExp(/^[가-힣]{2,10}$/).test(sales_name) == false){
	            alert("만난 사람 이름은 한글 2~10자로 입력해야합니다.");
	            sales_nameObj.val("");
	            return 1;
	         }
	         
	         //직급
	         var sales_jikupObj = $(".sales_jikup");
	            var sales_jikup = sales_jikupObj.val();
	            if( typeof(sales_jikup) != "string" ) sales_jikup = "";
	            sales_jikup = $.trim(sales_jikup);
	            sales_jikupObj.val(sales_jikup);
	            if(new RegExp(/^[가-힣]{2,8}$/).test(sales_jikup) == false){
	               alert("직급은 2~8자로 입력해야 합니다.");
	               sales_jikupObj.val("");
	               return 1;
	            }
	            
	            //핸드폰번호
	            var sales_phoneObj = $(".sales_phone");
	            var sales_phone = sales_phoneObj.val();
	            if( typeof(sales_phone) != "string" ) sales_phone = "";
	            sales_phone = $.trim(sales_phone);
	            sales_phoneObj.val(sales_phone);
	            if(new RegExp(/^(?:(010-\d{4})|(01[1|6|7|8|9]-\d{3,4}))-(\d{4})$/).test(sales_phone) == false){
	               alert("핸드폰 번호는 '-'를 넣어서 입력해주세요.");
	               sales_phoneObj.val("");
	               return 1;
	            }
	       
	            // 시작일
	            var start_day = $(".start_day").val();
	            if(start_day == ""){
	               alert("시작일을 선택해주세요.");
	            return 1; 
	           
	            }    
	            ///
	            var today = new Date();
	            var today_year = today.getFullYear();
	            var today_month = today.getMonth() + 1;
	            var today_date = today.getDate();
	            
	            //------------------------------
	           today_year = (today_year < 10)? '0' + today_year : today_year;
	           today_month = (today_month < 10)? '0' + today_month : today_month;
	           today_date = (today_date < 10)? '0' + today_date : today_date;
	           var today_day = today_year + "-" + today_month + "-" + today_date;
	           
	           if( start_day > today_day ){
	               alert("해당 업무 시작 날짜가 유효하지 않습니다.  현재 날짜 혹은 이전 날짜를 선택해주십시오.");
	               $(".start_day").val("");
	               return 1;
	            }
	           
	           ///
	            var start_time = $(".start_time").val();
	            if(start_time == ""){
	               alert("시작 시간을 선택해주세요.");
	               return 1;
	            }
	            
	            var end_day = $(".end_day").val();
	            if(end_day == ""){
	               alert("종료일을 선택해주세요.");
	               return 1;
	            }
	            
	            if( end_day > today_day ){
	                alert("해당 업무 종료 날짜가 유효하지 않습니다.  현재 날짜 혹은 이전 날짜를 선택해주십시오.");
	                $(".end_day").val("");
	                return 1;
	             }
	            
	            
	            var end_time = $(".end_time").val();
	            if(end_time == ""){
	               alert("종료 시간을 선택해주세요.");
	               return 1;
	            }
	            
	            if(start_day > end_day){
	               alert("시작일보다 종료일이 빠를 수 없습니다.");
	               $(".end_day").val("");
	               return 1;
	            }
	            
	            if(start_day == end_day){
	               if(start_time > end_time){
	                  alert("시작 시간보다 종료 시간이 빠를 수 없습니다.");
	                  $(".end_time").val("");
	                  return 1;
	               }
	            }
	         
	            
	          
	            
	            var contentObj = $(".sales_content");
	            var content = contentObj.val();
	            if( typeof(content) != "string" ) {content = "";}
	            content = $.trim(content);
	            contentObj.val(content);
	            if(new RegExp(/^[\w\s가-힣.]{1,300}$/).test(content) == false){
	               alert("업무 내용은 특수문자제외 1~300자로 입력해야합니다.");
	               contentObj.val("");
	               return 1;
	            }
	            
	            
	            
	            //
	            var sales_resultObj = $(".sales_result");
	            var sales_result = sales_resultObj.val();
	            if( typeof(sales_result) != "string" ) {sales_result = "";}
	            sales_result = $.trim(sales_result);
	            sales_resultObj.val(sales_result);
	            if(new RegExp(/^[\w\s가-힣.]{1,300}$/).test(sales_result) == false){
	               alert("영업 성과는 1~300자로 입력해야합니다.");
	               sales_resultObj.val("");
	               return 1;
	            }
	         }
	      
	      
	      // 휴가원
	      if(type == 4){
	         var type_code = $("[name=type_code]:checked").val();
	         if(typeof(type_code) == "undefined"){
	            alert("업무 구분을 선택해주세요.");
	            return 1;
	         }
	         
	         var start_day = $(".start_day").val();
	         if(start_day == ""){
	            alert("시작일을 선택해주세요.");
	            return 1;
	         }
	         
	         var start_time = $(".start_time").val();
	         if(start_time == ""){
	            alert("시작 시간을 선택해주세요.");
	            return 1;
	         }
	         
	         var end_day = $(".end_day").val();
	         if(end_day == ""){
	            alert("종료일을 선택해주세요.");
	            return 1;
	         }
	         
	         var end_time = $(".end_time").val();
	         if(end_time == ""){
	            alert("종료 시간을 선택해주세요.");
	            return 1;
	         }
	         
	         if(start_day > end_day){
	            alert("시작일보다 종료일이 빠를 수 없습니다.");
	            $(".end_day").val("");
	            return 1;
	         }
	         
	         if(start_day == end_day){
	            if(start_time > end_time){
	               alert("시작 시간보다 종료 시간이 빠를 수 없습니다.");
	               $(".end_time").val("");
	               return 1;
	            }
	         }
	         
	         
	         var contentObj = $(".content");
	         var content = contentObj.val();
	         if( typeof(content) != "string" ) content = "";
	         content = $.trim(content);
	         contentObj.val(content);
	         if(new RegExp(/^[\w\s가-힣.]{1,300}$/).test(content) == false){
	            alert("업무 내용은 1~300자로 입력해야합니다.");
	            contentObj.val("");
	            return 1;
	         }
	      }
	   }
	</script>