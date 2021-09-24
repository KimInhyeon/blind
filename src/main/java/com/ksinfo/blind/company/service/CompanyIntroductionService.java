package com.ksinfo.blind.company.service;

import com.ksinfo.blind.company.mapper.CompanyIntroductionMapper;
import com.ksinfo.blind.company.vo.CompanyIntroductionVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CompanyIntroductionService {
	private final CompanyIntroductionMapper companyIntroductionMapper;

	@Autowired
	public CompanyIntroductionService(CompanyIntroductionMapper companyIntroductionMapper) {
		this.companyIntroductionMapper = companyIntroductionMapper;
	}

	@Transactional(readOnly = true)
	public CompanyIntroductionVO getCompanyIntroduction(long companyId) {
		return companyIntroductionMapper.getCompanyIntroduction(companyId);
	}
}