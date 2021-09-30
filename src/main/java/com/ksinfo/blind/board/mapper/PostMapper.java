package com.ksinfo.blind.board.mapper;

import com.ksinfo.blind.board.dto.PostDto;
import com.ksinfo.blind.board.dto.PostRecommendDto;
import com.ksinfo.blind.board.dto.PostRequestDto;
import com.ksinfo.blind.board.dto.PostUpdateDto;
import com.ksinfo.blind.board.vo.PostRecommendVO;
import com.ksinfo.blind.board.vo.PostVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PostMapper {
	long writePost(PostDto postDto);

	void updatePost(PostUpdateDto postUpdateDto);

	void deletePost(long userId, long postId);

	void readPost(long postId);

	PostVO getPost(PostRequestDto postRequest);

	Long searchPostRecommend(PostRecommendDto postRecommendDto);

	void recommendPost(PostRecommendDto postRecommendDto);

	void updatePostRecommend(Long postRecommendId);

	PostRecommendVO getPostRecommendResult(PostRecommendDto postRecommendDto);
}