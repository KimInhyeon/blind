package com.ksinfo.blind.search.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostAlignDto;
import com.ksinfo.blind.search.dto.PostCountInfDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.ReplyDto;
import com.ksinfo.blind.search.dto.SearchDto;
import com.ksinfo.blind.search.dto.UserDto;


@Repository
@Mapper 
public interface SearchMapper {
	//회사프로필 관련 get메소드
	List<CompanyDto>getSearchCompany(String searchKeyword);  //searchMapper.xml에서 xml의 selectid와 통일시킨다.	
	List<CompanyReviewDto> getCompanyReviews(int companyId);

	
	//개시글 관련 get메소드 모음
	List<PostDto> getSearchPosts(String searchKeyword); 	//검색어와 관련된 포스트(게시글) 검색
	List<UserDto> getNicknameAndCompanynameOfPosts(int userId);	//검색어된 게시글에 대한 작성자의 정보(닉네임,근무회사) 
	
	List<PostCountInfDto> getViewCountOfPosts(int postId);	//게시글 조회수 카운트

	
	List<ReplyDto> getReplysOfPosts(int postId);

	List<BoardDto> getBoardTopicName(int boardId);
	List<PostAlignDto> getsortPostBylatestDate(String searchKeyword);
	List<PostDto> getPostsOfOneTopic(java.util.Map<String, Object> paramMap);

	List<Integer> getBoardTopicCount(String searchKeyword); 
	List<Integer> getRecommendCountOfPosts(int postId);
	List<Integer> getReplyCountsOfPosts(int postId);
	
	//(2)창주님경우 ->페이지 출력을 페이지 카운트
	//int getTotalRecordsCount(CompanySearchVO companySearchVO); //CompanySearchVO.java를 통해 객체 생성. 문제는 내용을 모르겠다.
	//List<CompanyVO>getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);
}
