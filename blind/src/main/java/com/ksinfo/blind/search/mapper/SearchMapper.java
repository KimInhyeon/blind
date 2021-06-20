package com.ksinfo.blind.search.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostCountInfDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.ReplyDto;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.dto.UserDto;

@Repository
@Mapper 
public interface SearchMapper {
	//(1)���� ���   -> mapper�� ���� �ǽ��� SQL���� �̸��� ����.
	List<CompanyDto>getSearchCompany(String searchKeyword);  //searchMapper.xml���� xml�� selectid�� ���Ͻ�Ų��.	
	List<PostDto> getSearchPosts(String searchKeyword); 
	List<CompanyReviewDto> getCompanyReviews(String searchKeyword);
	List<PostCountInfDto> getViewCountOfPosts(int postId);
	List<ReplyDto> getReplysOfPosts(int postId);
	List<Integer> getRecommendCountOfPosts(int postId);
	List<Integer> getReplyCountsOfPosts(int postId);
	List<UserDto> getWriterDataOfPosts(int userId);
	List<String>  getWriterCompany (int companyId);
	List<String>  getJobGroupNameOfCompanyReviewer(int jobGroupCode);	
	List<BoardDto> getBoardTopicName(int boardId);
	List<Integer> getBoardTopicCount(int boardId); 
	List<PostDto> getsortPostBylatestDate(String searchKeyword); 	
	//(2)â�ִ԰�� ->������ ����� ������ ī��Ʈ
	//int getTotalRecordsCount(CompanySearchVO companySearchVO); //CompanySearchVO.java�� ���� ��ü ����. ������ ������ �𸣰ڴ�.
	//List<CompanyVO>getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);
}
