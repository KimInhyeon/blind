package com.ksinfo.blind.search.service;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.CompanyVoteResultDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.mapper.SearchMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class SearchService {
	@Autowired
	public SearchMapper mapper; //SearchMapper.java

	public List<CompanyDto> getSearchCompany(String searchKeyword) {
		return mapper.getSearchCompany(searchKeyword); //searchMapper.java mapper확ㅈ
	}

	public List<CompanyReviewDto> getCompanyReviews(int companyId) {
		return mapper.getCompanyReviews(companyId);
	}

	public List<PostDto> getSearchPosts(String searchKeyword) {
		return mapper.getSearchPosts(searchKeyword); //searchMapper.java mapper확ㅈ
	}

	public List<BoardDto> getBoardNameAndIdAndCount(String searchKeyword) {
		return mapper.getBoardNameAndIdAndCount(searchKeyword);
	}

	public List<PostDto> getPostSelectTopic(int selectBoardId, String searchKeyword) {
		//사용자가 선택한 토픽(보드)을 넘버값과, 검색어를 받아서 검색을 진행한다.
		//전달해야 하는 값이 2개(boardId,searchKeyword) 이므로 HashMap을 활용하여 값을 넘긴다.
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :키값, object : 밸류값
		paramMap.put("searchKeyword", searchKeyword);
		paramMap.put("boardId", selectBoardId);

		return mapper.getPostSelectTopic(paramMap);
	}

	//포스트-정렬-최신일 순
	public List<PostDto> getSortPostBylatestDate(int selectBoardId, String searchKeyword) {
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :키값, object : 밸류값
		paramMap.put("searchKeyword", searchKeyword);
		paramMap.put("boardId", selectBoardId);

		return mapper.getSortPostBylatestDate(paramMap);
	}

	//포스트-정렬-추천순
	public List<PostDto> getSortPostByRecommend(int selectBoardId, String searchKeyword) {
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :키값, object : 밸류값
		paramMap.put("searchKeyword", searchKeyword);
		paramMap.put("boardId", selectBoardId);

		return mapper.getSortPostByRecommend(paramMap);
	}

	//유저가 선택한 해당기업에 대한 추천/비추천 값을 추가.
	public void setCompanyRecommendVote(int userId, int companyId, int companyVoteValue) {
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>();
		//COMPANY_RECOMMEND_INF에 기업추천/비추천을 위해 필요한 정보들을 준비.
		paramMap.put("userId", userId);
		paramMap.put("companyId", companyId);
		paramMap.put("companyVoteValue", companyVoteValue);
		mapper.setCompanyRecommendVote(paramMap);
	}

	//기업선호도 투표한 유저에게 결과(기업선호도)를 출력하기 위해 리턴.
	public List<CompanyVoteResultDto> getCompanyRecommendVoteResult(int companyId) {
		return mapper.getCompanyRecommendVoteResult(companyId);
	}
}