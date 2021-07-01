package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.dto.CompanyDto;
import com.ksinfo.blind.manage.dto.CompanySearchDto;
import com.ksinfo.blind.manage.dto.CompanyVerifyDto;
import com.ksinfo.blind.manage.service.CompanyService;
import com.ksinfo.blind.manage.vo.BusinessTypeVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class CompanyController {
	private final CompanyService companyService;

	@Autowired
	public CompanyController(CompanyService companyService) {
		this.companyService = companyService;
	}

	@GetMapping(value = "manage")
	public String company() {
		return "redirect:/manage/company";
	}

	@GetMapping(value = "manage/company")
	public ModelAndView company(String searchTarget, String searchKeyword,
		@RequestParam(name = "page", defaultValue = "1") int page,
		@RequestParam(name = "verifyFlag", defaultValue = "0") char verifyFlag,
		@RequestParam(name = "closingFlag", defaultValue = "0") char closingFlag
	) {
		CompanySearchDto companySearchDto = new CompanySearchDto(verifyFlag, closingFlag, searchTarget, searchKeyword);
		PageNavigator navi = companyService.getNavigator(page, companySearchDto);
		List<CompanyVO> companyList = companyService.getCompanyList(navi.getCurrentPage(), companySearchDto);
		List<BusinessTypeVO> businessTypeList = companyService.getBusinessTypeList();

		ModelAndView modelAndView = new ModelAndView("main/manage/company");
		modelAndView.addObject("search", companySearchDto);
		modelAndView.addObject("navi", navi);
		modelAndView.addObject("companyList", companyList);
		modelAndView.addObject("businessTypeList", businessTypeList);

		return modelAndView;
	}

	@ResponseBody
	@PostMapping(value = "manage/company")
	public int applyCompany(@RequestBody CompanyDto company, @AuthenticationPrincipal Account account) {
		company.setUserId(account.getUserId());
		return companyService.applyCompany(company);
	}

	@ResponseBody
	@PutMapping(value = "manage/company")
	public int updateCompany(@RequestBody CompanyDto company, @AuthenticationPrincipal Account account) {
		company.setUserId(account.getUserId());
		return companyService.updateCompany(company);
	}

	@ResponseBody
	@PatchMapping(value = "manage/company")
	public int verifyCompany(@RequestBody CompanyVerifyDto verifyData, @AuthenticationPrincipal Account account) {
		verifyData.setUserId(account.getUserId());
		return companyService.verifyCompany(verifyData);
	}
}