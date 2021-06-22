package com.ksinfo.blind.test.mapper;

import com.ksinfo.blind.test.dto.TestDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface TestMapper {
	List<TestDto> findTestData();
}