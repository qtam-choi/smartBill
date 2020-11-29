package com.smartbill.common.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class CryptoUtil 
{
	StandardPBEStringEncryptor standardStringEncryptor = null;

	private  void init()
	{
		standardStringEncryptor = new StandardPBEStringEncryptor();
		standardStringEncryptor.setAlgorithm("PBEWithSHA1AndDESede");
		standardStringEncryptor.setPassword("O6i+Mx2qd/52YvL9KhV8pO0OSIx=");
	}
	
	public  String encrypt(String val) throws UnsupportedEncodingException
	{
		if(standardStringEncryptor == null)
		{
			init();
		}
		String temp = standardStringEncryptor.encrypt(val);
		return URLEncoder.encode(temp, "UTF-8");
	}
	
	
	public  String decrypt(String val) throws UnsupportedEncodingException
	{
		if(standardStringEncryptor == null)
		{
			init();
		}
		String temp = URLDecoder.decode(val, "UTF-8");
		return standardStringEncryptor.decrypt(temp);
	}
}
