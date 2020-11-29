package com.smartbill.service.impl.menu03;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.smartbill.common.util.DateUtil;
import com.smartbill.common.util.Paging;
import com.smartbill.service.AbstractHpService;

@Component
public class Menu0301Impl extends AbstractHpService 
{
	@Override
	public Object serviceCallImpl(Map dataMap)
	{
		Map returnMap = new HashMap();
	
		int totalCnt = 0;
		int curPage = 1;
		int rowCnt  = 10;
		
		
		if(dataMap.containsKey("curPage")){
			curPage = Integer.parseInt(dataMap.get("curPage").toString());
		}
		
		if(dataMap.containsKey("rowCnt")){
			rowCnt = Integer.parseInt(dataMap.get("rowCnt").toString());
		}
		
		//사용자관리 Paging 관련 
		totalCnt = sqlSession.selectOne("ADMIN_MENU03.selAdminListCnt", dataMap);
		Paging paging = new Paging(totalCnt, curPage, rowCnt, 5);
		
		dataMap.put("startNum", paging.getStartNum() - 1);
		dataMap.put("pageSize", paging.getNumPerPage());
		
		
		//사용자관리
		List dataList = sqlSession.selectList("ADMIN_MENU03.selAdminList", dataMap);

		returnMap.put("dataList", dataList);
		returnMap.put("paging", paging);		
		
		
		return returnMap;
	}
}
