package com.ksinfo.blind.topicMain.mapper;

import com.ksinfo.blind.topicMain.dto.PostDetailDto;
import com.ksinfo.blind.topicMain.dto.PostDto;
import com.ksinfo.blind.topicMain.dto.ReplyDto;
import com.ksinfo.blind.topicMain.dto.ReplyResultDto;
import com.ksinfo.blind.topicMain.dto.TopicMainDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface TopicMapper {
	List<TopicMainDto> getTopicMainList();

	List<PostDto> getPostListBySearchKeyword(String searchKeyword);

	PostDetailDto getPostDetail(long postId);

	void updatePostCount(long postId);

	void insertReply(ReplyDto dto);

	List<ReplyResultDto> readReply(long postId);

	long replyCount(long postId);
}