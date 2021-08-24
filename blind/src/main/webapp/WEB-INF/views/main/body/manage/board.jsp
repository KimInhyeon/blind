<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>トピック管理</title>
</head>
<style>
	.ui.grid > .middle.aligned.row {
		padding-bottom: 0;
	}

	.ui.table thead th {
		padding: 0;
	}

	td.center.aligned {
		padding: 0 .2em 0 .2em;
	}

	.ui.compact.selection.dropdown {
		font-weight: 700;
		padding: 0;
		text-align-last: center;
	}

	.ui.modal > .actions {
		text-align: center;
	}

	.ui.container {
		max-width: 40% !important;
	}

	.row.scroll {
		height: 40em;
		overflow: auto;
	}

	.ui.yellow.button {
		margin: 0;
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
</style>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<h3 class="ui header">トピック管理</h3>
		</div>
		<div class="row scroll">
			<table class="ui selectable single line celled table">
				<thead class="center aligned">
					<tr>
						<th class="sequence">順序</th>
						<th id="closedFilter">
							<select class="ui compact selection dropdown fluid" onchange="getBoardList()">
								<option value="0">正常</option>
								<option value="1">閉鎖</option>
							</select>
						</th>
						<th id="anonymousFilter">
							<select class="ui compact selection dropdown fluid" onchange="getBoardList()">
								<option value="2">全部</option>
								<option value="0">一般</option>
								<option value="1">マスキング</option>
							</select>
						</th>
						<th>トピック名</th>
						<th class="edit">編集</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="board" items="${boardList}">
					<tr>
						<td class="center aligned" data-id="${board.boardId}">${board.boardOrder}</td>
						<td class="center aligned" data-value="${board.closedFlag}">
						<c:choose>
							<c:when test="${board.closedFlag eq '0'}">正常</c:when>
							<c:when test="${board.closedFlag eq '1'}">閉鎖</c:when>
							<c:otherwise>ERROR</c:otherwise>
						</c:choose>
						</td>
						<td class="center aligned" data-value="${board.anonymousFlag}">
							<c:choose>
								<c:when test="${board.anonymousFlag eq '0'}">一般</c:when>
								<c:when test="${board.anonymousFlag eq '1'}">マスキング</c:when>
								<c:otherwise>ERROR</c:otherwise>
							</c:choose>
						</td>
						<td>${board.boardTopicName}</td>
						<td class="center aligned">
							<button class="ui yellow button" onclick="openEditBoardModal(this)">編集</button>
						</td>
					</tr>
				</c:forEach>
				</tbody>
				<script>
					(function () {
						const tbody = document.querySelector("tbody");
						if (tbody.childElementCount < 1) {
							tbody.innerHTML =
								"<tr><td class=\"center aligned\" colspan=\"5\">データが存在しません</td></tr>";
						}
					}());
				</script>
			</table>
		</div>
		<div class="row">
			<div class="three wide column right floated right aligned">
				<button class="ui grey button" onclick="openCreateBoardModal()">新規</button>
			</div>
		</div>
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
</div>
<script>
	let lastOrder = ${lastOrder};

	function getClosedFlagName(closedFlag) {
		switch (closedFlag) {
			case "0":
				return "正常";
			case "1":
				return "閉鎖";
			default:
				return "ERROR";
		}
	}

	function getAnonymousFlagName(anonymousFlag) {
		switch (anonymousFlag) {
			case "0":
				return "一般";
			case "1":
				return "マスキング";
			default:
				return "ERROR";
		}
	}

	function getBoardList() {
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
		}).then(function (boardList) {
			const tbody = document.querySelector("tbody");
			history.replaceState(tbody.innerHTML, "");
			const boardListLength = boardList.length;
			if (boardListLength < 1) {
				document.querySelector("tbody").innerHTML =
					"<tr><td class=\"center aligned\" colspan=\"5\">データが存在しません</td></tr>";
			} else {
				let html = "";
				for (let i = 0; i < boardListLength; ++i) {
					html += "<tr><td class=\"center aligned\" data-id=\"" + boardList[i].boardId + "\">" +
							boardList[i].boardOrder + "</td><td class=\"center aligned\" data-value=\"" +
							boardList[i].closedFlag + "\">" + getClosedFlagName(boardList[i].closedFlag) +
							"</td><td class=\"center aligned\" data-value=\"" +	boardList[i].anonymousFlag +
							"\">" + getAnonymousFlagName(boardList[i].anonymousFlag) + "</td><td>" +
							boardList[i].boardTopicName + "</td><td class=\"center aligned\"><button class=\"" +
							"ui yellow button\" onclick=\"openEditBoardModal(this)\">編集</button></td></tr>";
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

	function checkClosedBoard(closedFlag) {
		const order = document.getElementById("order");
		const topicName = document.getElementById("topicName");
		if (closedFlag.value === "0") {
			document.getElementById("anonymousFlag").disabled = false;
			order.readOnly = false;
			if (closedFlag.dataset.value === "1") {
				order.value = String(lastOrder + 1);
				order.setAttribute("max", order.value);
			} else {
				order.setAttribute("max", String(lastOrder));
			}
			order.closest("div").setAttribute("class", "ui input fluid");
			topicName.disabled = false;
			topicName.closest("div").setAttribute("class", "ui fluid input");
		} else {
			const anonymousFlag = document.getElementById("anonymousFlag");
			anonymousFlag.disabled = true;
			anonymousFlag.value = anonymousFlag.dataset.value;
			order.value = order.dataset.value;
			order.readOnly = true;
			order.closest("div").setAttribute("class", "ui input fluid disabled");
			topicName.disabled = true;
			topicName.value = topicName.dataset.value;
			topicName.closest("div").setAttribute("class", "ui fluid input disabled");
		}
	}

	function openEditBoardModal(button) {
		const td = button.closest("tr").children;
		const order = document.getElementById("order");
		order.value = order.dataset.value = td[0].innerText;
		order.dataset.id = td[0].dataset.id;
		const closedFlag = document.getElementById("closedFlag");
		closedFlag.value = closedFlag.dataset.value = td[1].dataset.value;
		closedFlag.disabled = false;
		checkClosedBoard(closedFlag);
		const anonymousFlag = document.getElementById("anonymousFlag");
		anonymousFlag.value = anonymousFlag.dataset.value = td[2].dataset.value;
		const topicName = document.getElementById("topicName");
		topicName.value = topicName.dataset.value = td[3].innerText;
		const boardSubmit = document.getElementById("boardSubmit");
		boardSubmit.setAttribute("onclick", "checkForUpdate()");
		boardSubmit.innerText = "更新";
		$("#boardInfo").modal("show");
	}

	function openCreateBoardModal() {
		const closedFlag = document.getElementById("closedFlag");
		closedFlag.value = closedFlag.dataset.value = "0";
		closedFlag.disabled = true;
		checkClosedBoard(closedFlag);
		document.getElementById("anonymousFlag").options[0].selected = true;
		document.getElementById("order").value = String(lastOrder + 1);
		document.getElementById("topicName").value = "";
		const boardSubmit = document.getElementById("boardSubmit");
		boardSubmit.setAttribute("onclick", "checkForCreate()");
		boardSubmit.innerText = "作成";
		$("#boardInfo").modal("show");
	}

	async function boardSubmit(method, board) {
		let result = -1;
		await fetch(location.pathname, {
			method: method,
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify(board)
		}).then(function (response) {
			if (response.ok) {
				result = response.json();
			} else {
				throw response.status;
			}
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
		return result;
	}

	function checkBoardInfo(order, topicName, closedFlag) {
		let newOrder = order.value.trim();
		if (newOrder.length < 1) {
			alert("順位を入力してください");
			order.focus();
			return false;
		} else {
			newOrder = Number(newOrder);
			const max = Number(document.getElementById("order").getAttribute("max"));
			if (newOrder < 1 || (max !== null && newOrder > max)) {
				alert("正しい順位を入力してください");
				order.focus();
				return false;
			}
		}
		const newTopicNameLength = topicName.value.trim().length;
		if (newTopicNameLength < 1) {
			alert("トピック名を入力してください");
			topicName.focus();
			return false;
		} else if (newTopicNameLength > 30) {
			alert("トピック名は30文字以下にしてください");
			topicName.focus();
			return false;
		}
		if (closedFlag.value === "1" && closedFlag.dataset.value === "1") {
			alert("閉鎖したトピックの変更はできません");
			return false;
		}
		return true;
	}

	function rerenderBoardInfo(tdList, board) {
		tdList[0].innerText = String(board.boardOrder);
		tdList[1].dataset.value = board.closedFlag;
		tdList[1].innerText = getClosedFlagName(board.closedFlag);
		tdList[2].dataset.value = board.anonymousFlag;
		tdList[2].innerText = getAnonymousFlagName(board.anonymousFlag);
		tdList[3].innerText = board.boardTopicName;
	}

	function getNewBoardRow(board) {
		return "<tr class=\"warning\"><td class=\"center aligned\" data-id=\"" + board.boardId + "\">" +
				board.boardOrder + "</td><td class=\"center aligned\" data-value=\"" + board.closedFlag + "\">" +
				getClosedFlagName(board.closedFlag) + "</td><td class=\"center aligned\" data-value=\"" +
				board.anonymousFlag + "\">" + getAnonymousFlagName(board.anonymousFlag) + "</td><td>" +
				board.boardTopicName + "</td><td class=\"center aligned\"><button class=\"ui yellow button\" " +
				"onclick=\"openEditBoardModal(this)\">編集</button></td></tr>";
	}

	function checkForUpdate() {
		const topicName = document.getElementById("topicName");
		const order = document.getElementById("order");
		const anonymousFlag = document.getElementById("anonymousFlag");
		const closedFlag = document.getElementById("closedFlag");
		const board = {
			"boardTopicName": topicName.value,
			"boardOrder": Number(order.value),
			"anonymousFlag": anonymousFlag.value,
			"closedFlag": closedFlag.value,
			"boardId": Number(order.dataset.id)
		};
		if (checkBoardInfo(order, topicName, closedFlag) && confirm("更新しますか？")) {
			boardSubmit("PATCH", board).then(function (result) {
				if (result > 0) {
					const tbody = document.querySelector("tbody");
					const trList = tbody.children;
					const originOrder = Number(order.dataset.value);
					if (board.closedFlag === "1") { // トピックの閉鎖
						--lastOrder;
						for (let i = trList.length - 1; i > -1; --i) {
							const tdList = trList[i].children;
							if (tdList[0].dataset.id === order.dataset.id) {
								trList[i].setAttribute("class", "negative");
								rerenderBoardInfo(tdList, board);
								break;
							} else {
								tdList[0].innerText = String(Number(tdList[0].innerText - 1));
							}
						}
					} else if (closedFlag.dataset.value === "1") { // トピックの復活
						++lastOrder;
						for (let i = trList.length - 1; i > -1; --i) {
							const tdList = trList[i].children;
							if (tdList[0].dataset.id === order.dataset.id) {
								trList[i].setAttribute("class", "positive");
								rerenderBoardInfo(tdList, board);
								break;
							}
						}
					} else if (board.boardOrder < originOrder) { // トピックの順序が早くなる
						let tbodyHtml = "";
						let i = 0;
						const length = trList.length;
						while (i < length) {
							const td = trList[i].firstElementChild;
							if (Number(td.innerText) < board.boardOrder) {
								tbodyHtml += trList[i].outerHTML;
								++i;
							} else {
								break;
							}
						}
						tbodyHtml += getNewBoardRow(board);
						while (i < length) {
							const td = trList[i].firstElementChild;
							const order = Number(td.innerText);
							if (order < originOrder) {
								td.innerText = String(order + 1);
								tbodyHtml += trList[i].outerHTML;
								++i;
							} else {
								++i;
								break;
							}
						}
						while (i < length) {
							tbodyHtml += trList[i].outerHTML;
							++i;
						}
						tbody.innerHTML = tbodyHtml;
					} else if (board.boardOrder > originOrder) { // トピックの順序が遅くなる
						let tbodyHtml = "";
						let i = 0;
						const length = trList.length;
						while (i < length) {
							const td = trList[i].firstElementChild;
							if (Number(td.innerText) < originOrder) {
								tbodyHtml += trList[i].outerHTML;
								++i;
							} else {
								++i;
								break;
							}
						}
						while (i < length) {
							const td = trList[i].firstElementChild;
							const order = Number(td.innerText);
							if (order <= board.boardOrder) {
								td.innerText = String(order - 1);
								tbodyHtml += trList[i].outerHTML;
								++i;
							} else {
								break;
							}
						}
						tbodyHtml += getNewBoardRow(board);
						while (i < length) {
							tbodyHtml += trList[i].outerHTML;
							++i;
						}
						tbody.innerHTML = tbodyHtml;
					} else { // 順序の変化がない更新
						for (let i = trList.length - 1; i > -1; --i) {
							const tdList = trList[i].children;
							if (tdList[0].dataset.id === order.dataset.id) {
								trList[i].setAttribute("class", "warning");
								rerenderBoardInfo(tdList, board);
								break;
							}
						}
					}
					history.replaceState(tbody.innerHTML, "");
					alert("更新に成功しました");
					$("#boardInfo").modal("hide");
				} else if (result > -1) {
					alert("更新に失敗しました");
				}
			});
		}
	}

	function checkForCreate() {
		const order = document.getElementById("order");
		const topicName = document.getElementById("topicName");
		const closedFlag = document.getElementById("closedFlag");
		const board = {
			"boardTopicName": topicName.value,
			"boardOrder": Number(order.value),
			"anonymousFlag": document.getElementById("anonymousFlag").value
		};
		if (checkBoardInfo(order, topicName, closedFlag) && confirm("新しいトピックを生成しますか？")) {
			boardSubmit("POST", board).then(function (boardId) {
				if (boardId > 0) {
					++lastOrder;
					board.boardId = boardId;
					board.closedFlag = "0";
					const tbody = document.querySelector("tbody");
					const closedFlag = document.querySelector("#closedFilter > select").value;
					if (closedFlag === "0") {
						let tbodyHtml = "";
						const trList = tbody.children;
						const length = trList.length;
						let i = 0;
						while (i < length) {
							const td = trList[i].firstElementChild;
							if (Number(td.innerText) < board.boardOrder) {
								tbodyHtml += trList[i].outerHTML;
								++i;
							} else {
								break;
							}
						}
						tbodyHtml += getNewBoardRow(board);
						while (i < length) {
							const td = trList[i].firstElementChild;
							td.innerText = String(Number(td.innerText) + 1);
							tbodyHtml += trList[i].outerHTML;
							++i;
						}
						tbody.innerHTML = tbodyHtml;
					} else {
						tbody.innerHTML = getNewBoardRow(board) + tbody.innerHTML;
					}
					history.replaceState(tbody.innerHTML, "");
					alert("生成に成功しました");
					$("#boardInfo").modal("hide");
				} else if (boardId > -1) {
					alert("生成に失敗しました");
				}
			});
		}
	}

	onload = function () {
		// 検索パラメータ、順序の最大値
		const searchParams = new URLSearchParams(location.search);
		const closedFilter = document.querySelector("#closedFilter > select");
		const anonymousFilter = document.querySelector("#anonymousFilter > select");
		if (searchParams.has("closedFlag")) {
			closedFilter.value = searchParams.get("closedFlag");
		}
		if (searchParams.has("anonymousFlag")) {
			anonymousFilter.value = searchParams.get("anonymousFlag");
		}

		// モーダル
		const topicName = document.getElementById("topicName");
		$("#boardInfo").modal({
			duration: 100,
			closable: false,
			autofocus: false,
			onVisible: function () {
				topicName.focus();
			}
		});

		// Pjax
		const tbody = document.querySelector("tbody");
		onpopstate = function (event) {
			tbody.innerHTML = event.state;
			const searchParams = new URLSearchParams(location.search);
			const closedFlag = searchParams.get("closedFlag");
			const anonymousFlag = searchParams.get("anonymousFlag");
			closedFilter.value = closedFlag === null ? "0" : closedFlag;
			anonymousFilter.value = anonymousFlag === null ? "2" : anonymousFlag;
		};
	};
</script>
</body>
</html>