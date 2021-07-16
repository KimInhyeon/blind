<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	/*사용하는 기기의 스크린화면별 동적CSS*/
	@media screen and (max-width:1799px) {
		#mypage_wrap{ background-color: red; }	
	}
	
	@media screen and (max-width:1199px) {
		#mypage_wrap{ background-color: green; }
	}
	
	@media screen and (max-width:899px) {
			#mypage_wrap{ background-color: blue; }
	}
	
	@media screen and (max-width:599px) {
		#mypage_wrap{ background-color: black; }
	}
	
	/*-------------------------------------------*/
	/*class(.)를 활용하여 공통속성부여*/
	/*id(#)를 활용하여 개별속성부여*/	

	
	/* 1. 마이페이지 전체 적용css ---------------------------------------------------------------------- */
	/* 1.1. 마이페이지 전체를 감싸는 div */
	#mypage_wrap{ 				
		text-align:center;	 		/*자식 div에게 'display: inline-block;' 속성을 줘야 가운데 정렬이 적용된다.*/
	}	

	/* 1.2. <a>태그의 설정. */
	a {
	  text-decoration-line: none;	/*<a>의 밑줄속성 삭제*/
	}
	
	
	
	/* 2.헤더부분 css ------------------------------------------------------------------------------ */
	.mypage_header{
		font-size: 2.5em;
		margin:2%;
	}
	

	
	/* 3.메인(유저프로필, 버튼들) -----------------------------------------------------------------------*/

	/* 3.0. 메인 전체를 적용 */
	.mypage_main_warp{
		text-align:center; 					/*내부에 배치되는 중앙정렬할 div에게 display: inline-block; 속성을 줘야 적용된다.*/
	}


	/* 3.1. 메인-유저프로필(닉네임,이메일,소속기업명 출력부분) */
	#mypage_main_user_profile{
		display: inline-block;  					/*div의 중앙 정렬을 위한 설정.*/
		width:30%;
		height:auto;
		background-color: #71736e;
	}
	
	#mypage_main_user_profile_nick_and_mail{
		text-align:left;
		padding:10px;
	}
	
	
	/* 3.2. 메인-버튼 */
	


	/* 4. 옵션적 css(각 항목마다 필요따라 선택적 활용.) --------------------------------------------------------------- */

	/* 4.1.폰트 옵션 모음*/
	 .mypage_common_font{
	 	font-size: 1.2em;
	 	margin:2%;
	 }
	
	/*4.2.정렬 옵션 모음*/
	/*4.2.1. 정렬 옵션-우측정렬모음*/
	.mypage_option_align_right_wrap{     
	 		/*자식 div에게 'display: inline-block;' 속성을 줘야 본 정렬옵션이 적용된다.*/
		display: block;

	}	
	.mypage_option_align_right_target{     

		display: inline-block;
	}	

	
</style>
</head>
<body>
	<div id="mypage_wrap" >
		<div class="mypage_header mypage_option_align_right_wrap" >
			<div style="display: inline;">
				My Page
			</div>												<!-- [차후 수정사항] 1줄내에 Mypage글자와 로그아웃 아이콘 배치되도록 할것. -->
			<div class="mypage_option_align_right_target">
				<a><i class="sign out alternate icon"></i></a>
			</div>
		</div>
		
		
		
		<div id="mypage_main_warp">

			<!-- 메인1. 유저 프로필(닉네임,메일,근무기업) -->				
			<div id="mypage_main_user_profile">
	      		<c:set var = "user_auth" scope = "session" value = "${user_auth}" /> 	<!-- 유저의 계급을 수신. -->
	      		<c:choose>
	        		<c:when test = "${user_auth eq 'RM' }">								<!-- 정회원 프로필 -->
						<div id="mypage_main_user_profile_nick_and_mail"> 	
							<div style="display: inline-block;">
								<div>
									${user_nickName }
								</div>
								<div class="mypage_option_align_target_right" style="display: inline;">
									<a><i class="user circle icon"></i></a>
								</div>
							</div>
				
							<div>정회원 이메일</div>
							<div>소속 기업명</div>
						</div>
				
						<div id="mypage_main_user_activity"> 				<!-- 유저의 토픽/기업리뷰/연봉탭 관련 활동안내 리스트 -->
						</div>
	   		    	</c:when>
	         		
	        		<c:when test = "${user_auth eq 'NM' }">
						<div id="mypage_main_user_profile_nick_and_mail"> 	<!-- 유저의 프로필 -->
							<div class="mypage_common_font">회원 닉네임</div>
							<div><a><i class="user circle icon"></i></a></div>
							<div class="mypage_common_font">회원 이메일</div>
							<div class="mypage_common_font">（汎用のメール）</div>
						</div>
				
						<div id="mypage_main_user_activity"> 				<!-- 유저의 토픽/기업리뷰/연봉탭 관련 활동안내 리스트 -->
						</div>
	        	 	</c:when>
	         		
	         		<c:otherwise>
						<!-- 로그인 않은 상태로 파악. alert창 알림 후 로그인페이지로 이동처리. -->
	         		</c:otherwise>

	      		</c:choose>
			</div>
						
			<!-- main구성 : 2.각종 버튼탭(버튼모음) -->
			<div id="mypage_buttontap"> 
				<div id="mypage_buttontap_account_update"> <!-- 버튼탭1. 계정정보변경(기업메일인증, 연봉) -->

				</div> 
				
				<div id="mypage_buttontap_invite_and_weblogin"> <!-- 버튼탭2. 타인초대 및 웹로그인 -->

				</div> 

				<div id="mypage_buttontap_writedpost_and_bookmark"> <!-- 버튼탭3. 로그인한 회원이 작성한 포스트/기업리뷰, 즐겨핯기한 포스트 리스트출력-->

				</div> 

				<div id="mypage_buttontap_writedpost_and_bookmark"> <!-- 버튼탭4. 고객센터-->

				</div> 


			</div>
			
		</div>

		

	</div>
</body>
</html>