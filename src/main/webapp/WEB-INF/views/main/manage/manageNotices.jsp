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
						<select class="ui compact selection dropdown fluid" onchange="getNoticeListForManagerSelectedColumn()">
							<option value="0">作成者</option>
						</select>
					</th>

					<!--５．公知事項のタイトル -->
					<th>公知事項のタイトル</th>

					<!--６．編集ボタン -->
					<th class="edit">編集</th>

					<!--７．削除ボタン -->
					<th class="edit">削除</th>
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
							<button class="ui yellow button" onclick="openEditNoticeModal(this);">編集</button>
						</td>

						<!--７．削除ボタン -->
						<td class="center aligned">
							<button class="ui gray button" onclick="openDeleteNoticeModal(this);">削除</button>
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
				<button class="ui grey button" onclick="openCreateNoticeModal();">新規</button>
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
						<button class="ui positive button" id="postSubmit">登録</button>
					</div>
				</div>
			</div>
			<!--登録する公知事項のタイプ選択、タイトルと本文の作成ができる。　-->
			<div class="scrolling content">
				<div class="ui big form">
					<div class="field">
						<!--登録する公知事項のタイプ選択　-->
						<div class="ui selection dropdown">
							<input type="hidden" id="postModalTopic">
							<i class="dropdown icon"></i>
							<div class="default text">登録する公知事項のタイプを選んでください</div>
							<div class="menu"></div>
						</div>
					</div>
					<!--公知事項のタイトル作成ができる。　-->
					<div class="field">
						<input type="text" placeholder="登録する公知事項のタイトルを入力してください" id="postModalTitle">
					</div>
					<div class="ui divider"></div>
					<!--知事項の本文の作成ができる。　-->
					<div id="postModalContents"></div>
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
	//function getNoticeListForSelectedColumn()：(메모) 테이블헤더에서 선택한 칼럼에 해당하는 정보들만 출력하는 코드입니다.

	//[part1.4]
	function getNoticeListForManagerSelectedColumn() {
		//[part1.4] 1단계 : 변수/상수 선언 및 값 설정.
		const url = new URL(location.href);                                              //[메모]const : 상수값(변함없는 값)을 저장시 사용하는 선언자.
		const noticeTypeSelect = document.querySelector("#noticeTypeFilter > select").value; //closedFilter       //[메모].querySelector() : CSS 선택자로 요소를 선택하게 해줍니다.
		const noticeStatusSelect = document.querySelector("#noticeStatusFilter > select").value; //closedFilter       //[메모].querySelector() : CSS 선택자로 요소를 선택하게 해줍니다.
		const wirteManagerSelect = document.querySelector("#wirteManagerFilter > select").value;   //anonymousFilter  //[메모].querySelector() : 주의할 점은 선택자에 해당하는 첫번째 요소만 선택한다는 것입니다.

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
		alert("getNoticeListForSelectedColumn-url.search : " + url.search );

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
											+ "<button class=\"" +  "ui yellow button\" onclick=\"openEditNoticeModal(this);\">編集</button>"
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
	//modal関連のコード。

	//modal show.
	function openEditNoticeModal(button) {
		$("#noticeModal").modal("show");
	}
	//modal close.
	document.getElementById("closeNoticeModal").addEventListener("click", function () {
		$(noticeModal).modal("hide");
	});

	let editor;
	let totalFileSize;

	async function deleteFile(postFileId) {
		return await fetch("image", {
			method: "DELETE",
			headers: {
				"Content-Type": "application/json"
			},
			body: postFileId
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			}
			throw response.status;
		});
	}

	function cancelUpload(icon) {
		const fileName = icon.closest("span").innerText;
		if (confirm(fileName + "のアップロードをキャンセルしますか？")) {
			const postFileId = icon.dataset.id;
			deleteFile(postFileId).then(function (isDeleted) {
				if (isDeleted) {
					const caption = document.querySelectorAll(".cdx-input.cdx-simple-image__caption");
					for (let i = caption.length - 1; i > -1; --i) {
						if (caption[i].innerText === postFileId) {
							caption[i].closest("div.ce-block").remove();
							break;
						}
					}
					icon.closest("span").remove();
				} else {
					alert("ファイルの削除に失敗しました");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
			});
		}
	}

	async function getFileHash(file) {
		return await file.arrayBuffer().then(function (arrayBuffer) {
			const byteArray = new Int8Array(arrayBuffer);
			return crypto.subtle.digest("SHA-256", byteArray);
		}).then(function (digest) {
			const hashArray = Array.from(new Uint8Array(digest));
			let fileHash = "";
			for (let j = 0, arrayLength = hashArray.length; j < arrayLength; ++j) {
				fileHash += hashArray[j].toString(16).padStart(2, "0");
			}
			return fileHash;
		});
	}

	addEventListener("DOMContentLoaded", function () {
		<%-- モーダル --%>
		const postModal = document.getElementById("postModal");
		$(postModal).modal({
			duration: 100,
			closable: false,
			autofocus: false
		});
		const postModalTopic = document.getElementById("postModalTopic");
		const postModalTitle = document.getElementById("postModalTitle");
		const postUploadFiles = document.getElementById("postUploadFiles");
		document.getElementById("openPostModal").addEventListener("click", function () {
			totalFileSize = 0;
			postModal.dataset.id = "0";
			$(postModal).modal("show");
			if (editor === undefined) {
				fetch("board", {
					method: "GET"
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					}
					throw response.status;
				}).then(function (topicList) {
					let topicOptionList = "";
					for (let i = 0, length = topicList.length; i < length; ++i) {
						topicOptionList += "<div class=\"item\" data-value=\"" + topicList[i].boardId + "\">" +
								topicList[i].boardTopicName + "</div>";
					}
					document.querySelector(".ui.selection.dropdown > .menu").innerHTML = topicOptionList;
					$(postModalTopic).closest("div").dropdown();
				}).catch(function (error) {
					alert("予期しないエラーが発生しました");
					$(postModal).modal("hide");
					console.error(error);
				});
				editor = new EditorJS({
					holder: "postModalContents",
					tools: {
						underline: Underline,
						marker: Marker,
						image: SimpleImage
					}
				});
			} else {
				$(postModalTopic).closest("div").dropdown("restore defaults");
				postModalTitle.value = postUploadFiles.value = "";
				editor.blocks.clear();
				document.querySelectorAll("#postModal > .actions > span").forEach(function (span) {
					span.remove();
				});
				deleteFile(postModal.dataset.id).catch(function (error) {
					alert("予期しないエラーが発生しました");
					$(postModal).modal("hide");
					console.error(error);
				});
			}
		});

		postModalTitle.addEventListener("input", function () {
			const title = this.value.trim();
			if (title.length > 200) {
				alert("タイトルは２００文字以内にしてください");
				this.value = title.substring(0, 200);
			}
		});
		addEventListener("keydown", function (event) {
			if (event.key === "Escape") {
				$(".ui.modal").modal("hide");
			}
		});

		<%-- ファイルアップロード --%>
		const fileSizeLimit = 10485760;
		const totalLimit = 104857600;
		const uploadingText = document.getElementById("uploadingText");
		postUploadFiles.previousElementSibling.addEventListener("click", function () {
			postUploadFiles.click();
		});
		postUploadFiles.addEventListener("change", async function () {
			let size = 0;
			const filesLength = this.files.length;
			for (let i = 0; i < filesLength; ++i) {
				if (this.files[i].size > fileSizeLimit) {
					alert("10MB以上のファイルはアップロードできません");
					this.value = "";
					return;
				}
				size += this.files[i].size;
			}
			if (totalFileSize + size > totalLimit) {
				alert("ファイルサイズの合計は100MB以下にしてください");
				this.value = "";
				return;
			}

			const postId = postModal.dataset.id;
			const searchParams = new URLSearchParams();
			searchParams.append("postId", postId);
			const type = "image";
			const config = SimpleImage;
			const needToFocus = false;
			uploadingText.className = "ui active dimmer";
			for (let i = 0; i < filesLength; ++i) {
				const file = this.files[i];
				const fileHash = await getFileHash(file);

				searchParams.set("fileHash", fileHash);
				searchParams.set("originName", file.name);

				let postFile = await fetch("image?" + searchParams.toString(), {
					method: "GET"
				}).then(function (response) {
					if (response.ok) {
						return response.text();
					}
					throw response.status;
				}).then(function (responseBody) {
					console.log(responseBody);
					if (responseBody) {
						return JSON.parse(responseBody);
					}
					return null;
				}).catch(function (error) {
					alert("予期しないエラーが発生しました");
					console.error(error);
					postUploadFiles.value = "";
					uploadingText.className = "ui disabled dimmer";
				});

				if (postFile === null) {
					const formData = new FormData();
					formData.append("postId", postId);
					formData.append("file", file);
					postFile = await fetch("image", {
						method: "POST",
						body: formData
					}).then(function (response) {
						if (response.ok) {
							return response.json();
						}
						throw response.status;
					}).catch(function (error) {
						alert("予期しないエラーが発生しました");
						console.error(error);
						postUploadFiles.value = "";
						uploadingText.className = "ui disabled dimmer";
					});
				}

				const data = {
					"url": postFile.postFileUrl,
					"caption": postFile.postFileId,
					"withBorder": false,
					"withBackground": false,
					"stretched": false
				};
				const index = editor.blocks.getBlocksCount();
				editor.blocks.insert(type, data, config, index, needToFocus);
				const html = "<span>" +  file.name + "<i class=\"window close outline link icon\" " +
						"onclick=\"cancelUpload(this);\" data-id=\"" + data.caption + "\"></i></span>";
				this.closest("div").insertAdjacentHTML("beforeend", html);
				totalFileSize += file.size;
			}
			this.value = "";
			uploadingText.className = "ui disabled dimmer";
		});

		document.getElementById("postSubmit").addEventListener("click", function () {
			if (!postModalTopic.value.length) {
				alert("トピックを選択してください");
				postModalTopic.closest("div").focus();
				return;
			}
			postModalTitle.value = postModalTitle.value.trim();
			if (!postModalTitle.value.length) {
				alert("タイトルを入力してください");
				postModalTitle.focus();
				return;
			}
			if (postModalTitle.value.length > 200) {
				alert("タイトルは２００文字以内にしてください");
				postModalTitle.focus();
				return;
			}
			editor.save().then(function (savedData) {
				if (!savedData.blocks.length) {
					alert("内容を入力してください");
					editor.focus();
					return;
				}
				if (postModal.dataset.id === "0") {
					if (confirm("ポストを作成しますか？")) {
						const blockList = savedData.blocks;
						for (let i = blockList.length - 1; i > -1; --i) {
							delete blockList[i].id;
						}
						uploadingText.firstElementChild.innerText = "ポストをアップロードしています";
						uploadingText.className = "ui active dimmer";
						fetch("post", {
							method: "POST",
							headers: {
								"Content-Type": "application/json"
							},
							body: JSON.stringify({
								postTitle: postModalTitle.value,
								boardId: postModalTopic.value,
								postBlindFlag: "0", <%-- 確認必要 --%>
								postContents: savedData.blocks
							})
						}).then(function (response) {
							if (response.ok) {
								return response.json();
							}
							throw response.status;
						}).then(function (postId) {
							location.href = "post/" + postId;
						}).catch(function (error) {
							uploadingText.className = "ui disabled dimmer";
							uploadingText.firstElementChild.innerText = "ファイルをアップロードしています";
							alert("予期しないエラーが発生しました");
							console.error(error);
						});
					}
				} else {
					if (confirm("ポストを修正しますか？")) {
						const blockList = savedData.blocks;
						for (let i = blockList.length - 1; i > -1; --i) {
							delete blockList[i].id;
						}
						uploadingText.firstElementChild.innerText = "ポストを修正しています";
						uploadingText.className = "ui active dimmer";
						fetch("post", {
							method: "PUT",
							headers: {
								"Content-Type": "application/json"
							},
							body: JSON.stringify({
								postId: postModal.dataset.id,
								postTitle: postModalTitle.value,
								boardId: postModalTopic.value,
								postBlindFlag: "0", <%-- 確認必要 --%>
								postContents: savedData.blocks
							})
						}).then(function (response) {
							if (!response.ok) {
								throw response.status;
							}
						}).then(function () {
							location.reload();
						}).catch(function (error) {
							uploadingText.className = "ui disabled dimmer";
							uploadingText.firstElementChild.innerText = "ファイルをアップロードしています";
							alert("予期しないエラーが発生しました");
							console.error(error);
						});
					}
				}
			});
		});
	});
	//------------------------------------------------------------------------------------------------------------
</script>