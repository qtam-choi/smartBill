package com.smartbill.common.handler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

public class ClobTypeHandler extends BaseTypeHandler<String>{
	
	
	
	public String getResult(String str) throws SQLException
	{
		return str;
	}
	

	@Override
	public void setParameter(PreparedStatement ps, int i, String param,
			JdbcType jdbcType) throws SQLException {
		ps.setString(i, param);
	}



	@Override
	public String getNullableResult(ResultSet arg0, String arg1)
			throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getNullableResult(ResultSet arg0, int arg1)
			throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getNullableResult(CallableStatement arg0, int arg1)
			throws SQLException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void setNonNullParameter(PreparedStatement arg0, int arg1,
			String arg2, JdbcType arg3) throws SQLException {
		// TODO Auto-generated method stub
		
	}

}
