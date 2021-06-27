package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.service.ReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReportController {
	@Autowired
	private ReportService reportService;

	@GetMapping(value = "manage/report")
	public ModelAndView report(ModelAndView mav) {
		mav.setViewName("main/manage/report");
		return mav;
	}
}