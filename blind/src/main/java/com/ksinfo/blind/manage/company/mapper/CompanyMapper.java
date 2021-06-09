package com.ksinfo.blind.manage.company.mapper;

import com.ksinfo.blind.manage.company.dto.CompanyDto;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CompanyMapper {
	List<CompanyDto> test();
}