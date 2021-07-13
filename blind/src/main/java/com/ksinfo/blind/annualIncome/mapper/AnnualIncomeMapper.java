package com.ksinfo.blind.annualIncome.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.annualIncome.dto.CompanyDto;
import com.ksinfo.blind.annualIncome.dto.JobGroupDto;
import com.ksinfo.blind.annualIncome.dto.AnnualIncomeByJobGroupDto;

@Repository
@Mapper
public interface AnnualIncomeMapper {
	List<CompanyDto> getCompanyProfile(String selectCompany);
	List<JobGroupDto> getJobGroupList();		
	List<AnnualIncomeByJobGroupDto> getAnnualIncomeData(java.util.Map<String, Object> paramMap);
	List<AnnualIncomeByJobGroupDto> getAnnualIncomeAllJobGroup(int companyId);
} 