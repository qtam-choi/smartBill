package com.smartbill.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.smartbill.service.impl.common.CommonActionImpl;
import com.smartbill.service.impl.common.LoginActionImpl;
import com.smartbill.service.impl.common.MainFormImpl;

@Controller
public class CommonController {
	
	
	@Autowired
	LoginActionImpl loginActionImpl;
	
	@Autowired
	MainFormImpl mainFormImpl;
	
	@Autowired
	CommonActionImpl commonActionImpl;
	
		

	/**********************************************
	 * 로그인 관련
	 **********************************************/
	// 로그인 폼 
	@RequestMapping("/login.do")  
	public ModelAndView danalRest0101(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		
		ModelAndView modelAndView = new ModelAndView("");
		modelAndView.setViewName("login");
		
		return modelAndView;
	}
	
	//로그인 프로세스
	@RequestMapping("/loginAction.do") 
	public ModelAndView danal0101Action(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		
		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		Map paramMap = new HashMap();
		
		Enumeration req = request.getParameterNames();

		 while(req.hasMoreElements()){
			 String key = req.nextElement().toString();
			 String value = request.getParameter(key);
			 
			 paramMap.put(key, value);
		 }
		 paramMap.put("clientIp", request.getRemoteAddr());
		
		 Map resultMap = (Map)loginActionImpl.serviceCall(paramMap);
		 
		 
		 if(resultMap.get("RETURN_CODE").equals("S")){
			HttpSession session = request.getSession();
			session.setAttribute("USER_INFO", resultMap.get("userInfo"));
		 }
		
		modelAndView.addAllObjects(resultMap);
		
		return modelAndView;
	}
	
	//로그아웃 
	@RequestMapping("/logout.do")
	public ModelAndView adminLogout(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		
		HttpSession session = request.getSession();
		session.invalidate();

		String url =  "redirect:login.do";
		return new ModelAndView(url);
		
	}
	
	
	/**********************************************
	 * 메인 
	 **********************************************/
	// 메인 폼 
	@RequestMapping("/main.do")  
	public ModelAndView main(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		
		
		
		ModelAndView modelAndView = new ModelAndView("");
		
		Map paramMap = new HashMap();
		
		Enumeration req = request.getParameterNames();

		 while(req.hasMoreElements()){
			 String key = req.nextElement().toString();
			 String value = request.getParameter(key);
			 
			 paramMap.put(key, value);
		 }
		 
		 modelAndView.setViewName("common/main");
		
		Map resultMap = (Map)mainFormImpl.serviceCall(paramMap);
		
		Set<String> keys = resultMap.keySet();
		
		for(String key : keys){
			modelAndView.addObject(key, resultMap.get(key));
		}
		
		return modelAndView;
	
	}
	
	
	/***********************************************
	 * CURL
	 * ********************************************/

	//구매정보 등록/수정 등 action 
	@RequestMapping("/common/commonAction.do") 
	public ModelAndView menu0101Action(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		
		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		Map paramMap = new HashMap();
		
		Enumeration req = request.getParameterNames();

		 while(req.hasMoreElements()){
			 String key = req.nextElement().toString();
			 String value = request.getParameter(key);
			 
			 paramMap.put(key, value);
		 }
		 paramMap.put("clientIp", request.getRemoteAddr());
		
		 Map resultMap = (Map)commonActionImpl.serviceCall(paramMap);
		
		modelAndView.addAllObjects(resultMap);
		
		return modelAndView;
	}
	
	
}
