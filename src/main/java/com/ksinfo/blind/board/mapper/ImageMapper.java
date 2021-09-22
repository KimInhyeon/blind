package com.ksinfo.blind.board.mapper;

import com.ksinfo.blind.board.dto.PostFileDto;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ImageMapper {
	long getFileSize(String postFileUrl);

	long getTotalFileSize(long userId, long postId);

	long uploadFile(PostFileDto postFileDto);

	boolean deleteUploadedFile(long userId, long postFileId);
}