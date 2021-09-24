package com.ksinfo.blind.member.controller;

import com.ksinfo.blind.member.service.MemberService;
import com.ksinfo.blind.member.vo.MyPostVO;
import com.ksinfo.blind.member.service.MyPostService;
import com.ksinfo.blind.security.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public final class MyPostController {
	private final MyPostService myPostService;
	private final MemberService memberService;

	@Autowired
	public MyPostController(MyPostService myPostService, MemberService memberService) {
		this.myPostService = myPostService;
		this.memberService = memberService;
	}

	@RequestMapping(value = "member/post")
	public ModelAndView myPostView(@AuthenticationPrincipal Account account) {
		List<MyPostVO> postList = myPostService.getMyPostList(account.getUserId());
		account = memberService.getLatestMemberInformation(account);

		ModelAndView modelAndView = new ModelAndView("main/member/myPost");
		modelAndView.addObject("title", "マイポスト");
		modelAndView.addObject("postList", postList);
		modelAndView.addObject("userNickname", account.getUserNickname());
		modelAndView.addObject("reportedCount", account.getReportedCount());

		return modelAndView;
	}
}