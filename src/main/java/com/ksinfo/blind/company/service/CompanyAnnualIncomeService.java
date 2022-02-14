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
	public List<CompanyBusinessTypeVO> getBusinessTypeNameList() {
		return companyAnnualIncomeMapper.getBusinessTypeNameList();
	}


	@Transactional(readOnly = true)
	public CompanyAnnualIncomeForAndroidVO getAnnualIncomeFristPage( long userId) {
		return companyAnnualIncomeMapper.getAnnualIncomeFristPage(userId);
	}

	@Transactional(readOnly = true)
	public CompanyAnnualIncomeForAndroidVO getAnnualIncomeUpdateToSelectedSpinner( Integer selectBusinessType, Integer selectJobGroup, Integer selectWorkPeriod,Long userId ){
		java.util.Map<String, Object> paramMap = new HashMap<String, Object>();

		//메모 String :키값, object : 밸류값
		paramMap.put("selectBusinessType", selectBusinessType);
		paramMap.put("selectJobGroup", selectJobGroup);
		paramMap.put("selectWorkPeriod", selectWorkPeriod);
		paramMap.put("userId", userId);

		return companyAnnualIncomeMapper.getAnnualIncomeUpdateToSelectedSpinner(paramMap);
		//return companyAnnualIncomeMapper.getAnnualIncomeForAndroid(paramMap);
	}


}