package com.ksinfo.blind.companyReview.mapper;

import java.util.List;
import java.util.Map;


import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.companyReview.dto.CompanyDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.companyReview.dto.CompanyMainViewDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.companyReview.dto.CompanyReviewDto;

@Repository
@Mapper
public interface CompanyReviewMapper {
	List<CompanyDto> companySearch(String paramString);
	List<CompanyDto> companySearchAll();
	int companyReviewJoin(CompanyJoinDto inputDto);
	List<CompanyMainViewDto> companySearchPopular();

	//BLIND_0013_企業登録申請(2021-08-05)
	void sendRequestCompanyRegist(java.util.Map<String, Object> paramMap);

	//BLIND_0017_企業ポストタブ(2021-08-11)
	String getCompanyName(int companyId);
	int getTotalRecord(Map<String, Object> paramMap );
	List<PostDto> getPosts(RowBounds row, Map<String, Object> paramMap );

	//BLIND_0016 企業レビュー詳細照会(2021-08-25)
	List<CompanyReviewDto> getCompanyReviews(Map<String, Object> paramMap);
}
