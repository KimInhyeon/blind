package com.ksinfo.blind.member.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.member.dto.SalaryRankingDto;
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
	//	int userId = (int) account.getUserId();
		
		int userId = 29;
		
		List<SalaryRankingDto> salaryRankingData = mypageService.getSalaryRankingData(); 
		int myRankNumber=salaryRankingData.size();//초기화 설정. 0으로 초기화시 연산에러 나므로 순위를 맨 뒤에 두로록 설정.

		for(int i=0; i<salaryRankingData.size(); i++) {
			if(salaryRankingData.get(i).getUserId() == userId){
				 myRankNumber=salaryRankingData.get(i).getSalaryRanking();
				 break;
			}
		}
		
		int myRankPercent = (myRankNumber/salaryRankingData.size() )*100 ;	//유저에게 리턴되는 정보. 연봉랭크에서 상위 00% 출력시 랭크숫자값을 리턴.
																		//상위랭크계산법 : (나의순위/전체인원수)x100
		
		//공통정보(닉네임) mav에 저장(일반회원 경우 프로필이 '정회원 인증안내'로 대체되므로 닉네임만 전달하면 됨)
		int companyId= (int) account.getCompanyId();		
		String userCompanyName = mypageService.getUsersCompanyName(companyId);
		mav.addObject("user_nick_name",userNickname);

		//출력할 페이지 설정		
		if(userAuth.equals("ROLE_RM")) {	//정회원인 경우
			
			int userPostCountsThisMonth= mypageService.getPostCountsThisMonth(userId);
			int postLikeCountThisMonth = mypageService.getPostLikeCountThisMonth(userId); 
			
			
			//int postReplyCountThisMonth = mypageService.getPostReplyCountThisMonth(userId); DB 데이터 제작 후 태스트 진행
			
			//account 자체를 그대로 전송시 password등도 같이 전송되어 보안 우려로 개별전송.
			
			mav.addObject("user_company_name",userCompanyName);
			mav.addObject("user_post_counts_this_month",userPostCountsThisMonth);
			mav.addObject("like_count_this_month",postLikeCountThisMonth);
			
			//mav.addObject("reply_count_this_month",postReplyCountThisMonth); DB 데이터 제작 후 태스트 진행
			
			mav.addObject("my_rank_percent",myRankPercent);
			
			
			
			
			mav.setViewName("main/member/mypageRegular");	//레귤러(정회원) 아닌 경우에는 일반회원의 마이페이지로 리턴.
			return mav;			
		}

		mav.setViewName("main/member/mypageNormal");
		return mav;

		//레귤러 회원/일반회원으로 각각 이동할 페이지 구분하여 생성

	}
	
	
	//1.계정정보 수정
	//1.1.이메일 인증페이지로 이동(회원등급 제한없음)
	@RequestMapping(value="certification")
	public ModelAndView Certification(@AuthenticationPrincipal Account account, ModelAndView mav) {

		mav.setViewName("main/member/certification");
		return mav;
	}
	
	//1.2.연봉등록 페이지로 이동.(단 정회원만 가능. 일반회원시 이메일 인증페이지로 이동.
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
	
	//2.초대, 웹로그인
	//2.1. 초대하기 페이지로 이동(회원등급 제한없음)
	@RequestMapping(value="invite")
	public ModelAndView Invite(@AuthenticationPrincipal Account account, ModelAndView mav) {

		mav.setViewName("main/member/invite");
		return mav;
	}	
	
	//2.2. 웹로그인 페이지로 이동(일반회원불가. 일반회원은 인증페이지로 리턴.)
	@RequestMapping(value="webLogin")
	public ModelAndView WebLogin(@AuthenticationPrincipal Account account, ModelAndView mav) {
		//로그인한 유저의 정보
		String userAuth = account.getUserAuth();

		//출력할 페이지 설정		
		if(userAuth.equals("ROLE_RM")) {	//정회원인 경우 연봉등록페이지로 이동			
			mav.setViewName("main/member/webLogin");
			return mav;
		}

		//일반회원인 경우 이메일 인증페이지로 이동.
		int explain_flag=1;	//explain_flag : 정회원만 이용할 수 있는 페이지를 일반회원이 접속시 '인증(main/member/certification)'페이지로 보내고 안내 팝업창을 띄우도록 하는 신호값.
		mav.addObject("explain_flag",explain_flag);
		mav.setViewName("main/member/certification");
		return mav;
	}	
	
	//3.내가 작성한 포스트, 북마크, 기업리뷰
	//3.1. 내가 작성한 포스트들 보기 페이지로 이동(일반회원불가. 일반회원은 인증페이지로 리턴)
	@RequestMapping(value="viewListWritedPost")
	public ModelAndView ViewListWritedPost(@AuthenticationPrincipal Account account, ModelAndView mav) {
		//로그인한 유저의 정보
		String userAuth = account.getUserAuth();

		//출력할 페이지 설정		
		if(userAuth.equals("ROLE_RM")) {	//정회원인 경우 연봉등록페이지로 이동			
			mav.setViewName("main/member/viewListWritedPost");
			return mav;
		}

		//일반회원인 경우 이메일 인증페이지로 이동.
		int explain_flag=1;	//explain_flag : 정회원만 이용할 수 있는 페이지를 일반회원이 접속시 '인증(main/member/certification)'페이지로 보내고 안내 팝업창을 띄우도록 하는 신호값.
		mav.addObject("explain_flag",explain_flag);
		mav.setViewName("main/member/certification");
		return mav;
	}	
	
	//3.2. 나의 북마크(즐겨찾기) 리스트 보기 페이지 이동.(일반회원불가. 일반회원은 인증페이지로 리턴)
	@RequestMapping(value="viewListMyBookmark")
	public ModelAndView ViewListmyBookmark(@AuthenticationPrincipal Account account, ModelAndView mav) {
		//로그인한 유저의 정보
		String userAuth = account.getUserAuth();

		//출력할 페이지 설정		
		if(userAuth.equals("ROLE_RM")) {	//정회원인 경우 연봉등록페이지로 이동			
			mav.setViewName("main/member/viewListMyBookmark");
			return mav;
		}

		//일반회원인 경우 이메일 인증페이지로 이동.
		int explain_flag=1;	//explain_flag : 정회원만 이용할 수 있는 페이지를 일반회원이 접속시 '인증(main/member/certification)'페이지로 보내고 안내 팝업창을 띄우도록 하는 신호값.
		mav.addObject("explain_flag",explain_flag);
		mav.setViewName("main/member/certification");
		return mav;
	}	
		
	//3.3. 나의 기업리뷰 리스트 보기 페이지 이동.(일반회원불가. 일반회원은 인증페이지로 리턴)
	@RequestMapping(value="viewListWritedCompanyReview")
	public ModelAndView ViewListWritedCompanyReview(@AuthenticationPrincipal Account account, ModelAndView mav) {
		//로그인한 유저의 정보
		String userAuth = account.getUserAuth();

		//출력할 페이지 설정		
		if(userAuth.equals("ROLE_RM")) {	//정회원인 경우 연봉등록페이지로 이동			
			mav.setViewName("main/member/viewListWritedCompanyReview");
			return mav;
		}

		//일반회원인 경우 이메일 인증페이지로 이동.
		int explain_flag=1;	//explain_flag : 정회원만 이용할 수 있는 페이지를 일반회원이 접속시 '인증(main/member/certification)'페이지로 보내고 안내 팝업창을 띄우도록 하는 신호값.
		mav.addObject("explain_flag",explain_flag);
		mav.setViewName("main/member/certification");
		return mav;
	}	

	
	
	
	//4. 나의 신고한/신고당한 내역페이지 이동.
	@RequestMapping(value="viewMyAlertList")
	public ModelAndView ViewMyAlertList(@AuthenticationPrincipal Account account, ModelAndView mav) {
		mav.setViewName("main/member/viewMyAlertList");
		return mav;
	}		
	
}
