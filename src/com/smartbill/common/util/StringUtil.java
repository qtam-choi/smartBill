package com.smartbill.common.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



/**  
 * @ClassName : StringUtility.java
 * @Description : 문자열 처리 Utility Class
 * @Author  모바일개발팀
 * @Since 2013. 3. 12.
 * @Version 1.0
 * @see <pre>
 * &lt;&lt; 개정이력(Modification Information) &gt;&gt;
 *
 *   수정일             수정자                수정내용
 *  --------------        ---------------       ---------------------------
 *   2013. 3. 12.        모바일개발팀            최초작성
 *
 * </pre>
 *  
 * Copyright (C) by SMC All right reserved.
 */
public class StringUtil {
	
	/**
	 * Map 형태의 Object 를 String Parameter 형태로 변환
	 * @param param Map
	 * @return parameterString
	 */
	public static String convertParameterString(Map<String,Object> param){
		
		String result = "";
		if(param != null && param.size() > 0){
			
			Set<String> keys = param.keySet();
			Iterator<String> it = keys.iterator();
			while(it != null && it.hasNext()){
				String key = (String) it.next();
				result += key + "=" + param.get(key) + "&";
			}
		}
		return result;
	}
	
	

	
    /**
     * 빈 값인지 체크
     * @param str
     * @return
     */
    public static boolean isNull(String str) {
        return (str == null || "".equals(str.trim()) || "null".equalsIgnoreCase(str.trim()));
    }	
    
    /**
     * 빈 값인지 체크
     * @param str
     * @return
     */
    public static boolean isNull(Object obj) {

    	boolean ret = false;
    	
    	if (obj != null) {
    		if (obj.getClass().isArray()) {
    			if ("[Ljava.lang.String;".equals(obj.getClass().getName())) {
    				String[] strArr = (String[])obj ;
    				if ("".equals(strArr[0].trim()) || strArr[0] == null) {
    					ret = true;
    				}
    			}
    		}
    	} else {
    		ret = true;
    	}
        return ret ;
    }    
    
    /**
     * 빈 값인지 체크
     * @param source:원본문자열, toReplace:바꿔야할 문자, replacement:바꿀문자열
     * @return
     */
    public static String replaceAll(String source, String toReplace, String replacement) {
    	int idx = source.lastIndexOf(toReplace);
    	String str_result="";
    	if (idx != -1) {
    		StringBuffer ret = new StringBuffer(source);
    		ret.replace(idx, idx+toReplace.length(), replacement);
    		while((idx=source.lastIndexOf(toReplace, idx-1)) != -1)
    			ret.replace(idx, idx+toReplace.length(), replacement);
    			str_result = ret.toString();
    	}else{
    		str_result=source;
    	}    	
    	return str_result;
    }
    
    
    public static String getMD5(String str){

        String rtnMD5 = "";

        try {

            //MessageDigest 인스턴스 생성
            MessageDigest md = MessageDigest.getInstance("MD5");

            //해쉬값 업데이트
            md.update(str.getBytes());

            //해쉬값(다이제스트) 얻기
            byte byteData[] = md.digest();
            StringBuffer sb = new StringBuffer();

            //출력
            for(byte byteTmp : byteData) {
            	sb.append(Integer.toString((byteTmp&0xff) + 0x100, 16).substring(1));
            }

            rtnMD5 = sb.toString();

        } catch (Exception e) {
            e.printStackTrace(); 
            rtnMD5 = null; 
        }

        return rtnMD5;
    } 
    
    
    public static String removeTag(String str){		
    	Matcher mat;  

    	// script 처리 
    	Pattern script = Pattern.compile("<(no)?script[^>]*>.*?</(no)?script>",Pattern.DOTALL);  
    	mat = script.matcher(str);  
    	str = mat.replaceAll("");  
    	// style 처리
    	Pattern style = Pattern.compile("<style[^>]*>.*</style>",Pattern.DOTALL);  
    	mat = style.matcher(str);  
    	str = mat.replaceAll("");  
    	// tag 처리 
    	Pattern tag = Pattern.compile("<(\"[^\"]*\"|\'[^\']*\'|[^\'\">])*>");  
    	mat = tag.matcher(str);  
    	str = mat.replaceAll("");  
    	// ntag 처리 
    	Pattern ntag = Pattern.compile("<\\w+\\s+[^<]*\\s*>");  
    	mat = ntag.matcher(str);  
    	str = mat.replaceAll("");  
    	// entity ref 처리
    	Pattern Eentity = Pattern.compile("&[^;]+;");  
    	mat = Eentity.matcher(str);  
    	str = mat.replaceAll("");
    	// whitespace 처리 
    	Pattern wspace = Pattern.compile("\\s\\s+");  
    	mat = wspace.matcher(str); 
    	str = mat.replaceAll(""); 	          

    	return str ;		
    }
    
    
    /* 한글 Byte 자르기 */
    public static String subString(String strData, int iStartPos, int iByteLength) {
		byte[] bytTemp = null;
		int iRealStart = 0;
		int iRealEnd = 0;
		int iLength = 0;
		int iChar = 0;
		
		
		try {
			// UTF-8로 변환하는경우 한글 2Byte, 기타 1Byte로 떨어짐
			bytTemp = strData.getBytes("EUC-KR");
			iLength = bytTemp.length;


			for(int iIndex = 0; iIndex < iLength; iIndex++) {
				if(iStartPos <= iIndex) {
					break;
				}
				iChar = (int)bytTemp[iIndex];
				if((iChar > 127)|| (iChar < 0)) {
					// 한글의 경우(2byte 통과처리)
					// 한글은 2Byte이기 때문에 다음 글자는 볼것도 없이 스킵한다
					iRealStart++;
					iIndex++;
				} else {
					// 기타 글씨(1Byte 통과처리)
					iRealStart++;
				}
			}
			
			iRealEnd = iRealStart;
			int iEndLength = iRealStart + iByteLength;
			for(int iIndex = iRealStart; iIndex < iEndLength; iIndex++)
			{
				iChar = (int)bytTemp[iIndex];
				if((iChar > 127)|| (iChar < 0)) {
					// 한글의 경우(2byte 통과처리)
					// 한글은 2Byte이기 때문에 다음 글자는 볼것도 없이 스킵한다
					iRealEnd++;
					iIndex++;
				} else {
					// 기타 글씨(1Byte 통과처리)
					iRealEnd++;
				}
			}
		} catch(Exception e) {

		}

		return strData.substring(iRealStart, iRealEnd);
    } 
    
    
    
	// 문자열 배열로 자르기
	public static String[] makeArrayToString(String raw, int len) {

		if (raw == null)
			return null;

		ArrayList aryList = new ArrayList();
		// String[] ary =null;
		try {
			// raw 의 byte
			byte[] rawBytes = raw.getBytes("MS949");
			int rawLength = rawBytes.length;

			if (rawLength > len) {

				int aryLength = (rawLength / len)
						+ (rawLength % len != 0 ? 1 : 0);

				int endCharIndex = 0; // 문자열이 끝나는 위치
				String tmp;
				for (int i = 0; i < aryLength; i++) {

					if (i == (aryLength - 1)) {

						tmp = raw.substring(endCharIndex);
						// else 부분에서 endCharIndex 가 작아져서 (이를테면 len 10 이고 else
						// 부분에서 잘려지는 길이가 9 일때)
						// 위에서 계산되어진 aryLength 길이보다 길이가 더 길어질 소지가 있습니다.
						// 이에 길이가 더 길 경우에는 for 한번더 돌도록 한다.
						if (tmp.getBytes("MS949").length > len) {
							aryLength++;
							i--;
							continue;
						}

					} else {

						int useByteLength = 0;
						int rSize = 0;
						for (; endCharIndex < raw.length(); endCharIndex++) {

							if (raw.charAt(endCharIndex) > 0x007F) {
								useByteLength += 2;
							} else {
								useByteLength++;
							}
							if (useByteLength > len) {
								break;
							}
							rSize++;
						}
						tmp = raw.substring((endCharIndex - rSize),
								endCharIndex);
					}
					aryList.add(tmp);

				}

			} else {
				aryList.add(raw);
			}

		} catch (java.io.UnsupportedEncodingException e) {
		}

		return (String[]) aryList.toArray(new String[0]);
	}
	
	
	
	// 문자열뒤에 공백을 붙여주는 메서드
	public static String appendSpace(String str, int len) {
		int strLength = str.getBytes().length;
		String tempStr = str;

		if (strLength < len) {
			int endCount = len - strLength;

			for (int i = 0; i < endCount; i++) {
				str = str + " ";
			}
		} else if (strLength > len) {
			byte[] temp = new byte[len];
			System.arraycopy(str.getBytes(), 0, temp, 0, len);
			str = new String(temp);
		} else {

		}

		// 한글을 못짜를때.... len 에 한글이 물려 있을경우...
		// 이경우는 len-1 만큼 자른후 공백을 붙여 반환한다.
		if (str.length() == 0) {
			byte[] temp = new byte[len];
			System.arraycopy(tempStr.getBytes(), 0, temp, 0, len - 1);
			str = new String(temp);
		}

		return str;
	}
	
	
	// 문자열뒤에 공백을 붙여주는 메서드
	public static void fileAppend(String filePath, String contents) throws IOException {
        
		//Specify the file name and path here
    	File file =new File(filePath);

    	if(!file.exists()){
    		file.createNewFile();
    	}
    	
    	//Here true is to append the content to file
    	FileWriter fw = new FileWriter(file,true);
    	//BufferedWriter writer give better performance
    	BufferedWriter bw = new BufferedWriter(fw);
    	bw.write(contents);
    	//Closing BufferedWriter Stream
    	bw.close();
	 
	}
	
	//숫자인지 체크
	public static boolean isNumeric(String s) {
		try {
	    	Double.parseDouble(s);
	    	return true;
	  	} catch(NumberFormatException e) {
	    	return false;
	  	}
	}
	
	
	// oralce OracleToLong
	public static double numberToLong(Object num) {
       
    	BigDecimal value = (BigDecimal)num;

    	if(value == null){
    		return (double) 0;
    	}
    	
    	return (double) value.doubleValue();
	 
	}
	
	
    
}
