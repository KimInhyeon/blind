package com.ksinfo.blind.topicMain.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.topicMain.dto.TopicMainDto;
import com.ksinfo.blind.topicMain.mapper.TopicMapper;

@Service
public class TopicMainService {

	@Autowired
	public TopicMapper mapper;

	public List<TopicMainDto> getTopicMainList() {
		return mapper.getTopicMainList();
	}
}
