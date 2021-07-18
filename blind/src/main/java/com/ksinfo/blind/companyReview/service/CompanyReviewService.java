package com.ksinfo.blind.companyReview.service;

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
}
