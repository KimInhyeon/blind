package com.ksinfo.blind.common.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface TestMapper {
	@Select("SELECT test FROM blind.test;")
	String findTestData();
}