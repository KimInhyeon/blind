package com.ksinfo.blind.company.mapper;

import com.ksinfo.blind.company.dto.CompanyReviewRecommendDto;
import com.ksinfo.blind.company.dto.CompanyReviewSearchDto;
import com.ksinfo.blind.company.dto.CompanyReviewWriteDto;
import com.ksinfo.blind.company.vo.CompanyReviewAverageVO;
import com.ksinfo.blind.company.vo.CompanyReviewRecommendResultVO;
import com.ksinfo.blind.company.vo.CompanyReviewVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface CompanyReviewMapper {
	CompanyReviewAverageVO getReviewAveragePoint(long companyId);

	int getTotalReviewRecord(long companyId);

	List<CompanyReviewVO> getCompanyReviewList(CompanyReviewSearchDto search, RowBounds rowBounds);

	Long findReviewRecommendId(CompanyReviewRecommendDto reviewRecommendDto);

	void recommendReview(CompanyReviewRecommendDto reviewRecommendDto);

	void updateReviewRecommend(Long reviewRecommendId);

	CompanyReviewRecommendResultVO getReviewRecommendResult(CompanyReviewRecommendDto reviewRecommendDto);

	void writeCompanyReview(CompanyReviewWriteDto companyReview);


	//BLIND_0016 企業レビュー詳細照会(2021-08-25)
	List<CompanyReviewVO> getCompanyReviews(long companyId);

	//BLIND_0017_企業ポストタブ(2021-08-11)
	String getCompanyName(long companyId);
}