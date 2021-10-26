package com.ksinfo.blind.board.service;

import com.ksinfo.blind.board.dto.PostFileDto;
import com.ksinfo.blind.board.mapper.ImageMapper;
import com.ksinfo.blind.board.vo.PostEditFileVO;
import com.ksinfo.blind.board.vo.PostFileVO;
import com.ksinfo.blind.util.FileHashManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class ImageService {
	private final static long TOTAL_FILE_SIZE_LIMIT = 104857600L; // 100MB
	private final ImageMapper imageMapper;
	private final FileHashManager fileHashManager;

	@Autowired
	public ImageService(ImageMapper imageMapper, FileHashManager fileHashManager) {
		this.imageMapper = imageMapper;
		this.fileHashManager = fileHashManager;
	}

	private PostFileVO getPostFile(PostFileDto postFileDto) {
		long postFileId = imageMapper.uploadFile(postFileDto);

		return new PostFileVO(postFileId, postFileDto.getPostFileUrl());
	}

	public PostFileVO getPostFile(long userId, long postId, String fileHash, String originName) {
		String postFileUrl = fileHashManager.getFileUrl(fileHash);
		if (postFileUrl == null) {
			return null;
		}
		long fileSize = imageMapper.getFileSize(postFileUrl);
		if (fileSize + imageMapper.getTotalFileSize(userId, postId) > TOTAL_FILE_SIZE_LIMIT) {
			throw new MaxUploadSizeExceededException(TOTAL_FILE_SIZE_LIMIT);
		}
		PostFileDto postFileDto = new PostFileDto(userId, postId, postFileUrl, originName, fileSize);

		return getPostFile(postFileDto);
	}

	public PostFileVO getPostFile(long userId, long postId, MultipartFile file){
		long fileSize = file.getSize();
		if (fileSize + imageMapper.getTotalFileSize(userId, postId) > TOTAL_FILE_SIZE_LIMIT) {
			throw new MaxUploadSizeExceededException(TOTAL_FILE_SIZE_LIMIT);
		}
		String postFileUrl = fileHashManager.getFileUrl(file);
		PostFileDto postFileDto = new PostFileDto(userId, postId, postFileUrl, file.getOriginalFilename(), fileSize);

		return getPostFile(postFileDto);
	}

	public String getReplyFileUrl(String fileHash) {
		return fileHashManager.getFileUrl(fileHash);
	}

	public String getReplyFileUrl(MultipartFile file) {
		return fileHashManager.getFileUrl(file);
	}

	public boolean deleteUploadedFile(long userId, long postFileId) {
		return imageMapper.deleteUploadedFile(userId, postFileId);
	}

	public List<PostEditFileVO> getPostFileList(long userId, long postId) {
		return imageMapper.getPostFileList(userId, postId);
	}
}