package com.ksinfo.blind.mytask.controller;

import com.ksinfo.blind.mytask.service.MyTaskService;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class MyTaskController {

    @Autowired
    MyTaskService mytaskService;

	@RequestMapping(value = "/mytask")
    public ModelAndView mytaskView(@AuthenticationPrincipal Account account, ModelAndView mv) {
        mv.addObject("companyreviewList", mytaskService.companyreviewList(account.getUserId()));
        mv.addObject("reportList", mytaskService.reportList(account.getUserId()));
        mv.setViewName("main/mytask/mytask");
        return mv;
    }
}