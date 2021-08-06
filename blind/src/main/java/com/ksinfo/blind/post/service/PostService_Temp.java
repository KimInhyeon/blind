package com.ksinfo.blind.post.service;

import com.ksinfo.blind.post.dto.PostDto;
import com.ksinfo.blind.post.dto.PostFileDto;
import com.ksinfo.blind.post.mapper.PostMapper;
import com.ksinfo.blind.post.vo.PostFileVO;
import com.ksinfo.blind.post.vo.TopicVO;
import com.ksinfo.blind.util.FileHashManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.MultipartFile;

import javax.activation.UnsupportedDataTypeException;
import java.util.ArrayList;
import java.util.List;

@Service
public class PostService_Temp {
	private final static long TOTAL_FILE_SIZE_LIMIT = 104857600L; // 100MB
	private final FileHashManager fileHashManager;
	private final PostMapper postMapper;

	@Autowired
	public PostService_Temp(FileHashManager fileHashManager, PostMapper postMapper) {
		this.fileHashManager = fileHashManager;
		this.postMapper = postMapper;
	}

	public List<TopicVO> getTopicList() {
		return postMapper.getTopicList();
	}

	public int deleteUploadedFile(long userId, long postFileId) {
		return postMapper.deleteUploadedFile(userId, postFileId);
	}

	public List<PostFileVO> uploadFile(PostFileDto postFileDto, MultipartFile[] files) {
		long totalSize = 0;
		int filesLength = files.length;
		List<PostFileVO> postFileList = null;
		try {
			for (int i = 0; i < filesLength; ++i) {
				if (!files[i].getContentType().substring(0, 5).equals("image")) {
					throw new UnsupportedDataTypeException();
				}
				totalSize += files[i].getSize();
			}
			if (totalSize > TOTAL_FILE_SIZE_LIMIT ||
				totalSize + postMapper.getTotalFileSize(postFileDto) > TOTAL_FILE_SIZE_LIMIT
			) {
				throw new MaxUploadSizeExceededException(TOTAL_FILE_SIZE_LIMIT);
			}

			List<String> fileUrlList = fileHashManager.getFileUrl(files);
			postFileList = new ArrayList<>(files.length);
			for (int i = 0; i < filesLength; ++i) {
				String fileUrl = fileUrlList.get(i);
				postFileDto.setPostFileInfo(fileUrl, files[i]);
				postFileList.add(new PostFileVO(postMapper.uploadFile(postFileDto), fileUrl));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return postFileList;
	}

	public long writePost(PostDto postDto) {
		return postMapper.writePost(postDto);
	}
}