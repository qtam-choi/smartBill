package com.smartbill.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.servlet.view.AbstractView;


public class FileDownload extends AbstractView {

	public FileDownload() {
        setContentType("applicaiton/download;charset=utf-8");
    }
 
	@Override
	protected void renderMergedOutputModel(Map<String, Object> model,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String return_code = (String)model.get("RETURN_CODE");
		
		if(return_code.equals("E")){
			
			response.setContentType("text/html; charset=UTF-8");
	        PrintWriter out = response.getWriter();
	        out.println("<script>alert('"+(String)model.get("RETURN_MSG")+"');window.close();</script>");
	        out.flush(); 
	        
	        return;
		}
		
		
		Map fileInfo = (Map)model.get("fileInfo");
		
		String path = ExXMLConfiguration.getInstance().getString("file.savedir") + (String)fileInfo.get("file_path");
		String fileNm = (String)fileInfo.get("file_name_org");
		String fileExt = (String)fileInfo.get("file_ext");
		
		if(fileNm.indexOf(".") < 0 && fileExt != null){
			fileNm = fileNm  + "." + (String)fileInfo.get("file_ext");
		}
		
		
		System.out.println("path:" + path);
		System.out.println("fileName:" + fileNm);
		
		
		FileInputStream fis = null;
		OutputStream out = response.getOutputStream();
		 
		try {
		
			File file = new File(path);
	
		    response.setContentType(getContentType());
		    response.setContentLength((int)file.length());
	         
		    String fileName = java.net.URLEncoder.encode(fileNm, "UTF-8");
	         
		    response.setHeader("Content-Type", "application/octet-stream");
		    response.setHeader("Content-Disposition", "attachment;filename=\""+fileName+"\";");
		    response.setHeader("Content-Transfer-Encoding", "binary");
	   
            fis = new FileInputStream(file);
            FileCopyUtils.copy(fis, out);
	    } catch (Exception e) {
            e.printStackTrace();
	    } finally {
            if (fis != null) { try { fis.close(); } catch (Exception e2) {}}
	    }
	    out.flush();
	}
}
