package com.ksinfo.blind.companyIntroduction.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ksinfo.blind.companyIntroduction.dto.CompanyAverageDto;
import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyIntroduction.mapper.CompanyIntroductionMapper;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;

@Service
public class CompanyIntroductionService {
	@Autowired
	private  CompanyIntroductionMapper CompanyIntroductionMapper;
	public CompanyIntroductionDto companyIntroduction(long paramlong){
		return CompanyIntroductionMapper.companyIntro(paramlong);
	}
	public int reviewCount(Long companyId) {
		return CompanyIntroductionMapper.reviewCount(companyId);
	}
	public CompanyAverageDto companyAveragePoint(long companyId) {
		return CompanyIntroductionMapper.companyAveragePoint(companyId);
	}
	public CompanyJoinDto oneCompanyReview(long companyId) {
		return CompanyIntroductionMapper.oneCompanyReview(companyId);
	}
	public List<CompanyJoinDto> companyReviewList(long companyId){
		return CompanyIntroductionMapper.companyReviewList(companyId);
	}
	public void helpCount(Map<String,Long> param) {
		CompanyIntroductionMapper.helpCount(param);
	}
}
