package com.ksinfo.blind.common.service;

import com.ksinfo.blind.common.mapper.TestMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TestService {
	private final TestMapper testMapper;

	@Autowired
	public TestService(TestMapper testMapper) {
		this.testMapper = testMapper;
	}

	public String findTestData() {
		return testMapper.findTestData();
	}
}