package com.ksinfo.blind.topicMain.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.topicMain.dto.PostDetailDto;
import com.ksinfo.blind.topicMain.dto.PostDto;
import com.ksinfo.blind.topicMain.dto.TopicMainDto;

@Repository
@Mapper
public interface TopicMapper {
	List<TopicMainDto> getTopicMainList();
	List<PostDto> getPostListBySearchKeyword(String searchKeyword);
	PostDetailDto getPostDetail(long postId);
	void updatePostCount(long postId);
}



