package com.ksinfo.blind.company.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ksinfo.blind.company.dto.CompanyAnnualIncomeSearchDto;
import com.ksinfo.blind.company.vo.AnnualIncomeRankVO;
import com.ksinfo.blind.company.vo.CompanyAnnualIncomeVO;
import com.ksinfo.blind.company.vo.CompanyBusinessTypeVO;
import com.ksinfo.blind.company.vo.CompanyJobGroupVO;
import com.ksinfo.blind.company.vo.CompanyWorkTypeVO;

@Mapper
public interface CompanyAnnualIncomeMapper {
	List<CompanyJobGroupVO> getJobGroupListInCompany(long companyId);

	CompanyAnnualIncomeVO getAnnualIncome(CompanyAnnualIncomeSearchDto search);

	List<CompanyJobGroupVO> getJobGroupListAll();

	List<CompanyWorkTypeVO> getWorkTypeAll();

	void setAnnualData(java.util.Map<String, Object> paramMap);

	List<CompanyBusinessTypeVO> getBusinessTypeListExistAIData();

	List<CompanyJobGroupVO> getJobGroupListExistAIData();

	String getUserBusinessTypeCode(Long userId);

	String  getUserJobGroupCode(Long userId);

	AnnualIncomeRankVO getAnnualIncomeAndRank(java.util.Map<String, Object> paramMap);

}