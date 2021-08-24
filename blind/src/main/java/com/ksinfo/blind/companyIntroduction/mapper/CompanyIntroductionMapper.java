package com.ksinfo.blind.companyIntroduction.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;

@Repository
@Mapper
public interface CompanyIntroductionMapper {
 CompanyIntroductionDto companyIntro(long paramlong);
 int reviewCount(Long companyId);
 CompanyJoinDto companyAveragePoint(long companyId); 
}
