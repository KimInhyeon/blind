package com.ksinfo.blind.annualIncome.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.annualIncome.dto.companyDto;
import com.ksinfo.blind.annualIncome.dto.jobGroupDto;
import com.ksinfo.blind.annualIncome.dto.annualIncomeByJobGroupDto;
import com.ksinfo.blind.annualIncome.mapper.AnnualIncomeMapper;

@Service
public class AnnualIncomeService {
	
	@Autowired
	public AnnualIncomeMapper mapper;
	
	public List<companyDto> getCompanyProfile(String selectCompany){
		return mapper.getCompanyProfile(selectCompany);
	}

	public List<jobGroupDto> getJobGroupList(){
		return mapper.getJobGroupList();		
	}
	
	public List<annualIncomeByJobGroupDto> getAnnualIncomeData(int companyId, String jobGroupCode){

		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); 
		//String :키값, object : 밸류값
		paramMap.put("companyId", companyId); //변수명.put("키값", 밸류값)
		paramMap.put("jobGroupCode", jobGroupCode);	      //put은 데이터를 입력하는 것이다.	
		
		return mapper.getAnnualIncomeData(paramMap);		
	}
	
	
}