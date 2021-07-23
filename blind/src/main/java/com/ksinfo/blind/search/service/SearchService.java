package com.ksinfo.blind.search.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostDto;
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
	public List<BoardDto> getBoardNameAndIdAndCount(String searchKeyword){
		return mapper.getBoardNameAndIdAndCount(searchKeyword);			
	} 
	
		
	public List<PostDto> getPostSelectTopic(int selectBoardId, String searchKeyword){
		//����ڰ� ������ ����(����)�� �ѹ�����, �˻�� �޾Ƽ� �˻��� �����Ѵ�.
		//�����ؾ� �ϴ� ���� 2��(boardId,searchKeyword) �̹Ƿ� HashMap�� Ȱ���Ͽ� ���� �ѱ��.
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :Ű��, object : �����
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);		
		return mapper.getPostSelectTopic(paramMap);			
	}

	
	//����Ʈ-����-�ֽ��� ��
	public List<PostDto> getSortPostBylatestDate(int selectBoardId, String searchKeyword){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :Ű��, object : �����
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);			
		return mapper.getSortPostBylatestDate(paramMap);		
	} 
	//����Ʈ-����-��õ��
	public List<PostDto> getSortPostByRecommend(int selectBoardId, String searchKeyword){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); //String :Ű��, object : �����
		paramMap.put("searchKeyword", searchKeyword); //
		paramMap.put("boardId", selectBoardId);		
		return mapper.getSortPostByRecommend(paramMap);					
	}

	public void setCompanyRecommendVote(int userId, int companyId, int companyVoteValue){
		
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); 

		//COMPANY_RECOMMEND_INF에 기업추천/비추천을 위해 필요한 정보들을 준비.
		paramMap.put("userId", userId); 					
		paramMap.put("companyId", companyId);				
		paramMap.put("companyVoteValue", companyVoteValue);		
		
		mapper.setCompanyRecommendVote(paramMap);							
	}
	

}
