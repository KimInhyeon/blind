package com.ksinfo.blind.companyReview.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.companyReview.dto.CompanyDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.companyReview.dto.CompanyMainViewDto;
import com.ksinfo.blind.manage.dto.CompanySearchDto;
import com.ksinfo.blind.search.dto.PostDto;

@Repository
@Mapper
public interface CompanyReviewMapper {
	List<CompanyDto> companySearch(String paramString);
	List<CompanyDto> companySearchAll();
	int companyReviewJoin(CompanyJoinDto inputDto);
	List<CompanyMainViewDto> companySearchPopular();
	String getCompanyName(int companyId);
	

	int getTotalRecord(Map<String, Object> paramMap );
	
	List<PostDto> getPosts(RowBounds row, Map<String, Object> paramMap );
}
