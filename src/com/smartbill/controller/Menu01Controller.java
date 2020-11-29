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

import com.smartbill.service.impl.menu01.Menu0101Detail2Impl;
import com.smartbill.service.impl.menu01.Menu0101DetailImpl;
import com.smartbill.service.impl.menu01.Menu0101Impl;
import com.smartbill.service.impl.menu01.Menu0102Impl;

@Controller
public class Menu01Controller {
	
	
	@Autowired
	Menu0101Impl menu0101Impl;
	
	@Autowired
	Menu0101DetailImpl menu0101DetailImpl;
	
	@Autowired
	Menu0101Detail2Impl menu0101Detail2Impl;
	
	@Autowired
	Menu0102Impl menu0102Impl;
	
	

	/**********************************************
	 * 전자영수증 회원관리
	 **********************************************/
	// 전자영수증 회원관리 리스트
	@RequestMapping("/menu01/menu0101.do")  
	public ModelAndView menu0101(HttpServletRequest request,
			ModelMap model, HttpServletResponse response) throws IOException {
		

		ModelAndView modelAndView = new ModelAndView("");
		
		Map paramMap = new HashMap();
		
		Enumeration req = request.getParameterNames();

		 while(req.hasMoreElements()){
			 String key = req.nextElement().toString();
			 String value = request.getParameter(key);
			 
			 paramMap.put(key, value);
		 }
		 
		 modelAndView.setViewName("menu01/menu0101");
		
		Map resultMap = (Map)menu0101Impl.serviceCall(paramMap);
		
		Set<String> keys = resultMap.keySet();
		
		for(String key : keys){
			modelAndView.addObject(key, resultMap.get(key));
		}
		
		return modelAndView;
	}
	
	
	
		
		//구매정보 Detail
		@RequestMapping("/menu01/menu0101Detail.do")
		public ModelAndView menu0101Detail(HttpServletRequest request,
				ModelMap model, HttpServletResponse response) throws IOException {
			
			ModelAndView modelAndView = new ModelAndView("jsonView");
			
			modelAndView.setViewName("menu01/menu0101Detail");
			
			Map paramMap = new HashMap();
			
			Enumeration req = request.getParameterNames();

			 while(req.hasMoreElements()){
				 String key = req.nextElement().toString();
				 String value = request.getParameter(key);
				 
				 paramMap.put(key, value);
			 }
			
			Map serviceMap = (Map)menu0101DetailImpl.serviceCall(paramMap);
			
			Set<String> keys = serviceMap.keySet();
			
			for(String key : keys){
				modelAndView.addObject(key, serviceMap.get(key));
			}
			
			return modelAndView;
		}
		
		
		//구매정보 Detail
		@RequestMapping("/menu01/menu0101Detail2.do")
		public ModelAndView menu0101Detail2(HttpServletRequest request,
				ModelMap model, HttpServletResponse response) throws IOException {
			
			ModelAndView modelAndView = new ModelAndView("jsonView");
			
			modelAndView.setViewName("menu01/menu0101Detail2");
			
			Map paramMap = new HashMap();
			
			Enumeration req = request.getParameterNames();

			 while(req.hasMoreElements()){
				 String key = req.nextElement().toString();
				 String value = request.getParameter(key);
				 
				 paramMap.put(key, value);
			 }
			
			Map serviceMap = (Map)menu0101Detail2Impl.serviceCall(paramMap);
			
			Set<String> keys = serviceMap.keySet();
			
			for(String key : keys){
				modelAndView.addObject(key, serviceMap.get(key));
			}
			
			return modelAndView;
		}
		
		/**********************************************
		 * 사서함 동의관리
		 **********************************************/
		//  리스트
		@RequestMapping("/menu01/menu0102.do")  
		public ModelAndView menu0102(HttpServletRequest request,
				ModelMap model, HttpServletResponse response) throws IOException {
			

			ModelAndView modelAndView = new ModelAndView("");
			
			Map paramMap = new HashMap();
			
			Enumeration req = request.getParameterNames();

			 while(req.hasMoreElements()){
				 String key = req.nextElement().toString();
				 String value = request.getParameter(key);
				 
				 paramMap.put(key, value);
			 }
			 
			
			modelAndView.setViewName("menu01/menu0102");
			
			Map resultMap = (Map)menu0102Impl.serviceCall(paramMap);
			
			Set<String> keys = resultMap.keySet();
			
			for(String key : keys){
				modelAndView.addObject(key, resultMap.get(key));
			}
			
			return modelAndView;
		}
		
		
	
	
}
