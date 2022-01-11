package com.ksinfo.blind.company.service;

import com.ksinfo.blind.company.dto.CompanyAnnualIncomeSearchDto;
import com.ksinfo.blind.company.vo.CompanyAnnualIncomeVO;
import com.ksinfo.blind.company.mapper.CompanyAnnualIncomeMapper;
import com.ksinfo.blind.company.vo.CompanyJobGroupVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CompanyAnnualIncomeService {
	private final CompanyAnnualIncomeMapper companyAnnualIncomeMapper;

	@Autowired
	public CompanyAnnualIncomeService(CompanyAnnualIncomeMapper companyAnnualIncomeMapper) {
		this.companyAnnualIncomeMapper = companyAnnualIncomeMapper;
	}

	@Transactional(readOnly = true)
	public List<CompanyJobGroupVO> getJobGroupListInCompany(long companyId) {
		return companyAnnualIncomeMapper.getJobGroupListInCompany(companyId);
	}

	@Transactional(readOnly = true)
	public CompanyAnnualIncomeVO getAnnualIncome(CompanyAnnualIncomeSearchDto search) {
		return companyAnnualIncomeMapper.getAnnualIncome(search);
	}

	@Transactional(readOnly = true)
	public List<CompanyJobGroupVO> getJobGroupListAll(){
		return companyAnnualIncomeMapper.getJobGroupListAll();
	}
}