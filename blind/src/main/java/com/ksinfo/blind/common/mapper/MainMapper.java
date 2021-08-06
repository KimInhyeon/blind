package com.ksinfo.blind.common.mapper;

import com.ksinfo.blind.common.dto.CommonPostDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface MainMapper {
	public List<CommonPostDto> topicBestList(); //토픽베스트

	public List<CommonPostDto> topicSubList();
}