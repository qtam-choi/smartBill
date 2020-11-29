package  com.smartbill.service.impl.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.smartbill.service.AbstractHpService;
import com.smartbill.service.SifResult;

@Component
public class CommonActionImpl extends AbstractHpService 
{	
	@Override
	public Object serviceCallImpl(Map dataMap)
	{	
		SifResult result = new SifResult();
		String action = (String)dataMap.get("action");
		
		 if(action.equals("PWCHG")){  
			
			sqlSession.update("ADMIN_COMMON.upUserInfoPw", dataMap);
		
		}else if(action.equals("MAIN")){  
			
			List venInfoList = sqlSession.selectList("ADMIN_COMMON.selVenInfo", dataMap);
			
			
			List<String> channelArr = new ArrayList<String>();
			List<String> totCntArr = new ArrayList<String>();
			List<String> todayCntArr = new ArrayList<String>();
			
			if(venInfoList.size() != 0){
				
				Iterator it = venInfoList.iterator();
				
				while (it.hasNext()) {
					Map venMap = (Map)it.next();
					channelArr.add((String)venMap.get("app_van_desc"));
					totCntArr.add("" +venMap.get("tot_cnt"));
					todayCntArr.add("" +venMap.get("today_cnt"));
				}
				
			}
		
			//VAN사
			result.setResultObject("channelArr", channelArr);
			result.setResultObject("totCntArr", totCntArr);
			result.setResultObject("todayCntArr", todayCntArr);
			result.setResultObject("venInfoList", venInfoList);
			
			/////////////////////   전자영수증
			
			List receptInfoList = sqlSession.selectList("ADMIN_COMMON.selReceptInfo", dataMap);
			
			
			List<String> regDateArr = new ArrayList<String>();
			List<String> naverArr = new ArrayList<String>();
			List<String> kakaoArr = new ArrayList<String>();
			List<String> passArr = new ArrayList<String>();
			List<String> etcArr = new ArrayList<String>();
			
			if(receptInfoList.size() != 0){
				
				Iterator it = receptInfoList.iterator();
				
				while (it.hasNext()) {
					Map venMap = (Map)it.next();
					regDateArr.add("" + venMap.get("reg_at"));
					naverArr.add("" +venMap.get("naver_cnt"));
					kakaoArr.add("" +venMap.get("kakao_cnt"));
					passArr.add("" +venMap.get("pass_cnt"));
					etcArr.add("" +venMap.get("etc_cnt"));
				}
				
			}
			
			//날짜별
			result.setResultObject("regDateArr", regDateArr);
			result.setResultObject("naverArr", naverArr);
			result.setResultObject("kakaoArr", kakaoArr);
			result.setResultObject("passArr", passArr);
			result.setResultObject("etcArr", etcArr);
			
			
			List receptTotList = sqlSession.selectList("ADMIN_COMMON.selReceptTotInfo", dataMap);  
			
			result.setResultObject("receptTotList", receptTotList);
		
		}
		
		return result.getResultMap();
	}
	
}
