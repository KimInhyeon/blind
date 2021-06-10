package com.ksinfo.blind.manage.company.mapper;

import com.ksinfo.blind.manage.company.vo.CompanyVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface CompanyMapper {
	List<CompanyVO> getCompanyList();
}