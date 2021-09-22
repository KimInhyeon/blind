<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<title>通報管理</title>
</head>
<style>
	.ui.table thead th {
		padding: 0;
	}

	.ui.table td {
		padding: .78571429em .2em .78571429em .2em;
	}

	.ui.compact.selection.dropdown {
		font-weight: 700;
		padding: 0;
	}

	select.fluid {
		text-align-last: center;
	}

	.pointer {
		cursor: pointer;
		color: steelblue;
	}
</style>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<div class="left floated two wide column">
				<h3 class="ui header">通報管理</h3>
			</div>
			<div class="right floated six wide column right aligned">
				<div class="ui fluid icon input">
					<select class="ui compact selection dropdown" id="searchTarget">
						<option value="contents">内容</option>
						<option value="name">トピック・企業名</option>
						<option value="reason">理由</option>
						<option value="writer">作成者</option>
						<option value="reporter">通報者</option>
					</select>
					<input type="text" placeholder="キーワードを入力" id="searchKeyword">
					<i class="search link icon" id="searchIcon"></i>
				</div>
			</div>
		</div>
		<div class="row">
			<table class="ui selectable celled table">
				<thead class="center aligned">
				<tr>
					<th class="center aligned" style="width: 2%;">
						<input type="checkbox" class="ui checkbox" onclick="checkAllReportRows(this.checked);">
					</th>
					<th style="width: 5%;">
						<select class="ui compact selection dropdown fluid" id="verifyFilter">
							<option value="0">待機</option>
							<option value="1">承認</option>
							<option value="2">却下</option>
							<option value="3">全部</option>
						</select>
					</th>
					<th style="width: 8%;">
						<select class="ui compact selection dropdown fluid" id="typeFilter">
							<option value="1">ポスト</option>
							<option value="2">コメント</option>
							<option value="3">レビュー</option>
							<option value="0" selected>全部</option>
						</select>
					</th>
					<th>トピック・企業名</th>
					<th>理由</th>
					<th>内容</th>
					<th>作成者</th>
					<th>通報者</th>
					<th style="width: 9%;">通報日</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="report" items="${reportList}">
					<tr>
						<td class="center aligned" data-id="${report.targetId}">
							<input type="checkbox" class="ui checkbox" onclick="checkReportRow(this);">
						</td>
						<td class="center aligned">
						<c:choose>
							<c:when test="${report.completeFlag eq '0'}">待機</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${report.verifyFlag eq '0'}">却下</c:when>
									<c:otherwise>承認</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
						</td>
						<td class="center aligned">${report.type}</td>
						<td>${report.name}</td>
						<td>
						<c:choose>
							<c:when test="${empty report.reportReason}">${report.reportCodeReason}</c:when>
							<c:otherwise>
								<span class="pointer" data-tooltip="${report.reportReason}" data-position="top left">${report.reportCodeReason}</span>
							</c:otherwise>
						</c:choose>
						</td>
						<td data-id="${report.targetId}"><span class="pointer" onclick="readContents(this);">${report.contents}</span></td>
						<td>${report.writer}</td>
						<td>${report.reporter}</td>
						<td class="center aligned">${report.reportDate}</td>
					</tr>
				</c:forEach>
				<script>
					function setVerifiedColor(verifyFlag) {
						switch (verifyFlag.innerText) {
							case "承認":
								verifyFlag.closest("tr").className = "positive";
								break;
							case "却下":
								verifyFlag.closest("tr").className = "negative";
								break;
							default:
								verifyFlag.closest("tr").removeAttribute("class");
								break;
						}
					}

					(function () {
						const tbody = document.querySelector("tbody");
						if (tbody.childElementCount > 0) {
							document.querySelectorAll(".verifyFlag").forEach(function (verifyFlag) {
								setVerifiedColor(verifyFlag);
							});
						} else {
							tbody.innerHTML = "<tr><td class=\"center aligned\" colspan=\"9\">データが存在しません</td></tr>";
						}
					}());
				</script>
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="five wide column"></div>
			<div class="six wide column center aligned">
				<c:choose>
					<c:when test="${navi.startPage gt navi.pagination}">
						<div class="ui pagination menu">
							<a class="item" href="javascript:getReportListByPage(${navi.startPage - navi.pagination});">前へ</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="ui pagination menu" style="visibility: hidden;"><a class="item">前へ</a></div>
					</c:otherwise>
				</c:choose>
				<div class="ui pagination menu">
				<c:forEach var="page" begin="${navi.startPage}" end="${navi.endPage}">
					<c:choose>
						<c:when test="${page eq navi.currentPage}">
							<div class="active item">${page}</div>
						</c:when>
						<c:otherwise>
							<a class="item" href="javascript:getReportListByPage(${page});">${page}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</div>
				<c:choose>
					<c:when test="${navi.totalPage gt navi.endPage}">
						<div class="ui pagination menu">
							<a class="item" href="javascript:getReportListByPage(${navi.endPage + 1})">次へ</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="ui pagination menu" style="visibility: hidden;"><a class="item">次へ</a></div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="five wide column right aligned">
				<button class="ui green button" onclick="verifyReportList(true, false);">承認</button>
				<button class="ui red button" onclick="verifyReportList(false, false);">却下</button>
				<button class="ui yellow button" onclick="openInputReasonModal();">直接処理</button>
			</div>
		</div>
	</div>
	<div class="ui modal" id="contents">
		<i class="close cancel icon"></i>
		<div class="header">臨時コンテンツ</div>
		<div class="content"></div>
		<div class="actions">臨時コンテンツ</div>
	</div>
	<div class="ui small modal" id="verifyModal">
		<i class="close cancel icon"></i>
		<div class="content ui form">
			<textarea class="field" id="verifyMessage"></textarea>
		</div>
		<div class="actions">
			<button class="ui left floated button" onclick="setDefaultAcceptMessage();">基本承認メッセージ</button>
			<button class="ui left floated button" onclick="setDefaultRejectMessage();">基本却下メッセージ</button>
			<button class="ui green button" onclick="verifyReportList(true, true);">承認</button>
			<button class="ui red button" onclick="verifyReportList(false, true);">却下</button>
		</div>
	</div>
</div>
<script>
	function checkReportRow(checkbox) {
		if (checkbox.checked) {
			checkbox.closest("tr").setAttribute("class", "warning");
			const length = document.querySelector("tbody").childElementCount;
			if (length === document.querySelectorAll("td > input[type=checkbox]:checked").length) {
				document.querySelector("th > input[type=checkbox]").checked = true;
			}
		} else {
			document.querySelector("th > input[type=checkbox]").checked = false;
			setVerifiedColor(checkbox.closest("td").nextElementSibling);
		}
	}

	function checkAllReportRows(checked) {
		if (checked) {
			const checkboxList = document.querySelectorAll("td > input[type=checkbox]");
			for (let i = checkboxList.length - 1; i > -1; --i) {
				if (!checkboxList[i].checked) {
					checkboxList[i].checked = true;
					checkReportRow(checkboxList[i]);
				}
			}
		} else {
			const checkboxList = document.querySelectorAll("td > input[type=checkbox]:checked");
			for (let i = checkboxList.length - 1; i > -1; --i) {
				checkboxList[i].checked = false;
				checkReportRow(checkboxList[i]);
			}
		}
	}

	function getReportList(searchParams) {
		const url = new URL(location.href);
		url.search = searchParams;
		location.href = url;
	}

	function getReportListByPage(page) {
		const searchParams = new URLSearchParams(location.search);
		if (page > 1) {
			searchParams.set("page", page);
		} else {
			searchParams.delete("page");
		}
		getReportList(searchParams);
	}

	function readContents(span) {
		const td = span.closest("tr").children;
		const type = getTypeCharacter(td[2].innerText);
		fetch(location.pathname + "/" + type + "/" + td[5].dataset.id, {
			method: "GET"
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			} else {
				throw response.status;
			}
		}).then(function (result) {
			document.querySelector("#contents > .content").innerText = result.contents;
			$("#contents").modal("show");
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}

	function openInputReasonModal() {
		if (document.querySelectorAll("td > input[type=checkbox]:checked").length > 0) {
			$("#verifyModal").modal("show");
		} else {
			alert("1つ以上の通報を選択してください。");
		}
	}

	function getDefaultAcceptMessage() {
		return "通報に対応いたしました。\n\nご迷惑をおかけして申し訳ありません。";
	}

	function getDefaultRejectMessage() {
		return "綿密に検討したところ、適切な通報ではないと判断しました。";
	}

	function setDefaultAcceptMessage() {
		document.getElementById("verifyMessage").value = getDefaultAcceptMessage();
	}

	function setDefaultRejectMessage() {
		document.getElementById("verifyMessage").value = getDefaultRejectMessage();
	}

	function getTypeCharacter(type) {
		switch (type) {
			case "ポスト":
				return "1";
			case "コメント":
				return "2"
			case "レビュー":
				return "3"
			default:
				return "0";
		}
	}

	function verifyReportList(isAccept, isCustomMessage) {
		const checkboxList = document.querySelectorAll("td > input[type=checkbox]:checked");
		let reportListLength = checkboxList.length;
		if (reportListLength < 1) {
			alert("1つ以上の通報を選択してください。");
		} else if (confirm(isAccept ? "承認しますか？" : "却下しますか？")) {
			let reason;
			if (isCustomMessage) {
				reason = document.getElementById("verifyMessage").value.trim();
				if (reason.length < 1) {
					alert("理由を入力してください。");
					return;
				}
			} else {
				reason = getDefaultAcceptMessage();
			}
			let verifyFlag;
			let className;
			let verifyName;
			if (isAccept) {
				verifyFlag = "1";
				className = "positive";
				verifyName = "承認";
			} else {
				verifyFlag = "0";
				className = "negative";
				verifyName = "却下";
			}

			const reportList = [];
			for (let i = 0; i < reportListLength; ++i) {
				const td = checkboxList[i].closest("td");
				reportList.push({
					"targetId": Number(td.dataset.id),
					"type": getTypeCharacter(td.nextElementSibling.nextElementSibling.innerText)
				});
			}
			reportList.sort(function (o1, o2) {
				if (o1.type === o2.type) {
					return o1.targetId - o2.targetId;
				}
				return Number(o1.type) - Number(o2.type);
			});
			for (--reportListLength; reportListLength > 0; --reportListLength) {
				const o1 = reportList[reportListLength];
				const o2 = reportList[reportListLength - 1];
				if (o1.type === o2.type && o1.targetId === o2.targetId) {
					reportList.splice(reportListLength, 1);
				}
			}

			fetch(location.pathname, {
				method: "PATCH",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify({
					"verifyFlag": verifyFlag,
					"reason": reason,
					"reportList": reportList
				})
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				} else {
					throw response.status;
				}
			}).then(function (result) {
				if (result) {
					const length = reportList.length;
					const tr = document.querySelectorAll("tbody > tr");
					for (let i = tr.length - 1; i > -1; --i) {
						const td = tr[i].children;
						const targetId = Number(td[0].dataset.id);
						const type = getTypeCharacter(td[2].innerText);
						for (let j = 0; j < length; ++j) {
							if (type === reportList[j].type && targetId === reportList[j].targetId) {
								td[1].innerText = verifyName;
								tr[i].className = className;
							}
						}
					}
					checkAllReportRows(false);
					alert("通報の処理に成功しました。");
					$("#verifyModal").modal("hide");
				} else {
					alert("通報の処理に失敗しました");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました。");
				console.error(error);
			});
		}
	}

	addEventListener("DOMContentLoaded", function () {
		<%-- 検索 --%>
		const searchParams = new URLSearchParams(location.search);
		const verifyFilter = document.getElementById("verifyFilter");
		const typeFilter = document.getElementById("typeFilter");
		const inputSearchKeyword = document.getElementById("searchKeyword");
		if (searchParams.has("verifyFlag")) {
			verifyFilter.value = searchParams.get("verifyFlag");
		}
		if (searchParams.has("type")) {
			typeFilter.value = searchParams.get("type");
		}
		if (searchParams.has("searchKeyword")) {
			inputSearchKeyword.value = searchParams.get("searchKeyword");
			document.getElementById("searchTarget").value = searchParams.get("searchTarget");
		}
		const getReportListByChangedFilter = function (filterName, filterValue) {
			if (filterValue === "0") {
				searchParams.delete(filterName);
			} else {
				searchParams.set(filterName, filterValue);
			}
			searchParams.delete("page");
			searchParams.delete("searchTarget");
			searchParams.delete("searchKeyword");
			getReportList(searchParams);
		}
		verifyFilter.addEventListener("change", function () {
			getReportListByChangedFilter("verifyFlag", this.value);
		});
		typeFilter.addEventListener("change", function () {
			getReportListByChangedFilter("type", this.value);
		});
		const search = function () {
			const searchKeyword = inputSearchKeyword.value.trim();
			if (searchKeyword.length > 0) {
				const searchParams = new URLSearchParams(location.search);
				searchParams.delete("page");
				searchParams.set("searchTarget", document.getElementById("searchTarget").value);
				searchParams.set("searchKeyword", searchKeyword);
				getReportList(searchParams);
			} else {
				alert("キーワードを入力してください");
			}
		};
		inputSearchKeyword.addEventListener("keydown", function (event) {
			if (event.key === "Enter") {
				search();
			}
		});
		document.getElementById("searchIcon").addEventListener("click", function () {
			search();
		});

		<%-- モーダル --%>
		$("#contents, #verifyModal").modal({
			duration: 100,
			closable: false
		});
	});
</script>
</body>
</html>