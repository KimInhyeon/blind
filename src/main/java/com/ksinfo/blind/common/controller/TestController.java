package com.ksinfo.blind.common.controller;

import com.ksinfo.blind.common.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
public final class TestController {
	private final TestService testService;

	@Autowired
	public TestController(TestService testService) {
		this.testService = testService;
	}

	@GetMapping("test")
	public ModelAndView test() {
		String testMessage = testService.findTestData();

		ModelAndView modelAndView = new ModelAndView("main/common/test");
		modelAndView.addObject("title", "KSINFOSYS BLIND");
		modelAndView.addObject("testMessage", testMessage);

		return modelAndView;
	}

	@ResponseBody
	@PostMapping("testAndroidAccess")
	public Map<String, String> androidTestWithRequestAndResponse(HttpServletRequest request){
		String param = request.getParameter("content");
		System.out.println(param);

		String message = testService.findTestData();
		System.out.println(message);

		Map<String, String> result = new HashMap<>(1);
		result.put("message", message);

		return result;
	}
}