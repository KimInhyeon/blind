package com.ksinfo.blind.topicMain.service;

import com.ksinfo.blind.topicMain.dto.ReplyDto;
import com.ksinfo.blind.topicMain.dto.ReplyResultDto;
import com.ksinfo.blind.topicMain.mapper.TopicMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReplyService {

	@Autowired
	public TopicMapper mapper;

	public void insertReply(ReplyDto dto) {
		mapper.insertReply(dto);
	}

	public List<ReplyResultDto> readReply(long postId) {
		return mapper.readReply(postId);
	}
}