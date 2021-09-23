package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.dto.ReviewSearchDto;
import com.ksinfo.blind.manage.dto.ReviewVerifyDto;
import com.ksinfo.blind.manage.service.ManageReviewService;
import com.ksinfo.blind.manage.vo.CompanyReviewVO;
import com.ksinfo.blind.manage.vo.ReviewVO;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@RestController
@RequestMapping("manage/review")
public final class ManageReviewController {
	private final ManageReviewService manageReviewService;

	@Autowired
	public ManageReviewController(ManageReviewService manageReviewService) {
		this.manageReviewService = manageReviewService;
	}

	@GetMapping
	public ModelAndView review(String searchTarget, String searchKeyword,
		@RequestParam(name = "page", defaultValue = "1") int page,
		@RequestParam(name = "verifyFlag", defaultValue = "0") char verifyFlag,
		@RequestParam(name = "workingFlag", defaultValue = "2") char workingFlag
	) {
		ReviewSearchDto reviewSearchDto = new ReviewSearchDto(verifyFlag, workingFlag, searchTarget, searchKeyword);
		PageNavigator navi = manageReviewService.getNavigator(page, reviewSearchDto);
		List<ReviewVO> reviewList = manageReviewService.getReviewList(navi.getCurrentPage(), reviewSearchDto);

		ModelAndView modelAndView = new ModelAndView("main/manage/manageReview");
		modelAndView.addObject("title", "レビュー管理");
		modelAndView.addObject("navi", navi);
		modelAndView.addObject("reviewList", reviewList);

		return modelAndView;
	}

	@GetMapping(value = "{companyReviewId}")
	public CompanyReviewVO getReview(@PathVariable("companyReviewId") long companyReviewId) {
		return manageReviewService.getReview(companyReviewId);
	}

	@PatchMapping
	public int verifyReview(@RequestBody ReviewVerifyDto reviewVerifyDto, @AuthenticationPrincipal Account account) {
		reviewVerifyDto.setUserId(account.getUserId());
		return manageReviewService.verifyReview(reviewVerifyDto);
	}
}