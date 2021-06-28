package com.ksinfo.blind.search.service;

import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostAlignDto;
import com.ksinfo.blind.search.dto.PostCountInfDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.ReplyDto;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.dto.UserDto;
import com.ksinfo.blind.search.mapper.SearchMapper;

@Service 
public class SearchService {

	
	@Autowired 
	public SearchMapper mapper;  //SearchMapper.java
	
	public List<CompanyDto> getSearchCompany(String searchKeyword) { 
		return mapper.getSearchCompany(searchKeyword);     //searchMapper.java mapper확ㅈ
	}

	public List<CompanyReviewDto> getCompanyReviews(int companyId){
		return mapper.getCompanyReviews(companyId);
	}

	public List<PostDto>  getSearchPosts(String searchKeyword){ 
		return mapper.getSearchPosts(searchKeyword);     //searchMapper.java mapper확ㅈ
	}
	
	public List<UserDto> getNicknameAndCompanynameOfPosts(int userId){
		return mapper.getNicknameAndCompanynameOfPosts(userId);	
	}

	public List<BoardDto> getBoardNameAndIdAndCount(String searchKeyword){
		return mapper.getBoardNameAndIdAndCount(searchKeyword);			
	} 
	

		
	public List<PostDto> getPostSelectTopic(int selectBoardId, String searchKeyword){
		//사용자가 선택한 토픽(보드)을 넘버값과, 검색어를 받아서 검색을 진행한다.
		//전달해야 하는 값이 2개(boardId,searchKeyword) 이므로 HashMap을 활용하여 값을 넘긴다.
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :키값, object : 밸류값
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);		
		return mapper.getPostSelectTopic(paramMap);			
	}

	
	//포스트-정렬-최신일 순
	public List<PostDto> getSortPostBylatestDate(String searchKeyword,int selectBoardId){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :키값, object : 밸류값
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);			
		return mapper.getSortPostBylatestDate(paramMap);		
	} 
	//포스트-정렬-추천순
	public List<PostDto> getSortPostByRecommend(int selectBoardId, String searchKeyword){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :키값, object : 밸류값
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);		
		return mapper.getSortPostByRecommend(paramMap);					
	}
	
}


