package  com.smartbill.service.impl.common;

import java.util.Map;

import org.springframework.stereotype.Component;

import com.smartbill.common.util.CommonUtil;
import com.smartbill.common.util.StringUtil;
import com.smartbill.service.AbstractHpService;
import com.smartbill.service.SifResult;

@Component
public class LoginActionImpl extends AbstractHpService 
{
	
	//로그인 필요없을시 아래 오버라이드 추가할것, 로그인 필요시 아래 오버라이드 제거
	@Override
	protected boolean checkSession() {
		return false;
	}
	
	
	@Override
	public Object serviceCallImpl(Map dataMap)
	{	
		SifResult result = new SifResult();
		
		Map userMap = sqlSession.selectOne("ADMIN_COMMON.selUserInfo", dataMap);
		
		if(userMap != null){
			

			int faultCnt =   Integer.parseInt(userMap.get("fault_cnt") + "");

			
			if(faultCnt >= 5){
				result.setResult(false, "5회 이상 패스워드가 틀렸습니다.\n해당 ID를 다시 사용하기 위해서는 관리자에게 문의해 주세요.");
				return result.getResultMap();
			}
			
			String passwd = CommonUtil.sha256((String)dataMap.get("passwd"));
			
			if(!passwd.equals(userMap.get("passwd"))){
				
				userMap.put("pw_check", "false");
				sqlSession.update("ADMIN_COMMON.upPwFaultCnt", userMap);
				result.setResult(false, "패스워드가 잘못되었습니다.\n5회 이상 틀릴 경우 해당 ID가 잠금처리되니 주의해주세요\n(남은횟수 : "+ (5 - faultCnt - 1) +")");
			}else{
				
				sqlSession.update("ADMIN_COMMON.upPwFaultCnt", userMap);
				result.setResultObject("userInfo", userMap);
				
			}
		}else{
			result.setResult(false, "사용자 ID가 없습니다.");
		}
		return result.getResultMap();
	}
	
}
