package com.ksinfo.blind.company.controller;

import com.ksinfo.blind.company.dto.CompanyPostSearchDto;
import com.ksinfo.blind.company.service.CompanyCommonService;
import com.ksinfo.blind.company.service.CompanyPostService;
import com.ksinfo.blind.company.vo.CompanyMenuVO;
import com.ksinfo.blind.company.vo.CompanyPostVO;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("company/post")
public class CompanyPostController {
	private final CompanyCommonService companyCommonService;
	private final CompanyPostService companyPostService;

	@Autowired
	public CompanyPostController(CompanyCommonService companyCommonService, CompanyPostService companyPostService) {
		this.companyCommonService = companyCommonService;
		this.companyPostService = companyPostService;
	}

	@GetMapping
	public void company(
		@Value("${server.servlet.context-path}") String contextPath, HttpServletResponse httpServletResponse
	) throws IOException {
		httpServletResponse.sendRedirect(contextPath + "/company");
	}

	@GetMapping("{companyId}")
	public ModelAndView companyReviewPost(
		@AuthenticationPrincipal Account account, @PathVariable long companyId,
		String searchKeyword, @RequestParam(defaultValue = "1") int page
	) {
		CompanyMenuVO companyMenu = companyCommonService.getCompanyMenu(companyId);
		long userId = account == null ? 0L : account.getUserId();
		CompanyPostSearchDto search = new CompanyPostSearchDto(userId, companyMenu.getCompanyName(), searchKeyword);
		PageNavigator navi = companyPostService.getPageNavigator(search, page);
		List<CompanyPostVO> companyPostList = companyPostService.getCompanyPostList(search, navi.getCurrentPage());
		String title;
		if (searchKeyword == null) {
			title = companyMenu.getCompanyName() + " ポスト";
		} else {
			title = companyMenu.getCompanyName() + " " + searchKeyword;
		}

		ModelAndView modelAndView = new ModelAndView("main/company/companyPost");
		modelAndView.addObject("title", title);
		modelAndView.addObject("companyMenu", companyMenu);
		modelAndView.addObject("navi", navi);
		modelAndView.addObject("companyPostList", companyPostList);

		return modelAndView;
	}
}