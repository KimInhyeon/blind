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
import java.util.HashMap;
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

	@GetMapping("getUserBusinessTypeCode")
	public HashMap<String, String> getUserBusinessTypeCode(Long userId)
	{
		System.out.println("android access getUserBusinessTypeCode");
		System.out.println("receive userId of getUserBusinessTypeCode : " + userId);
		System.out.println("return getUserBusinessTypeCode : " + companyAnnualIncomeService.getUserBusinessTypeCode( userId )  );

		HashMap<String, String> tempBTC = new HashMap<>();
		tempBTC.put("userBTC",companyAnnualIncomeService.getUserBusinessTypeCode(userId)); //userBTC : getUserBusinessTypeCode
		return tempBTC;
	}

	@GetMapping("getUserJobGroupCode")
	public HashMap<String, String>  getUserJobGroupCode(Long userId)
	{
		System.out.println("android access getUserJobGroupCode");
		System.out.println("receive userId of getUserJobGroupCode : " + userId);
		System.out.println("return getUserJobGroupCode : " + companyAnnualIncomeService.getUserJobGroupCode( userId )  );

		HashMap<String, String> tempJGC = new HashMap<>();
		tempJGC.put("userJGC",companyAnnualIncomeService.getUserJobGroupCode( userId )); //userJGC : userJobGroupCode
		return tempJGC;
	}

	//[메모] 3.Rank 페이지의 최초출력(유저랭크)을 위해 '유저의 직군코드' 리턴.
	@GetMapping("getAnnualIncomeAndRank")
	public AnnualIncomeRankVO  getAnnualIncomeAndRank(String selectBusinessTypeCode, String selectJobGroupCode, Long userId)
	{
		System.out.println("android access getAnnualIncomeAndRank");
		System.out.println("receive selectBusinessTypeCode of getAnnualIncomeAndRank : " + selectBusinessTypeCode);
		System.out.println("receive selectJobGroup of getAnnualIncomeAndRank : " 	   + selectJobGroupCode);
		System.out.println("receive userId of getAnnualIncomeAndRank :" + userId);


		AnnualIncomeRankVO checkResult
				= companyAnnualIncomeService.getAnnualIncomeAndRank(selectBusinessTypeCode, selectJobGroupCode, userId );

		/*
		AnnualIncomeRankVO checkResult
				= companyAnnualIncomeService.getAnnualIncomeAndRank(
						Integer.parseInt(selectBusinessTypeCode),
						Integer.parseInt(selectJobGroupCode), userId );
		*/
		System.out.println("return minAnnualIncome : " + checkResult.getMinAnnualIncome());
		System.out.println("return avgAnnualIncome : " + checkResult.getAvgAnnualIncome());
		System.out.println("return maxAnnualIncome : " + checkResult.getMaxAnnualIncome());
		System.out.println("return userAnnualIncome : " + checkResult.getUserAnnualIncome());
		System.out.println("return countOfParticipant : " + checkResult.getCountOfParticipant());
		System.out.println("return userRank : " + checkResult.getUserRank());

		return companyAnnualIncomeService.getAnnualIncomeAndRank(selectBusinessTypeCode, selectJobGroupCode, userId );

		/*
		return companyAnnualIncomeService.getAnnualIncomeAndRank( Integer.parseInt(selectBusinessTypeCode),
																  Integer.parseInt(selectJobGroupCode),
				 												  userId );
		*/
	}

}