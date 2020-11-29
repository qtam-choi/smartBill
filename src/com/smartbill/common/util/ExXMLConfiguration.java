package com.smartbill.common.util;

import java.io.IOException;

import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.XMLConfiguration;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

/**  
 * @ClassName : ExXMLConfiguration.java
 * @Description : 
 * @Author  모바일개발팀
 * @Since 2013. 3. 27.
 * @Version 1.0
 * @see <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 *
 *   수정일             수정자                수정내용
 *  --------------        ---------------       ---------------------------
 *   2013. 3. 27.        모바일개발팀            최초작성
 *
 * </pre>
 *  
 * Copyright (C) by SMC All right reserved.
 */

@Component
public final class ExXMLConfiguration extends XMLConfiguration {

	private static final long serialVersionUID = -3523381408933521341L;
	
	private static ExXMLConfiguration xmlConfiguration = null;
	private static String path = "";
	
	private ExXMLConfiguration() {
		
		final DefaultResourceLoader loader = new DefaultResourceLoader();
		Resource configResource = loader.getResource("classpath:../config/env_values.xml");
		
		//Resource configResource = ContextUtil.getApplicationContext().getResource("/WEB-INF/config/env_values.xml");
		try {
			path = configResource.getFile().getAbsolutePath();
		} catch (IOException e) {
			System.out.println("ExXMLConfiguration 오류");
		}
	}
	
	/**
	 * XMLConfiguration Singleton 객체를 생성하여 리턴한다.
	 * 
	 * @return XMLConfiguration Singleton 객체
	 */
	public static ExXMLConfiguration getInstance() {
		if(xmlConfiguration==null) {
			xmlConfiguration = getInstance(path);
		}
		
		return xmlConfiguration;
    }
	
	/**
	 * XMLConfiguration Singleton 객체를 생성하여 리턴한다.
	 * 
	 * @param home home directory
	 * @param fileName Configuration file name
	 * @return XMLConfiguration Singleton 객체
	 */
	public static ExXMLConfiguration getInstance(String filePath) {
		if(xmlConfiguration==null && filePath != null) {
    		xmlConfiguration = new ExXMLConfiguration();
	        try {
	        	xmlConfiguration.load(filePath);
	        } catch(ConfigurationException ce) {
	        	
	        		ce.printStackTrace();
	        }
    	}
    	
    	return xmlConfiguration;
	}
}