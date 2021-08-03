package com.ksinfo.blind.companyIntroduction.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.companyIntroduction.dto.CompanyAverageDto;
import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;

@Repository
@Mapper
public interface CompanyIntroductionMapper {
 CompanyIntroductionDto companyIntro(long paramlong);
 int reviewCount(Long companyId);
 CompanyAverageDto companyAveragePoint(long companyId);
 CompanyJoinDto	oneCompanyReview(long companyId);
 List<CompanyJoinDto>	companyReviewList(long companyId);
 void helpCount(Map<String ,Long> paramMap);
}
