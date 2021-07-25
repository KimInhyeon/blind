package com.ksinfo.blind.companyIntroduction.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyIntroduction.service.CompanyIntroductionService;
import com.ksinfo.blind.companyReview.dto.CompanyJoinDto;

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
		public ModelAndView CompanyShowReview(HttpServletRequest req, Long companyId) throws Exception {
			ModelAndView mav = new ModelAndView();
		
			CompanyIntroductionDto companyIntroduction = companyIntroductionService.companyIntroduction(companyId);
			CompanyJoinDto companyJoinDto = companyIntroductionService.companyAveragePoint(companyId);
			mav.addObject("companyJoinDto",companyJoinDto );
			mav.addObject("companyIntroduction", companyIntroduction);
			mav.setViewName("main/companyIntroduction/companyShowReview");
			int reviewCount = companyIntroductionService.reviewCount(companyId);
			mav.addObject("reviewCount", reviewCount);
			return mav;
			
		}		
		 
		   

	}

