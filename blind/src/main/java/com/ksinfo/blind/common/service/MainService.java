package com.ksinfo.blind.common.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.common.dto.CommonPostDto;
import com.ksinfo.blind.common.mapper.MainMapper;

@Service
public class MainService {

	@Autowired
    private MainMapper mainMapper;
	
	public List<CommonPostDto> topicBestList(){

		return mainMapper.topicBestList();
	}
	
	public List<CommonPostDto> topicSubList(){
		
		return mainMapper.topicSubList();
	}

}
