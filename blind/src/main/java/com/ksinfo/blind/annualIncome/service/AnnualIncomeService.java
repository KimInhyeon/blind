package com.ksinfo.blind.annualIncome.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.annualIncome.mapper.AnnualIncomeMapper;

@Service
public class AnnualIncomeService {
	
	@Autowired
	public AnnualIncomeMapper mapper;
	
}
