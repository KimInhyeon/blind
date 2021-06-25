package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.dto.CompanyVerifyDto;
import com.ksinfo.blind.manage.dto.CompanyDto;
import com.ksinfo.blind.manage.dto.CompanySearchDto;
import com.ksinfo.blind.manage.mapper.CompanyMapper;
import com.ksinfo.blind.manage.vo.BusinessTypeVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class CompanyService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	@Autowired
	private CompanyMapper companyMapper;

	public PageNavigator getNavigator(int page, CompanySearchDto companySearchDto) {
		int totalRecord = companyMapper.getTotalRecord(companySearchDto);
		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	public List<CompanyVO> getCompanyList(PageNavigator navi, CompanySearchDto companySearchDto) {
		int offset = (navi.getCurrentPage() - 1) * recordLimit;
		return companyMapper.getCompanyList(new RowBounds(offset, recordLimit), companySearchDto);
	}

	public List<BusinessTypeVO> getBusinessTypeList() {
		return companyMapper.getBusinessTypeList();
	}

	public boolean applyCompany(CompanyDto company, HttpSession session) {
		company.setUserId((long) session.getAttribute("userId"));
		return companyMapper.applyCompany(company) > 0;
	}

	public boolean updateCompany(CompanyDto company, HttpSession session) {
		company.setUserId((long) session.getAttribute("userId"));
		return companyMapper.updateCompany(company) > 0;
	}

	public int verifyCompany(CompanyVerifyDto data, HttpSession session) {
		data.setUserId((long) session.getAttribute("userId"));
		return companyMapper.verifyCompany(data);
	}
}