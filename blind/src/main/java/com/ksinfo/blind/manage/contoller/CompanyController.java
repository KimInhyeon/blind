package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.service.CompanyService;
import com.ksinfo.blind.manage.service.PageNavigator;
import com.ksinfo.blind.manage.vo.CompanySearchVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CompanyController /*extends ManageController*/ {
	@Autowired
	CompanyService companyService;

	@RequestMapping(value = "manage")
	public String company() {
		return "redirect:manage/company";
	}
//	@RequestMapping(value = "manage/company")
//	public ModelAndView company(HttpSession session, ModelAndView mav) {
//		if (authCheck(session)) {
//			mav.setViewName("main/manage/company");
//			mav.addObject("companyList", companyService.getCompanyList());
//		} else {
//			mav.setViewName(main);
//		}
//		return mav;
//	}
	@RequestMapping(value = "manage/company")
	public ModelAndView company(String searchTarget, String searchKeyword, ModelAndView mav,
			@RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
			@RequestParam(name = "verifyFlag", defaultValue = "0") byte verifyFlag,
			@RequestParam(name = "closingFlag", defaultValue = "0") byte closingFlag) {
		CompanySearchVO companySearchVO = new CompanySearchVO(verifyFlag, closingFlag, searchTarget, searchKeyword);
		PageNavigator navi = companyService.getNavi(currentPage, companySearchVO);
		mav.addObject("companyList", companyService.getCompanyList(navi, companySearchVO));
		mav.addObject("navi", navi);
		mav.addObject("searchMap", companySearchVO);
		mav.setViewName("main/manage/company");
		return mav;
	}
}