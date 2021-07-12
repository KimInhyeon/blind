package com.ksinfo.blind.annualIncome.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.ksinfo.blind.annualIncome.dto.CompanyDto;

@Repository
@Mapper
public interface AnnualIncomeMapper {
	List<CompanyDto> getCompanyProfile(String selectCompany);
}
