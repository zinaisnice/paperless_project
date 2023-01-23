package com.example.paperless;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class SessionInterceptor implements HandlerInterceptor{

	@Override
	public boolean preHandle(
			HttpServletRequest request
			, HttpServletResponse response
			, Object handler
	) throws Exception{
		
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String uri = request.getRequestURI();
		
		if(id == null) {
			response.sendRedirect("/loginForm.do");
			return false; 
		}
		else return true;
		
	}
}
