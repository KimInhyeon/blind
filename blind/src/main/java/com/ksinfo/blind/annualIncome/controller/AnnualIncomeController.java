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

import com.ksinfo.blind.annualIncome.dto.AnnualIncomeByJobGroupDto;
import com.ksinfo.blind.annualIncome.dto.CompanyDto;
import com.ksinfo.blind.annualIncome.dto.JobGroupDto;
import com.ksinfo.blind.annualIncome.service.AnnualIncomeService;
import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyIntroduction.service.CompanyIntroductionService;



@Controller
public class AnnualIncomeController {	
	private static final Logger logger = LoggerFactory.getLogger(AnnualIncomeController.class);

	@Autowired 	
	AnnualIncomeService annualIncomeService;
	
	@Autowired
	CompanyIntroductionService companyIntroductionService;

	@RequestMapping(value = "/annualIncome/viewAnnualIncomeBySelectedJobGroupCode", method = RequestMethod.POST, produces="application/json")
	@ResponseBody 	
	public List<AnnualIncomeByJobGroupDto> viewAnnualIncomeBySelectedJobGroupCode(int companyId, String jobGroupCode) {
		List<AnnualIncomeByJobGroupDto> annualIncomeData = annualIncomeService.getAnnualIncomeData(companyId,jobGroupCode); 
		return annualIncomeData;
	}
	
	

	//@RequestMapping("/annual_income/annual_income")
	//public ModelAndView annualIncome(int selectCompanyId, ModelAndView mav) { 
	//[안내]int selectCompanyId가 null값으로 인한 에러로 인식되어 작동을 않습니다.
	//    0018 연봉탭 기능만 작동하실 경우에는 아래의 [0018연봉탭 제작시 사용한 임시코드]으로 진행해주십시오.
		
	//----------------------------------------------------------------------------------------------------------------------	
	// [0018연봉탭 제작시 사용한 임시코드] annualIncome 본 기능만 제작구현시 사용한 임시코드. 정식 서비스에서는 사용하지마세요.
		@RequestMapping("/annual_income/annual_income")
		public ModelAndView annualIncome(String fakeSelectCompanyId, ModelAndView mav) { //int형의 경우 null 불허. 이로인해 맵핑에러로 이어짐.
		int selectCompanyId = 1; //1 : Company_mgt의 'トヨタ自動車株式会社'의 companyId(사용자분의 DB상태에 따라 출력기업 달리집니다.)
	//----------------------------------------------------------------------------------------------------------------------	
	
		List<CompanyDto> companyProfile = annualIncomeService.getCompanyProfile(selectCompanyId);
		//기업프로필 수신. searchService.getSearchCompany(searchKeyword);를 활용.
		//지금은 기업이름(String)으로 하고있지만 기업Id(int)로 하는것이 나은지 논의 필요.
		
		//등록되어있는 직군이름들을 로드.
		List<JobGroupDto> jobGroupList = annualIncomeService.getJobGroupList();
		
		//선택한 기업소속으로 연봉정보를 등록한 직군이름들을 로드. JobGroupDto의 disableFlag 설정하고자 select실시.
		List<JobGroupDto> jobGroupInCompany
			= annualIncomeService.getJobGroupInCompany(selectCompanyId);

		
		//0(char형)으로 flag 초기화 실시.
		for(int i=0; i<jobGroupList.size();i++){
			jobGroupList.get(i).setDisableFlag('0');
		}
		
		//선택한 기업의 연봉정보를 등록한 직군이면 jsp페이지에 출력할 수 있도록 disableFlag를 1으로 설정변경.
		for(int i=0; i<jobGroupList.size();i++){ 
			for(int j=0; j<jobGroupInCompany.size();j++){
				if(jobGroupList.get(i).getJobGroupCode().equals(jobGroupInCompany.get(j).getJobGroupCode()) ){
					jobGroupList.get(i).setDisableFlag('1');
					break;
				}
			}	
		}
		
		
		//선택한 기업의 전체직군의  연봉(최대/최소/중앙)정보를 로드. JobGroupDto의 disableFlag 설정하고자 select
		List<AnnualIncomeByJobGroupDto> annualIncomeData 
			= annualIncomeService.getAnnualIncomeData(companyProfile.get(0).getCompanyId(),"-1"); //-1 : 전체직군 선택시 flag역할을 하는 값.
		
		CompanyIntroductionDto companyIntroduction = companyIntroductionService.companyIntroduction(selectCompanyId);
		mav.addObject("companyIntroduction", companyIntroduction);
		
		mav.addObject("companyProfile",companyProfile);
		mav.addObject("jobGroupList",jobGroupList);
		mav.addObject("annualIncomeData",annualIncomeData);
		
		mav.setViewName("main/annualIncome/annualIncome");
		return mav;
	}
	
	

}
