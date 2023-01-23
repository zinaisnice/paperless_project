package com.example.paperless;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MvcConfiguration implements WebMvcConfigurer{
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new SessionInterceptor()).excludePathPatterns(
				"/loginForm.do"
				, "/loginProc.do"
				, "/ApprovalLineReg.do"
				, "/ApprovalLineProc.do"
				, "/js/**"
				, "/css/**"
				, "/img/**"
				, "/font/**"
		);
	}
	
}
