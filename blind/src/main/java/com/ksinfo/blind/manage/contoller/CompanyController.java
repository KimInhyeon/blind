package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.dto.CompanyDto;
import com.ksinfo.blind.manage.dto.CompanySearchDto;
import com.ksinfo.blind.manage.dto.CompanyVerifyDto;
import com.ksinfo.blind.manage.service.CompanyService;
import com.ksinfo.blind.util.PageNavigator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class CompanyController {
	@Autowired
	private CompanyService companyService;

	@GetMapping(value = "manage")
	public String company() {
		return "redirect:/manage/company";
	}

	@GetMapping(value = "manage/company")
	public ModelAndView company(ModelAndView mav, String searchTarget, String searchKeyword,
		@RequestParam(name = "page", defaultValue = "1") int page,
		@RequestParam(name = "verifyFlag", defaultValue = "0") char verifyFlag,
		@RequestParam(name = "closingFlag", defaultValue = "0") char closingFlag
	) {
		CompanySearchDto companySearchDto = new CompanySearchDto(verifyFlag, closingFlag, searchTarget, searchKeyword);
		PageNavigator navi = companyService.getNavigator(page, companySearchDto);
		mav.addObject("companyList", companyService.getCompanyList(navi, companySearchDto));
		mav.addObject("businessTypeList", companyService.getBusinessTypeList());
		mav.addObject("navi", navi);
		mav.addObject("search", companySearchDto);
		mav.setViewName("main/manage/company");
		return mav;
	}

	@ResponseBody
	@PostMapping(value = "manage/company/apply")
	public boolean applyCompany(@RequestBody CompanyDto company, HttpSession session) {
		return companyService.applyCompany(company, session);
	}

	@ResponseBody
	@PutMapping(value = "manage/company/update")
	public boolean updateCompany(@RequestBody CompanyDto company, HttpSession session) {
		return companyService.updateCompany(company, session);
	}

	@ResponseBody
	@PatchMapping(value = "manage/company/update")
	public int verifyCompany(@RequestBody CompanyVerifyDto data, HttpSession session) {
		return companyService.verifyCompany(data, session);
	}
}