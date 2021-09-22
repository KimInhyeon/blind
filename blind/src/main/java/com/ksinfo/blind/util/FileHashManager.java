package com.ksinfo.blind.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

@Component
public final class FileHashManager {
	private static final String ALGORITHM = "SHA-256";
//	private static final String ABSOLUTE_PATH = System.getProperty("user.dir") + "/src/main/webapp"; // Unix系
	private static final String ABSOLUTE_PATH =
		System.getProperty("user.dir").replaceAll("\\\\", "/") + "/src/main/webapp";
	private static final String RESOURCES_PATH = "/resources/upload/";
	private static final int MAX_PATH_LENGTH = RESOURCES_PATH.length() + 76; // 76 == "YYYYMM/64_hash_char.jpeg"
	private final String contextPath;
	private final Map<String, String> fileUrlMap;

	@Autowired
	public FileHashManager(@Value("${server.servlet.context-path}") String contextPath) {
		this.contextPath = contextPath;
		fileUrlMap = new HashMap<>();
		initFileUrlMap(ABSOLUTE_PATH + RESOURCES_PATH);
	}

	private void initFileUrlMap(String path) {
		File[] files = new File(path).listFiles();
		for (int i = files.length - 1, absolutePathLength = ABSOLUTE_PATH.length(); i > -1; --i) {
			if (files[i].isFile()) {
				fileUrlMap.put(
					files[i].getName().substring(0, 64),
//					contextPath + files[i].getAbsolutePath().substring(absolutePathLength) // Unix系
					contextPath + files[i].getAbsolutePath().substring(absolutePathLength)
															.replaceAll("\\\\", "/")
				);
			} else {
				initFileUrlMap(files[i].getPath());
			}
		}
	}

	public String getFileUrl(String fileHash) {
		return fileUrlMap.get(fileHash);
	}

	private String getFileHash(MultipartFile file) {
		String fileHash = null;
		try {
			MessageDigest sha256 = MessageDigest.getInstance(ALGORITHM);
			byte[] digest = sha256.digest(file.getBytes());
			fileHash = new BigInteger(1, digest).toString(16);
		} catch (NoSuchAlgorithmException | IOException e) {
			e.printStackTrace();
		}

		return fileHash;
	}

	public String getFileUrl(MultipartFile file) {
		String fileHash = getFileHash(file);
		LocalDate now = LocalDate.now();
		String path = new StringBuilder(MAX_PATH_LENGTH).append(RESOURCES_PATH)
					.append(now.getYear()).append(String.format("%02d", now.getMonthValue())).append('/')
					.append(fileHash).append('.').append(file.getContentType().substring(6)).toString();
		File newFile = new File(ABSOLUTE_PATH + path);
		if (!newFile.exists()) {
			newFile.mkdirs();
		}
		try {
			file.transferTo(newFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		String fileUrl = contextPath + path;
		fileUrlMap.put(fileHash, fileUrl);

		return fileUrl;
	}
}