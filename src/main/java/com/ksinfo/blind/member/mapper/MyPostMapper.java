package com.ksinfo.blind.member.mapper;

import com.ksinfo.blind.member.vo.MyPostVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface MyPostMapper {
	List<MyPostVO> getMyPostList(long userId);
}