package com.ksinfo.blind.test.contoller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.test.dto.TestDto;
import com.ksinfo.blind.test.service.TestService;

@Controller
public class TestController {

	@Autowired TestService testService;

	@RequestMapping(value="test")
	public ModelAndView test() throws Exception{
		ModelAndView mav = new ModelAndView(); 
		//ModelAndView : 모델->view(유저화면)으로 데이터를 이동
		List<TestDto> testList = testService.findTestData(); 
	
		mav.addObject("testMessage", testList.get(0).getTest());
		mav.setViewName("test");
		return mav;
	}
}
