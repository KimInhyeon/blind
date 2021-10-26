package com.ksinfo.blind.board.mapper;

import com.ksinfo.blind.board.dto.PostFileDto;
import com.ksinfo.blind.board.vo.PostEditFileVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ImageMapper {
	long getFileSize(String postFileUrl);

	long getTotalFileSize(long userId, long postId);

	long uploadFile(PostFileDto postFileDto);

	boolean deleteUploadedFile(long userId, long postFileId);

	List<PostEditFileVO> getPostFileList(long userId, long postId);
}