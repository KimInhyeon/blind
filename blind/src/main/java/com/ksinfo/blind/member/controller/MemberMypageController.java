package com.ksinfo.blind.member.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import com.ksinfo.blind.mytask.service.BookmarkService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ksinfo.blind.member.dto.SalaryRankingDto;
import com.ksinfo.blind.member.service.MemberMypageService;
import com.ksinfo.blind.security.Account;

@Controller
public class MemberMypageController {

	private static final Logger logger = LoggerFactory.getLogger(MemberMypageController.class);	

	@Autowired 
	MemberMypageService mypageService;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	
	@RequestMapping(value="/member/mypage")
	public ModelAndView Mypage(@AuthenticationPrincipal Account account, ModelAndView mav) {
	
		//로그인한 유저의 정보
		String userNickname = account.getUserNickname();
		String userAuth = account.getUserAuth();
		int userId = (int) account.getUserId();
			
		
		//공통정보(닉네임) mav에 저장(일반회원 경우 프로필이 '정회원 인증안내'로 대체되므로 닉네임만 전달하면 됨)	
		mav.addObject("user_nick_name",userNickname);

		//출력할 페이지 설정	
		if(userAuth.equals("ROLE_RM")) {	//정회원인 경우
			int userPostCountsThisMonth= mypageService.getPostCountsThisMonth(userId);
			int postLikeCountThisMonth = mypageService.getPostLikeCountThisMonth(userId); 
	
			//account 자체를 그대로 전송시 password등도 같이 전송되어 보안 우려로 개별전송.	
			//int companyId= (int) account.getCompanyId();	
			//String userCompanyName = mypageService.getUsersCompanyName(companyId);
			//mav.addObject("user_company_name",userCompanyName); //정보노출 우려로 주석처리.
			
			mav.addObject("user_post_counts_this_month",userPostCountsThisMonth);
			mav.addObject("like_count_this_month",postLikeCountThisMonth);

			float myRankNumber = mypageService.getSalaryRankingData(userId);//상위랭크계산법 : (나의순위/전체인원수)x100
			mav.addObject("my_rank_percent",myRankNumber);
			mav.setViewName("main/member/mypageRegular");
			return mav;			
		}

		// 일반회원으로 각각 이동할 페이지 구분하여 생성	
		mav.setViewName("main/member/mypageNormal");
		return mav;
	}
	
	
	//1.계정정보 수정
	//1.1.개인정보(비밀번호)수정 페이지로 이동.
	@RequestMapping(value="accountUpdate")
	public ModelAndView AccountUpdate(@AuthenticationPrincipal Account account, ModelAndView mav) {
		mav.setViewName("main/member/accountUpdate");
		return mav;
	}	
	
	//1.1.1. 현재비밀번호 일치여부 체크.(jsp페이지의 첫번째 기존비밀번호 입력박스)
	@RequestMapping(value = "checkCurrentPassword", method = RequestMethod.POST, produces="application/json")
	@ResponseBody 	
	public int checkCurrentPassword(@AuthenticationPrincipal Account account, String inputCurrentPassword ){ 
		
		//DB에서 현 유저의 비밀번호를 가져옴.
		String currentPassword = mypageService.getCurrentPassword( (int)account.getUserId() );
		//account.getPassword()) (@AuthenticationPrincipal Account account의 최초 로그인시의 비밀번호 보관)를 사용시 로그아웃까지 이전비밀번호가 적용됨.
		//위의 이유로 비밀번호 수정시에는 DB에서 비밀번호를 가져와서 체크하는 형태로 변경.

		logger.info("currentPassword : " + currentPassword );
		
		if( passwordEncoder.matches(inputCurrentPassword, currentPassword ) )  { //기존의 비밀번호가 일치하는지 확인
			return 1; //1: 비밀번호가 일치함을 확인.
 		}  		
		return 0; //1: 비밀번호가 불일치함을 확인.
	}
	
	
	//1.1.2. 비밀번호갱신실시((jsp페이지의 비밀번호갱신하기 클릭시 실행)
	@RequestMapping(value = "updateToNewPassword", method = RequestMethod.POST, produces="application/json")
	@ResponseBody 	
	public int updateToNewPassword(@AuthenticationPrincipal Account account, String inputCurrentPassword, String inputNewPassword){ 
		//DB에서 현 유저의 비밀번호를 가져옴.
		String currentPassword = mypageService.getCurrentPassword( (int)account.getUserId() );
		//account.getPassword()) (@AuthenticationPrincipal Account account의 최초 로그인시의 비밀번호 보관)를 사용시 로그아웃까지 이전비밀번호가 적용됨.
		//위의 이유로 비밀번호 수정시에는 DB에서 비밀번호를 가져와서 체크하는 형태로 변경.

		if( passwordEncoder.matches(inputCurrentPassword, currentPassword ) )  { //현재 쓰이던 기존의 비밀번호가 일치하는지 확인
			mypageService.updateToNewPassword( (int)account.getUserId() , inputNewPassword);
			return 1;	//비밀번호 변경이 성공.  
 		} 
		
		return 0; 	//비밀번호 변경 실패.  
		
	}
	
	
	
	//1.2.이메일 인증페이지로 이동(회원등급 제한없음)
	@RequestMapping(value="certification")
	public ModelAndView Certification(@AuthenticationPrincipal Account account, ModelAndView mav) {

		mav.setViewName("main/member/certification");
		int explain_flag =0; //explain_flag : 정회원만 이용할 수 있는 페이지를 일반회원이 접속시 '인증(main/member/certification)'페이지로 보내고 안내 팝업창을 띄우도록 하는 신호값.
							 //전송않을시 ajax 에러로 modal이 작동않게 되어 값을 전송.
		mav.addObject("explain_flag",explain_flag);
		return mav;
		
		/* 이전 코드
		mav.setViewName("main/member/certification");
		return mav;
		*/
	}
	
	//1.3.연봉등록 페이지로 이동.(단 정회원만 가능. 일반회원시 이메일 인증페이지로 이동.
	@RequestMapping(value="registerAnnualIncome")
	public ModelAndView RegisterAnnualIncome(@AuthenticationPrincipal Account account, ModelAndView mav) {
		//로그인한 유저의 정보
		String userAuth = account.getUserAuth();
		//출력할 페이지 설정		
		if(userAuth.equals("ROLE_RM")) {	//정회원인 경우 연봉등록페이지로 이동											[피드백:관리자도 가능하도록 추가설정]			
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
		
	//3.2. 나의 기업리뷰 리스트 보기 페이지 이동.(일반회원불가. 일반회원은 인증페이지로 리턴)
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

	@RequestMapping(value="/member/logout", method = RequestMethod.POST)
    public ModelAndView logout(HttpSession session, ModelAndView mav) {
        session.invalidate();	//로그아웃 처리(세션아웃)        
        mav.addObject("url", "/blind/login" ); //리턴값으로 로그아웃후 이동할 페이지 값을 리턴.   
        return mav;    	
    }

}
