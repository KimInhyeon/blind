package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.mapper.CompanyMapper;
import com.ksinfo.blind.manage.vo.CompanySearchVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyService {
	private final int countPerPage = 10;
	private final int pagePerGroup = 5;

	@Autowired
	CompanyMapper companyMapper;

	public PageNavigator getNavi(int currentPage, CompanySearchVO companySearchVO) {
		int totalRecordsCount = companyMapper.getTotalRecordsCount(companySearchVO);
		return new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordsCount);
	}

	public List<CompanyVO> getCompanyList(PageNavigator navi, CompanySearchVO companySearchVO) {
		RowBounds rowBounds = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		return companyMapper.getCompanyList(rowBounds, companySearchVO);
	}
}