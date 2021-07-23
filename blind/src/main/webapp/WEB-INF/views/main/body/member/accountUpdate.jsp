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
	/*@media screen and (max-width:1799px) {
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
	}*/
	
	
	/* 1. 마이페이지 전체 일괄적용css ---------------------------------------------------------------------- */
	/* 1.1. 마이페이지 전체를 감싸는 div */
	#mypage_wrap{ 				
		text-align:center;	 		/*자식 div에게 'display: inline-block;' 속성을 줘야 가운데 정렬이 적용된다.*/
		width:50%;
	}	

	/* 1.2. <a>태그의 설정. */
	a {
	  text-decoration-line: none;	/*<a>의 밑줄속성 삭제*/
	}
	
	/* 1.3.폰트 옵션 모음*/
	 .mypage_common_font{
	 	font-size: 1.2em;
	 }
	
	
	
	/* 2.헤더부분 css ------------------------------------------------------------------------------ */
	.mypage_header{
		font-size: 2.5em;
		margin:2%;
	}

	
	/* 3.메인(유저프로필, 버튼들) -----------------------------------------------------------------------*/

	/* 3.0. 메인 전체를 적용 */
	.mypage_main_wrap{
		text-align:center; 					/*내부에 배치되는 중앙정렬할 div에게 display: inline-block; 속성을 줘야 적용된다.*/
	}


	/* 3.1. 메인-유저프로필(닉네임,이메일,소속기업명 출력부분) */
	#mypage_main_user_profile {
		display: inline-block;  					/*div의 중앙 정렬을 위한 설정.*/
		height:auto;
		width:100%;
		background-color: #71736e;
		font-size: 1.5em;
	}
	
	.mypage_main_user_profile_style_wrap{ 		/*버튼 각각의 바탕배경색 및 간격설정. mypage_button_style_button_name과 mypage_button_style_button_icon을 감싸는 역할.*/
		background-color: #444444; 
		margin: 2%; 
		padding: 1.5%;			
	} 	

	.mypage_main_user_profile_style_nick_names{ /* 유저모양의 아이콘이 우측으로 정렬할 수 있도록 라인설정*/
		text-align:left;
		position:absolute;
		margin: 2%;
	} 	
	
	.mypage_main_user_profile_style_user_icon{ /*'>'아이콘의 정렬 및 폰트크기 설정.*/
		text-align: right;
		font-size: 2em;
		margin-top : 5%;
		margin-right : 2%; 
	} 
	
	.mypage_main_user_profile_style_company_names{ 
		text-align:left;
		margin: 2%;
	} 	

	.mypage_main_textmargin{ /**/
		font-size: 1.0em;
		
		margin-left: -15%;
		margin-top: 7%;
	}



	.mypage_buttontap_name{ /*각 버튼탭들의 정렬설정(좌측정렬)*/
		text-align:left;
		margin:3%;
	}

	.mypage_buttontap_wrap{ /*버튼탭 내에 배치되는 버튼명과 '>'아이콘을 묶어주는 영역*/
		text-align:left;
		margin:3%;
	}

	.mypage_button_style_wrap{ 		/*버튼 각각의 바탕배경색 및 간격설정. mypage_button_style_button_name과 mypage_button_style_button_icon을 감싸는 역할.*/
		background-color: #ffffff; 
		margin: 2%; 
		padding: 1.5%;			
		cursor: pointer;
	} 	

	.mypage_button_style_button_name{ /* 버튼의 '>'아이콘이 우측으로 정렬할 수 있도록 라인설정*/
		display: inline-block;
		position:absolute;" 
	} 	
	
	.mypage_button_style_button_icon{ /*'>'아이콘의 정렬 및 폰트크기 설정.*/
		text-align: right;
		font-size: 1.5em;
	} 


	</style>


	<script>
		$(function(){ 		
        	$("#intro_popup_service_center").on("click", function(){
        		alert("고객 센터에 연락주세요.");	
        	})  	
		});
	
	</script>
</head>


<body>
	<div id="mypage_wrap" >
		<div class="mypage_header">
			<div style="display: inline-block; position:absolute;">
				アカウントの情報変更
			</div>	
			<div class="mypage_button_style_button_icon">	
				<a><i class="sign out alternate icon"></i></a>
			</div>
		</div>
		<div id="mypage_main_wrap">
			<div style="text-align:left;">
				パスワード変更
			</div>
		
			<div id="mypage_button_update_certification_and_income"
				 style="background-color: #71736e;">
				<div class="mypage_buttontap_name">												
					현재의 패스워드
				</div>	
		
				<div class="mypage_buttontap_wrap"> 												
					<div class="mypage_button_style_wrap"
						 style="margin:-3%;"> 	
						<div class="mypage_button_style_button_name"> 	
							현재의 비밀번호 입력창(텍스트) 
						</div>
					</div>	
				</div>
						
				<div class="mypage_buttontap_wrap"> 												
					<div class="mypage_button_style_wrap"
						 style="margin:-3%;"> 	
						<div class="mypage_button_style_button_name"> 	
							현재의 비밀번호 일치여부(라벨)
						</div>
					</div>
				</div>

			<div id="mypage_button_update_certification_and_income"
				 style="background-color: #71736e;">
				<div class="mypage_buttontap_name">												
					새로운 패스워드
				</div>	
		
				<div class="mypage_buttontap_wrap"> 												
					<div class="mypage_button_style_wrap"
						 style="margin:-3%;"> 	
						<div class="mypage_button_style_button_name"> 	
							신규로 설정할 비밀번호 입력창(텍스트) 
						</div>
					</div>	
				</div>
						
				<div class="mypage_buttontap_wrap"> 												
					<div class="mypage_button_style_wrap"
						 style="margin:-3%;"> 	
						<div class="mypage_button_style_button_name"> 	
							신규로 설정할 비밀번호의 입력 조건 만족여부 체크(라벨)
						</div>
					</div>
				</div>

			<div id="mypage_button_update_certification_and_income"
				 style="background-color: #71736e;">
				<div class="mypage_buttontap_name">												
					새로운 패스워드
				</div>	
		
				<div class="mypage_buttontap_wrap"> 												
					<div class="mypage_button_style_wrap"
						 style="margin:-3%;"> 	
						<div class="mypage_button_style_button_name"> 	
							신규로 설정할 비밀번호 입력창(텍스트) 
						</div>
					</div>	
				</div>
						
				<div class="mypage_buttontap_wrap"> 												
					<div class="mypage_button_style_wrap"
						 style="margin:-3%;"> 	
						<div class="mypage_button_style_button_name"> 	
							신규로 설정할 비밀번호의 입력 조건 만족여부 체크(라벨)
						</div>
					</div>
				</div>

			</div>	
		</div>
	</div>
	
</body>
</html>