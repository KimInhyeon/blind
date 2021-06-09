package com.ksinfo.blind.search.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.test.dto.TestDto;

@Repository
@Mapper 
public class SearchMapper {
	List<TestDto> showTestSQL(); 
}
