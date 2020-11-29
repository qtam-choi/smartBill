package com.smartbill.service.impl.menu01;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.smartbill.common.util.DateUtil;
import com.smartbill.common.util.Paging;
import com.smartbill.service.AbstractHpService;

@Component
public class Menu0101DetailImpl extends AbstractHpService 
{
	@Override
	public Object serviceCallImpl(Map dataMap)
	{
		Map returnMap = new HashMap();
		
		//detail
		Map dataView = sqlSession.selectOne("ADMIN_MENU01.getEbUser", dataMap);	
		returnMap.put("dataView", dataView);
		
		
		//List
		int totalCnt = 0;
		int curPage = 1;
		int rowCnt  = 10;
		
		String startDate = DateUtil.chgYMDFormat(DateUtil.getPreviousMonth());
		String endDate = DateUtil.getToday();
		
		
		if(dataMap.containsKey("curPage")){
			curPage = Integer.parseInt(dataMap.get("curPage").toString());
		}
		
		if(dataMap.containsKey("rowCnt")){
			rowCnt = Integer.parseInt(dataMap.get("rowCnt").toString());
		}
		
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
		
		
		// Paging 관련 
		totalCnt = sqlSession.selectOne("ADMIN_MENU01.selEbReceptListCnt", dataMap);
		Paging paging = new Paging(totalCnt, curPage, rowCnt, 5);
		
		dataMap.put("startNum", paging.getStartNum() - 1);
		dataMap.put("pageSize", paging.getNumPerPage());
		
		
		// 관리
		List dataList = sqlSession.selectList("ADMIN_MENU01.selEbReceptList", dataMap);

		returnMap.put("dataList", dataList);
		returnMap.put("paging", paging);		
				
		
		return returnMap;
		

	}
}
