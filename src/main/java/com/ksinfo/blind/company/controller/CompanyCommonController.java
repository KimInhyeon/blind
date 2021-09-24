package com.ksinfo.blind.company.controller;

import com.ksinfo.blind.company.dto.CompanyRequestDto;
import com.ksinfo.blind.company.service.CompanyCommonService;
import com.ksinfo.blind.company.vo.CompanyJobGroupVO;
import com.ksinfo.blind.company.vo.CompanyMainVO;
import com.ksinfo.blind.company.vo.CompanySearchVO;
import com.ksinfo.blind.company.vo.CompanyVoteResultDto;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("company")
public class CompanyCommonController {
	private final CompanyCommonService companyCommonService;

	@Autowired
	public CompanyCommonController(CompanyCommonService companyCommonService) {
		this.companyCommonService = companyCommonService;
	}

	@GetMapping
	public ModelAndView companyMain() {
		List<CompanyMainVO> popularCompanyList = companyCommonService.getPopularCompanyList();

		ModelAndView modelAndView = new ModelAndView("main/company/companyMain");
		modelAndView.addObject("title", "企業情報");
		modelAndView.addObject("popularCompanyList", popularCompanyList);

		return modelAndView;
	}

	@PostMapping
	public boolean requestCompany(@RequestBody CompanyRequestDto request, @AuthenticationPrincipal Account account) {
		request.setUserId(account == null ? 0L : account.getUserId());
		companyCommonService.requestCompany(request);

		return true;
	}

	@GetMapping("search")
	public List<CompanySearchVO> searchCompany(@RequestParam String companyName) {
		return companyCommonService.searchCompany(companyName);
	}

	@GetMapping("jobGroup")
	public List<CompanyJobGroupVO> getJobGroupList() {
		return companyCommonService.getJobGroupList();
	}

	//유저가 검색된 기업에 대하여 근무를 추천/비추천 버튼 클릭한 값에 따라 추천/비추천 한 정보를 insert실시 및 기업의 추천도를 리턴.
	@PostMapping("recommend")
	public CompanyVoteResultDto companyRecommendPush(
		@AuthenticationPrincipal Account account, long companyId, int companyVoteValue
	) {
		//로그인한 유저인지 체크(로그인 않은 유저의 경우에는 로그인 페이지로 이동하는 등의 조처를 하도록 작성예정.
		long userId = account.getUserId();

		// companyRecommendValue : 기업추천여부를 갖는 값.( 1:기업추천 / 0:기업 비추천)
		companyCommonService.setCompanyRecommendVote(userId, companyId, companyVoteValue);

		return companyCommonService.getCompanyRecommendVoteResult(companyId); //투표에 참여한 유저에게 기업의 선호도를 출력하기 위한 값들을 리턴.
	}
}