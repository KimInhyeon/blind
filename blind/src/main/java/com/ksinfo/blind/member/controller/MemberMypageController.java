package com.ksinfo.blind.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MemberMypageController {

	

	@RequestMapping(value="/member/mypage")
	public ModelAndView Mypage(ModelAndView mav) {
		
		String userAuth="RM";
		String userNickName= "NickName";
		
		mav.addObject("user_auth",userAuth);
		mav.addObject("user_nickName",userNickName);

		mav.setViewName("main/member/mypage");
		return mav;
	}
}
