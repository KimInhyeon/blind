package com.ksinfo.blind.test.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.test.dto.TestDto;

@Repository
@Mapper 
public interface TestMapper { 
	List<TestDto> findTestData(); 
}

