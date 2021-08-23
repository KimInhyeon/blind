package com.ksinfo.blind.util;

import org.springframework.stereotype.Component;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@Component
public class SecurityUtil {

	public String encryptSHA256(String str) {
		String sha = null;
		try {
			MessageDigest sh = MessageDigest.getInstance("SHA-256");
			sh.update(str.getBytes());
			byte[] byteData = sh.digest();
			StringBuilder sb = new StringBuilder(64);
			for(int i = 0, byteDataLength = byteData.length; i < byteDataLength; ++i) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			sha = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return sha;
	}
}