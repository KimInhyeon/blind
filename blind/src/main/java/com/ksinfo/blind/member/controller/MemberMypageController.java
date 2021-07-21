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
		
		//공통정보(닉네임) mav에 저장(일반회원 경우 프로필이 회원인증안내 텍스트로 대체되므로 닉네임만 전달하면 됨)
		int companyId= (int) account.getCompanyId();		
		String userCompanyName = mypageService.getUsersCompanyName(companyId);
		mav.addObject("user_nick_name",userNickname);

		//출력할 페이지 설정		
		if(userAuth.equals("ROLE_RM")) {	//정회원인 경우
			int userId = (int) account.getUserId();
			
			
			int userPostCountsThisMonth= mypageService.getPostCountsThisMonth(userId);
			int postLikeCountThisMonth = mypageService.getPostLikeCountThisMonth(userId); 
			
			
			//int postReplyCountThisMonth = mypageService.getPostReplyCountThisMonth(userId); DB 데이터 제작 후 태스트 진행
			
			//account 자체를 그대로 전송시 password등도 같이 전송되어 보안 우려로 개별전송.
			
			mav.addObject("user_company_name",userCompanyName);
			mav.addObject("user_post_counts_this_month",userPostCountsThisMonth);
			mav.addObject("like_count_this_month",postLikeCountThisMonth);
			
			//mav.addObject("reply_count_this_month",postReplyCountThisMonth); DB 데이터 제작 후 태스트 진행
			
			
			mav.setViewName("main/member/mypageRegular");	//레귤러(정회원) 아닌 경우에는 일반회원의 마이페이지로 리턴.
			return mav;			
		}

		mav.setViewName("main/member/mypageNormal");
		return mav;

		//레귤러 회원/일반회원으로 각각 이동할 페이지 구분하여 생성

	}
	
	
	//이메일 인증페이지로 이동
	@RequestMapping(value="certification")
	public ModelAndView Certification(@AuthenticationPrincipal Account account, ModelAndView mav) {

		mav.setViewName("main/member/certification");
		return mav;
	}
	
	
	//연봉등록 탭으로 이동.(단 정회원만 가능. 일반회원시 이메일 인증페이지로 이동.
	@RequestMapping(value="registerAnnualIncome")
	public ModelAndView RegisterAnnualIncome(@AuthenticationPrincipal Account account, ModelAndView mav) {
		//로그인한 유저의 정보
		String userAuth = account.getUserAuth();

		//출력할 페이지 설정		
		if(userAuth.equals("ROLE_RM")) {	//정회원인 경우 연봉등록페이지로 이동			
			mav.setViewName("main/member/registerAnnualIncome");	//레귤러(정회원) 아닌 경우에는 일반회원의 마이페이지로 리턴.
			return mav;			
		}

		//일반회원인 경우 이메일 인증페이지로 이동.
		int explain_flag=1;	//explain_flag : 정회원만 이용할 수 있는 페이지를 일반회원이 접속시 '인증(main/member/certification)'페이지로 보내고 안내 팝업창을 띄우도록 하는 신호값.
		mav.addObject("explain_flag",explain_flag);
		mav.setViewName("main/member/certification");
		return mav;

	}	

}
