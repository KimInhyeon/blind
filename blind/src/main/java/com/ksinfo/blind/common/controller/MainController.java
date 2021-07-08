package com.ksinfo.blind.common.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.common.service.MainService;

@Controller
public class MainController {

	@Autowired
	MainService mainService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
    public ModelAndView mainView(ModelAndView mv) {
		mv.addObject("topicBestList", mainService.topicBestList());
		mv.addObject("topicSubList", mainService.topicSubList());
        mv.setViewName("main/main");
        return mv;
    }
	
	
	
}
