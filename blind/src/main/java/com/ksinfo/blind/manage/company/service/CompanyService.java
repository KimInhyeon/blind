package com.ksinfo.blind.manage.company.service;

import com.ksinfo.blind.manage.company.dto.CompanyDto;
import com.ksinfo.blind.manage.company.mapper.CompanyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CompanyService {
	@Autowired
	CompanyMapper mapper;

	public List<CompanyDto> test() {
		return mapper.test();
	}
}