package com.ksinfo.blind.test.service;

import com.ksinfo.blind.test.dto.TestDto;
import com.ksinfo.blind.test.mapper.TestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TestService {
	@Autowired
	public TestMapper mapper;

	public List<TestDto> findTestData() {
		return mapper.findTestData();
	}
}