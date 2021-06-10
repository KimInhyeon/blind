package com.ksinfo.blind.manage.company.contoller;

import com.ksinfo.blind.manage.common.controller.ManageController;
import com.ksinfo.blind.manage.company.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
public class CompanyController extends ManageController {
	@Autowired
	CompanyService companyService;

	@RequestMapping(value = "manage")
	public String company() {
		return "redirect:manage/company";
	}

	@RequestMapping(value = "manage/company")
	public ModelAndView company(HttpSession session, ModelAndView mav) {
//		if (authCheck(session)) {
			mav.setViewName("manage/company");
			mav.addObject("companyList", companyService.getCompanyList());
//		} else {
//			mav.setViewName(main);
//		}
		return mav;
	}
}