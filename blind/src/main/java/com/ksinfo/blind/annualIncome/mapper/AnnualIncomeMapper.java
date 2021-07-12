package com.ksinfo.blind.annualIncome.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.annualIncome.dto.companyDto;
import com.ksinfo.blind.annualIncome.dto.jobGroupDto;
import com.ksinfo.blind.annualIncome.dto.annualIncomeByJobGroupDto;

@Repository
@Mapper
public interface AnnualIncomeMapper {
	List<companyDto> getCompanyProfile(String selectCompany);
	List<jobGroupDto> getJobGroupList();		
	List<annualIncomeByJobGroupDto> getAnnualIncomeData(java.util.Map<String, Object> paramMap);
}
