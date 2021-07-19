package com.ksinfo.blind.member.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.member.service.MemberMypageService;
import com.ksinfo.blind.security.Account;

@Controller
public class MemberMypageController {

	private static final Logger logger = LoggerFactory.getLogger(MemberMypageController.class);	

	@Autowired MemberMypageService mypageService;
	
	@RequestMapping(value="/member/mypage")
	public ModelAndView Mypage(@AuthenticationPrincipal Account account, ModelAndView mav) {
	
		//로그인한 유저의 정보
		String userNickname = account.getUserNickname();
		String userAuth = account.getUserAuth();
		
		int companyId= (int) account.getCompanyId();
		String userCompanyName = mypageService.getUsersCompanyName(companyId);
		

		//account 자체를 그대로 전송시 password등도 같이 전송되어 보안 우려로 개별전송.
		mav.addObject("user_nick_name",userNickname);
		mav.addObject("user_auth",userAuth);			//table의 user_auth칼럼이 char(7)인 관계로 'RM     ' 형태로 리턴됨을 확인함.
		mav.addObject("user_company_name",userCompanyName);
		
		mav.setViewName("main/member/mypage");
		return mav;
	}
}
