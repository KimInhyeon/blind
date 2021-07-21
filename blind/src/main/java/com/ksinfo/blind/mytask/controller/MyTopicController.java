package com.ksinfo.blind.mytask.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.mytask.service.MyTopicService;
import com.ksinfo.blind.security.Account;


@Controller
public class MyTopicController {

	@Autowired
	MyTopicService mytopicService;
	
	@RequestMapping(value = "/mytopic")
    public ModelAndView mytopicView(@AuthenticationPrincipal Account account, ModelAndView mv) {
        mv.addObject("mytopicList", mytopicService.mytopicList(account.getUserId()));
        mv.setViewName("main/mytask/mytopic");
        return mv;
    }
}

