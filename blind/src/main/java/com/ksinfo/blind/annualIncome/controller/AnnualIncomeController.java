package com.ksinfo.blind.annualIncome.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.annualIncome.dto.CompanyDto;
import com.ksinfo.blind.annualIncome.dto.JobGroupDto;
import com.ksinfo.blind.annualIncome.dto.AnnualIncomeByJobGroupDto;
import com.ksinfo.blind.annualIncome.service.AnnualIncomeService;



@Controller
public class AnnualIncomeController {

	private static final Logger logger = LoggerFactory.getLogger(AnnualIncomeController.class);

	@Autowired 	AnnualIncomeService annualIncomeService; 

	@RequestMapping(value = "/annual_income/viewAnnualIncomeBySelectedJobGroupCode", method = RequestMethod.POST, produces="application/json")
	@ResponseBody 	
	public List<AnnualIncomeByJobGroupDto> viewAnnualIncomeBySelectedJobGroupCode(int companyId, String jobGroupCode) {
		logger.info("viewAnnualIncomeBySelectedJobGroupCode start");
		logger.info("companyId :"+companyId);
		logger.info("jobGroupCode :"+jobGroupCode);
		List<AnnualIncomeByJobGroupDto> annualIncomeData = annualIncomeService.getAnnualIncomeData(companyId,jobGroupCode); 

		logger.info("viewAnnualIncomeBySelectedJobGroupCode end");
		return annualIncomeData;
	}
	
	
	
	
	@RequestMapping("/annual_income/annual_income")
	public ModelAndView annualIncome(String selectCompany, ModelAndView mav) {
		
		//임시코드(테스트를 위해 임시 설정)
		selectCompany = "トヨタ自動車株式会社"; //여기서는 유저가 도요타 자동차 프로필에서 연봉탭으로 이동하는 것으로 전제하고 진행함.

		//본코드
		List<CompanyDto> companyProfile = annualIncomeService.getCompanyProfile(selectCompany);
		//기업프로필 수신. searchService.getSearchCompany(searchKeyword);를 활용.
		//지금은 기업이름(String)으로 하고있지만 기업Id(int)로 하는것이 나은지 논의 필요.
		
		//등록되어있는 직군이름들을 로드.
		List<JobGroupDto> jobGroupList = annualIncomeService.getJobGroupList();
		
		//선택한 기업의 모든 직군의 연봉(최대/최소/중앙)정보를 로드. JobGroupDto의 disableFlag 설정하고자 select
		List<AnnualIncomeByJobGroupDto> annualIncomeAllJobGroup
			= annualIncomeService.getAnnualIncomeAllJobGroup(companyProfile.get(0).getCompanyId());

		
		//0(char형)으로 flag 초기화 실시.
		for(int i=0; i<jobGroupList.size();i++){ //모든 직군들을 확인.
			jobGroupList.get(i).setDisableFlag('0');
		}
		
		
		for(int i=0; i<jobGroupList.size();i++){ //모든 직군들을 확인.
			for(int j=0; j<annualIncomeAllJobGroup.size();j++){
				if(jobGroupList.get(i).getJobGroupCode().equals(annualIncomeAllJobGroup.get(j).getJobGroupCode()) ){
					jobGroupList.get(i).setDisableFlag('1');
					break;
				}
			}	
		}
		
		
		//선택한 기업의 전체직군의  연봉(최대/최소/중앙)정보를 로드. JobGroupDto의 disableFlag 설정하고자 select
		List<AnnualIncomeByJobGroupDto> annualIncomeData 
			= annualIncomeService.getAnnualIncomeData(companyProfile.get(0).getCompanyId(),"-1"); //-1 : 전체직군 선택시 값.
		
		mav.addObject("companyProfile",companyProfile);
		mav.addObject("jobGroupList",jobGroupList);
		mav.addObject("annualIncomeData",annualIncomeData);
		
		mav.setViewName("main/annual_income/annual_income");
		return mav;
	}
	
	

}
