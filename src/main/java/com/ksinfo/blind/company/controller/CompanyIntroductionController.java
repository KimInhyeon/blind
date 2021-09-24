package com.ksinfo.blind.company.controller;

import com.ksinfo.blind.company.service.CompanyIntroductionService;
import com.ksinfo.blind.company.service.CompanyCommonService;
import com.ksinfo.blind.company.vo.CompanyIntroductionVO;
import com.ksinfo.blind.company.vo.CompanyMenuVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("company/introduction")
public class CompanyIntroductionController {
	private final CompanyCommonService companyCommonService;
	private final CompanyIntroductionService companyIntroductionService;

	@Autowired
	public CompanyIntroductionController(
		CompanyCommonService companyCommonService, CompanyIntroductionService companyIntroductionService
	) {
		this.companyCommonService = companyCommonService;
		this.companyIntroductionService = companyIntroductionService;
	}

	@GetMapping
	public void company(
		@Value("${server.servlet.context-path}") String contextPath, HttpServletResponse httpServletResponse
	) throws IOException {
		httpServletResponse.sendRedirect(contextPath  + "/company");
	}

	@GetMapping("{companyId}")
	public ModelAndView companyIntroduction(@PathVariable long companyId) {
		CompanyMenuVO companyMenu = companyCommonService.getCompanyMenu(companyId);
		CompanyIntroductionVO companyIntroduction = companyIntroductionService.getCompanyIntroduction(companyId);

		ModelAndView modelAndView = new ModelAndView("main/company/companyIntroduction");
		modelAndView.addObject("title", companyMenu.getCompanyName() + " 紹介");
		modelAndView.addObject("companyMenu", companyMenu);
		modelAndView.addObject("companyIntroduction", companyIntroduction);

		return modelAndView;
	}
}