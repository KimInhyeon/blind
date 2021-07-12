package com.ksinfo.blind.annualIncome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.annualIncome.dto.CompanyDto;
import com.ksinfo.blind.annualIncome.mapper.AnnualIncomeMapper;

@Service
public class AnnualIncomeService {
	
	@Autowired
	public AnnualIncomeMapper mapper;
	
	public List<CompanyDto> getCompanyProfile(String selectCompany){
		return mapper.getCompanyProfile(selectCompany);
	}
}
