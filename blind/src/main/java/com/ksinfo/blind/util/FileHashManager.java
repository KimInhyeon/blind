package com.ksinfo.blind.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.PostConstruct;
import java.io.File;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
public final class FileHashManager {
	private static final String ALGORITHM = "SHA-256";
//	private static final String ABSOLUTE_PATH = System.getProperty("user.dir") + "/src/main/webapp"; // Unix系
	private static final String ABSOLUTE_PATH =
		System.getProperty("user.dir").replaceAll("\\\\", "/") + "/src/main/webapp";
	private final String contextPath;
	private final Map<String, String> fileUrlMap;

	@Autowired
	public FileHashManager(@Value("${server.servlet.context-path}") String contextPath) {
		this.contextPath = contextPath;
		fileUrlMap = new HashMap<>();
	}

	@PostConstruct
	public void init() {
		initFileHashMap(ABSOLUTE_PATH + "/resources/upload/");
	}

	private void initFileHashMap(String path) {
		File[] files = new File(path).listFiles();
		for (int i = files.length - 1; i > -1; --i) {
			if (files[i].isFile()) {
				fileUrlMap.put(
					files[i].getName().substring(0, 64),
//					contextPath + files[i].getAbsolutePath().substring(ABSOLUTE_PATH.length()) // Unix系
					contextPath + files[i].getAbsolutePath().substring(ABSOLUTE_PATH.length()).replaceAll("\\\\", "/")
				);
			} else {
				initFileHashMap(files[i].getPath());
			}
		}
	}

	private String getFileHash(MultipartFile file) throws Exception {
		MessageDigest sha256 = MessageDigest.getInstance(ALGORITHM);
		byte[] digest = sha256.digest(file.getBytes());

		return new BigInteger(1, digest).toString(16);
	}

	public List<String> getFileUrl(MultipartFile[] files) throws Exception {
		LocalDate now = LocalDate.now();
		int filesLength = files.length;
		List<String> fileUrlList = new ArrayList<>(filesLength);
		for (int i = 0; i < filesLength; ++i) {
			String fileHash = getFileHash(files[i]);
			if (!fileUrlMap.containsKey(fileHash)) {
				String path = new StringBuilder("/resources/upload/")
							.append(now.getYear()).append(String.format("%02d", now.getMonthValue())).append('/')
							.append(fileHash).append('.').append(files[i].getContentType().substring(6)).toString();
				File file = new File(ABSOLUTE_PATH + path);
				if (!file.exists()) {
					file.mkdirs();
				}
				files[i].transferTo(file);
				fileUrlMap.put(fileHash, contextPath + path);
			}
			fileUrlList.add(fileUrlMap.get(fileHash));
		}

		return fileUrlList;
	}
}