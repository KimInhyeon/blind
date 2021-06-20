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
	//(1)나의 경우   -> mapper를 통해 실시할 SQL문의 이름을 설정.
	List<CompanyDto>getSearchCompany(String searchKeyword);  //searchMapper.xml에서 xml의 selectid와 통일시킨다.	
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
	//(2)창주님경우 ->페이지 출력을 페이지 카운트
	//int getTotalRecordsCount(CompanySearchVO companySearchVO); //CompanySearchVO.java를 통해 객체 생성. 문제는 내용을 모르겠다.
	//List<CompanyVO>getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);
}
