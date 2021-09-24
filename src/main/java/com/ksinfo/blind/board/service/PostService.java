package com.ksinfo.blind.board.service;

import com.ksinfo.blind.board.dto.PostDto;
import com.ksinfo.blind.board.dto.PostRecommendDto;
import com.ksinfo.blind.board.dto.PostRequestDto;
import com.ksinfo.blind.board.mapper.PostMapper;
import com.ksinfo.blind.board.vo.PostRecommendResultVO;
import com.ksinfo.blind.board.vo.PostVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PostService {
	private final PostMapper postMapper;

	@Autowired
	public PostService(PostMapper postMapper) {
		this.postMapper = postMapper;
	}

	public long writePost(PostDto postDto) {
		postDto.escapeDoubleQuote();
		return postMapper.writePost(postDto);
	}

	@Transactional(isolation = Isolation.READ_UNCOMMITTED)
	public void readPost(long postId) {
		postMapper.readPost(postId);
	}

	@Transactional(readOnly = true)
	public PostVO getPost(PostRequestDto postRequest) {
		return postMapper.getPost(postRequest);
	}

	public PostRecommendResultVO recommendPost(PostRecommendDto postRecommendDto) {
		Long postRecommendId = postMapper.searchPostRecommend(postRecommendDto);
		if (postRecommendId == null) {
			postMapper.recommendPost(postRecommendDto);
		} else {
			postMapper.updatePostRecommend(postRecommendId);
		}

		return postMapper.getPostRecommendResult(postRecommendDto);
	}
}