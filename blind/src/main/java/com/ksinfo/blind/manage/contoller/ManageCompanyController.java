package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.dto.CompanyDto;
import com.ksinfo.blind.manage.dto.CompanySearchDto;
import com.ksinfo.blind.manage.dto.CompanyVerifyDto;
import com.ksinfo.blind.manage.service.ManageCompanyService;
import com.ksinfo.blind.manage.vo.BusinessTypeVO;
import com.ksinfo.blind.manage.vo.CompanyVO;
import com.ksinfo.blind.security.Account;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("manage/company")
public final class ManageCompanyController {
	private final ManageCompanyService manageCompanyService;

	@Autowired
	public ManageCompanyController(ManageCompanyService manageCompanyService) {
		this.manageCompanyService = manageCompanyService;
	}

	@GetMapping
	public ModelAndView manageCompany(
		String searchTarget, String searchKeyword, @RequestParam(defaultValue = "1") int page,
		@RequestParam(defaultValue = "0") char verifyFlag, @RequestParam(defaultValue = "0") char closingFlag
	) {
		CompanySearchDto companySearchDto = new CompanySearchDto(verifyFlag, closingFlag, searchTarget, searchKeyword);
		PageNavigator navi = manageCompanyService.getNavigator(page, companySearchDto);
		List<CompanyVO> companyList = manageCompanyService.getCompanyList(navi.getCurrentPage(), companySearchDto);
		List<BusinessTypeVO> businessTypeList = manageCompanyService.getBusinessTypeList();

		ModelAndView modelAndView = new ModelAndView("main/manage/manageCompany");
		modelAndView.addObject("search", companySearchDto);
		modelAndView.addObject("navi", navi);
		modelAndView.addObject("companyList", companyList);
		modelAndView.addObject("businessTypeList", businessTypeList);

		return modelAndView;
	}

	@GetMapping(params = "ajax=true")
	public Map<String, Object> getCompanyList(
		String searchTarget, String searchKeyword, @RequestParam(defaultValue = "1") int page,
		@RequestParam(defaultValue = "0") char verifyFlag, @RequestParam(defaultValue = "0") char closingFlag
	) {
		CompanySearchDto companySearchDto = new CompanySearchDto(verifyFlag, closingFlag, searchTarget, searchKeyword);
		PageNavigator navi = manageCompanyService.getNavigator(page, companySearchDto);
		List<CompanyVO> companyList = manageCompanyService.getCompanyList(navi.getCurrentPage(), companySearchDto);

		Map<String, Object> result = new HashMap<>(2);
		result.put("navi", navi);
		result.put("companyList", companyList);

		return result;
	}

	@PostMapping
	public int applyCompany(@RequestBody CompanyDto company, @AuthenticationPrincipal Account account) {
		company.setUserId(account.getUserId());
		return manageCompanyService.applyCompany(company);
	}

	@PutMapping
	public int updateCompany(@RequestBody CompanyDto company, @AuthenticationPrincipal Account account) {
		company.setUserId(account.getUserId());
		return manageCompanyService.updateCompany(company);
	}

	@PatchMapping
	public int verifyCompany(@RequestBody CompanyVerifyDto verifyData, @AuthenticationPrincipal Account account) {
		verifyData.setUserId(account.getUserId());
		return manageCompanyService.verifyCompany(verifyData);
	}
}