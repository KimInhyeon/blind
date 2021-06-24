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

	//출력시 페이징 관연을 위해 필요.
	private final int countPerPage = 10;
	private final int pagePerGroup = 5;
	
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
	
	public List<PostCountInfDto> getViewCountOfPosts(int postId){
		return mapper.getViewCountOfPosts(postId);	
	}

	public 	List<ReplyDto> getReplysOfPosts(int postId){
		return mapper.getReplysOfPosts(postId);	
	}

	
	public List<Integer> getRecommendCountOfPosts(int postId){
		return mapper.getRecommendCountOfPosts(postId);	
	}
	
	public List<Integer> getReplyCountsOfPosts(int postId){
		return mapper.getReplyCountsOfPosts(postId);	
	}
	
	public List<UserDto> getNicknameAndCompanynameOfPosts(int userId){
		return mapper.getNicknameAndCompanynameOfPosts(userId);	
	}

	public List<BoardDto> getBoardNameAndIdAndCount(String searchKeyword){
		return mapper.getBoardNameAndIdAndCount(searchKeyword);			
	} 
	
	
	public List<PostAlignDto> getsortPostBylatestDate(String searchKeyword){
		return mapper.getsortPostBylatestDate(searchKeyword);					
	} 

	
	public List<PostDto> getPostsOfOneTopic(int selectBoardId, String searchKeyword){
		//사용자가 선택한 토픽(보드)을 넘버값과, 검색어를 받아서 검색을 진행한다.
		//전달해야 하는 값이 2개(boardId,searchKeyword) 이므로 HashMap을 활용하여 값을 넘긴다.
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :키값, object : 밸류값
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);		
		return mapper.getPostsOfOneTopic(paramMap);							
	}
	
}


