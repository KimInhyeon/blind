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

	//List<CompanyBusinessTypeVO> getBusinessTypeNameList();

	List<CompanyBusinessTypeVO> getBusinessTypeListExistAIData();

	List<CompanyJobGroupVO> getJobGroupListExistAIData();

	CompanyBusinessTypeVO  getUserBusinessTypeCode(Long userId);

	CompanyJobGroupVO getUserJobGroupCode(Long userId);

	AnnualIncomeRankVO getAnnualIncomeAndRank(java.util.Map<String, Object> paramMap);

}