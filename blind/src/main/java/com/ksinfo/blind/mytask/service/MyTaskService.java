package com.ksinfo.blind.mytask.service;

import com.ksinfo.blind.mytask.dto.MyTaskDto;
import com.ksinfo.blind.mytask.mapper.MyTaskMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MyTaskService {

	@Autowired
	MyTaskMapper mytaskMapper;

	public List<MyTaskDto> companyreviewList(long userId){

		return mytaskMapper.companyreviewList(userId);
	}

	public List<MyTaskDto> reportList(long userId){

		return mytaskMapper.reportList(userId);
	}
}
