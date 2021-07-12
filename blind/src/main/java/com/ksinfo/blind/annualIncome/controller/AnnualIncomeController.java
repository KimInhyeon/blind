package com.ksinfo.blind.annualIncome.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.annualIncome.dto.CompanyDto;
import com.ksinfo.blind.annualIncome.dto.JobGroupDto;
import com.ksinfo.blind.annualIncome.dto.AnnualIncomeByJobGroupDto;
import com.ksinfo.blind.annualIncome.service.AnnualIncomeService;



@Controller
public class AnnualIncomeController {

	private static final Logger logger = LoggerFactory.getLogger(AnnualIncomeController.class);

	@Autowired 	AnnualIncomeService annualIncomeService; 
	
	@RequestMapping("/annual_income/annual_income")
	public ModelAndView annualIncome(String selectCompany, ModelAndView mav) {
		
		//임시코드(테스트를 위해 임시 설정)
		selectCompany = "トヨタ自動車株式会社"; //여기서는 도요타 자동차에서 하는 것으로 전제하고 진행함.

		//본코드
		List<CompanyDto> companyProfile = annualIncomeService.getCompanyProfile(selectCompany);
		//기업프로필 수신. searchService.getSearchCompany(searchKeyword);를 활용.
		//지금은 기업이름(String)으로 하고있지만 기업Id(int)로 하는것이 나은지 논의 필요.
		
		List<JobGroupDto> jobGroupList = annualIncomeService.getJobGroupList();
		List<AnnualIncomeByJobGroupDto> annualIncomeData =annualIncomeService.getAnnualIncomeData(companyProfile.get(0).getCompanyId(),"-1"); //-1 : 전체직군 선택시 값.
		
		mav.addObject("companyProfile",companyProfile);
		mav.addObject("jobGroupList",jobGroupList);
		mav.addObject("annualIncomeData",annualIncomeData);
		
		mav.setViewName("main/annual_income/annual_income");
		return mav;
	}

}
