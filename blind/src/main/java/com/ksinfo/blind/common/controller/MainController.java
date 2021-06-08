package com.ksinfo.blind.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController  {

	@RequestMapping("/main")
    public ModelAndView index() {

        ModelAndView mv = new ModelAndView();
        
        
        mv.setViewName("main/test/test");
        return mv;
    }
}
