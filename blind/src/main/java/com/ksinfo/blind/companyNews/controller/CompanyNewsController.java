package com.ksinfo.blind.companyNews.controller;

import com.ksinfo.blind.companyIntroduction.dto.CompanyIntroductionDto;
import com.ksinfo.blind.companyIntroduction.service.CompanyIntroductionService;
import com.ksinfo.blind.companyNews.service.CompanyNewsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

@RestController
public final class CompanyNewsController {
	private final CompanyIntroductionService companyIntroductionService;
	private final CompanyNewsService companyNewsService;

	@Autowired
	public CompanyNewsController(CompanyIntroductionService companyIntroductionService, CompanyNewsService companyNewsService) {
		this.companyIntroductionService = companyIntroductionService;
		this.companyNewsService = companyNewsService;
	}

	@GetMapping("company/news/{companyId}")
	public ModelAndView companyNews(@PathVariable long companyId, @RequestParam(defaultValue = "1") int page) {
		CompanyIntroductionDto companyIntroduction = companyIntroductionService.companyIntroduction(companyId);
		int reviewCount = companyIntroductionService.reviewCount(companyId);
		Map<String, Object> companyNews = companyNewsService.getCompanyNews(companyIntroduction.getCompanyName(), page);

		ModelAndView modelAndView = new ModelAndView("main/companyNews/companyNews");
		modelAndView.addObject("companyIntroduction", companyIntroduction);
		modelAndView.addObject("reviewCount", reviewCount);
		modelAndView.addObject("articles", companyNews.get("articles"));
		modelAndView.addObject("navi", companyNews.get("navi"));

		return modelAndView;
	}

	@GetMapping(value = "company/news/{companyId}", params = "ajax=true")
	public Map<String, Object> getArticles(@PathVariable long companyId, @RequestParam(defaultValue = "1") int page) {
		String companyName = companyNewsService.getCompanyName(companyId);

		return companyNewsService.getCompanyNews(companyName, page);
	}
}