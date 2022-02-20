package com.ksinfo.blind.company.controller;

import com.ksinfo.blind.company.dto.CompanyAnnualIncomeSearchDto;
import com.ksinfo.blind.company.service.CompanyAnnualIncomeService;
import com.ksinfo.blind.company.service.CompanyCommonService;
import com.ksinfo.blind.company.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("company/annualIncome")
public final class CompanyAnnualIncomeController {
//	private static final Logger logger = LoggerFactory.getLogger(AnnualIncomeController.class);
	private final CompanyCommonService companyCommonService;
	private final CompanyAnnualIncomeService companyAnnualIncomeService;

	@Autowired
	public CompanyAnnualIncomeController(
		CompanyCommonService companyCommonService, CompanyAnnualIncomeService companyAnnualIncomeService
	) {
		this.companyCommonService = companyCommonService;
		this.companyAnnualIncomeService = companyAnnualIncomeService;
	}

	@GetMapping
	public void company(
		@Value("${server.servlet.context-path}") String contextPath, HttpServletResponse httpServletResponse
	) throws IOException {
		httpServletResponse.sendRedirect(contextPath  + "/company");
	}

	@GetMapping("{companyId}")
	public ModelAndView annualIncome(@PathVariable long companyId) {
		CompanyMenuVO companyMenu = companyCommonService.getCompanyMenu(companyId);
		List<CompanyJobGroupVO> jobGroupList = companyAnnualIncomeService.getJobGroupListInCompany(companyId);
		CompanyAnnualIncomeVO annualIncome = null;
		if (!jobGroupList.isEmpty()) {
			CompanyAnnualIncomeSearchDto search = new CompanyAnnualIncomeSearchDto(companyId, "00");
			annualIncome = companyAnnualIncomeService.getAnnualIncome(search);
		}

		ModelAndView modelAndView = new ModelAndView("main/company/companyAnnualIncome");
		modelAndView.addObject("title", companyMenu.getCompanyName() + " 年収");
		modelAndView.addObject("companyMenu", companyMenu);
		modelAndView.addObject("jobGroupList", jobGroupList);
		modelAndView.addObject("annualIncome", annualIncome);

		return modelAndView;
	}

	@GetMapping("{companyId}/{jobGroupCode}")
	public CompanyAnnualIncomeVO getAnnualIncome(@PathVariable long companyId, @PathVariable String jobGroupCode) {
		CompanyAnnualIncomeSearchDto search = new CompanyAnnualIncomeSearchDto(companyId, jobGroupCode);

		return companyAnnualIncomeService.getAnnualIncome(search);
	}

	//下のコードはAndroidに関連のコード。

	// Android-年俸計算機の職種return
	@GetMapping("annualIncomeCalculator")
	public List<CompanyJobGroupVO> getJobGroupListAll() {
		System.out.println("android access getJobGroupListAll");
		return companyAnnualIncomeService.getJobGroupListAll();
	}

	// Android-年俸計算機の勤務タイプをreturn
	@GetMapping("annualIncomeCalculator2")
	public List<CompanyWorkTypeVO> getWorkTypeAll() {
		System.out.println("android access getWorkTypeAll");
		return companyAnnualIncomeService.getWorkTypeAll();
	}
	/*
	// Android-業界(businessType)をreturn
	@GetMapping("getBusinessTypeNameList")
	public List<CompanyBusinessTypeVO> getBusinessTypeNameList() {
		System.out.println("android access getBusinessTypeNameList");
		return companyAnnualIncomeService.getBusinessTypeNameList();
	}
	*/

	// Android-年俸計算機の職種_post_test
	//@GetMapping("annualIncomeCalculator999")
	//public void requestSample999(String string) { System.out.println("receive text : "+string); }

	@GetMapping("saveAnnualData")
	public void saveAnnualData( Integer annualIncome, String selectJob, Integer selectWorkPeriod, Integer selectWorkType, Long userId )
	{
		System.out.println("receive annualIncome : "	 + annualIncome);
		System.out.println("receive selectJob : " 		 + selectJob);
		System.out.println("receive selectWorkPeriod : " + selectWorkPeriod);
		System.out.println("receive selectWorkType : "	 + selectWorkType);
		System.out.println("receive userId : "	 + userId);

		companyAnnualIncomeService.setAnnualData(annualIncome, selectJob, selectWorkPeriod, selectWorkType, userId);
	}



	//Android - RankPage
	// Android-業界(businessType)をreturn.
	//[메모] 4.Rank페이지에서 spinner의 item을 구성할 업계들을 리턴.
	@GetMapping("getBusinessTypeListExistAIData")
	public List<CompanyBusinessTypeVO> getBusinessTypeListExistAIData() {
		System.out.println("android access getBusinessTypeListExistAIData");
		return companyAnnualIncomeService.getBusinessTypeListExistAIData();
	}

	// Android-業界(businessType)をreturn.
	//[메모] 5.Rank페이지에서 spinner의 item을 구성할 직군들을 리턴.
	@GetMapping("getJobGroupListExistAIData")
	public List<CompanyJobGroupVO> getJobGroupListExistAIData() {
		System.out.println("android access getJobGroupListExistAIData");
		return companyAnnualIncomeService.getJobGroupListExistAIData();
	}

	//[메모] 1.Rank 페이지의 최초출력(유저랭크)을 위해 '유저가 일하는 회사의 업계코드'를 리턴.
	@GetMapping("getUserBusinessTypeCode")
	public CompanyBusinessTypeVO getUserBusinessTypeCode(Long userId)
	{
		System.out.println("access getAnnualIncomeUpdateBySelectedSpinner");
		System.out.println("receive userId : " + userId);
		return companyAnnualIncomeService.getUserBusinessTypeCode(userId );
	}

	//[메모] 2.Rank 페이지의 최초출력(유저랭크)을 위해 '유저의 직군코드' 리턴.
	@GetMapping("getUserJobGroupCode")
	public CompanyJobGroupVO getUserJobGroupCode(Long userId)
	{
		System.out.println("access getAnnualIncomeUpdateBySelectedSpinner");
		System.out.println("receive userId : " + userId);
		return companyAnnualIncomeService.getUserJobGroupCode( userId );
	}

	//[메모] 3.Rank 페이지의 최초출력(유저랭크)을 위해 '유저의 직군코드' 리턴.
	@GetMapping("getAnnualIncomeAndRank")
	public AnnualIncomeRankVO  getAnnualIncomeAndRank( Integer selectBusinessType, Integer selectJobGroup, Integer selectWorkPeriod, Long userId)
	{
		System.out.println("access getAnnualIncomeUpdateBySelectedSpinner");
		System.out.println("receive selectBusinessType : " + selectBusinessType);
		System.out.println("receive selectJobGroup : " 	   + selectJobGroup);
		System.out.println("receive selectWorkPeriod : "   + selectWorkPeriod);
		System.out.println("receive userId : " + userId);

		return companyAnnualIncomeService.getAnnualIncomeAndRank(selectBusinessType, selectJobGroup, selectWorkPeriod, userId );
	}

}