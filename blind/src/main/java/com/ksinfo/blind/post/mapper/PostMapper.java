package com.ksinfo.blind.post.mapper;

import com.ksinfo.blind.post.dto.PostDto;
import com.ksinfo.blind.post.dto.PostFileDto;
import com.ksinfo.blind.post.vo.TopicVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface PostMapper {
	List<TopicVO> getTopicList();

	int deleteUploadedFile(long userId, long postFileId);

	long getTotalFileSize(PostFileDto postFileDto);

	long uploadFile(PostFileDto postFileDto);

	long writePost(PostDto postDto);
}