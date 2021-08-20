package com.ksinfo.blind.companyReview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.companyReview.dto.CompanyDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.companyReview.dto.CompanyMainViewDto;
import com.ksinfo.blind.companyReview.mapper.CompanyReviewMapper;
import com.ksinfo.blind.manage.dto.CompanySearchDto;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.util.PageNavigator;


@Service
public class CompanyReviewService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	
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
	
	public String getCompanyName(int companyId){
		return companyReviewMapper.getCompanyName(companyId);
	}
	
	public PageNavigator getNavigator(int page, int totalRecord) { 
		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	
}
