package com.ksinfo.blind.companyIntroduction.mapper;

import com.ksinfo.blind.companyIntroduction.dto.CompanyAverageDto;
import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface CompanyIntroductionMapper {
 CompanyIntroductionDto companyIntro(long paramlong);
 int reviewCount(Long companyId);
 CompanyAverageDto companyAveragePoint(long companyId);
 CompanyJoinDto	oneCompanyReview(long companyId);
 List<CompanyJoinDto>	companyReviewList(Map<String,Long> paramMap, RowBounds rowBounds);
 void helpCount(Map<String ,Long> paramMap);
 void updateHelpCount(Map<String, Long> paramMap);
 CompanyJoinDto searchCompanyRecommend(long companyReviewId);
 int  checkRecommend(Map<String,Long> paramMap);
 int getTotalRecord(Map<String, Object> map);
}