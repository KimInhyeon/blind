package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.mapper.TopicMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TopicService {
	@Autowired
	TopicMapper topicMapper;
}