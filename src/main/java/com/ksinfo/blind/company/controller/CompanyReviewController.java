package com.ksinfo.blind.company.controller;

import com.ksinfo.blind.company.dto.CompanyReviewRecommendDto;
import com.ksinfo.blind.company.dto.CompanyReviewSearchDto;
import com.ksinfo.blind.company.dto.CompanyReviewWriteDto;
import com.ksinfo.blind.company.service.CompanyReviewService;
import com.ksinfo.blind.company.service.CompanyCommonService;
import com.ksinfo.blind.company.vo.CompanyMenuVO;
import com.ksinfo.blind.company.vo.CompanyReviewAverageVO;
import com.ksinfo.blind.company.vo.CompanyReviewRecommendResultVO;
import com.ksinfo.blind.company.vo.CompanyReviewVO;
import com.ksinfo.blind.company.vo.CompanySearchVO;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("company/review")
public class CompanyReviewController {
	private final CompanyCommonService companyCommonService;
	private final CompanyReviewService companyReviewService;

	@Autowired
	public CompanyReviewController(CompanyCommonService companyCommonService, CompanyReviewService companyReviewService) {
		this.companyCommonService = companyCommonService;
		this.companyReviewService = companyReviewService;
	}

	@GetMapping
	public ModelAndView writeCompanyReview(@RequestParam(defaultValue = "0") long companyId) {
		ModelAndView modelAndView = new ModelAndView("main/company/companyReviewWrite");
		if (companyId > 0) {
			String companyName = companyReviewService.getCompanyName(companyId);
			modelAndView.addObject("companyId", companyId);
			modelAndView.addObject("companyName", companyName);
		}

		return modelAndView;
	}

	@PostMapping
	public void writeCompanyReview(
		@Value("${server.servlet.context-path}") String contextPath, HttpServletResponse httpServletResponse,
		@AuthenticationPrincipal Account account, CompanyReviewWriteDto companyReview
	) throws IOException {
		companyReview.setUserId(account.getUserId());
		companyReview.setJobGroupCode("01"); // companyReviewWrite.jspにjobGroupCodeを入力する欄がないので確認必要
		companyReviewService.writeCompanyReview(companyReview);

		httpServletResponse.sendRedirect(contextPath); // メインではなく、本人が書いたレビュー画面へ移動させることも？
	}

	@GetMapping("{companyId}")
	public ModelAndView companyReviewView(
		@AuthenticationPrincipal Account account,
		@PathVariable long companyId, @RequestParam(defaultValue = "1") int page
	) {


		CompanyMenuVO companyMenu = companyCommonService.getCompanyMenu(companyId);
		CompanyReviewAverageVO reviewAverage = companyReviewService.getReviewAveragePoint(companyId);
		PageNavigator navi = companyReviewService.getNavigator(page, companyId);
		long userId = account == null ? 0L : account.getUserId();
		CompanyReviewSearchDto search = new CompanyReviewSearchDto(userId, companyId);
		List<CompanyReviewVO> companyList = companyReviewService.getCompanyReviewList(search, navi.getCurrentPage());

		ModelAndView modelAndView = new ModelAndView("main/company/companyReviewView");
		modelAndView.addObject("title", companyMenu.getCompanyName() + " レビュー");
		modelAndView.addObject("companyMenu", companyMenu);
		modelAndView.addObject("allPointAvg", Math.round(companyMenu.getAllPointAvg()));
		modelAndView.addObject("reviewAverage", reviewAverage);
		modelAndView.addObject("navi", navi);
		modelAndView.addObject("companyList", companyList);

		return modelAndView;
	}

	@PostMapping("recommend")
	public CompanyReviewRecommendResultVO recommendCompanyReview(
		@AuthenticationPrincipal Account account, @RequestBody long companyReviewId
	) {
		CompanyReviewRecommendDto reviewRecommendDto =
			new CompanyReviewRecommendDto(account.getUserId(), companyReviewId);

		return companyReviewService.recommendReview(reviewRecommendDto);
	}


	//BLIND_0016 企業レビュー詳細照会(2021-08-25)
	@GetMapping("{companyId}/{companyReviewId}")
	public ModelAndView companyReviewDetails(
		@AuthenticationPrincipal Account account,
		@PathVariable long companyId, @PathVariable long companyReviewId
	) {
		//0.임시정보(작동을 위해 임시적으로 구성한 정보입니다.
		companyId = 1;    //기업ID
		int blurEffectSet = 1; //이외게시글 블러효과적용여부. 기업리뷰 작성여부에 따라 값 결정.(0:기업리뷰 미작성, 1:기업리뷰 작성)

		CompanyMenuVO companyMenu = companyCommonService.getCompanyMenu(companyId);
		List<CompanyReviewVO> companyReviewLists = companyReviewService.getCompanyReviews(companyId);

		//company = companyReviewService.getPosts(navi.getCurrentPage(), paramMap);//사용자가 입력한 검색어로 검색

		ModelAndView modelAndView = new ModelAndView("main/company/companyReviewDetails");
		modelAndView.addObject("nowCompanyId", companyId);
		modelAndView.addObject("companyMenu", companyMenu);
		modelAndView.addObject("companyReviewLists", companyReviewLists);
		modelAndView.addObject("blurEffectSet", blurEffectSet);

		return modelAndView;
	}
}