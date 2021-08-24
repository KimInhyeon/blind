package com.ksinfo.blind.test.contoller;

import com.ksinfo.blind.test.dto.TestDto;
import com.ksinfo.blind.test.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class TestController {
	@Autowired
	TestService testService;

	@RequestMapping(value = "test")
	public ModelAndView test() throws Exception {
		ModelAndView mav = new ModelAndView();
		List<TestDto> testList = testService.findTestData();
		mav.addObject("testMessage", testList.get(0).getTest());
		mav.setViewName("main/test/test");
		return mav;
	}
}