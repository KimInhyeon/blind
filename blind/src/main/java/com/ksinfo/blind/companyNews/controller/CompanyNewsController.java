package com.ksinfo.blind.companyNews.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CompanyNewsController {

	@GetMapping("companyNews/{companyId}")
	public String companyNews(@PathVariable long companyId, @RequestParam(defaultValue = "1") int page) {
		return "redirect:/";
	}
}