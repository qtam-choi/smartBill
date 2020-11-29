package com.smartbill.service.impl.menu03;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.smartbill.common.util.DateUtil;
import com.smartbill.service.AbstractHpService;

@Component
public class Menu0301DetailImpl extends AbstractHpService 
{
	@Override
	public Object serviceCallImpl(Map dataMap)
	{
		Map returnMap = new HashMap();
		
		//detail
		Map dataView = sqlSession.selectOne("ADMIN_MENU03.getAdmin", dataMap);	
		returnMap.put("dataView", dataView);
		
		
		return returnMap;
	}
}
