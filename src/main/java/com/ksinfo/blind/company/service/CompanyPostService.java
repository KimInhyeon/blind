package com.ksinfo.blind.company.service;

import com.ksinfo.blind.company.dto.CompanyPostSearchDto;
import com.ksinfo.blind.company.mapper.CompanyPostMapper;
import com.ksinfo.blind.company.vo.CompanyPostVO;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CompanyPostService {
	private static final int recordLimit = 10;
	private static final int pagination = 5;
	private final CompanyPostMapper companyPostMapper;

	@Autowired
	public CompanyPostService(CompanyPostMapper companyPostMapper) {
		this.companyPostMapper = companyPostMapper;
	}

	@Transactional(readOnly = true)
	public PageNavigator getPageNavigator(CompanyPostSearchDto search, int page) {
		int totalRecord = companyPostMapper.getTotalCompanyPostRecord(search);

		return new PageNavigator(page, totalRecord, recordLimit, pagination);
	}

	@Transactional(readOnly = true)
	public List<CompanyPostVO> getCompanyPostList(CompanyPostSearchDto search, int page) {
		int offset = (page - 1) * recordLimit;

		return companyPostMapper.getCompanyPostList(search, new RowBounds(offset, recordLimit));
	}
}