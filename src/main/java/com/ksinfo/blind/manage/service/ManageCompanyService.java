package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.dto.CompanyDto;
import com.ksinfo.blind.manage.dto.CompanySearchDto;
import com.ksinfo.blind.manage.dto.CompanyVerifyDto;
import com.ksinfo.blind.manage.mapper.ManageCompanyMapper;
import com.ksinfo.blind.manage.vo.BusinessTypeVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ManageCompanyService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	private final ManageCompanyMapper manageCompanyMapper;

	@Autowired
	public ManageCompanyService(ManageCompanyMapper manageCompanyMapper) {
		this.manageCompanyMapper = manageCompanyMapper;
	}

	@Transactional(readOnly = true)
	public PageNavigator getNavigator(int page, CompanySearchDto companySearchDto) {
		int totalRecord = manageCompanyMapper.getTotalCompanyRecord(companySearchDto);
		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	@Transactional(readOnly = true)
	public List<CompanyVO> getCompanyList(int page, CompanySearchDto companySearchDto) {
		int offset = (page - 1) * recordLimit;
		return manageCompanyMapper.getCompanyList(new RowBounds(offset, recordLimit), companySearchDto);
	}

	@Transactional(readOnly = true)
	public List<BusinessTypeVO> getBusinessTypeList() {
		return manageCompanyMapper.getBusinessTypeList();
	}

	public int applyCompany(CompanyDto company) {
		return manageCompanyMapper.applyCompany(company);
	}

	public int updateCompany(CompanyDto company) {
		return manageCompanyMapper.updateCompany(company);
	}

	public int verifyCompany(CompanyVerifyDto verifyData) {
		return manageCompanyMapper.verifyCompany(verifyData);
	}
}