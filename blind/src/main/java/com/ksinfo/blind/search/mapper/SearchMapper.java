package com.ksinfo.blind.search.mapper;

import com.ksinfo.blind.search.dto.BoardDto;
import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.CompanyVoteResultDto;
import com.ksinfo.blind.search.dto.PostDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface SearchMapper {
	//회사프로필 관련 get메소드
	List<CompanyDto>getSearchCompany(String searchKeyword); //searchMapper.xml에서 xml의 selectid와 통일시킨다.
	List<CompanyReviewDto> getCompanyReviews(int companyId);

	//포스트 관련
	//2.1. 검색시 포스트 출력 관련
	List<PostDto> getSearchPosts(String searchKeyword); //포스트 제목 기준검색
	List<BoardDto> getBoardNameAndIdAndCount(String searchKeyword); //게시글 제목 기준 검색

	//2.2.포스트-토픽선택(왼쪽드롭박스)
	List<PostDto> getPostSelectTopic(Map<String, Object> paramMap);

	//2.3. 드롭박스-정렬옵션(최신일, 추천순)
	//2.3.1. 최신일 정렬
	List<PostDto> getSortPostBylatestDate(Map<String, Object> paramMap); //전체 정렬시 boardId 필요없음.
	//2.3.2. 추천순 정렬
	List<PostDto> getSortPostByRecommend(java.util.Map<String, Object> paramMap); //추천순으로 1개의 토픽의 포스트만 정렬.

	//기업선호도 관련
	void setCompanyRecommendVote(java.util.Map<String, Object> paramMap); //사용자의 기업선호(추천/비추천) 값을 추가.
	List<CompanyVoteResultDto> getCompanyRecommendVoteResult(int companyId); //투표한 유저에게 기업의선호도를 출력하기 위해 good/bad 출력.
}