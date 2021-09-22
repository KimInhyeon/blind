package com.ksinfo.blind.manage.mapper;

import com.ksinfo.blind.manage.dto.CompanyDto;
import com.ksinfo.blind.manage.dto.CompanySearchDto;
import com.ksinfo.blind.manage.dto.CompanyVerifyDto;
import com.ksinfo.blind.manage.vo.BusinessTypeVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import java.util.List;

@Mapper
public interface ManageCompanyMapper {
	int getTotalCompanyRecord(CompanySearchDto companySearchDto);

	List<CompanyVO> getCompanyList(RowBounds rowBounds, CompanySearchDto companySearchDto);

	List<BusinessTypeVO> getBusinessTypeList();

	int applyCompany(CompanyDto company);

	int updateCompany(CompanyDto company);

	int verifyCompany(CompanyVerifyDto verifyData);
}