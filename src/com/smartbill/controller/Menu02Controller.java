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

import com.smartbill.service.impl.menu02.Menu0201Impl;

@Controller
public class Menu02Controller {
	
	
	@Autowired
	Menu0201Impl menu0201Impl;
	

	/**********************************************
	 * App 관리
	 **********************************************/
	// 구매관리 리스트
	@RequestMapping("/menu02/menu0201.do")  
	public ModelAndView menu0201(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		

		ModelAndView modelAndView = new ModelAndView("");
		
		Map paramMap = new HashMap();
		
		Enumeration req = request.getParameterNames();

		 while(req.hasMoreElements()){
			 String key = req.nextElement().toString();
			 String value = request.getParameter(key);
			 
			 paramMap.put(key, value);
		 }
		 
		 modelAndView.setViewName("menu02/menu0201");
		
		Map resultMap = (Map)menu0201Impl.serviceCall(paramMap);
		
		Set<String> keys = resultMap.keySet();
		
		for(String key : keys){
			modelAndView.addObject(key, resultMap.get(key));
		}
		
		return modelAndView;
	}
	
	
	
	
}
