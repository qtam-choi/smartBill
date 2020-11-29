package com.smartbill.common.util;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class UserInfoUtil {
	
	@Autowired
    protected SqlSessionTemplate sqlSession;
	
	
	public  UserInfoUtil(SqlSessionTemplate sqlSession){
		this.sqlSession = sqlSession;
		
	}
	
	public String getUserId(String tknId){
		Map<String, String> paramMap = new HashMap<String, String>();
		String userId = "";
		
		paramMap.put("TOKEN_ID", tknId);
		Map userIdMap = sqlSession.selectOne("COMM.selectUserId", paramMap);
		
		if(userIdMap != null){
			userId = (String) userIdMap.get("USER_ID");
		}
		
		return userId;
	}
	
}
