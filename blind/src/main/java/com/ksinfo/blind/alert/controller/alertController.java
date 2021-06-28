package com.ksinfo.blind.alert.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.search.controller.SearchController;

@Controller
public class alertController {
	
	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@RequestMapping("/test/test_alert")  
	public ModelAndView test_sqlView(ModelAndView mav){	
		logger.info("test/test_alert");
	mav.setViewName("main/test/test_alert");
	return mav;	
	}
}
