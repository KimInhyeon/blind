package com.ksinfo.blind.companyReview.service;

import com.ksinfo.blind.companyReview.dto.CompanyDto;
import com.ksinfo.blind.companyReview.dto.CompanyMainViewDto;
import com.ksinfo.blind.companyReview.dto.CompanyReviewDto;

import com.ksinfo.blind.companyReview.mapper.CompanyReviewMapper;
import com.ksinfo.blind.search.dto.PostDto;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import java.util.HashMap;
import java.util.List;
import java.util.Map;


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

	//BLIND_0013_企業登録申請(2021-08-05)
	public void sendRequestCompanyRegist(String requestCompnayName, String requestCompnayEmail,int userid){
	//	java.util.Map<String, Object> paramMap = new HashMap<String, Object>();
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("userid", userid);
		paramMap.put("requestCompnayName", requestCompnayName);
		paramMap.put("requestCompnayEmail", requestCompnayEmail);

		companyReviewMapper.sendRequestCompanyRegist(paramMap);
	}

	//BLIND_0017_企業ポストタブ(2021-08-11)
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

	//BLIND_0016 企業レビュー詳細照会(2021-08-25)
	public List<CompanyReviewDto> getCompanyReviews(int companyId){
		return companyReviewMapper.getCompanyReviews(companyId);
	}
}
