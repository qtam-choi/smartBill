package test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class convDbCol {
	
	public static void main(String[] args) {
		
		String[] colArr = {
				"ykiho"
				,"yadmNm"
				,"clCd"
				,"clCdNm"
				,"sidoCd"
				,"sidoCdNm"
				,"sgguCd"
				,"sgguCdNm"
				,"emdongNm"
				,"postNo"
				,"addr"
				,"telno"
				,"hospUrl"
				,"estbDd"
				,"drTotCnt"
				,"gdrCnt"
				,"intnCnt"
				,"resdntCn"
				,"sdrCnt"
				,"xPos"
				,"yPos"
				,"distance"
		};
		
		for(int i =0; i < colArr.length;  i++){
			String col = colArr[i];
			System.out.println(convert2DbColumn(col)); 
		}
		
		
		
	}


	public static  String convert2DbColumn(String str) {
	    if (str == null) return null;
	    String dbColumn_Pre = "";
	    String dbColumn = "";
	    int oldStart = 0;
	    int oldStart2 = 0;
	    
	    Matcher m2 = Pattern.compile("^[\\S]*\\.").matcher(str);
	    if (m2.find()) {
	        dbColumn_Pre = m2.group();
	        str = str.substring(m2.group().length());
	    }
	    
	    Matcher m = Pattern.compile("[A-Z]").matcher(str);
	    
	    while(m.find()) {
	        int start = m.start();
	        if (start - oldStart2 == 1) {
	            if(str.length() == (start+1) || isLowerCase(str.charAt(start+1))) {
	                oldStart2 = start;
	                continue;
	            }
	        }
	        if (dbColumn.length() != 0) dbColumn += "_";
	        dbColumn += str.substring(oldStart, start).toUpperCase();
	        oldStart = start;
	        oldStart2 = start;
	    }
	    
	    if (dbColumn.length() != 0) dbColumn += "_";
	    dbColumn += str.substring(oldStart).toUpperCase();
	    
	    return dbColumn_Pre + dbColumn;
	}

	public static  boolean isLowerCase(char chr) {
	    String str = "" + chr;
	    Matcher m = Pattern.compile("[a-z]").matcher(str);
	    return m.find();
	}


}



