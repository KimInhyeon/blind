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
	#mypage_wrap {
		text-align: center; <%--자식 div에게 'display: inline-block;' 속성을 줘야 가운데 정렬이 적용된다.--%>
		width: 50%;
		padding: 2%;
		background-color: #444444;
	}

	<%-- 1.2. <a>태그의 설정. --%>
	a {
		text-decoration: none;
		color: black;
	}

	a:visited {
		text-decoration: none;
		color: black;
	}

	a:hover {
		text-decoration: none;
		color: black;
	}

	a:focus {
		text-decoration: none;
		color: black;
	}

	a:hover, a:active {
		text-decoration: none;
		color: black;
	}

	<%-- 1.3.폰트 옵션 모음--%>
	.mypage_common_font {
		font-size: 1.2em;
	}

	<%-- 2.헤더부분 css ------------------------------------------------------------------------------ --%>
	.mypage_header {
		font-size: 2.5em;
		margin: 2%;
		padding: 4%; <%--내부의 요소들을 정렬위한 여백 설정.--%>
		margin-left: -4%;
		margin-right: -4%;
		margin-top: -4%; <%--배경색을 전체 적용하기 위한 설정.--%>


		background-color: #333333;
	}

	<%-- 3.메인(유저프로필, 버튼들) -------------------------------------------------------------------------%>

	<%-- 3.0. 메인 전체를 적용 --%>
	.mypage_main_wrap {
		text-align: center; <%--내부에 배치되는 중앙정렬할 div에게 display: inline-block; 속성을 줘야 적용된다.--%>
		background-color: red;
	}


	<%-- 3.1. 메인-유저프로필(닉네임,이메일,소속기업명 출력부분) --%>
	.mypage_main_textmargin { <%----%>
		font-size: 1.0em;
		margin-left: -15%;
		margin-top: 7%;
	}


	.mypage_passwordtap_name { <%--각 버튼탭들의 정렬설정(좌측정렬)--%>
		text-align: left;
		margin: 3%;
	}


	.mypage_passwordtap_wrap { <%--버튼탭 내에 배치되는 버튼명과 '>'아이콘을 묶어주는 영역--%>
		text-align: left;
		margin: 3%;
	}

	.mypage_password_style_wrap { <%--버튼 각각의 바탕배경색 및 간격설정. mypage_button_style_button_name과 mypage_button_style_button_icon을 감싸는 역할.--%>
		background-color: #ffffff;
		margin: 2%;
		padding: 1.5%;
		cursor: pointer;
	}

	.mypage_button_style_button_icon { <%--'>'아이콘의 정렬 및 폰트크기 설정.--%>
		display: inline-block;
		float: right;
		font-size: 1.5em;
	}


	<%-- 정회원/일반회원의 가능한 기능을 설명하는 표. --%>
	#intro_user_function {
		margin-left: auto;
		margin-right: auto; <%--테이블 자체 가운데 정렬--%>
		width: auto; <%--테이블의 폭 자동설정--%>

		text-align: center; <%--테이블 내의 택스트 중앙정렬--%>
		<%--margin:--%>
	}


	<%--모달창들의 CSS설정--%>
	<%--1. なぜ企業のメールが必要ですか。 에 대한 설명.--%>
	#guide_agreement_modal {
		display: none;
		width: auto;
		height: auto;
		padding: 20px 20px;
		background-color: #444444;
		border-radius: 10px;
	}

	#guide_agreement_modal div {
		list-style: none;
		margin-bottom: 15px;
	}


	<%--2. 利用規約や個人情報取り扱い  에 대한 설명.--%>
	#guide_privacy_policy_modal {
		display: none;
		width: auto;
		height: auto;
		padding: 20px 20px;
		background-color: #ffffff;
		border-radius: 10px;
	}

	#guide_privacy_policy_modal div {
		list-style: none;
		margin-bottom: 15px;
	}

</style>

<%-- 인증페이지 --%>
<div id="mypage_wrap">
	<div class="mypage_header">
		<div style="display: inline-block; position: absolute; left: 0; font-size: 1.5em;">
			<a href="member/myPage">
				<i class="angle left icon"></i>
			</a>
		</div>

		<div style="display: inline-block; position: relative;">正会員認証ページ</div>
	</div>

	<div id="mypage_main_wrap">
		<div>企業のメールで認証して正會員になり、全サービスを利用してください。</div>
		<table class="ui celled table" id="intro_user_function" style="background-color:#333333; padding: 0.7%;">
			<thead>
			<tr>
				<th style=" background-color: #444444;">
					<%-- (공란/기입내용없음)--%>
				</th>
				<th style="vertical-align: top; padding-top: 5%;">
					<i class="lock icon" style="font-size: 2em;"></i><br>
					汎用のメール<br>
					（yahoo など）
				</th>
				<th style="vertical-align: top; padding-top: 5%; background-color: #A60014; ">
					<i class="lock open icon" style="font-size: 2em;"></i><br>
					企業のメール
				</th>
			</tr>
			</thead>

			<tbody>
			<tr>
				<td style="background-color: #444444;">トピックのポストを読む</td>
				<td style="background-color: #555555;">O</td>
				<td style="background-color: #a85032;">O</td>
			</tr>
			<tr>
				<td style="background-color: #444444;">トピックにポストを書く</td>
				<td style="background-color: #333333;">-</td>
				<td style="background-color: #A60014;">O</td>
			</tr>
			<tr>
				<td style="background-color: #444444;">企業のレビューを読む</td>
				<td style="background-color: #555555;">△</td>
				<td style="background-color: #a85032;">O</td>
			</tr>
			<tr>
				<td style="background-color: #444444;">企業のレビューを書く</td>
				<td style="background-color: #333333;">-</td>
				<td style="background-color: #A60014;">O</td>
			</tr>
			<tr>
				<td style="background-color:#444444;">給料のランク確認</td>
				<td style="background-color:#555555;">△</td>
				<td style="background-color:#a85032;">O</td>
			</tr>
			</tbody>
		</table>
	</div>

	<div class="ui input focus" style="width: 50%; margin-top: 5%;">
		<input type="text" placeholder="企業のメールを入力してください。">
	</div>

	<div>
		<button class="ui primary button" style="margin-top: 5%;" id="sendEmailCertification">ネクスト</button>
	</div>

	<div style="margin-top: 3%;" id="show_guide_agreement">
		<p style="text-decoration: underline; color: #333333; cursor: pointer;">なぜ企業のメールが必要ですか。</p>
	</div>

	<div style="margin-top: 3%;" id="show_guide_privacy_policy">
		<p style="text-decoration:underline; color: #333333; cursor: pointer;">利用規約や個人情報取り扱い</p>
	</div>
</div>

<%--설명 모달창--%>
<%-- 1. なぜ企業のメールが必要ですか。 모달창 --%>
<div id="guide_agreement_modal" data-backdrop="static" data-keyboard="false">
	<div class="warp_alert_modal">
		<div class="inf_title">
			<h2 style="display: inline;">なぜ企業のメールが必要ですか。</h2>
			<div style="float: right;" class="modal_close_btn">X</div>

			<div align="left">정회원 인증시 장점들을 설명하는 내용들을 기재</div>
		</div>
	</div>
</div>

<%-- 2. 利用規約や個人情報取り扱い 모달창 --%>
<div id="guide_privacy_policy_modal" data-backdrop="static" data-keyboard="false">
	<div class="warp_alert_modal">
		<div class="inf_title">
			<h2 style="display: inline;">なぜ企業のメールが必要ですか。</h2>
			<div style="float: right;" class="modal_close_btn">X</div>

			<div align="left">이용약관등을 작성</div>
		</div>
	</div>
</div>

<script>
	<%--2.안내를 위한 모달창 열기/닫기--%>
	$(function () {
		$("#show_guide_agreement").on("click", function () { <%--정회원 메일인증이 필요한 이유에 대한 설명 페이지 모달출력.--%>
			$('#guide_agreement_modal').modal({closable: false}); <%--모달밖을 클릭해도 닫히지 않도록 설정.--%>
			$('#guide_agreement_modal').modal('show');

			$(".modal_close_btn").on("click", function () { <%--신고되면 모달창을 닫도록 함.--%>
				$('#guide_agreement_modal').modal('hide');
			});
		});

		$("#show_guide_privacy_policy").on("click", function () { <%--신고되면 모달창을 닫도록 함.--%>
			$('#guide_privacy_policy_modal').modal({closable: false}); <%--모달밖을 클릭해도 닫히지 않도록 설정.--%>
			$('#guide_privacy_policy_modal').modal('show');


			$(".modal_close_btn").on("click", function () { <%--신고되면 모달창을 닫도록 함.--%>
				$('#guide_privacy_policy_modal').modal('hide');
			});
		});

		<%--본래의 서비스를 이용하려는데 정회원이 아닌관계로 본 인증페이지로 이동한 유저들에게 안내를 위해 사용하는 팝업창.--%>
		if (${explain_flag == 1}) { <%--인증으로 넘기는 컨트롤러에서 플래그값을 넘긴다.--%>
			alert("企業のメールを通じた認証が必要です。");
		}
	});
</script>