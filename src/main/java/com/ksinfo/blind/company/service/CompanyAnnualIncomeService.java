package com.ksinfo.blind.company.service;

import com.ksinfo.blind.company.dto.CompanyAnnualIncomeSearchDto;
import com.ksinfo.blind.company.vo.*;
import com.ksinfo.blind.company.mapper.CompanyAnnualIncomeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;

@Service
public class CompanyAnnualIncomeService {
	private final CompanyAnnualIncomeMapper companyAnnualIncomeMapper;

	@Autowired
	public CompanyAnnualIncomeService(CompanyAnnualIncomeMapper companyAnnualIncomeMapper) {
		this.companyAnnualIncomeMapper = companyAnnualIncomeMapper;
	}

	@Transactional(readOnly = true)
	public List<CompanyJobGroupVO> getJobGroupListInCompany(long companyId) {
		return companyAnnualIncomeMapper.getJobGroupListInCompany(companyId);
	}

	@Transactional(readOnly = true)
	public CompanyAnnualIncomeVO getAnnualIncome(CompanyAnnualIncomeSearchDto search) {
		return companyAnnualIncomeMapper.getAnnualIncome(search);
	}

	@Transactional(readOnly = true)
	public List<CompanyJobGroupVO> getJobGroupListAll(){
		return companyAnnualIncomeMapper.getJobGroupListAll();
	}

	@Transactional(readOnly = true)
	public List<CompanyWorkTypeVO> getWorkTypeAll(){
		return companyAnnualIncomeMapper.getWorkTypeAll();
	}

	public void setAnnualData(Integer annualIncome, String selectJob, Integer selectWorkPeriod, Integer selectWorkType, Long userId){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>();

		//메모 String :키값, object : 밸류값
		paramMap.put("annualIncome", annualIncome); 		//메모 변수명.put("키값", 밸류값)
		paramMap.put("selectJob", selectJob);	      	  	//메모 put은 데이터를 입력하는 것이다.
		paramMap.put("selectWorkPeriod", selectWorkPeriod);
		paramMap.put("selectWorkType", selectWorkType);
		paramMap.put("userId", userId);

		/* 메모 입력되는 정보를 아래와 같이 매칭.
			----------------------------|---------------------
			Integer annualIncome,	 	| salary
			Integer selectJob, 			| job_group_code
			Integer selectWorkPeriod,	| years_of_service
			Integer selectWorkType, 	| work_type_code
			Long userId					| user_id
		*/
		companyAnnualIncomeMapper.setAnnualData(paramMap);
	}

	@Transactional(readOnly = true)
	public List<CompanyBusinessTypeVO> getBusinessTypeListExistAIData()
	{
		return companyAnnualIncomeMapper.getBusinessTypeListExistAIData();
	}

	@Transactional(readOnly = true)
	public List<CompanyJobGroupVO> getJobGroupListExistAIData()
	{
		return companyAnnualIncomeMapper.getJobGroupListExistAIData();
	}

	@Transactional(readOnly = true)
	public String getUserBusinessTypeCode(Long userId)
	{
		return companyAnnualIncomeMapper.getUserBusinessTypeCode(userId);
	}

	@Transactional(readOnly = true)
	public String	 getUserJobGroupCode(Long userId)
	{
		return companyAnnualIncomeMapper.getUserJobGroupCode( userId );
	}

	@Transactional(readOnly = true)
	public AnnualIncomeRankVO getAnnualIncomeAndRank( String selectBusinessTypeCode, String selectJobGroupCode, Long userId ){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>();

		//메모 String :키값, object : 밸류값
		paramMap.put("selectBusinessTypeCode",  selectBusinessTypeCode );	//메모 SQL에서 char형이기에 그에 맞춰 char형으로 변환.
		paramMap.put("selectJobGroupCode", selectJobGroupCode );			//메모 SQL에서 char형이기에 그에 맞춰 char형으로 변환.
		paramMap.put("userId", userId);

		System.out.println("selectBusinessTypeCode Of paramMap : " + paramMap.get("selectBusinessTypeCode") );
		System.out.println("selectJobGroupCode Of paramMap : "  + paramMap.get("selectJobGroupCode") );

		return companyAnnualIncomeMapper.getAnnualIncomeAndRank(paramMap);
	}


}