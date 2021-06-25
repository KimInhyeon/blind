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

	
	//포스트 관련
	//2.1.포스트 출력 관련
	List<PostDto> getSearchPosts(String searchKeyword); 	//포스트 제목 기준검색
	List<UserDto> getNicknameAndCompanynameOfPosts(int userId);	//게시글 작성자의 정보(닉네임,근무회사) 
	List<BoardDto> getBoardNameAndIdAndCount(String searchKeyword); //게시글 제목 기준 검색	

	//2.2. 드롭박스 정렬 옵션
	//2.2.1. 최신일 정렬
	List<PostDto> getSortPostAllTopicBylatestDate(String searchKeyword); //전체 정렬시 boardId 필요없음.
//	List<PostDto> getSortPostAllTopicBylatestDate(String searchKeyword,int boardId); //전체 정렬시 boardId 필요없음.
//	List<PostDto> getSortPostOneTopicBylatestDate(String searchKeyword,); //1개 토픽선택시 boardId 필요함.

	//2.2.2. 최신일 정렬
	List<PostDto> getPostsOfOneTopic(java.util.Map<String, Object> paramMap); //추천순 정렬
	
	

}
