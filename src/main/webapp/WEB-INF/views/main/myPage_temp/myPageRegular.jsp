<%@ page contentType="text/html; charset=UTF-8" %>
<style>
	<%--사용하는 기기의 스크린화면별 동적CSS--%>
	<%--@media screen and (max-width:1799px) {
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
	}--%>


	<%-- 1. 마이페이지 전체 일괄적용css ---------------------------------------------------------------------- --%>
	<%-- 1.1. 마이페이지 전체를 감싸는 div --%>
	#mypage_wrap{
		text-align:center; <%--자식 div에게 'display: inline-block;' 속성을 줘야 가운데 정렬이 적용된다.--%>
		width:50%;
	}

	<%-- 1.2. <a>태그의 설정. --%>
    a { text-decoration: none; color: black; }
    a:visited { text-decoration: none;color: black;  }
    a:hover { text-decoration: none; color: black; }
    a:focus { text-decoration: none; color: black; }
    a:hover, a:active { text-decoration: none; color: black; }


	<%-- 1.3.폰트 옵션 모음--%>
	 .mypage_common_font{
	 	font-size: 1.2em;
	 }



	<%-- 2.헤더부분 css ------------------------------------------------------------------------------ --%>
	.mypage_header{
		font-size: 2.5em;
		margin:2%;
	}


	<%-- 3.메인(유저프로필, 버튼들) -------------------------------------------------------------------------%>

	<%-- 3.0. 메인 전체를 적용 --%>
	.mypage_main_wrap{
		text-align:center; <%--내부에 배치되는 중앙정렬할 div에게 display: inline-block; 속성을 줘야 적용된다.--%>
	}


	<%-- 3.1. 메인-유저프로필(닉네임,이메일,소속기업명 출력부분) --%>
	#mypage_main_user_profile{
		display: inline-block; <%--div의 중앙 정렬을 위한 설정.--%>
		height:auto;
		width:100%;
		background-color: #71736e;
		font-size: 1.5em;
	}

	.mypage_main_user_profile_style_wrap{ <%--버튼 각각의 바탕배경색 및 간격설정. mypage_button_style_button_name과 mypage_button_style_button_icon을 감싸는 역할.--%>
		margin: 2%;
		padding: 3%;
		padding-bottom: 7%;
	}

	.mypage_main_user_profile_style_nick_names{ <%-- 유저모양의 아이콘이 우측으로 정렬할 수 있도록 라인설정--%>
		text-align:left;
		position:absolute;
		margin: 2%;
	}

	.mypage_main_user_profile_style_user_icon{ <%--'>'아이콘의 정렬 및 폰트크기 설정.--%>
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

	.mypage_main_textmargin{ <%----%>
			font-size: 1.0em;
			margin: 3%;
	}

	.mypage_main_user_profile_style_textalign_left{ <%-- 유저의 프로필 정보 토픽/기업리뷰/연봉랭크들의 글을 정렬. --%>
		text-align:left;
		margin:4%;
	}

	.mypage_buttontap_name{ <%--각 버튼탭들의 정렬설정(좌측정렬)--%>
		text-align:left;
		margin:3%;
	}

	.mypage_buttontap_wrap{ <%--버튼탭 내에 배치되는 버튼명과 '>'아이콘을 묶어주는 영역--%>
		text-align:left;
		margin:3%;
	}

	.mypage_button_style_wrap{ <%--버튼 각각의 바탕배경색 및 간격설정. mypage_button_style_button_name과 mypage_button_style_button_icon을 감싸는 역할.--%>
		background-color: #ffffff;
		margin: 2%;
		padding: 1.5%;
		cursor: pointer;
		padding-top: 2.5%; <%--vertical-align: middle; 처럼 정중앙배치 효과위해 적용.--%>
	}

	.mypage_button_style_button_name{ <%-- 버튼의 '>'아이콘이 우측으로 정렬할 수 있도록 라인설정--%>
		display: inline-block;
		position:absolute;"
	}

	.mypage_button_style_button_icon{ <%--'>'아이콘의 정렬 및 폰트크기 설정.--%>
		text-align: right;
		font-size: 1.5em;
	}
</style>

<div id="mypage_wrap" >
	<div class="mypage_header">
		<div style="display: inline-block; position: absolute;">My Page</div>
		<div class="mypage_button_style_button_icon" id="logout">
			<i class="sign out alternate icon"></i>	<%-- logout Button --%>
		</div>
	</div>
	<div id="mypage_main_wrap">
		<div id="mypage_main_user_profile"> <%-- 메인1. 유저 프로필(닉네임,메일,근무기업) --%>
			<div class="mypage_main_user_profile_style_wrap">
				<div style="position: inherit; float: left; color: #ffffff;">${user_nick_name}</div>

				<div class="ui secondary button" style=" position: inherit; float: right; font-size: 1em;"
						onclick="location.href='member/accountUpdate';">
					<i class="user circle icon"></i> <%-- 유저 아이콘(font-size 통해 크기조절) --%>
					情報修正
				</div>
			</div>

			<div style="background-color: #444444; width: 95%;  display: inline-block;"> <%--지정컬러로 바탕을 칠하기 위한 div영역설정 --%>
				<div style=" width:100%; display: inline-block; margin-top: 2%; margin-bottom: 2%;"> <%-- 텍스트들을 배치하기 위한 div --%>
					<div id="mypage_main_user_activity" class="mypage_main_user_profile_style_textalign_left"
								style="color: #ffffff;"> <%-- 유저의 토픽/기업리뷰/연봉탭 관련 활동안내 리스트 --%>
						私の最近の活動と結果です。
						<div class="mypage_main_user_profile_style_textalign_left" style="color: #ffffff;">
							トピック
							<div class="mypage_main_user_profile_style_textalign_left" style="color: #ffffff;">
								 - 今月間書いたポストの数は ${user_post_counts_this_month} 個
							</div>
							<div class="mypage_main_user_profile_style_textalign_left" style="color: #ffffff;">
								- 今月間もらった「好きです」は ${like_count_this_month}個
							</div>
						</div>
						<div class="mypage_main_user_profile_style_textalign_left">
							給料ランク
							<div class="mypage_main_user_profile_style_textalign_left">
								- 今月間給料ランクの順位が上位 ${my_rank_percent} ％中に入りました！
							</div>
						</div>
					</div>
				</div>
			</div>


			<div id="mypage_button_warp"> <%-- main구성 : 2.각종 버튼탭(버튼모음) --%>
				<div id="mypage_button_update_certification_and_income">
					<div class="mypage_buttontap_name" style="color: #ffffff;">
						アカウントの情報変更
					</div>
					<div class="mypage_buttontap_wrap">
						<div class="mypage_button_style_wrap" onclick="location.href='member/certification';">
							<div class="mypage_button_style_button_name">
								企業メールを認証する
							</div>
							<div class="mypage_button_style_button_icon">
								<i class="chevron right icon"></i>
							</div>
						</div>

						<div class="mypage_button_style_wrap" onclick="location.href='member/registerAnnualIncome';">
							<div class="mypage_button_style_button_name">
								私の年俸ランキング
							</div>
							<div class="mypage_button_style_button_icon">
								<i class="chevron right icon"></i>
							</div>
						</div>
					</div>
				</div>

				<div id="mypage_buttontap_invite_and_weblogin"> <%-- 버튼탭2. 타인초대 및 웹로그인 --%>
					<div class="mypage_buttontap_name" style="color: #ffffff;">
						招待、Webログイン
					</div>
					<div class="mypage_buttontap_wrap">
						<div class="mypage_button_style_wrap" onclick="location.href='member/invite';">
							<div class="mypage_button_style_button_name">
								招待する
							</div>
							<div class="mypage_button_style_button_icon">
								<i class="chevron right icon"></i>
							</div>
						</div>

						<div class="mypage_button_style_wrap">
							<div class="mypage_button_style_button_name" onclick="location.href='member/login';">
								Webブラウザログイン
							</div>
							<div class="mypage_button_style_button_icon">
								<i class="chevron right icon"></i>
							</div>
						</div>
					</div>
				</div>


				<div id="mypage_buttontap_writedpost_and_bookmark"> <%--버튼탭3. 로그인한 회원이 작성한 포스트/기업리뷰, 즐겨핯기한 포스트 리스트출력--%>
					<div class="mypage_buttontap_name" style="color: #ffffff;">私が書いたポスト、ブックマーク</div>

					<div class="mypage_buttontap_wrap">
						<div class="mypage_button_style_wrap"
							 onclick="location.href='memeber/viewListWritedPost';">
							<div class="mypage_button_style_button_name">
								私が書いたポスト
							</div>
							<div class="mypage_button_style_button_icon">
								<i class="chevron right icon"></i>
							</div>
						</div>

						<div class="mypage_button_style_wrap" onclick="location.href='bookmark';">
							<div class="mypage_button_style_button_name">
								ブックマーク
							</div>
							<div class="mypage_button_style_button_icon">
								<i class="chevron right icon"></i>
							</div>
						</div>

						<div class="mypage_button_style_wrap" onclick="location.href='member/viewListWritedCompanyReview';">
							<div class="mypage_button_style_button_name">
								企業レビュー
							</div>
							<div class="mypage_button_style_button_icon">
								<i class="chevron right icon"></i>
							</div>
						</div>

					</div>
				</div>

				<div id="mypage_buttontap_service_center"> <%-- 버튼탭4. 고객센터--%>
					<div class="mypage_buttontap_name" style="color: #ffffff;">カスタマーセンター</div>

					<div class="mypage_buttontap_wrap">
						<div class="mypage_button_style_wrap" id="intro_popup_service_center">
							<div class="mypage_button_style_button_name">
								お問い合わせ・バグの報告
							</div>
							<div class="mypage_button_style_button_icon">
								<i class="chevron right icon"></i>
							</div>
						</div>

						<div class="mypage_button_style_wrap" onclick="location.href='member/viewMyAlertList';">
							<div class="mypage_button_style_button_name">
								通報した内容/通報された内容を確認
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

<script>
	<%--신고안내 팝업창--%>
	$(function() {
		$("#intro_popup_service_center").on("click", function() {
			alert("service@blind.comにメールを送ってください。");
		});

		<%--5. 로그아웃 실시--%>
		$("#logout").on('click', function() {
			$.ajax({
				type:"POST",
				url: "member/logout",
				success: function(result) {
					<%--alert("ログアウトを完了しました。");--%>
					location.replace(result.url);  <%--로그인 페이지로 이동하도록실시.--%>
				},
				error: function() {
					<%--alert("エラー");--%>
					location.replace(result.url);  <%--컨트롤러에서 로그아웃 처리되었으므로 로그인페이지로 이동처리.--%>
				}
			});
		});

	});
</script>