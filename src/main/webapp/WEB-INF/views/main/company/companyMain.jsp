<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.companysearchbox {
		padding: 60px;
		align: center;
	}

	.companysearchbox p {
		font-size: 17px;
	}

	#searchKeyword {
		border-radius: 50px;
		border-color: black;
	}

	#searchKeyword::placeholder {
		font-size: 15px;
		padding-left: 15px;
	}

	#box {
		width: 65%;
		padding: 30px 0;
	}

	.companyapplymain a {
		color: black;
	}

	#apply {
		text-decoration: underline;
	}

	#companybackground {
		background-color: #ebf7fa;
		height: 270px;
		margin-top: 30px;
	}

	#imagetextback {
		background: url(resources/images/companymainjp.png) 0 0 no-repeat;
		height: 320px;
		top: -45px;
		background-position: 480px 0;
		background-size: 618px 320px;
		position: relative;
	}

	#searchicon {
		padding-left: 70px;
	}

	.bestcompanyname {
		font-size: 15px;
		font-weight: 700;
		color: black;
	}

	.div_star {
		padding-top: 6px;
	}

	.div_tab {
		padding-top: 8px;
	}

	.div_tab a {
		font-size: 13px;
		padding-left: 11px;
	}

	.div_tab a:first-child {
		padding-left: 0px;
	}

	#bestcompanygrid .column:last-child {
		margin-bottom: 100px;
	}

	<%-- 기업등록신청(BLIND_0013_企業登録申請) 모달창 css --%>
	#request_company_register_modal { <%--기업등록 신청 모달창의 크기등을 설정.--%>
		display: none;
		width: 40%;
		height: auto;
		padding: 20px 20px;
		background-color: #ffffff;
		border-radius: 3px;
	}

	#request_company_register_modal div { <%--request_company_register_modal 내의 모든 div 옵션--%>
		list-style: none;
		margin-bottom: 15px;
	}
</style>

<div class="ui container">
	<div class="companysearchbox" align="center">
		<h1>現職者たちの会社レビュー。</h1>
		<p>実際の職員たちが評価する年俸と福祉はどうなのか確認してみてください。</p>

		<div class="ui fluid big left icon input" id="box">
			<input class="prompt" type="text" id="searchKeyword" oninput="searchCompany(this.value.trim())"
					placeholder="会社の名前を入力してください。">
			<i class="search icon" id="searchicon"></i>
			<div class="ui middle aligned selection list" id="selectList" style="margin-top: 65px; font-size: 0.8em;
					background-color: #999999; position: absolute; margin-left: 60px;"></div>
		</div>

		<div class="companyapplymain" align="center">
			お探しの会社がありませんか。
		<span id="apply" onclick="requestCompanyRegisterModalStart()" style="cursor: pointer">
			知りたい会社を直接申し込んでください。
		</span>
		</div>
	</div>
</div>

<div class="ui fluid container" id="companybackground">
	<div class="ui container" id="imagetextback">
		<h2 style="text-align: left; padding-top: 130px;">私の会社をレビューする</h2>

		<p style="text-align: left;">会員様のレビューは、求職者が会社を 検討するのに役立ちます。</p>
		<button class="ui blue button" onclick="location.href='company/review'"
				style="float: left; margin-top: 10px; padding: 15px 30px;">レビュー作成
		</button>
	</div>
</div>

<div class="ui container" style="padding-top: 75px;">
	<h3 align="left" style="font-size: 20px;">ベスト会社</h3>
	<div class="ui three column grid" style="padding-top: 30px;" id="bestcompanygrid">

		<c:forEach var="company" items="${popularCompanyList}">
			<div class="column"><%--회사--%>
				<div class="ui segment">
					<div style="display: inline-block;">
						<img class="ui tiny left floated image" src="resources/images/company/${company.companyId}.png" >
						<div style="display:inline-block;">
							<a class="bestcompanyname" href="company/introduction/${company.companyId}"
									style="display:inline-block;">${company.companyName}</a>
							<div class="div_star">
								<div class="ui star rating" data-rating="${company.allPoint}"
									 data-max-rating="5"></div>
									${company.realAllPoint}
							</div>
							<div class="div_tab">
								<a class="" href="company/review/${company.companyId}">レビュー</a>
								<a class="" href="#">掲示板</a>
								<a class="" href="company/annualIncome/${company.companyId}">年収</a>
								<a class="" href="#">採用</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>

<%--기업등록신청 모달창--%>
<div id="request_company_register_modal" data-backdrop="static" data-keyboard="false">
	<div align='center'>
		<div> <%-- 모달창의 헤더(제목 및 닫기버튼)배치 --%>
			<h1 style="display: inline;">企業の登録申請</h1>
			<div style="float: right;" id="modal_close_btn">X</div>
		</div>

		<div align='left' style="margin-top: 5%; width: 80%;">  <%-- 작성을 위한 안내멘트 기입. --%>
			<h2>知りたい企業の企業名と、企業のメールを入力してください！</h2>
		</div>

		<div align='center'>
			<div style="margin-top: 5%; width: 80%;">
				<p align="left">企業名</p>
				<div class="ui input" style="width: 100%;">
					<input type="text" placeholder="企業名を入力してください。" id="request_compnay_name" maxlength="25"
						   onKeyup="checkInputTextByte('企業名',document.getElementById('request_compnay_name').value ,25)">
				</div>

				<p align="left">企業のメール</p>
				<div class="ui input" style="width: 100%;">
					<input type="text" placeholder="企業のメールを入力してください。" id="request_compnay_email" maxlength="25"
						   onKeyup="checkInputTextByte('企業のメール',document.getElementById('request_compnay_email').value ,25)">
				</div>

				<button class="ui primary button" id="send_request_company_register"
						style="width: 30%; height: auto; text-align: center; margin-top: 20px;">
					申し込む
				</button>

				<div style="margin-top: 4%;">
					<h3>お申し込みいただいた企業は、担当者の検証手続きに従って登録が進行されます。</h3>
					<%-- 申請された企業は、担当者の確認結果について登録／登録しない。--%>
				</div>
			</div>

		</div>

	</div>
</div>

<script>
	function searchCompany(companyName) {
		if (companyName) {
			fetch("company/search?companyName=" + companyName, {
				method: "GET"
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				}
				throw response.status;
			}).then(function (companyList) {
				let html = "";
				for (const company of companyList) {
					html += "<div style=\"display: flex;\" onclick=\"location.href='company/introduction/" +
							company.companyId + "';\"><img class=\"ui avatar image\" src=\"resources/image/company/" +
							company.companyId + ".png\"><div class=\"content\"><div class=\"header\">" +
							company.companyName + "</div></div></div>";
				}
				document.getElementById("selectList").innerHTML = html;
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
			});
		}
	}

	<%--企業登録申請（BLIND_0013_企業登録申請）モーダルウィンドウのためのajax機能。--%>
	<%--ユーザーが入力したテキストのbyteをチェック。maxsize以上ならストップ。 --%>
	function checkInputTextByte(typeName,inputText,maxSize) {
		if(inputText.length>maxSize) {
			alert(typeName+"の入力は"+maxSize+"字まで入力できます。");
			return false;
		}
		else{
			return true;
		}
	}

	function checkEmailType(inputTextEmail) {
		var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		/*
		if (regEmail.test(inputTextEmail) === true) {
			alert('入力したテキストはe-mailです。');
		}
		else{
			alert('入力したテキストはe-mailじゃありません。');
		}
		*/
		return regEmail.test(inputTextEmail); // 形式に合うならば、trueをreturn。

	}

	<%--1.기업등록신청 모달(request_company_register_modal)-팝업실시.--%>
	function requestCompanyRegisterModalStart() {
		$('#request_company_register_modal').modal({closable: false}); <%--모달밖을 클릭해도 닫히지 않도록 설정.--%>
		$('#request_company_register_modal').modal('show');
	}

	$(function () {
		const $searchKeyword = $("#searchKeyword");

		$searchKeyword.focus(function () {
			$(this).css("border-color", "black");
			$(this).css("border-width", "1px");
		});

		$searchKeyword.blur(function () {
			$(this).css("border-color", "");
			$(this).css("border-width", "");
		});
		$('.ui.rating').rating('disable');

		$searchKeyword.html("会社の名前を入力してください。");

		document.getElementById("send_request_company_register").addEventListener("click", function () {
			const companyName = document.getElementById("request_compnay_name").value.trim();
			const companyDomain = document.getElementById("request_compnay_email").value.trim();

			<%--alert("request_compnay_name :" + request_compnay_name);--%>
			<%--alert("request_compnay_email :" + request_compnay_email);--%>

			<%----%>
			if(!companyName) {
				<%--ユーザーが会社名を入力しなかったら、入力案内文出力と企業登録申請をストップ。--%>
				alert("企業名を入力してください。"); <%--通報内容（選んだラジオボタン）無い時の案内。--%>
				return false;
			}
			if( !checkEmailType(companyDomain) && !(companyDomain == "") ) {　<%--선택된 신고사항이 없기에 선택을 요청--%>
				alert("企業メールを形式に合わせて再入力してください");
				return false;
			}
			else {
				fetch("company", {
					method: "POST",
					headers: {
						"Content-Type": "application/json"
					},
					body: JSON.stringify({
						companyName: companyName,
						companyDomain: companyDomain,
						companyHomepage: "",
						companyExplain: ""
					})
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					}
					throw response.status;
				}).then(function (result) {
					if (result) {
						alert("申込みが完了しました。");
						$('#request_company_register_modal').modal('hide');
					} else {
						alert("システムのエラーです。管理者にお問い合わせください。");
					}
				}).catch(function (error) {
					console.error(error);
					alert("システムのエラーです。管理者にお問い合わせください。");
				});
			}
		});

		$("#modal_close_btn").on("click", function () { <%--신고되면 모달창을 닫도록 함.--%>
			$('#request_company_register_modal').modal('hide');
		});

	});
</script>