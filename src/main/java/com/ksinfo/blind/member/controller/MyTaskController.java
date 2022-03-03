package com.ksinfo.blind.member.controller;

import com.ksinfo.blind.member.service.MyTaskService;
import com.ksinfo.blind.member.vo.MyCompanyReviewVO;
import com.ksinfo.blind.member.vo.MyReportVO;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping("member/task")
public final class MyTaskController {
	private final MyTaskService myTaskService;

	@Autowired
	public MyTaskController(MyTaskService myTaskService) {
		this.myTaskService = myTaskService;
	}


	@GetMapping
	public ModelAndView myTaskView(@AuthenticationPrincipal Account account) {
		List<MyCompanyReviewVO> companyReviewList = myTaskService.getMyCompanyReviewList(account.getUserId());
		List<MyReportVO> reportList = myTaskService.getMyReportList(account.getUserId());

		ModelAndView modelAndView = new ModelAndView("main/member/myTask");
		modelAndView.addObject("title", "マイタスク");
		modelAndView.addObject("companyReviewCount", companyReviewList.size());
		modelAndView.addObject("companyReviewList", companyReviewList);
		modelAndView.addObject("reportCount", reportList.size());
		modelAndView.addObject("reportList", reportList);

		return modelAndView;
	}

	@ResponseBody
	@GetMapping(value = "mytaskApi")
	public List<MyCompanyReviewVO> myTaskViewApi(@RequestParam("userId") String userId) {

		List<MyCompanyReviewVO> mycompanyreviewList = myTaskService.getMyCompanyReviewList(Long.valueOf(userId));

		return mycompanyreviewList;
	}

	@ResponseBody
	@GetMapping(value = "mytaskReportApi")
	public List<MyReportVO> myTaskReportViewApi(@RequestParam("userId") String userId) {

		List<MyReportVO> reportList = myTaskService.getMyReportList(Long.valueOf(userId));

		return reportList;
	}
}