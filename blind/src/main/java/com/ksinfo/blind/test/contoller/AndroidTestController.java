package com.ksinfo.blind.test.contoller;

import com.ksinfo.blind.test.dto.TestDto;
import com.ksinfo.blind.test.service.TestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AndroidTestController {
	@Autowired
	TestService testService;

	@PostMapping("/testAndroidAccess")
	@ResponseBody
	public Map<String, String> androidTestWithRequestAndResponse(HttpServletRequest request){

		Map<String, String> result = new HashMap<String, String>();

		List<TestDto> testList = testService.findTestData();

		String param = request.getParameter("content");

		System.out.println(param);
		System.out.println(testList.get(0).getTest());
		result.put("message", testList.get(0).getTest());

		return result;
	}
}