package com.ksinfo.blind.manage.service;

import com.ksinfo.blind.manage.mapper.CompanyMapper;
import com.ksinfo.blind.manage.vo.BusinessTypeVO;
import com.ksinfo.blind.manage.vo.CompanySearchVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import com.ksinfo.blind.manage.vo.PageNavigator;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CompanyService {
	@Autowired
	CompanyMapper companyMapper;

	public PageNavigator getNavi(int page, CompanySearchVO companySearchVO) {
		int totalRecordsCount = companyMapper.getTotalRecordsCount(companySearchVO);
		return new PageNavigator(10, 5, page, totalRecordsCount);
	}

	public List<CompanyVO> getCompanyList(PageNavigator navi, CompanySearchVO companySearchVO) {
		RowBounds rowBounds = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		return companyMapper.getCompanyList(rowBounds, companySearchVO);
	}

	public List<BusinessTypeVO> getBusinessTypeList() {
		return companyMapper.getBusinessTypeList();
	}

	public boolean applyCompany(Map<String, Object> company) {
		return companyMapper.applyCompany(company) > 0;
	}

	public boolean updateCompany(Map<String, Object> data) {
		return companyMapper.updateCompany(data) > 0;
	}

	public boolean updateVerify(Map<String, Object> data) {
		return companyMapper.updateVerify(data) > 0;
	}
}