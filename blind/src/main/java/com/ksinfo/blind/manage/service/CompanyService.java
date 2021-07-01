package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.dto.CompanyDto;
import com.ksinfo.blind.manage.dto.CompanySearchDto;
import com.ksinfo.blind.manage.dto.CompanyVerifyDto;
import com.ksinfo.blind.manage.mapper.CompanyMapper;
import com.ksinfo.blind.manage.vo.BusinessTypeVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	private final CompanyMapper companyMapper;

	@Autowired
	public CompanyService(CompanyMapper companyMapper) {
		this.companyMapper = companyMapper;
	}

	public PageNavigator getNavigator(int page, CompanySearchDto companySearchDto) {
		int totalRecord = companyMapper.getTotalRecord(companySearchDto);
		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	public List<CompanyVO> getCompanyList(int page, CompanySearchDto companySearchDto) {
		int offset = (page - 1) * recordLimit;
		return companyMapper.getCompanyList(new RowBounds(offset, recordLimit), companySearchDto);
	}

	public List<BusinessTypeVO> getBusinessTypeList() {
		return companyMapper.getBusinessTypeList();
	}

	public int applyCompany(CompanyDto company) {
		return companyMapper.applyCompany(company);
	}

	public int updateCompany(CompanyDto company) {
		return companyMapper.updateCompany(company);
	}

	public int verifyCompany(CompanyVerifyDto verifyData) {
		return companyMapper.verifyCompany(verifyData);
	}
}