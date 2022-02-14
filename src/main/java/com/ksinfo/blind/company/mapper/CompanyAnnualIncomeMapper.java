package com.ksinfo.blind.company.mapper;

import com.ksinfo.blind.company.dto.CompanyAnnualIncomeSearchDto;
import com.ksinfo.blind.company.vo.*;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Mapper
public interface CompanyAnnualIncomeMapper {
	List<CompanyJobGroupVO> getJobGroupListInCompany(long companyId);

	CompanyAnnualIncomeVO getAnnualIncome(CompanyAnnualIncomeSearchDto search);

	List<CompanyJobGroupVO> getJobGroupListAll();

	List<CompanyWorkTypeVO> getWorkTypeAll();

	void setAnnualData(java.util.Map<String, Object> paramMap);

	List<CompanyBusinessTypeVO> getBusinessTypeNameList();

	CompanyAnnualIncomeForAndroidVO getAnnualIncomeFristPage(Long userId);

	CompanyAnnualIncomeForAndroidVO getAnnualIncomeUpdateToSelectedSpinner(java.util.Map<String, Object> paramMap);

}