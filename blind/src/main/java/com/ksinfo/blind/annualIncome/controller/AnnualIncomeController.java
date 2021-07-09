package com.ksinfo.blind.annualIncome.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.annualIncome.service.AnnualIncomeService;


@Controller
public class AnnualIncomeController {

	private static final Logger logger = LoggerFactory.getLogger(AnnualIncomeController.class);

	@Autowired 	AnnualIncomeService annualIncomeService; 
	
	@RequestMapping("/annual_income/annual_income")
	public ModelAndView annualIncome(ModelAndView mav) {
		mav.setViewName("main/annual_income/annual_income");
		return mav;
	}

}
