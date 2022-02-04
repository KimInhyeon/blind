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


    //編集ボタン
	.ui.yellow.button {
		margin: 0;
	}

    //削除ボタン
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
					    <!--　１．順序　-->
						<th class="sequence">順序</th>

						<!-- ２．公知の可否 -->
						<th id="closedFilter">
							<select class="ui compact selection dropdown fluid" onchange="getNoticeList()">
								<option value="0">公知の可否</option>
								<option value="1">公知中</option>
								<option value="2">非知中</option>
							</select>
						</th>

						<!-- ３．作成者 -->
						<th id="anonymousFilter">
							<select class="ui compact selection dropdown fluid" onchange="getNoticeList()">
								<option value="0">作成者</option>
							</select>
						</th>

						<!-- ４．公知事項のタイトル -->
						<th>公知事項のタイトル</th>

						<!--　５．編集ボタン -->
						<th class="edit">編集</th>

						<!--　６．削除ボタン -->
						<th class="edit">削除</th>
					</tr>
				</thead>

				<tbody>
				<c:forEach var="notice" items="${noticeList}">
				<c:set var="index_no" value="${index_no+1}"/>
					<tr>
                        <!--　１．順序　-->
						<!-- <td class="right aligned"> ${index_no} </td> -->
						<td class="right aligned" data-id="${notice.noticeId}">${index_no}</td>

						<!-- ２．公知の可否 -->
						<td class="center aligned" data-value="${notice.noticeBlindFlag}">
						<c:choose>
							<c:when test="${notice.noticeBlindFlag eq '0'}">公知中</c:when>
							<c:when test="${notice.noticeBlindFlag eq '1'}">非知中</c:when>
							<c:otherwise>ERROR</c:otherwise>
						</c:choose>
						</td>

						<!-- ３．作成者 -->
						<td class="center aligned">${notice.userNickname}</td>

                        <!-- ４．公知事項のタイトル -->
						<td>${notice.noticeTitle}</td>

						<!--　５．編集ボタン -->
						<td class="center aligned">
							<button class="ui yellow button" onclick="openNoticeModal(this);">編集</button>
						</td>

						<!--　６．削除ボタン -->
						<td class="center aligned">
							<button class="ui gray button" onclick="openNoticeModal(this);">削除</button>
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
				<button class="ui grey button" onclick="openNoticeModal();">新規</button>
			</div>
		</div>

        <!--　公知事項を管理（新規/編集）するmodal。（新規/編集ボタンを押すと出力する。）-->
        <!--　まだ未完成。「ポスト作成」を参考してUIの統一なるようにする。-->
		<div class="ui tiny modal" id="boardInfo">
			<i class="close cancel icon"></i>
			<div class="content">
				<div class="ui grid">
					<div class="row">
						<div class="five wide column">
							<div class="ui grid middle aligned">
								<div class="six wide column">運用</div>
								<div class="ten wide column">
									<select class="ui compact selection dropdown fluid"
											onchange="checkClosedBoard(this)" id="closedFlag">
										<option value="0">正常</option>
										<option value="1">閉鎖</option>
									</select>
								</div>
							</div>
						</div>
						<div class="eleven wide column">
							<div class="ui grid middle aligned">
								<div class="five wide column right aligned">マスキング</div>
								<div class="eleven wide column">
									<select class="ui compact selection dropdown" id="anonymousFlag">
										<option value="0">一般</option>
										<option value="1">マスキング</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="five wide column">
							<div class="ui grid middle aligned">
								<div class="six wide column">順位</div>
								<div class="ten wide column">
									<div class="ui input fluid"><input type="number" min="1" id="order"></div>
								</div>
							</div>
						</div>
						<div class="eleven wide column">
							<div class="ui grid middle aligned">
								<div class="five wide column">トピック名</div>
								<div class="eleven wide column">
									<div class="ui fluid input"><input type="text" id="topicName"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="actions center aligned">
				<button class="ui primary button" id="boardSubmit"></button>
			</div>
		</div>


	</div>
</div>

<script>
/*
	function getNoticeList() {
		const url = new URL(location.href);
		const searchParam = new URLSearchParams();
		const closedFlag = document.querySelector("#closedFilter > select").value;
		const anonymousFlag = document.querySelector("#anonymousFilter > select").value;
		searchParam.set("closedFlag", closedFlag);
		searchParam.set("anonymousFlag", anonymousFlag);
		searchParam.set("ajax", "true");
		url.search = searchParam;
		fetch(url.href, {
			method: "GET"
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			} else {
				throw response.status;
			}
		}).then(function (noticeList) {
			const tbody = document.querySelector("tbody");
			history.replaceState(tbody.innerHTML, "");
			const noticeListLength = noticeList.length;
			if (noticeListLength < 1) {
				document.querySelector("tbody").innerHTML =
					"<tr><td class=\"center aligned\" colspan=\"5\">データが存在しません</td></tr>";
			} else {
				let html = "";
				for (let i = 0; i < noticeListLength; ++i) {
					html += "<tr><td class=\"right aligned\">" +
							noticeList[i].boardOrder + "</td><td class=\"center aligned\" data-value=\"" +
							noticeList[i].closedFlag + "\">" + getClosedFlagName(noticeList[i].closedFlag) +
							"</td><td class=\"center aligned\" data-value=\"" +	noticeList[i].anonymousFlag +
							"\">" + getAnonymousFlagName(noticeList[i].anonymousFlag) + "</td><td>" +
							noticeList[i].boardTopicName + "</td><td class=\"center aligned\"><button class=\"" +
							"ui yellow button\" onclick=\"openEditBoardModal(this);\">編集</button></td></tr>";
				}
				tbody.innerHTML = html;
			}
			if (closedFlag === "0") {
				searchParam.delete("closedFlag");
			}
			if (anonymousFlag === "2") {
				searchParam.delete("anonymousFlag");
			}
			searchParam.delete("ajax");
			url.search = searchParam;
			history.pushState(tbody.innerHTML, "", url.href);
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}
	*/
</script>
