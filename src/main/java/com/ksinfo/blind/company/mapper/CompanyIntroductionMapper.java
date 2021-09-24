package com.ksinfo.blind.company.mapper;

import com.ksinfo.blind.company.vo.CompanyIntroductionVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CompanyIntroductionMapper {
	CompanyIntroductionVO getCompanyIntroduction(long companyId);
}