package com.example.paperless;

import java.util.regex.Pattern;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

//NoticeDTO 객체에 저장된 데이터의 유효성 체크할 NoticeValidator 클래스 선언하기
public class NoticeValidator implements Validator {
	
	/*
	private String upRegMode;
	
	public NoticeValidator( String upRegMode ) {
		this.upRegMode = upRegMode;
	}
	*/
	
	// =============================================
	//  유효성 체크할 데이터가 저장된 DTO 객체의 클래스 타입 정보 얻어 리턴하기
	// =============================================
	@Override
	public boolean supports(Class<?> arg0) {
		return NoticeDTO.class.isAssignableFrom(arg0);  // 검증할 객체의 클래스 타입 정보
	}
	
	
	// =============================================
	//  유효성 체크할 메소드 선언하기
	// =============================================
	@Override
	public void validate(
		Object obj          // DTO 객체 저장 매개변수
		, Errors errors     // 유효성 검사 시 발생하는 에러를 관리하는 Errors 객체 저장 매개변수
	){
		try {
			
			// 유효성 체크할 DTO 객체 얻기
			NoticeDTO dto = (NoticeDTO)obj;

			
			// ------------------------[title]-----------------------------
			// ValidationUtils 클래스의 rejectIfEmptyOrWhitespace 메소드 호출하여
			// BoardDTO 객체의 속성변수명 title이 비거나 공백으로 구성되어 있으면
			// 경고 메시지를 Errors 객체에 저장하기
			ValidationUtils.rejectIfEmptyOrWhitespace(
				errors                      	// Errors 객체
				, "title"                   	// NoticeDTO 객체의 속성변수명
				, "제목을 입력해주세요."        // NoticeDTO 객체의 속성변수명이 비거나 공백으로 구성되어 있을때 경고 문구
			);

			
			// NoticeDTO 객체의 속성변수명 title 저장된 데이터가 1~20자 인데 이것을 위반하면
			// Errors 객체에 속성변수명 "title" 와  경고 메시지 저장하기
			// 이때 문자열의 패턴 검사는 Pattern 클래스의 matches 메소드를 이용한다.
			String title = dto.getTitle();
			if( title == null  ) { title = ""; }
			if( Pattern.matches(  "^.{1,20}$", title  ) == false ) {
				errors.rejectValue("title", "제목은 1-20자까지 입력해야합니다.");
			}
			
			
			// NoticeDTO 객체의 속성변수명 title 저장된 데이터에 "<script>" 또는 "<SCRIPT>"가 들어 있으면
			// Errors 객체에 속성변수명 "title" 와  경고 메시지 저장하기
			// 이때 문자열의 패턴 검사는 Pattern 클래스의 matches 메소드를 이용한다.
			if( title.toUpperCase().indexOf(  "<SCRIPT>"   ) >= 0  ) {
                errors.rejectValue("title", "제목에 <script> 를 사용할 수 없습니다.");
            }
			// ------------------------[title]----------------------------- 
			
			
			
			// ------------------------[content]----------------------------- 

			ValidationUtils.rejectIfEmptyOrWhitespace(
				errors                       
				, "content"                   
				, "내용을 입력해주세요"
			);

			String  content = dto.getContent();
			if( content == null  ) { content = ""; }
			if( Pattern.matches(  "^.{1,1500}$", content  ) == false ) {
				errors.rejectValue("content", "내용은  1~1,500자까지 입력해야합니다.");
			}

			if( content.toUpperCase().indexOf(  "<SCRIPT>"   ) >= 0  ) {
                errors.rejectValue("content", "내용에 <script> 를 사용할 수 없습니다.");
            }
			// ------------------------[content]----------------------------- 
			
		}catch(Exception ex) {
			System.out.println( "BoardValidator.validate 메소드 실행 시 예외발생!" );
		}
		
	}
}
