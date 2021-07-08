package com.ksinfo.blind.topicMain.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.topicMain.dto.PostDto;
import com.ksinfo.blind.topicMain.mapper.TopicMapper;

@Service
public class PostService {

	@Autowired
	public TopicMapper mapper;
	
	public List<PostDto> getPostListBySearchKeyword(String searchKeyword) {
		return mapper.getPostListBySearchKeyword(searchKeyword);
	}
	
}
