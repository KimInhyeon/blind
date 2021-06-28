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
		return mapper.getSearchCompany(searchKeyword);     //searchMapper.java mapperȮ��
	}

	public List<CompanyReviewDto> getCompanyReviews(int companyId){
		return mapper.getCompanyReviews(companyId);
	}

	public List<PostDto>  getSearchPosts(String searchKeyword){ 
		return mapper.getSearchPosts(searchKeyword);     //searchMapper.java mapperȮ��
	}
	
	public List<UserDto> getNicknameAndCompanynameOfPosts(int userId){
		return mapper.getNicknameAndCompanynameOfPosts(userId);	
	}

	public List<BoardDto> getBoardNameAndIdAndCount(String searchKeyword){
		return mapper.getBoardNameAndIdAndCount(searchKeyword);			
	} 
	
	public List<PostDto> getSortPostAllTopicBylatestDate(String searchKeyword){
		return mapper.getSortPostAllTopicBylatestDate(searchKeyword);			
	}
	
	public List<PostDto> getSortPostOneTopicBylatestDate(String searchKeyword,int selectBoardId){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :Ű��, object : �����
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);			
		return mapper.getSortPostOneTopicBylatestDate(paramMap);		
	} 
	
		
	public List<PostDto> getPostsOfOneTopic(int selectBoardId, String searchKeyword){
		//����ڰ� ������ ����(����)�� �ѹ�����, �˻�� �޾Ƽ� �˻��� �����Ѵ�.
		//�����ؾ� �ϴ� ���� 2��(boardId,searchKeyword) �̹Ƿ� HashMap�� Ȱ���Ͽ� ���� �ѱ��.
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :Ű��, object : �����
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);		
		return mapper.getPostsOfOneTopic(paramMap);			
	}
	
	public List<PostDto> getSortPostByRecommend(int selectBoardId, String searchKeyword){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :Ű��, object : �����
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);		
		return mapper.getSortPostByRecommend(paramMap);					
	}
	
}


