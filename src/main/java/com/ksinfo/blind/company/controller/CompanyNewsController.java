package com.ksinfo.blind.company.controller;

import com.ksinfo.blind.company.service.CompanyCommonService;
import com.ksinfo.blind.company.service.CompanyNewsService;
import com.ksinfo.blind.company.vo.CompanyMenuVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

@RestController
@RequestMapping("company/news")
public final class CompanyNewsController {
	private final CompanyCommonService companyCommonService;
	private final CompanyNewsService companyNewsService;

	@Autowired
	public CompanyNewsController(CompanyCommonService companyCommonService, CompanyNewsService companyNewsService) {
		this.companyCommonService = companyCommonService;
		this.companyNewsService = companyNewsService;
	}

	@GetMapping
	public void company(
		@Value("${server.servlet.context-path}") String contextPath, HttpServletResponse httpServletResponse
	) throws IOException {
		httpServletResponse.sendRedirect(contextPath  + "/company");
	}

	@GetMapping("{companyId}")
	public ModelAndView companyNews(@PathVariable long companyId, @RequestParam(defaultValue = "1") int page) {
		CompanyMenuVO companyMenu = companyCommonService.getCompanyMenu(companyId);
		Map<String, Object> companyNews = companyNewsService.getCompanyNews(companyMenu.getCompanyName(), page);

		ModelAndView modelAndView = new ModelAndView("main/company/companyNews");
		modelAndView.addObject("title", companyMenu.getCompanyName() + " ニュース");
		modelAndView.addObject("companyMenu", companyMenu);
		modelAndView.addObject("articles", companyNews.get("articles"));
		modelAndView.addObject("navi", companyNews.get("navi"));

		return modelAndView;
	}

	@GetMapping(value = "{companyId}", params = "ajax=true")
	public Map<String, Object> getArticles(@PathVariable long companyId, @RequestParam(defaultValue = "1") int page) {
		String companyName = companyNewsService.getCompanyName(companyId);

		return companyNewsService.getCompanyNews(companyName, page);
	}
}