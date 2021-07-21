package com.ksinfo.blind.mytask.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.mytask.dto.MyTopicDto;
import com.ksinfo.blind.mytask.mapper.MyTopicMapper;

@Service
public class MyTopicService {

	@Autowired
    private MyTopicMapper mytopicMapper;
	
	public List<MyTopicDto> mytopicList(long userId){

		return mytopicMapper.mytopicList(userId);
	}
}
