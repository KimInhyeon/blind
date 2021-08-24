package com.ksinfo.blind.companyReview.controller;

import com.ksinfo.blind.companyIntroduction.service.CompanyIntroductionService;
import com.ksinfo.blind.companyReview.dto.CompanyDto;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;
import com.ksinfo.blind.companyReview.dto.CompanyMainViewDto;
import com.ksinfo.blind.companyReview.service.CompanyReviewService;
import com.ksinfo.blind.companyReview.service.CompanyReviewWriteService;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.MessageUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class CompanyReviewController {
	@Autowired
	CompanyReviewService companyReviewService;
	@Autowired
	CompanyReviewWriteService companyReviewWriteService;
	@Autowired
	MessageUtils msg;

	@RequestMapping(value = "companyReviewMain", method = RequestMethod.GET)
	public ModelAndView companyReviewMain(HttpServletRequest req) throws Exception {
		ModelAndView mav = new ModelAndView();
		List<CompanyDto> companyList = companyReviewService.companySearchAll();
		List<CompanyMainViewDto> companyJoinDto = companyReviewService.companySearchPopular();
		mav.addObject("companyJoinPopular",companyJoinDto);
		mav.addObject("companyList", companyList);
		mav.setViewName("main/companyReview/companyReview");

		return mav;
	}

	@RequestMapping(value = "companyReviewMain", method = RequestMethod.POST)
	public ModelAndView companyReviewSearch(HttpServletRequest req) throws Exception {
		ModelAndView mav = new ModelAndView();
		/*
		 * String paramString = (String) req.getParameter("searchKeyword");
		 * List<CompanyDto> companyDto =
		 * companyReviewService.companySearch(paramString); mav.addObject("companyDto",
		 * companyDto);
		 */
		mav.setViewName("main/companyReview/companyReview");

		return mav;
	}



	@RequestMapping(value = "companyReviewWrite", method = RequestMethod.GET)
	public ModelAndView companyReviewWrite(HttpServletRequest req, Long companyId) throws Exception {
		ModelAndView mav = new ModelAndView();
		if(companyId == null) {
			mav.addObject("companyId", 0);

		}else {
			mav.addObject("companyId", companyId);
		}
		mav.setViewName("main/companyReview/companyReviewWrite");
		return mav;
	}

	@RequestMapping(value="companyReviewWrite",method = RequestMethod.POST)
	public ModelAndView companyReviewJoin(HttpServletRequest req, @AuthenticationPrincipal Account account) throws Exception{
		ModelAndView mav= new ModelAndView();

		// int allPoint = Integer.parseInt(req.getParameter("hdnAllPoint")); 총점은 소수 여기서 나누기 5
		int careerPoint = Integer.parseInt(req.getParameter("hdnCareerPoint"));
		int workLifeBalancePoint = Integer.parseInt(req.getParameter("hdnWorkLifeBalancePoint"));
		int payPoint = Integer.parseInt(req.getParameter("hdnPayPoint"));
		int companyCulturePoint = Integer.parseInt(req.getParameter("hdnCompanyCulturePoint"));
		int headPoint = Integer.parseInt(req.getParameter("hdnHeadPoint"));
		float allPoint = (careerPoint + workLifeBalancePoint + payPoint + companyCulturePoint + headPoint)/5;
		String simpleComment =(String)req.getParameter("oneWriteReview");
		String advantages =(String)req.getParameter("strongPoint");
		String disadvantages=(String)req.getParameter("weakPoint");
		String resignReason =(String)req.getParameter("resignReason");
		String workStartDate =(String)req.getParameter("hdnStartDate");
		String workEndDate = (String)req.getParameter("hdnFinishDate");
		String workArea = (String)req.getParameter("workArea");
		long companyId= Long.parseLong(req.getParameter("hdnCompanyId"));
		CompanyJoinDto inputDto = new CompanyJoinDto();
		inputDto.setUserId(account.getUserId());
		inputDto.setCompanyId(companyId);
		inputDto.setJobGroupCode("01");
		inputDto.setVerifyFlag((char)0);
		inputDto.setCompleteFlag((char)0);
		inputDto.setAllPoint(allPoint);
		inputDto.setCareerPoint(careerPoint);
		inputDto.setWorkLifeBalancePoint(workLifeBalancePoint);
		inputDto.setPayPoint(payPoint);
		inputDto.setCompanyCulturePoint(companyCulturePoint);
		inputDto.setHeadPoint(headPoint);
		inputDto.setSimpleComment(simpleComment);
		inputDto.setAdvantages(advantages);
		inputDto.setDisadvantages(disadvantages);
		inputDto.setResignReason(resignReason);
		inputDto.setWorkStartDate(workStartDate);
		inputDto.setWorkEndDate(workEndDate);
		inputDto.setWorkArea(workArea);
		int insertCount = companyReviewWriteService.companyReviewJoin(inputDto);

		if (insertCount > 0) {
			String message = msg.getMessage("BLIND_SCS_MSG_001");
			mav.addObject("successMessage", message);
		} else {
			String message = msg.getMessage("BLIND_ERR_MSG_001");
			mav.addObject("exceptionMessage", message);
		}

		mav.setViewName("main/companyReview/companyReviewWrite");
		return mav;
	}

	@RequestMapping(value = "searchCompanyByCompanyName", method = RequestMethod.POST, produces="application/json")
	@ResponseBody//ajax통신할때 제공,html통신으로 body로 넘긴다.화면이 제로딩되지않고 html부분만 바뀐다.
	public List<CompanyDto> searchCompanyByCompanyName(String companyName){

		List<CompanyDto> companyDto = companyReviewService.companySearch(companyName);

		return companyDto;
	}

	
	@RequestMapping(value = "sendRequestCompanyRegist", method = RequestMethod.POST, produces="application/json")
	@ResponseBody
	public int sendRequestCompanyRegist(String requestCompnayName, String requestCompnayEmail, @AuthenticationPrincipal Account account){

		int userid = (int)account.getUserId();
		
		companyReviewService.sendRequestCompanyRegist(requestCompnayName, requestCompnayEmail, userid);

		return 1;//성공시1을 리턴하도록 실시.
	}
	
	
	
}
