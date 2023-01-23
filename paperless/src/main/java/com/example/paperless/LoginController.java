package com.example.paperless;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

	@Autowired
	private LoginDAO loginDAO;
	
	@RequestMapping(value="/loginForm.do")
	public ModelAndView loginForm(){
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("loginForm");
	
		return  mav;
	}
	
	@RequestMapping( 
			value="/loginProc.do" 
			,method=RequestMethod.POST
			,produces="application/json;charset=UTF-8"
	)
	
	@ResponseBody
	public int loginProc(
			@RequestParam( value="id" ) String id
			, @RequestParam( value="pwd" ) String pwd
			, @RequestParam( value="is_login", required = false  ) String is_login
			, HttpSession session
			, HttpServletResponse response
	){
		Map<String,String> map = new HashMap<String,String>();
		
		map.put("id", id);
		map.put("pwd", pwd);
		
		int loginIdCnt = loginDAO.getLoginCnt(map);
		
		if( loginIdCnt == 1 ){
			
			session.setAttribute("id", id);
			if(is_login == null){
				Cookie cookie1 = new Cookie("id", null);
				cookie1.setMaxAge(0);
				
				Cookie cookie2 = new Cookie("pwd", null);
				cookie2.setMaxAge(0);
				
				response.addCookie(cookie1);
				response.addCookie(cookie2);
			}
			else {
				Cookie cookie1 = new Cookie("id", id);
				cookie1.setMaxAge(60*60*24);
				
				Cookie cookie2 = new Cookie("pwd", pwd);
				cookie2.setMaxAge(60*60*24);
	
				response.addCookie(cookie1);
				response.addCookie(cookie2);
			}
		}
		return loginIdCnt ;
	}
	
	
	@RequestMapping(value="/loginout.do")
	public ModelAndView loginout(HttpSession session){
		
		session.invalidate();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("loginForm");
	
		return  mav;
	}
	
	
	
}
