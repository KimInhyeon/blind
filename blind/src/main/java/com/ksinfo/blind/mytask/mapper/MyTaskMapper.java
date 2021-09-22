package com.ksinfo.blind.mytask.mapper;

import com.ksinfo.blind.mytask.dto.MyTaskDto;
import com.ksinfo.blind.mytask.dto.MyTopicDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface MyTaskMapper {

	public List<MyTaskDto> companyreviewList(long userId);

	public List<MyTaskDto> reportList(long userId);
}
