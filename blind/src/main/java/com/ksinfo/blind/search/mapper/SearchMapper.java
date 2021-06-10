package com.ksinfo.blind.search.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.search.dto.SearchDto;

@Repository
@Mapper 
public interface SearchMapper {
	List<SearchDto> getBoard_topic_name_test(); 
}
