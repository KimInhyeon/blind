package com.ksinfo.blind.mytask.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BookmarkController {

	@RequestMapping(value = "/bookmark")
    public ModelAndView bookmarkView() {
        ModelAndView mv = new ModelAndView();
        
        mv.setViewName("main/mytask/bookmark");
        return mv;
    }
}
