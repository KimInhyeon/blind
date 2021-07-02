package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReportController {
	private final ReportService reportService;

	@Autowired
	public ReportController(ReportService reportService) {
		this.reportService = reportService;
	}

	@GetMapping(value = "manage/report")
	public ModelAndView report() {
		ModelAndView modelAndView = new ModelAndView("main/manage/report");

		return modelAndView;
	}
}