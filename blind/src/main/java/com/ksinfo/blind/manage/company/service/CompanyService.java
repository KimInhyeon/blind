package com.ksinfo.blind.manage.company.service;

import com.ksinfo.blind.manage.company.mapper.CompanyMapper;
import com.ksinfo.blind.manage.company.vo.CompanyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyService {
	@Autowired
	CompanyMapper mapper;

	public List<CompanyVO> getCompanyList() {
		return mapper.getCompanyList();
	}
}