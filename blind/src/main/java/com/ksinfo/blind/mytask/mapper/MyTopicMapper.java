package com.ksinfo.blind.mytask.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.mytask.dto.MyTopicDto;

@Repository
@Mapper
public interface MyTopicMapper {

	public List<MyTopicDto> mytopicList(long userId);
}
