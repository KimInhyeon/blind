package com.ksinfo.blind.company.mapper;

import com.ksinfo.blind.company.dto.CompanyAnnualIncomeSearchDto;
import com.ksinfo.blind.company.vo.CompanyAnnualIncomeVO;
import com.ksinfo.blind.company.vo.CompanyJobGroupVO;
import com.ksinfo.blind.company.vo.CompanyWorkTypeVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CompanyAnnualIncomeMapper {
	List<CompanyJobGroupVO> getJobGroupListInCompany(long companyId);

	CompanyAnnualIncomeVO getAnnualIncome(CompanyAnnualIncomeSearchDto search);

	List<CompanyJobGroupVO> getJobGroupListAll();

	List<CompanyWorkTypeVO> getWorkTypeAll();

	void setAnnualData(java.util.Map<String, Object> paramMap);
}