package com.smartbill.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.smartbill.service.impl.menu03.Menu0301ActionImpl;
import com.smartbill.service.impl.menu03.Menu0301DetailImpl;
import com.smartbill.service.impl.menu03.Menu0301Impl;

@Controller
public class Menu03Controller {
	
	
	@Autowired
	Menu0301Impl menu0301Impl;
	
	@Autowired
	Menu0301ActionImpl menu0301ActionImpl;
	
	@Autowired
	Menu0301DetailImpl menu0301DetailImpl;
	

	
	

	/**********************************************
	 * admin 사용자 관리
	 **********************************************/
	// 구매관리 리스트
	@RequestMapping("/menu03/menu0301.do")  
	public ModelAndView menu0301(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		

		ModelAndView modelAndView = new ModelAndView("");
		
		Map paramMap = new HashMap();
		
		Enumeration req = request.getParameterNames();

		 while(req.hasMoreElements()){
			 String key = req.nextElement().toString();
			 String value = request.getParameter(key);
			 
			 paramMap.put(key, value);
		 }
		 
		modelAndView.setViewName("menu03/menu0301");
		
		Map resultMap = (Map)menu0301Impl.serviceCall(paramMap);
		
		Set<String> keys = resultMap.keySet();
		
		for(String key : keys){
			modelAndView.addObject(key, resultMap.get(key));
		}
		
		return modelAndView;
	}
	
	
	//등록/수정 등 action 
	@RequestMapping("/menu03/menu0301Action.do") 
	public ModelAndView menu0301Action(HttpServletRequest request,
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
		
		 Map resultMap = (Map)menu0301ActionImpl.serviceCall(paramMap);
		
		modelAndView.addAllObjects(resultMap);
		
		return modelAndView;
	}
	
	
	//Detail
	@RequestMapping("/menu03/menu0301Reg.do")
	public ModelAndView menu0301Reg(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		
		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.setViewName("menu03/menu0301Reg");
		return modelAndView;
	}
	
	
	//Detail
	@RequestMapping("/menu03/menu0301Detail.do")
	public ModelAndView menu0301Detail(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		
		ModelAndView modelAndView = new ModelAndView("jsonView");
		
		modelAndView.setViewName("menu03/menu0301Detail");
		
		Map paramMap = new HashMap();
		
		Enumeration req = request.getParameterNames();

		 while(req.hasMoreElements()){
			 String key = req.nextElement().toString();
			 String value = request.getParameter(key);
			 
			 paramMap.put(key, value);
		 }
		
		Map serviceMap = (Map)menu0301DetailImpl.serviceCall(paramMap);
		
		Set<String> keys = serviceMap.keySet();
		
		for(String key : keys){
			modelAndView.addObject(key, serviceMap.get(key));
		}
		
		return modelAndView;
	}
	
	
	
		
	
}
