package  com.smartbill.service.impl.menu03;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.smartbill.common.util.CommonUtil;
import com.smartbill.common.util.ExXMLConfiguration;
import com.smartbill.service.AbstractHpService;
import com.smartbill.service.SifResult;

@Component
public class Menu0301ActionImpl extends AbstractHpService 
{	
	@Override
	public Object serviceCallImpl(Map dataMap)
	{	
		SifResult result = new SifResult();
		
		String action = (String)dataMap.get("action");
		
		
		if(action.equals("INSERT")){
			
			dataMap.put("passwd", CommonUtil.sha256((String)dataMap.get("passwd")));
			sqlSession.update("ADMIN_MENU03.insAdmin", dataMap);
			
		}else if(action.equals("UPDATE")){
			
			String passwd = (String)dataMap.get("passwd");
			
			if(passwd != null && !passwd.equals("")){
				dataMap.put("passwd", CommonUtil.sha256(passwd));
			}
			
			sqlSession.update("ADMIN_MENU03.upAdmin", dataMap);
			
		}else if(action.equals("DELETE")){
			sqlSession.delete("ADMIN_MENU03.delAdmin", dataMap);
		
		}else if(action.equals("LOCK_INIT")){
			sqlSession.update("ADMIN_MENU03.upLockInit", dataMap);
			
		}else if(action.equals("ID_CHECK")){

			Map idChk = sqlSession.selectOne("ADMIN_MENU03.getIdChk", dataMap);
			
			if(idChk == null){  //중복 아님
				result.setResultObject("IDCHK", "true");
				
			}else{  //중복
				result.setResultObject("IDCHK", "false");
			}
		}
		
		return result.getResultMap();
	}
	
	
	
}
