package com.ksinfo.blind.board.mapper;

import com.ksinfo.blind.board.dto.PostDto;
import com.ksinfo.blind.board.dto.PostRequestDto;
import com.ksinfo.blind.board.vo.PostVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PostMapper {
	long writePost(PostDto postDto);

	void readPost(long postId);

	PostVO getPost(PostRequestDto postRequest);
}