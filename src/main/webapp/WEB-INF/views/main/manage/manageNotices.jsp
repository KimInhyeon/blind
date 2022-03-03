<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.ui.grid > .middle.aligned.row {
		padding-bottom: 0;
	}

	.ui.table thead th {
		padding: 0;
	}

	.ui.compact.selection.dropdown {
		font-weight: 700;
		padding: 0;
		text-align-last: center;
	}

	.ui.modal > .actions {
		text-align: center;
	}
	/*編集ボタン*/
	.ui.yellow.button {
		margin: 0;
	}

	/*削除ボタン*/
	.ui.red.button {
		margin: 0;
	}

	/*
    td.center.aligned {
        padding: 0 .2em 0 .2em;
    }

    .ui.container {
        max-width: 40% !important;
    }

    .row.scroll {
        height: 40em;
        overflow: auto;
    }

    th.sequence {
        width: 8%;
    }

    #closedFilter {
        width: 12%;
    }

    #anonymousFilter {
        width: 15%;
    }

    th.edit {
        width: 9%;
    }
    */
</style>

<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<h3 class="ui header">公知事項管理</h3>
		</div>

		<div class="row scroll">
			<table class="ui selectable single line celled table">
				<thead class="center aligned">
				<tr>
					<!--１．順序　-->
					<th class="sequence">順序</th>

					<!--２．公知のタイプ -->
					<th id="noticeTypeFilter">
						<select class="ui compact selection dropdown fluid" onchange="getNoticeListForManagerSelectedColumn()">
							<option value="0">公知タイプ全体</option>
							<option value="1">システム点検（定期）</option>
							<option value="2">システム点検（緊急）</option>
							<option value="3">イベント案内</option>
							<option value="4">新規機能案内</option>
							<option value="5">運営規則公知</option>
						</select>
					</th>

					<!--３．公知の可否 -->
					<th id="noticeStatusFilter">
						<!--   <select id="noticeStatusFilter" class="ui compact selection dropdown fluid"
                                 onchange="getNoticeStatusSelect(this.value)"> -->
						<select class="ui compact selection dropdown fluid" onchange="getNoticeListForManagerSelectedColumn()">
							<option value="2">公知全体</option>
							<option value="0">公知中</option>
							<option value="1">非公知</option>
						</select>
					</th>

					<!--４．作成者 -->

					<th id="wirteManagerFilter">
						作成者
						<!--
						<select class="ui compact selection dropdown fluid" onchange="getNoticeListForManagerSelectedColumn()">
							<option value="0">作成者</option>
						</select>
						-->
					</th>

					<!--５．公知事項のタイトル -->
					<th>公知事項のタイトル</th>

					<!--６．編集ボタン -->
					<th class="edit">編集</th>

					<!--７．削除ボタン -->
					<th class="delete">削除</th>
				</tr>
				</thead>

				<tbody>
				<c:forEach var="notice" items="${noticeList}">
					<c:set var="index_no" value="${index_no+1}"/>
					<tr>
						<!--１．順序　-->
						<!-- <td class="right aligned"> ${index_no} </td> -->
						<td class="right aligned" data-id="${notice.noticeId}">${index_no}</td>

						<!--２．公知のタイプ -->
						<td class="center aligned" data-value="${notice.noticeTypeCode}">
							<c:choose>
								<c:when test="${notice.noticeTypeCode eq '1'}">システム点検（定期）</c:when>
								<c:when test="${notice.noticeTypeCode eq '2'}">システム点検（緊急）</c:when>
								<c:when test="${notice.noticeTypeCode eq '3'}">イベント案内</c:when>
								<c:when test="${notice.noticeTypeCode eq '4'}">新規機能案内</c:when>
								<c:when test="${notice.noticeTypeCode eq '5'}">運営規則公知</c:when>
								<c:otherwise>ERROR</c:otherwise>
							</c:choose>
						</td>

						<!--３．公知の可否 -->
						<td class="center aligned" data-value="${notice.noticeBlindFlag}">
							<c:choose>
								<c:when test="${notice.noticeBlindFlag eq '0'}">公知中</c:when>
								<c:when test="${notice.noticeBlindFlag eq '1'}">非知中</c:when>
								<c:otherwise>ERROR</c:otherwise>
							</c:choose>
						</td>

						<!--４．作成者 -->
						<td class="center aligned">${notice.userNickname}</td>

						<!--５．公知事項のタイトル -->
						<td>${notice.noticeTitle}</td>

						<!--６．編集ボタン -->
						<td class="center aligned">
							<button class="ui yellow button"
									onclick="openNoticeModal(${notice.noticeId},${notice.noticeTypeCode},${notice.noticeBlindFlag},
															'${notice.noticeTitle}','${notice.noticeContents}' );">
								編集
							</button>
						</td>

						<!--７．削除ボタン -->
						<td class="center aligned">
							<button class="ui gray button" onclick="openDeleteNoticeModal( ${notice.noticeId} );">削除</button>
						</td>

					</tr>
				</c:forEach>
				</tbody>

				<!--　データ（公知事項）が無い時の出力。　-->
				<script>
					(function () {
						const tbody = document.querySelector("tbody");
						if (tbody.childElementCount < 1) {
							tbody.innerHTML =
									"<tr><td class=\"center aligned\" colspan=\"5\">データ（公知事項）が存在しません。</td></tr>";
						}
					}());
				</script>
			</table>
		</div>

		<!--　新規（新しい公知事項作成）ボタン　-->
		<div class="row">
			<div class="three wide column right floated right aligned">
				<button class="ui grey button"
						onclick="openNoticeModal(0,0,1,'','');">
					新規
				</button>
			</div>
		</div>

		<!--　本文ページは終わり。下はmodalのレイアウト。-->

		<!--　公知事項を管理（新規/編集）するmodal。（新規/編集ボタンを押すと出力する。）-->
		<!--　まだ未完成。「ポスト作成」を参考してUIの統一なるようにする。-->
		<div class="ui tiny modal" id="noticeModal"
			 style="width:1000px; height:500px;">
			<!--画面を閉めるボタン、登録ボタンが配置。 -->
			<div class="header">
				<div class="ui grid middle aligned">
					<div class="two wide column left aligned">
						<i class="close link icon" id="closeNoticeModal"></i>
					</div>
					<div class="twelve wide column center aligned">公知事項作成</div>
					<div class="two wide column right aligned">
						<button class="ui positive button" id="noticeSubmit">登録</button>
					</div>
				</div>
			</div>
			<!--登録する公知事項のタイプ選択、タイトルと本文の作成ができる。　-->
			<div class="scrolling content">
				<div class="ui big form">
					<div class="field">
						<!--登録する公知事項のタイプ選択　-->
						<select class="ui compact selection dropdown fluid"
								id="noticeTypeCodeOfmodal" style="width:100%;">
							<option value="0">公知タイプ全体</option>
							<option value="1">システム点検（定期）</option>
							<option value="2">システム点検（緊急）</option>
							<option value="3">イベント案内</option>
							<option value="4">新規機能案内</option>
							<option value="5">運営規則公知</option>
						</select>
					</div>
					<!--公知事項のタイトル作成ができる。　-->
					<div class="field">
						<input type="text" placeholder="登録する公知事項のタイトルを入力してください" id="noticeTitleOfmodal">
					</div>

					<!-- タイトルのテキストバクスと、本文のテキストバクスを区分するための区分線。　-->
					<div class="ui divider"></div>

					<!--知事項の本文の作成ができる。　-->
					<div id="noticeContentsOfModal"></div>
				</div>
			</div>
			<!--登録する公知事項のアップロードするファイルを選択。　-->
			<div class="actions" style="text-align: left;">
				<i class="file image outline icon"></i>
				<button>ファイル選択</button>
				<input type="file" accept="image/*" id="postUploadFiles" multiple hidden>
			</div>
			<div class="ui disabled dimmer" id="uploadingText">
				<div class="ui indeterminate text loader">ファイルをアップロードしています</div>
			</div>
			<div>
				<input type="hidden" value="" id="hiddenNoticeId"/>
				<input type="hidden" value="" id="hiddenNoticeBlindFlag"/>
			</div>
		</div>

	</div>
</div>

<script src="resources/js/editor/editor.js"></script>
<script src="resources/js/editor/underline.js"></script>
<script src="resources/js/editor/marker.js"></script>
<script src="resources/js/editor/simple-image.js"></script>

<script>
	//[part1] 메모 표헤더에서 드롭박스 선택시마다 값을 리턴해주기 위한 관련 코드들이다.
	//[part1.1]메모 변수 선언
	let noticeListSize = ${noticeListSize}; // noticeListSize : noticeListのsize。rowを出力する時に関連して使うそうだ。
	//[메모]let : 블록 스코프의 범위를 가지는 지역 변수를 선언하며, 선언과 동시에 임의의 값으로 초기화할 수도 있습니다.

	//function getBoardList()參考してコード作成。（function getBoardList()はmanageBoard.jspに位置）
	//テーブルのヘッドを通して選んだオプションに当たるカラムを出力するコードです。
	function getNoticeListForManagerSelectedColumn() {
		//[part1.4] 1단계 : 변수/상수 선언 및 값 설정.
		const url = new URL(location.href);                                          		    　//[메모]const : 상수값(변함없는 값)을 저장시 사용하는 선언자.
		const noticeTypeSelect = document.querySelector("#noticeTypeFilter > select").value; 	　//closedFilter       //[메모].querySelector() : CSS 선택자로 요소를 선택하게 해줍니다.
		const noticeStatusSelect = document.querySelector("#noticeStatusFilter > select").value; //closedFilter       //[메모].querySelector() : CSS 선택자로 요소를 선택하게 해줍니다.
		const wirteManagerSelect = document.querySelector("#wirteManagerFilter > select").value; //anonymousFilter  //[메모].querySelector() : 주의할 점은 선택자에 해당하는 첫번째 요소만 선택한다는 것입니다.

		//alert("getNoticeListForSelectedColumn-noticeTypeSelect : " + noticeTypeSelect);
		//alert("getNoticeListForSelectedColumn-noticeStatusSelect : " + noticeStatusSelect);
		//alert("getNoticeListForSelectedColumn-wirteManagerSelect : " + wirteManagerSelect);

		const searchParam = new URLSearchParams();
		//[메모]URLSearchParams : javascript 에서 url 의 쿼리 파라미터들을 읽거나 수정할 때 사용.
		searchParam.set("selectedNoticeType", noticeTypeSelect);
		searchParam.set("selectedNoticeBlindFlag", noticeStatusSelect);
		searchParam.set("selectedWirteManager", wirteManagerSelect);
		searchParam.set("ajax", "true");
		url.search = searchParam;
		//alert("getNoticeListForSelectedColumn-url.search : " + url.search );

		//메모 [part1.4] 2단계 : fetch API를 활용하여 선택한 옵션대로 웹페이지 이동.
		//메모 (예) getNoticeListForSelectedColumn-url.search : ?noticeStatusSelect=1&wirteManagerSelect=0&ajax=true
		fetch(url.href, {method: "GET"})
				.then(function (response) {                   //[메모] 서버 요청에 대한 응답이 왔을경우 실행.
					if (response.ok) {return response.json();}        //[메모] json 데이터로 변경실시(서버에게 받은 데이터는 데이터타입 문자열이기 때문.)
					else { throw response.status; }})           //[메모] 에러가 날 경우 대비용?????
				.then(function (noticeList) {                 //[메모] noticeList가 리턴온 경우로 추정된다.
					const tbody = document.querySelector("tbody"); //[메모] tbody(List를 출력하는 테이블)선택.
					history.replaceState(tbody.innerHTML, "");    //[메모] 기존의 리스트들을 초기화.
					const noticeListLength = noticeList.length;       //[메모] 새롭게 출력할 리스트들의 갯수를 알린다.

					if (noticeListLength < 1) {                   //[메모] noticeList에 내용물이 없는 경우.
						document.querySelector("tbody").innerHTML =
								"<tr><td class=\"center aligned\" colspan=\"5\">データが存在しません</td></tr>";
					}
					else { //[메모] noticeList에 내용물이 n개 있는 경우.
						let html = "";

						for (let i = 0; i < noticeListLength; ++i) {
							html += "<tr>"
						/*１．順序 */		+ "<td class=\"right aligned\" >"
											+ (i+1)
										+ "</td>"

					/*２．公知のタイプ */	+ "<td class=\"center aligned\" >"
											+ noticeList[i].noticeTypeName
										+ "</td>"

					/*３．公知の可否 */	+ "<td class=\"center aligned\" >"
											+ noticeList[i].noticeBlindFlag
										+  "</td>"

						/*４．作成者 */	+ "<td class=\"center aligned\" >"
											+ noticeList[i].userNickname
										+ "</td>"

				/*５．公知事項のタイトル */	+ "<td class=\"center aligned\">"
											+ noticeList[i].noticeTitle
										+ "</td>"

					/*６．編集ボタン */	+ "<td class=\"center aligned\">"
											+ "<button class=\"" +  "ui yellow button\" onclick=\"openNoticeModal(noticeList[i].noticeId);\">編集</button>"
										+ "</td>"

					/*７．削除ボタン */	+ "<td class=\"center aligned\">"
											+ "<button class=\"" +  "ui gray button\" onclick=\"openDeleteNoticeModal(this);\">削除</button>"
										+ "</td>"
									+ "</tr>";
						}
						tbody.innerHTML = html;
					}
					searchParam.delete("ajax");
					url.search = searchParam;
					history.pushState(tbody.innerHTML, "", url.href);
				}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}
	//[part1.2]
	//메모 getClosedFlagName(closedFlag)와 getAnonymousFlagName(anonymousFlag)에서 받은 플래그값을 통하여 URL을 변환, 출력내용이 변환하게 된다.
	//메모 02-27에보니 1.2는 선택한 사항을 알맞는 텍스트로 바꾸기위한 수단으로 보인다.
	//메모 function getClosedFlagName(closedFlag) {..} 참고
	function getNoticeStatusSelect(selectedNoticeBlindFlag) {
		switch (selectedNoticeBlindFlag) {
			case "0":
				return "公知中"; // http://localhost:8282/blind/manage/board?anonymousFlag=0
			case "1":
				return "非知中"; // http://localhost:8282/blind/manage/board?closedFlag=1&anonymousFlag=0
			case "2":
				return "公知全体"; // http://localhost:8282/blind/manage/board?closedFlag=1&anonymousFlag=0
			default:
				return "ERROR";
		}
	}

	//[part1.3]
	//메모 function getAnonymousFlagName(anonymousFlag) {..} 참고
	function getWirteManagerSelect(selectedWirteManager) {
		switch (selectedWirteManager) {
			case "1":
				return "一般"; // http://localhost:8282/blind/manage/board?anonymousFlag=0
			case "2":
				return "マスキング"; // http://localhost:8282/blind/manage/board?anonymousFlag=1
			default:
				return "ERROR";
		}
	}

	//메모 표헤더에서 드롭박스 선택시마다 값을 리턴해주기 위한 관련 코드들 <끝>-------------------------------
	//------------------------------------------------------------------------------------------------------------


	//------------------------------------------------------------------------------------------------------------
	//modal関連のコード。

	let editor;
	let totalFileSize;

	//modal show.
	//메모 기존글 수정/신규등록 모두 동일한 포맷을 사용.
	function openNoticeModal(targetNoticeId,targetNoticeTypeCode,targetNoticeBlindFlag,
							 targetNoticeTitle,targetNoticeContents ) {

		//메모 위의 파라미터를 통헤 기존 공지글의 정보를 넣도록 한다.
		//메모 targetNoticeBlindFlag는 현재 사용용도 미정. 나중에 없애거나 활용하는 것으로 설정 예정.
		$("#noticeTypeCodeOfmodal").val(targetNoticeTypeCode);
		$("#noticeTitleOfmodal").val(targetNoticeTitle);
		$("#noticeContentsOfModal").val(targetNoticeContents);

		//메모 noticeId는 hidden에 저장시켜서 유저들에게 노출되지 않도록 설정.
		$("#hiddenNoticeId").val(targetNoticeId);
		$("#hiddenNoticeBlindFlag").val(targetNoticeBlindFlag);

		$("#noticeModal").modal("show");
		editor = new EditorJS({
			holder: "noticeContentsOfModal",

			tools: {
				underline: Underline,
				marker: Marker,
				image: SimpleImage
			}
		});
	}

	//modal close.
	document.getElementById("closeNoticeModal").addEventListener("click", function () {
		$(noticeModal).modal("hide");
	});

	//메모 modal submit(신규공지글 등록/기존글 수정 정보 전송)
	//메모 전송(submit)전 유효성체크(전송 전에 정상적으로 정보를 입력했는지 확인)
	document.getElementById("noticeSubmit").addEventListener("click", function () {

		// 메모 유효성체크1 : 공지유형 선택않은 경우.
		if (noticeTypeCodeOfmodal.value == 0) {
			alert("公知タイプを選択してください");
			return;
		}
		// 메모 유효성체크2-1 : 공지제목의 기입않은 경우
		if (noticeTitleOfmodal.value.length == 0) {
			alert("公知タイトルを入力してください");
			return;
		}
		// 메모 유효성체크2-2 : 공지제목 최대글자수 제한
		if (noticeTitleOfmodal.value.length > 90) {
			alert("公知タイトルは90文字以内にしてください");
			return;
		}

		//메모 앞의 유효성체크를 통과했다면 전송할 데이터를 준비한다.
		var sendNoticeId =  $('#hiddenNoticeId').val();
		var sendNoticeTypeCode = $('#noticeTypeCodeOfmodal').val();
		var sendNoticeTitle = $('#noticeTitleOfmodal').val();
		var sendNoticeContents = $('#noticeContentsOfModal').val();
		var sendNoticeBlindFlag = $('#hiddenNoticeBlindFlag').val();

		/*
		$.ajax({
			type: "POST",
			url: "manage/notices/testConnect",
			success: function () {
				alert("testConnect success");
			},
			error: function () {
				alert("testConnect error");
			}
		});
		*/

		//[메모]	noticeId가 0일 경우 신규글으로 파악.
		if (sendNoticeId === '0' ) {
			$.ajax({
				type: "POST",
				url: "manage/notices/insertNewNotice",
				data: {
					sendNoticeTypeCode
					, sendNoticeTitle
					, sendNoticeContents
					, sendNoticeBlindFlag
				},
				dataType: "json",
				success: function (result) {
					alert("通報の受付を完了しました。");
					//메모 화면 재구성하도록 refresh 실시.
					location.reload();
				},
				error: function () {
					alert("システムのエラーです。管理者にお問い合わせください。");
				}
			});
		}
		//메모 0이외의 고유의 noticeId를 보유한 경우에는 수정메소드로 전송,
		else {
			$.ajax({
				type: "POST",
				url: "manage/notices/updateOriginalNotice",
				data: {
					sendNoticeId
					, sendNoticeTypeCode
					, sendNoticeTitle
					, sendNoticeContents
					, sendNoticeBlindFlag
				},
				dataType: "json",
				success: function (result) {
					alert("通報の受付を完了しました。");
				},
				error: function () {
					alert("システムのエラーです。管理者にお問い合わせください。");
				}
			});
		}
	});

	//------------------------------------------------------------------------------------------------------------
</script>