package com.ksinfo.blind.search.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.search.dto.CompanyDto;
import com.ksinfo.blind.search.dto.CompanyReviewDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.search.dto.SearchDto;

@Repository
@Mapper 
public interface SearchMapper {
	//(1)나의 경우   -> mapper를 통해 실시할 SQL문의 이름을 설정.
	List<CompanyDto>getSearchCompany();  //searchMapper.xml에서 xml의 selectid와 통일시킨다.	
	List<PostDto> getSearchPosts(); 
	List<CompanyReviewDto> getCompanyReviews();

	//(2)창주님경우 ->페이지 출력을 페이지 카운트
	//int getTotalRecordsCount(CompanySearchVO companySearchVO); //CompanySearchVO.java를 통해 객체 생성. 문제는 내용을 모르겠다.
	//List<CompanyVO>getCompanyList(RowBounds rowBounds, CompanySearchVO companySearchVO);
}
