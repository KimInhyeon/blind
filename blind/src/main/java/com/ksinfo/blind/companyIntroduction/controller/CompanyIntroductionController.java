package com.ksinfo.blind.companyIntroduction.controller;

import com.ksinfo.blind.companyIntroduction.dto.CompanyAverageDto;
import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyIntroduction.service.CompanyIntroductionService;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CompanyIntroductionController {
	@Autowired
	CompanyIntroductionService companyIntroductionService;

	@RequestMapping(value = "/companyIntroduction", method = RequestMethod.GET)
	public ModelAndView CompanyView(HttpServletRequest req, long companyId) throws Exception {
		ModelAndView mav = new ModelAndView();

		CompanyIntroductionDto companyIntroduction = companyIntroductionService.companyIntroduction(companyId);

		mav.addObject("companyIntroduction", companyIntroduction);

		mav.setViewName("main/companyIntroduction/companyIntroduction");
		int reviewCount = companyIntroductionService.reviewCount(companyId);
		mav.addObject("reviewCount", reviewCount);
		return mav;

	}
	@RequestMapping(value = "/companyShowReview", method = RequestMethod.GET)
	public ModelAndView CompanyShowReview(HttpServletRequest req, Long companyId,@AuthenticationPrincipal Account account) throws Exception {
		ModelAndView mav = new ModelAndView();

		CompanyIntroductionDto companyIntroduction = companyIntroductionService.companyIntroduction(companyId);
		CompanyAverageDto companyAverageDto = companyIntroductionService.companyAveragePoint(companyId);
		CompanyJoinDto oneCompanyReview = companyIntroductionService.oneCompanyReview(companyId);
		Map<String,Long> map = new HashMap<String,Long>();
		map.put("companyId",companyId);
		map.put("userId",account.getUserId());

		List<CompanyJoinDto> companyReviewList = companyIntroductionService.companyReviewList(map);

		mav.addObject("oneCompanyReview", oneCompanyReview);
		mav.addObject("companyAverageDto",companyAverageDto );
		mav.addObject("companyIntroduction", companyIntroduction);
		companyReviewList.remove(0);
		mav.addObject("companyShowList", companyReviewList);
		mav.setViewName("main/companyIntroduction/companyShowReview");
		int reviewCount = companyIntroductionService.reviewCount(companyId);
		mav.addObject("reviewCount", reviewCount);


		return mav;

	}
	@RequestMapping(value = "helpCountUp", method = RequestMethod.POST, produces="application/json")
	@ResponseBody//ajax통신할때 제공,html통신으로 body로 넘긴다.화면이 제로딩되지않고 html부분만 바뀐다.
	public CompanyJoinDto helpCountup(Long companyId,Long companyReviewId, @AuthenticationPrincipal Account account){
		Map<String,Long> helpCount = new HashMap<String,Long>();
		helpCount.put("companyId", companyId);
		helpCount.put("companyReviewId", companyReviewId);
		helpCount.put("userId", account.getUserId());//로그인할때의 계정을 넣는다
		if(companyIntroductionService.checkRecommend(helpCount) == 0){
			companyIntroductionService.helpCount(helpCount);

		}else{
			companyIntroductionService.updateHelpCount(helpCount);
		}

		CompanyJoinDto companyReviewList = companyIntroductionService.searchCompanyRecommend(companyReviewId);

		return companyReviewList;
	}


/*	@RequestMapping(value = "addPostRecommend", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addPostRecommend(@AuthenticationPrincipal Account account, long postId){
		BookmarkDto searchPostRecommend = bookmarkService.searchPostRecommend(account.getUserId(), postId);
		List<BookmarkDto> prlist = new ArrayList<BookmarkDto>();
		prlist.add(searchPostRecommend);
		if(searchCompanyRecommend == null) {
			companyIntroductionService.helpCount(account.getUserId(), postId);
		}else if(prlist.size() > 0){
			bookmarkService.updatePostRecommend(searchPostRecommend);
		}*/



}

