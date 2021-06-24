package com.ksinfo.blind.manage.contoller;

import com.ksinfo.blind.manage.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TopicController {
	@Autowired
	TopicService topicService;

	@GetMapping(value = "manage/topic")
	public ModelAndView topic(ModelAndView mav) {
		System.out.println("test");
		mav.setViewName("main/manage/topic");
		return mav;
	}
}