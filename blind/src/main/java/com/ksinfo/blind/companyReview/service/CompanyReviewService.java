package com.ksinfo.blind.companyReview.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.companyReview.dto.CompanyDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.companyReview.dto.CompanyMainViewDto;
import com.ksinfo.blind.companyReview.mapper.CompanyReviewMapper;


@Service
public class CompanyReviewService {
	@Autowired
	private CompanyReviewMapper companyReviewMapper;
	
	public List<CompanyDto> companySearch(String paramString){
		
		return companyReviewMapper.companySearch(paramString);
	}
	public List<CompanyDto> companySearchAll(){
		return companyReviewMapper.companySearchAll();
	}
	public List<CompanyMainViewDto> companySearchPopular(){
		return companyReviewMapper.companySearchPopular();
	}
	
	public void sendRequestCompanyRegist(String requestCompnayName, String requestCompnayEmail,int userid){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>(); 

		paramMap.put("userid", userid);	   
		paramMap.put("requestCompnayName", requestCompnayName); 
		paramMap.put("requestCompnayEmail", requestCompnayEmail);	    
 
		companyReviewMapper.sendRequestCompanyRegist(paramMap);	
	}
	
}
