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
    a { text-decoration: none; color: black; }
    a:visited { text-decoration: none;color: black;  }
    a:hover { text-decoration: none; color: black; }
    a:focus { text-decoration: none; color: black; }
    a:hover, a:active { text-decoration: none; color: black; }
	
	
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
	#mypage_main_user_profile{
		display: inline-block;  					/*div의 중앙 정렬을 위한 설정.*/
		height:auto;
		width:100%;
		background-color: #71736e;
		font-size: 1.5em;
	}
	
	.mypage_main_user_profile_style_wrap{ 		/*버튼 각각의 바탕배경색 및 간격설정. mypage_button_style_button_name과 mypage_button_style_button_icon을 감싸는 역할.*/
		margin: 2%; 
		padding: 3%;
		padding-bottom: 7%;
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
		cursor: pointer;
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
		padding-top: 2.5%;		/*vertical-align: middle; 처럼 정중앙배치 효과위해 적용.*/	
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
		//신고안내 팝업창
		$(function(){ 		
        	$("#intro_popup_service_center").on("click", function(){
        		alert("service@blind.comにメールを送ってください。");	
        	});

    		//5. 로그아웃 실시
    		$("#logout").on('click', function(){	
    			$.ajax({
    				type:"POST",
    			    url: "logout",
    				success: function(result){
    					alert("ログアウトを完了しました。");
    					location.replace(result.url);  //로그인 페이지로 이동하도록실시.
    				},
    				error: function(){
    					alert("エラー");
    				}				
    			});
    		}); 
			
		}); 	
	</script>
</head>


<body>
	<div id="mypage_wrap" >
		<div class="mypage_header">
			<div style="display: inline-block; position:absolute;">
				My Page
			</div>	
			<div class="mypage_button_style_button_icon" id="logout">	
				<i class="sign out alternate icon"></i>	<!-- logout Button -->
			</div>
		</div>
		<div id="mypage_main_wrap">
			<div id="mypage_main_user_profile">					<!-- 메인1. 유저 프로필(닉네임,메일,근무기업) -->				
				<div class="mypage_main_user_profile_style_wrap"> 
					<div style="position: inherit; float:left; color:#ffffff;">
						${user_nick_name}
					</div>
							
					<div class="ui secondary button" style=" position: inherit; float:right; font-size:1em;"
						 onclick="location.href='${pageContext.request.contextPath}/accountUpdate';"> 	
						 	<i class="user circle icon"></i> <!-- 유저 아이콘(font-size 통해 크기조절) -->
							情報修正	
					</div>
				</div>
				
				<div id="mypage_main_Explanation" style="float:right; text-align: center;"> 	<!-- 일반회원은 인증이 필요하다는 안내페이지로 대체. -->
					<div style="background-color: #444444; width:95%;  display: inline-block;">	<!--지정컬러로 바탕을 칠하기 위한 div영역설정 -->
						<div style=" width:65%; display: inline-block; margin-top: 5%;margin-bottom: 5%;"> <!-- 텍스트들을 배치하기 위한 div -->
						
							<div style="margin-left:13%; margin-top:10%; vertical-align:bottom ; ">
								<div style="float:left; vertical-align: bottom; margin-top:5%;">
									<i class="lock icon"  style="float:left; font-size: 2.5em; position:static; color:#ffffff;"></i>
								</div>
						
								<div style="width:70%; color:#ffffff;">
									企業のメールで認証して正會員にならば、全サービスを利用することができます。
								</div>
							</div>

							<div style="margin-left: 25%; margin-top: 10%; text-align: left;"> <!-- 회사메일 인증시 가능한 사항들 목록. -->
								<div class="mypage_main_textmargin" style="color:#ffffff;">
									<i class="check circle icon" style="color:#ffffff;"> </i>
									トピックにポストを書く
								</div>
			
								<div class="mypage_main_textmargin"  style="color:#ffffff;">
									<i class="check circle icon" style="color:#ffffff;"></i>
									企業のレビューを読む
								</div>
								
								<div class="mypage_main_textmargin" style="color:#ffffff;">
									<i class="check circle icon" style="color:#ffffff;"></i>
									企業のレビューを書く
								</div>
					
								<div class="mypage_main_textmargin" style="color:#ffffff;">
									<i class="check circle icon" style="color:#ffffff;"></i>
									給料のランクに給料登録や確認
								</div>		
							</div>									
								
							<button class="ui primary button" style="margin:5%;"
									 onclick="location.href='${pageContext.request.contextPath}/certification';"> 	
								正會員認証を始める
							</button>
						</div>
					</div>						
				</div>
	   		 		
				<div id="mypage_button_warp" style="margin-top: 70%;"> 			<!-- main구성 : 2.각종 버튼탭(버튼모음) -->
					<div id="mypage_button_update_	certification_and_income">
						<div class="mypage_buttontap_name" style="color:#ffffff;">											
							アカウントの情報変更
						</div>	
						<div class="mypage_buttontap_wrap"> 												
							<div class="mypage_button_style_wrap"
			 					 onclick="location.href='${pageContext.request.contextPath}/certification';"> 	
								<div class="mypage_button_style_button_name"> 	
									企業メールを認証する
								</div>
								<div class="mypage_button_style_button_icon">	
									<i class="chevron right icon"></i>
								</div>											
							</div>
		
							<div class="mypage_button_style_wrap"
								 onclick="location.href='${pageContext.request.contextPath}/registerAnnualIncome';"> 					
								<div class="mypage_button_style_button_name"> 								
									私の年俸ランキング
								</div>
								<div class="mypage_button_style_button_icon">
									<i class="chevron right icon"></i>
								</div>								
							</div>							
						</div>
					</div>	
	
					<div id="mypage_buttontap_invite_and_weblogin"> <!-- 버튼탭2. 타인초대 및 웹로그인 -->
						<div class="mypage_buttontap_name" style="color:#ffffff;">
							招待、Webログイン
						</div>	
						<div class="mypage_buttontap_wrap"> 												
							<div class="mypage_button_style_wrap"
								 onclick="location.href='${pageContext.request.contextPath}/invite';"> 												
								<div class="mypage_button_style_button_name">
									招待する
								</div>
								<div class="mypage_button_style_button_icon">	
									<i class="chevron right icon"></i>
								</div>											
							</div>
		
							<div class="mypage_button_style_wrap"> 	
								<div class="mypage_button_style_button_name"
									 onclick="location.href='${pageContext.request.contextPath}/webLogin';"> 																						
									Webブラウザログイン
								</div>
								<div class="mypage_button_style_button_icon">
									<i class="chevron right icon"></i>
								</div>								
							</div>							
						</div>
					</div>	
	
					<div id="mypage_buttontap_writedpost_and_bookmark"> <!-- 버튼탭3. 로그인한 회원이 작성한 포스트/기업리뷰, 즐겨핯기한 포스트 리스트출력-->
						<div class="mypage_buttontap_name" style="color:#ffffff;">												
							私が書いたポスト、ブックマーク
						</div>	
						
						<div class="mypage_buttontap_wrap"> 												
							<div class="mypage_button_style_wrap"
								 onclick="location.href='${pageContext.request.contextPath}/viewListWritedPost';"> 					
								<div class="mypage_button_style_button_name">
									私が書いたポスト
								</div>
								<div class="mypage_button_style_button_icon">	
									<i class="chevron right icon"></i>
								</div>											
							</div>
		
							<div class="mypage_button_style_wrap"
								 onclick="location.href='${pageContext.request.contextPath}/viewListMyBookmark';"> 												
								<div class="mypage_button_style_button_name"> 								
									ブックマーク
								</div>
								<div class="mypage_button_style_button_icon">
									<i class="chevron right icon"></i>
								</div>								
							</div>							
						
							<div class="mypage_button_style_wrap"
								 onclick="location.href='${pageContext.request.contextPath}/viewListWritedCompanyReview';"> 		
								<div class="mypage_button_style_button_name"> 								
									企業レビュー
								</div>
								<div class="mypage_button_style_button_icon">
									<i class="chevron right icon"></i>
								</div>								
							</div>
														
						</div>
					</div> 
	
					<div id="mypage_buttontap_service_center"> <!-- 버튼탭4. 고객센터-->
						<div class="mypage_buttontap_name" style="color:#ffffff;"> 												
							カスタマーセンター
						</div>	
						
						<div class="mypage_buttontap_wrap"> 	
							<div class="mypage_button_style_wrap" id="intro_popup_service_center">
								<div class="mypage_button_style_button_name"> 		
									お問い合わせ・バグの報告
								</div>
								<div class="mypage_button_style_button_icon">	
									<i class="chevron right icon"></i>
								</div>											
							</div>
							
							<div class="mypage_button_style_wrap"
									 onclick="location.href='${pageContext.request.contextPath}/viewMyAlertList';"> 
								<div class="mypage_button_style_button_name">
									申告した内容/申告された内容を確認
								</div>
								<div class="mypage_button_style_button_icon">
									<i class="chevron right icon"></i>
								</div>								
							</div>	
						</div>	
					</div>				 
				</div>
				
				
			</div>
		</div>
	</div>
	
</body>



</html>