package com.ksinfo.blind.company.controller;

import com.ksinfo.blind.company.dto.CompanyReviewRecommendDto;
import com.ksinfo.blind.company.dto.CompanyReviewSearchDto;
import com.ksinfo.blind.company.dto.CompanyReviewWriteDto;
import com.ksinfo.blind.company.service.CompanyCommonService;
import com.ksinfo.blind.company.service.CompanyReviewService;
import com.ksinfo.blind.company.vo.CompanyMenuVO;
import com.ksinfo.blind.company.vo.CompanyReviewAverageVO;
import com.ksinfo.blind.company.vo.CompanyReviewRecommendResultVO;
import com.ksinfo.blind.company.vo.CompanyReviewVO;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.PageNavigator;
import org.apache.juli.logging.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("company/review")
public class CompanyReviewController {
	private final CompanyCommonService companyCommonService;
	private final CompanyReviewService companyReviewService;

	@Autowired
	public CompanyReviewController(
			CompanyCommonService companyCommonService, CompanyReviewService companyReviewService
	) {
		this.companyCommonService = companyCommonService;
		this.companyReviewService = companyReviewService;
	}

	@GetMapping
	public ModelAndView writeCompanyReview(@RequestParam(defaultValue = "0") long companyId) {//페이지 들어갈때
		ModelAndView modelAndView = new ModelAndView("main/company/companyReviewWrite");
		if (companyId > 0) {
			String companyName = companyReviewService.getCompanyName(companyId);
			modelAndView.addObject("companyId", companyId);
			modelAndView.addObject("companyName", companyName);
		}

		return modelAndView;
	}

	@PostMapping
	public void writeCompanyReview(//작성후 회사 리뷰 페이지
								   @Value("${server.servlet.context-path}") String contextPath, HttpServletResponse httpServletResponse,
								   @AuthenticationPrincipal Account account, CompanyReviewWriteDto companyReview
	) throws IOException {
		System.out.println(companyReview);
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
		modelAndView.addObject("companyId", userId > 0 ? account.getUserId() : 0);

		return modelAndView;
	}

	@GetMapping(value = "{companyId}",params = "averageStar")
	public CompanyReviewAverageVO getCompanyAverage(@AuthenticationPrincipal Account account,@PathVariable long companyId){
		CompanyReviewAverageVO reviewAverage = companyReviewService.getReviewAveragePoint(companyId);

		return reviewAverage;
		}




	@GetMapping(value = "{companyId}",params = "a=true")
	public List<CompanyReviewVO> getCompanyReviewList(
			@AuthenticationPrincipal Account account,
			@PathVariable long companyId, @RequestParam(defaultValue = "1") int page
	) {

//		CompanyMenuVO companyMenu = companyCommonService.getCompanyMenu(companyId);
//		CompanyReviewAverageVO reviewAverage = companyReviewService.getReviewAveragePoint(companyId);
		PageNavigator navi = companyReviewService.getNavigator(page, companyId);
		//long userId = account == null ? 0L : account.getUserId();
		long userId = 153;

		CompanyReviewSearchDto search = new CompanyReviewSearchDto(userId, companyId);
		List<CompanyReviewVO> companyList = companyReviewService.getCompanyReviewList(search, navi.getCurrentPage());



		return companyList;
	}

	@PostMapping("recommend")
	public CompanyReviewRecommendResultVO recommendCompanyReview(
			@AuthenticationPrincipal Account account, @RequestBody long companyReviewId
	) {
		long userId = 153;//하드코인
//		CompanyReviewRecommendDto reviewRecommendDto =
//				new CompanyReviewRecommendDto(account.getUserId(), companyReviewId);
		CompanyReviewRecommendDto reviewRecommendDto =
				new CompanyReviewRecommendDto(userId, companyReviewId);
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


	@ResponseBody
	@PostMapping("/write")
	public HashMap<String, String> writeCompanyReviewApi(//api는 웹내에서의 처리는 없고 데이터베이스 연결까지 해주고, 리턴은 안드로이드
														 HttpServletRequest request,
														 @AuthenticationPrincipal Account account
	) throws IOException {
		HashMap<String, String> result = new HashMap<>();

		CompanyReviewWriteDto companyReviewWriteDto = new CompanyReviewWriteDto(
				Long.parseLong(request.getParameter("companyId"))
				, "01"//하드코딩
				, Byte.valueOf(request.getParameter("careerPoint"))
				, Byte.valueOf(request.getParameter("workLifeBalancePoint"))
				, Byte.valueOf(request.getParameter("payPoint"))
				, Byte.valueOf(request.getParameter("companyCulturePoint"))
				, Byte.valueOf(request.getParameter("headPoint"))
				,request.getParameter("workStartDate").toString()
				,request.getParameter("workEndDate").toString()
				,request.getParameter("simpleComment").toString()
				,request.getParameter("resignReason").toString()
				, request.getParameter("workArea").toString()
				, request.getParameter("advantages").toString()
				, request.getParameter("disadvantages").toString()


		);

		companyReviewWriteDto.setUserId(11);//하드코딩
		companyReviewService.writeCompanyReview(companyReviewWriteDto);
		result.put("code", "0");
		return result;
	}

}