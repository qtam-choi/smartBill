package com.smartbill.common.util.seed;

import java.io.UnsupportedEncodingException;
import java.util.Arrays;


public class Seed128Util {

	private static final int SEED_BLOCK_SIZE = 16;
	public static String encrypt(String data, String key, String charset) throws UnsupportedEncodingException {
		return encrypt(data, key.getBytes(), charset);
	}
	public static String encrypt(String data, byte[] key, String charset)
	throws UnsupportedEncodingException {

		byte[] encrypt = null;
		if( charset == null ) {
			encrypt = BlockPadding.getInstance().addPadding(data.getBytes(), SEED_BLOCK_SIZE);
		} else {
			encrypt = BlockPadding.getInstance().addPadding(data.getBytes(charset), SEED_BLOCK_SIZE);
		}

		int pdwRoundKey[] = new int[32];
		SEED128.SeedRoundKey(pdwRoundKey, key);

		int blockCount = encrypt.length / SEED_BLOCK_SIZE;
		for( int i = 0; i < blockCount; i++ ) {

			byte sBuffer[] = new byte[SEED_BLOCK_SIZE];
			byte tBuffer[] = new byte[SEED_BLOCK_SIZE];

			System.arraycopy(encrypt, (i * SEED_BLOCK_SIZE), sBuffer, 0, SEED_BLOCK_SIZE);

			SEED128.SeedEncrypt(sBuffer, pdwRoundKey, tBuffer);

			System.arraycopy(tBuffer, 0, encrypt, (i * SEED_BLOCK_SIZE), tBuffer.length);
		}

		// HEX 로 변경
		StringBuffer sb = new StringBuffer(encrypt.length * 2);
		String hexNumber;
		for (int x = 0; x < encrypt.length; x++) {
			hexNumber = "0" + Integer.toHexString(0xff & encrypt[x]);
			sb.append(hexNumber.substring(hexNumber.length() - 2));
		}
		return sb.toString().toUpperCase();
		// Base64
		// return Base64.toString(encrypt);
	}

	public static String decrypt(String data, String key, String charset) throws UnsupportedEncodingException {
		return decrypt(data, key.getBytes(), charset);
	}
	public static String decrypt(String data, byte[] key, String charset)
			throws UnsupportedEncodingException {

		int pdwRoundKey[] = new int[32];
		SEED128.SeedRoundKey(pdwRoundKey, key);

		// Base64
		//byte[] decrypt = Base64.toByte(data);

		// Base64를 HEX로 변경
		byte[] decrypt = new byte[data.length() / 2];
	    for (int i = 0; i < decrypt.length; i++) {
	    	decrypt[i] = (byte) Integer.parseInt(data.substring(2 * i, 2 * i + 2), 16);
	    }
		// Base64를 HEX로 변경 END


		int blockCount = decrypt.length / SEED_BLOCK_SIZE;
		for (int i = 0; i < blockCount; i++) {

			byte sBuffer[] = new byte[SEED_BLOCK_SIZE];
			byte tBuffer[] = new byte[SEED_BLOCK_SIZE];

			System.arraycopy(decrypt, (i * SEED_BLOCK_SIZE), sBuffer, 0,
					SEED_BLOCK_SIZE);

			SEED128.SeedDecrypt(sBuffer, pdwRoundKey, tBuffer);

			System.arraycopy(tBuffer, 0, decrypt, (i * SEED_BLOCK_SIZE),
					tBuffer.length);
		}

		if (charset == null) {
			return new String(BlockPadding.getInstance().removePadding(decrypt,
					SEED_BLOCK_SIZE));
		} else {
			return new String(BlockPadding.getInstance().removePadding(decrypt,
					SEED_BLOCK_SIZE), charset);
		}
	}


	public static String rpad(String str, int length, char fillChar) {
		if (str.length() > length) return str;
		char[] chars = new char[length];
		Arrays.fill(chars, fillChar);
		System.arraycopy(str.toCharArray(), 0, chars, 0, str.length());
		return new String(chars);
	}

}
