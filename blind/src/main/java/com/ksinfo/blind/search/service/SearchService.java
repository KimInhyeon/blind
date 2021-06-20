package com.ksinfo.blind.search.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
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

	public List<CompanyReviewDto> getCompanyReviews(String searchKeyword){
		return mapper.getCompanyReviews(searchKeyword);
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
	
	public List<UserDto> getWriterDataOfPosts(int userId){
		return mapper.getWriterDataOfPosts(userId);	
	}
	
	public List<String> getWriterCompany (int companyId){
		return mapper.getWriterCompany(companyId);			
	}
	
	public List<String> getJobGroupNameOfCompanyReviewer(int jobGroupCode){
		return mapper.getJobGroupNameOfCompanyReviewer(jobGroupCode);			
	}
	
}


