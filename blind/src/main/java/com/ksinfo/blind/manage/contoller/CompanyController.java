package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.service.CompanyService;
import com.ksinfo.blind.manage.vo.PageNavigator;
import com.ksinfo.blind.manage.vo.CompanySearchVO;
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

import java.util.Map;

@Controller
public class CompanyController {
	@Autowired
	CompanyService companyService;

	@GetMapping(value = "manage")
	public String company() {
		return "redirect:manage/company";
	}

	@GetMapping(value = "manage/company")
	public ModelAndView company(String searchTarget, String searchKeyword, ModelAndView mav,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "verifyFlag", defaultValue = "0") byte verifyFlag,
			@RequestParam(name = "closingFlag", defaultValue = "0") byte closingFlag) {
		CompanySearchVO companySearchVO = new CompanySearchVO(verifyFlag, closingFlag, searchTarget, searchKeyword);
		PageNavigator navi = companyService.getNavi(page, companySearchVO);
		mav.addObject("companyList", companyService.getCompanyList(navi, companySearchVO));
		mav.addObject("navi", navi);
		mav.addObject("searchMap", companySearchVO);
		mav.addObject("businessTypeList", companyService.getBusinessTypeList());
		mav.setViewName("main/manage/company");
		return mav;
	}

	@ResponseBody
	@PostMapping(value = "manage/company/apply")
	public boolean createCompany(@RequestBody Map<String, Object> company) {
		return companyService.applyCompany(company);
	}

	@ResponseBody
	@PutMapping(value = "manage/company/update")
	public boolean verifyCompany(@RequestBody Map<String, Object> company) {
		return companyService.updateCompany(company);
	}

	@ResponseBody
	@PatchMapping(value = "manage/company/update")
	public boolean updateCompany(@RequestBody Map<String, Object> data) {
		return companyService.updateVerify(data);
	}
}