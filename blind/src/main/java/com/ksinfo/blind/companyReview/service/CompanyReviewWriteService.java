package com.ksinfo.blind.companyReview.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.companyReview.mapper.CompanyReviewMapper;

@Service
public class CompanyReviewWriteService {
	@Autowired
	private CompanyReviewMapper companyReviewWriteMapper;
	
	public int companyReviewJoin(CompanyJoinDto inputDto){
		return companyReviewWriteMapper.companyReviewJoin(inputDto);
	}

	public CompanyJoinDto companyReviewUpdate(long companyReviewId){
		return companyReviewWriteMapper.companyReviewUpdate(companyReviewId);
	}
}
