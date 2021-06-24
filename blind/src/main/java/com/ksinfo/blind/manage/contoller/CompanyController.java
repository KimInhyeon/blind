package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.service.CompanyService;
import com.ksinfo.blind.manage.vo.CompanySearchVO;
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
import java.util.Map;

@Controller
public class CompanyController {
	@Autowired
	CompanyService companyService;

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
	public boolean applyCompany(@RequestBody Map<String, Object> company, HttpSession session) {
		company.put("userId", session.getAttribute("userId"));
		return companyService.applyCompany(company);
	}

	@ResponseBody
	@PutMapping(value = "manage/company/update")
	public boolean updateCompany(@RequestBody Map<String, Object> company, HttpSession session) {
		company.put("userId", session.getAttribute("userId"));
		return companyService.updateCompany(company);
	}

	@ResponseBody
	@PatchMapping(value = "manage/company/update")
	public int verifyCompany(@RequestBody Map<String, Object> data, HttpSession session) {
		data.put("userId", session.getAttribute("userId"));
		return companyService.verifyCompany(data);
	}
}