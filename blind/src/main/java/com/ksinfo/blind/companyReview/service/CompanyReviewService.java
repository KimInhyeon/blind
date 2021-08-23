package com.ksinfo.blind.companyReview.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.companyReview.dto.CompanyDto;
import com.ksinfo.blind.companyReview.dto.CompanyMainViewDto;
import com.ksinfo.blind.companyReview.mapper.CompanyReviewMapper;
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
		
	
	public PageNavigator getNavigator(int page, Map<String, Object> paramMap ) { 
		int totalRecord = companyReviewMapper.getTotalRecord(paramMap);
		
		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}
	
	public List<PostDto> getPosts(int page, Map<String, Object> paramMap ){
		int offset = (page-1)*recordLimit;
		return companyReviewMapper.getPosts(new RowBounds(offset, recordLimit), paramMap);
	}
	
}
