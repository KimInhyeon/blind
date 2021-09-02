package com.ksinfo.blind.companyIntroduction.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public CompanyJoinDto companyAveragePoint(long companyId) {
		return CompanyIntroductionMapper.companyAveragePoint(companyId);
	}
}
