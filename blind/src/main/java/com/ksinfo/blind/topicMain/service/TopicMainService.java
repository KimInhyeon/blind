package com.ksinfo.blind.topicMain.service;

import com.ksinfo.blind.topicMain.dto.TopicMainDto;
import com.ksinfo.blind.topicMain.mapper.TopicMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TopicMainService {

	@Autowired
	public TopicMapper mapper;

	public List<TopicMainDto> getTopicMainList() {
		return mapper.getTopicMainList();
	}

	public long replyCount(long postId) {
		return mapper.replyCount(postId);
	}
}