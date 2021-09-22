package com.ksinfo.blind.myPage_temp.controller;

import com.ksinfo.blind.myPage_temp.service.MemberMyPageService;
import com.ksinfo.blind.security.Account;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public final class MemberMyPageController {
	private static final Logger logger = LoggerFactory.getLogger(MemberMyPageController.class);
	private final MemberMyPageService memberMyPageService;
	private final PasswordEncoder passwordEncoder;

	@Autowired
	public MemberMyPageController(MemberMyPageService memberMyPageService, PasswordEncoder passwordEncoder) {
		this.memberMyPageService = memberMyPageService;
		this.passwordEncoder = passwordEncoder;
	}

	@RequestMapping(value = "member/myPage")
	public ModelAndView myPage(@AuthenticationPrincipal Account account, ModelAndView mav) {

		//로그인한 유저의 정보
		String userNickname = account.getUserNickname();
		String userAuth = account.getAuthorities().get(0).toString();
		long userId = account.getUserId();


		//공통정보(닉네임) mav에 저장(일반회원 경우 프로필이 '정회원 인증안내'로 대체되므로 닉네임만 전달하면 됨)
		mav.addObject("user_nick_name", userNickname);

		//출력할 페이지 설정
		if (userAuth.equals("ROLE_RM")) {    //정회원인 경우
			int userPostCountsThisMonth = memberMyPageService.getPostCountsThisMonth(userId);
			int postLikeCountThisMonth = memberMyPageService.getPostLikeCountThisMonth(userId);

			//account 자체를 그대로 전송시 password등도 같이 전송되어 보안 우려로 개별전송.
			//int companyId= (int) account.getCompanyId();
			//String userCompanyName = mypageService.getUsersCompanyName(companyId);
			//mav.addObject("user_company_name",userCompanyName); //정보노출 우려로 주석처리.

			mav.addObject("user_post_counts_this_month", userPostCountsThisMonth);
			mav.addObject("like_count_this_month", postLikeCountThisMonth);

			float myRankNumber = memberMyPageService.getSalaryRankingData(userId);//상위랭크계산법 : (나의순위/전체인원수)x100
			mav.addObject("my_rank_percent", myRankNumber);
			mav.setViewName("main/myPage_temp/myPageRegular");
			return mav;
		}

		// 일반회원으로 각각 이동할 페이지 구분하여 생성
		mav.setViewName("main/myPage_temp/myPageNormal");
		return mav;
	}

	//1.계정정보 수정
	//1.1.개인정보(비밀번호)수정 페이지로 이동.
	@RequestMapping(value = "member/accountUpdate")
	public ModelAndView AccountUpdate(@AuthenticationPrincipal Account account, ModelAndView mav) {
		mav.setViewName("main/myPage_temp/accountUpdate");
		return mav;
	}

	//1.1.1. 현재비밀번호 일치여부 체크.(jsp페이지의 첫번째 기존비밀번호 입력박스)
	@RequestMapping(value = "member/checkCurrentPassword", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int checkCurrentPassword(@AuthenticationPrincipal Account account, String inputCurrentPassword) {

		//DB에서 현 유저의 비밀번호를 가져옴.
		String currentPassword = memberMyPageService.getCurrentPassword((int) account.getUserId());
		//account.getPassword()) (@AuthenticationPrincipal Account account의 최초 로그인시의 비밀번호 보관)를 사용시 로그아웃까지 이전비밀번호가 적용됨.
		//위의 이유로 비밀번호 수정시에는 DB에서 비밀번호를 가져와서 체크하는 형태로 변경.

		logger.info("currentPassword : " + currentPassword);

		if (passwordEncoder.matches(inputCurrentPassword, currentPassword)) { //기존의 비밀번호가 일치하는지 확인
			return 1; //1: 비밀번호가 일치함을 확인.
		}

		return 0; //1: 비밀번호가 불일치함을 확인.
	}

	//1.1.2. 비밀번호갱신실시((jsp페이지의 비밀번호갱신하기 클릭시 실행)
	@RequestMapping(value = "member/updateToNewPassword", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int updateToNewPassword(@AuthenticationPrincipal Account account, String inputCurrentPassword, String inputNewPassword) {
		//DB에서 현 유저의 비밀번호를 가져옴.
		String currentPassword = memberMyPageService.getCurrentPassword((int) account.getUserId());
		//account.getPassword()) (@AuthenticationPrincipal Account account의 최초 로그인시의 비밀번호 보관)를 사용시 로그아웃까지 이전비밀번호가 적용됨.
		//위의 이유로 비밀번호 수정시에는 DB에서 비밀번호를 가져와서 체크하는 형태로 변경.

		if (passwordEncoder.matches(inputCurrentPassword, currentPassword)) { //현재 쓰이던 기존의 비밀번호가 일치하는지 확인
			memberMyPageService.updateToNewPassword((int) account.getUserId(), inputNewPassword);
			return 1;    //비밀번호 변경이 성공.
		}

		return 0;    //비밀번호 변경 실패.
	}

	//1.2.이메일 인증페이지로 이동(회원등급 제한없음)
	@RequestMapping(value = "member/certification")
	public ModelAndView Certification(@AuthenticationPrincipal Account account, ModelAndView mav) {

		mav.setViewName("main/myPage_temp/certification");
		int explain_flag = 0; //explain_flag : 정회원만 이용할 수 있는 페이지를 일반회원이 접속시 '인증(main/myPage_temp/certification)'페이지로 보내고 안내 팝업창을 띄우도록 하는 신호값.
		//전송않을시 ajax 에러로 modal이 작동않게 되어 값을 전송.
		mav.addObject("explain_flag", explain_flag);
		return mav;

		/* 이전 코드
		mav.setViewName("main/myPage_temp/certification");
		return mav;
		*/
	}
}