package com.ksinfo.blind.manage.company.contoller;

import com.ksinfo.blind.manage.company.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class CompanyController {
	@Autowired
	CompanyService companyService;

	@RequestMapping(value = {"manage", "manage/company"}, method = RequestMethod.GET)
	public String company(Model model) {
		model.addAttribute("companyList", companyService.test());
		return "manage/company";
	}
}