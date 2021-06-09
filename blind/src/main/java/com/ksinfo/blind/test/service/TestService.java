package com.ksinfo.blind.test.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.test.dto.TestDto;
import com.ksinfo.blind.test.mapper.TestMapper;

@Service 
public class TestService { 
	
	@Autowired 
	public TestMapper mapper; 
	
	public List<TestDto> findTestData() { 
		return mapper.findTestData(); 
	} 
}

