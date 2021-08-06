package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.common.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class MainController {
	private final MainService mainService;

	@Autowired
	public MainController(MainService mainService) {
		this.mainService = mainService;
	}

	@GetMapping(value = "/")
	public void main(HttpServletResponse httpServletResponse) throws IOException {
		httpServletResponse.sendRedirect("/blind/main");
	}

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView mainView(ModelAndView mv) {
		mv.addObject("topicBestList", mainService.topicBestList());
		mv.addObject("topicSubList", mainService.topicSubList());
		mv.setViewName("main/main");
		return mv;
	}
}