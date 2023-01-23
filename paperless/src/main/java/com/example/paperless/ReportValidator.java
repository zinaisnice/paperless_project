package com.example.paperless;

import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class ReportValidator implements Validator{
	
	@Override
	public boolean supports(Class<?> arg0) {
		return ReportDTO.class.isAssignableFrom(arg0); // 검증할 객체의 클래스 타입 정보
	}
	
	@Override
	public void validate(Object obj, Errors errors) {
		try {
			
			ReportDTO rto = (ReportDTO)obj;
			
			String title = rto.getTitle();
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title", "작성자명을 입력 해주세요.");
			if(Pattern.matches("^[가-힣]{2,10}$", title) == false) {
				errors.rejectValue("title", "제목은 한글 2~10까지 입력 해야합니다.");
			}
			
			String content = rto.getContent();
			ValidationUtils.rejectIfEmptyOrWhitespace(errors, "content", "내용을 입력 해주세요.");
			if(Pattern.matches("^.{1,300}$", content) == false) {
				errors.rejectValue("content", "내용은 1~300자 내로 작성해주세요.");
			}
			if(content.toUpperCase().indexOf("<SCRIPT>") >= 0) {
				errors.rejectValue("content", "내용에는 <script> 단어가 들어갈 수 없습니다.");
			}
			
			
		}catch(Exception ex) {
			System.out.println("ReportValidator.validate 에러 발생");
		}
	}
}
