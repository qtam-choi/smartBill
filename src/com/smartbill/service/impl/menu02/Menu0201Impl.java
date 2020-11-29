package com.smartbill.service.impl.menu02;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.smartbill.common.util.DateUtil;
import com.smartbill.common.util.Paging;
import com.smartbill.service.AbstractHpService;

@Component
public class Menu0201Impl extends AbstractHpService 
{
	@Override
	public Object serviceCallImpl(Map dataMap)
	{
Map returnMap = new HashMap();
		
		String startDate = DateUtil.chgYMDFormat(DateUtil.getPreviousMonth());
		String endDate = DateUtil.getToday();
			
		if(dataMap.containsKey("startDate")){
			startDate = (String)dataMap.get("startDate");
		}else{
			dataMap.put("startDate", startDate);
		}
		
		if(dataMap.containsKey("endDate")){
			endDate = (String)dataMap.get("endDate");
		}else{
			dataMap.put("endDate", endDate);
		}
		
		returnMap.put("startDate", startDate);
		returnMap.put("endDate", endDate);
		
	
		// 관리
		List dataList = sqlSession.selectList("ADMIN_MENU02.selEbStatsList", dataMap);

		returnMap.put("dataList", dataList);
	
		
		return returnMap;
	}
}
