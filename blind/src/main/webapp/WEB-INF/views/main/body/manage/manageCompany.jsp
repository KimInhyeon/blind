<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<title>企業管理</title>
</head>
<style>
	.ui.grid > .middle.aligned.row {
		padding-bottom: 0;
	}

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

	.ui.modal > .actions {
		text-align: center;
	}

	#companyExplain {
		margin: 0em;
		width: 100%;
		-webkit-box-flex: 1;
		-ms-flex: 1 0 auto;
		flex: 1 0 auto;
		outline: none;
		-webkit-tap-highlight-color: rgba(255, 255, 255, 0);
		text-align: left;
		line-height: 1.21428571em;
		font-family: 'Lato', 'Helvetica Neue', Arial, Helvetica, sans-serif;
		padding: 0.67857143em 1em;
		background: #FFFFFF;
		border: 1px solid rgba(34, 36, 38, 0.15);
		color: rgba(0, 0, 0, 0.87);
		border-radius: 0.28571429rem;
		-webkit-transition: border-color 0.1s ease, -webkit-box-shadow 0.1s ease;
		transition: border-color 0.1s ease, -webkit-box-shadow 0.1s ease;
		transition: box-shadow 0.1s ease, border-color 0.1s ease;
		transition: box-shadow 0.1s ease, border-color 0.1s ease, -webkit-box-shadow 0.1s ease;
		-webkit-box-shadow: none;
		box-shadow: none;
	}

	#companyExplain:focus {
		border-color: #85B7D9;
		background: #FFFFFF;
		color: rgba(0, 0, 0, 0.8);
		-webkit-box-shadow: none;
		box-shadow: none;
	}

	th.date {
		width: 7%;
	}

	th.filter {
		width: 5%;
	}
</style>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<div class="left floated two wide column"><h3 class="ui header">企業管理</h3></div>
			<div class="right floated six wide column right aligned">
				<div class="ui fluid icon input">
					<select class="ui compact selection dropdown" id="searchTarget">
						<option value="companyName">企業名</option>
						<option value="businessTypeName">業種</option>
						<option value="companyAddress">所在地</option>
						<option value="companyDomain">ドメイン</option>
					</select>
					<input type="text" placeholder="キーワードを入力" id="searchKeyword">
					<i class="search link icon" id="searchIcon"></i>
				</div>
			</div>
		</div>
		<div class="row">
			<table class="ui selectable single line celled table">
				<thead class="center aligned">
					<tr>
						<th style="width: 2%;">
							<input type="checkbox" class="ui checkbox" onclick="checkAllCompanyRows(this.checked);">
						</th>
						<th class="filter">
							<select class="ui compact selection dropdown fluid" id="verifyFilter">
								<option value="0">待機</option>
								<option value="1">承認</option>
								<option value="2">却下</option>
								<option value="3">全部</option>
							</select>
						</th>
						<th class="filter">
							<select class="ui compact selection dropdown fluid" id="closingFilter">
								<option value="0">営業</option>
								<option value="1">廃業</option>
								<option value="2">全部</option>
							</select>
						</th>
						<th>企業名</th>
						<th style="width: 21%;">業種</th>
						<th style="width: 15%;">所在地</th>
						<th class="date">設立日</th>
						<th>従業員数</th>
						<th>ドメイン</th>
						<th>申請者</th>
						<th class="date">申請日</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="company" items="${companyList}">
					<tr>
						<td class="center aligned">
							<input type="checkbox" class="ui checkbox" data-id="${company.companyId}"
									onclick="checkCompanyRow(this);">
							<input type="hidden" value="${company.searchCompanyName}">
							<input type="hidden" value="${company.companyHomepage}">
							<input type="hidden" value="${company.companyExplain}">
						</td>
						<td class="center aligned verifyFlag" data-value="${company.verifyFlag}"></td>
						<td class="center aligned closingFlag" data-value="${company.closingFlag}"></td>
						<td>${company.companyName}</td>
						<td class="businessType" data-value="${company.businessTypeCode}"></td>
						<td>${company.companyAddress}</td>
						<td class="center aligned">${company.foundingDate}</td>
						<td class="right aligned">${company.workersCount}</td>
						<td>${company.companyDomain}</td>
						<td>${company.userNickName}</td>
						<td class="center aligned">${company.appDate}</td>
					</tr>
				</c:forEach>
				<script>
					function getBusinessTypeName(businessTypeCode) {
						switch (businessTypeCode) {
							<c:forEach var="businessType" items="${businessTypeList}">
							case "${businessType.businessTypeCode}":
								return "${businessType.businessTypeName}";
							</c:forEach>
							default:
								return "ERROR";
						}
					}

					function getClosedFlagName(closedFlag) {
						switch (closedFlag) {
							case "0":
								return "営業";
							case "1":
								return "廃業";
							default:
								return "ERROR";
						}
					}

					function getVerifyFlagName(verifyFlag) {
						switch (verifyFlag) {
							case "0":
								return "待機";
							case "1":
								return "承認";
							case "2":
								return "却下";
							default:
								return "ERROR";
						}
					}

					function setVerifiedColor(verifyFlag) {
						switch (verifyFlag.dataset.value) {
							case "1":
								verifyFlag.closest("tr").setAttribute("class", "positive");
								break;
							case "2":
								verifyFlag.closest("tr").setAttribute("class", "negative");
								break;
							default:
								verifyFlag.closest("tr").removeAttribute("class");
								break;
						}
					}

					function setTableByCodeToName(tbody) {
						document.querySelectorAll(".businessType").forEach(function (businessType) {
							businessType.innerText = getBusinessTypeName(businessType.dataset.value);
						});
						document.querySelectorAll(".closingFlag").forEach(function (closingFlag) {
							closingFlag.innerText = getClosedFlagName(closingFlag.dataset.value);
						});
						document.querySelectorAll(".verifyFlag").forEach(function (verifyFlag) {
							verifyFlag.innerText = getVerifyFlagName(verifyFlag.dataset.value);
							setVerifiedColor(verifyFlag);
						});
						if (tbody.childElementCount < 1) {
							tbody.innerHTML = "<tr><td class=\"center aligned\" colspan=\"11\">データが存在しません</td></tr>";
						}
					}

					(function () {
						setTableByCodeToName(document.querySelector("tbody"));
					}());
				</script>
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="five wide column"></div>
			<div class="six wide column center aligned" id="pagination">
				<c:choose>
					<c:when test="${navi.startPage gt navi.pagination}">
						<div class="ui pagination menu">
							<a class="item" href="javascript:getCompanyListByPage(${navi.startPage - navi.pagination});">前へ</a>
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
							<a class="item" href="javascript:getCompanyListByPage(${page});">${page}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</div>
				<c:choose>
					<c:when test="${navi.totalPage gt navi.endPage}">
						<div class="ui pagination menu">
							<a class="item" href="javascript:getCompanyListByPage(${navi.endPage + 1})">次へ</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="ui pagination menu" style="visibility: hidden;"><a class="item">次へ</a></div>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="five wide column right aligned">
				<button class="ui green button" onclick="approveCompanyList();">承認</button>
				<button class="ui red button" onclick="openRejectionModal();">却下</button>
				<button class="ui yellow button" onclick="checkSelectedList();">編集</button>
				<button class="ui grey button" onclick="openApplyCompanyModal();">新規</button>
			</div>
		</div>
	</div>
	<div class="ui modal" id="comInfo">
		<i class="close cancel icon"></i>
		<div class="header">申請情報</div>
		<div class="content">
			<div class="ui grid middle aligned">
				<div class="row">
					<div class="two wide column">処理状況</div>
					<div class="six wide column" id="verifyFlag"></div>
					<div class="two wide column">設立日</div>
					<div class="six wide column">
						<div class="ui input"><input type="date" id="foundingDate"></div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">営業状況</div>
					<div class="six wide column">
						<select class="ui compact selection dropdown" id="closingFlag">
							<option value="0">営業</option>
							<option value="1">廃業</option>
						</select>
					</div>
					<div class="two wide column">業種</div>
					<div class="six wide column">
						<select class="ui compact selection dropdown" id="businessTypeCode">
						<c:forEach var="businessType" items="${businessTypeList}">
							<option value="${businessType.businessTypeCode}">${businessType.businessTypeCode}. ${businessType.businessTypeName}</option>
						</c:forEach>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">企業名</div>
					<div class="six wide column">
						<div class="ui fluid input">
							<input type="text" id="companyName" placeholder="アルファベット、数字は半角で入力">
						</div>
					</div>
					<div class="two wide column">検索名</div>
					<div class="six wide column ui input">
						<div class="ui fluid input">
							<input type="text" id="searchCompanyName" placeholder="漢字、ひらがなをカタカナで入力">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">従業員数</div>
					<div class="six wide column">
						<div class="ui fluid input"><input type="text" id="workersCount"></div>
					</div>
					<div class="two wide column">所在地</div>
					<div class="six wide column">
						<div class="ui fluid input"><input type="text" id="companyAddress"></div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">ドメイン</div>
					<div class="six wide column">
						<div class="ui fluid input"><input type="text" id="companyDomain"></div>
					</div>
					<div class="two wide column">ホームページ</div>
					<div class="six wide column">
						<div class="ui fluid input"><input type="text" id="companyHomepage"></div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">詳細</div>
					<div class="fourteen wide column">
						<textarea rows="5" id="companyExplain"></textarea>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">申請者</div>
					<div class="six wide column" id="userNickName"></div>
					<div class="two wide column">申請日</div>
					<div class="six wide column" id="appDate"></div>
				</div>
			</div>
		</div>
		<div class="actions">
			<button class="ui primary button" id="comSubmit"></button>
		</div>
	</div>
	<div class="ui tiny modal" id="rejection">
		<i class="close cancel icon"></i>
		<div class="header">却下事由</div>
		<div class="content">
			<div class="ui grid">
				<div class="three wide column">
					<select class="ui compact selection dropdown" onchange="setRejectReason(this)">
						<option value="0">確認不能</option>
						<option value="1">承認済み</option>
						<option value="2">その他</option>
					</select>
				</div>
				<div class="thirteen wide column">
					<div class="ui fluid disabled input"><input type="text" id="reason" value="確認不能" readonly></div>
				</div>
			</div>
		</div>
		<div class="actions">
			<button class="ui primary button" onclick="rejectCompanyList();">却下</button>
		</div>
	</div>
</div>
<script>
	let checkedList;

	function checkCompanyRow(checkbox) {
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

	function checkAllCompanyRows(checked) {
		if (checked) {
			const checkboxList = document.querySelectorAll("td > input[type=checkbox]");
			for (let i = checkboxList.length - 1; i > -1; --i) {
				if (!checkboxList[i].checked) {
					checkboxList[i].checked = true;
					checkCompanyRow(checkboxList[i]);
				}
			}
		} else {
			const checkboxList = document.querySelectorAll("td > input[type=checkbox]:checked");
			for (let i = checkboxList.length - 1; i > -1; --i) {
				checkboxList[i].checked = false;
				checkCompanyRow(checkboxList[i]);
			}
		}
	}

	function getCompanyListByPage(page) {
		const searchParams = new URLSearchParams(location.search);
		if (page === 1) {
			searchParams.delete("page");
		} else {
			searchParams.set("page", String(page));
		}
		getCompanyList(searchParams);
	}

	function getCompanyList(searchParams) {
		const url = new URL(location.href);
		searchParams.set("ajax", "true");
		url.search = searchParams;
		fetch(url.toString(), {
			method: "GET",
			headers: {
				"Content-Type": "application/json"
			}
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			} else {
				throw response.status;
			}
		}).then(function (result) {
			const tbody = document.querySelector("tbody");
			const pagination = document.getElementById("pagination");
			history.replaceState({
				"tbody": tbody.innerHTML,
				"pagination": pagination.innerHTML
			}, "");
			const companyList = result.companyList;
			const navi = result.navi;
			const length = companyList.length;
			let html = "";
			for (let i = 0; i < length; ++i) {
				html += "<tr><td class=\"center aligned\"><input type=\"checkbox\" class=\"ui checkbox\" " +
						"data-id=\"" + companyList[i].companyId + "\" onclick=\"checkCompanyRow(this);\">" +
						"<input type=\"hidden\" value=\"" + companyList[i].searchCompanyName + "\">" +
						"<input type=\"hidden\" value=\"" + companyList[i].companyHomepage + "\">" +
						"<input type=\"hidden\" value=\"" + companyList[i].companyExplain + "\"></td>" +
						"<td class=\"center aligned verifyFlag\" data-value=\"" + companyList[i].verifyFlag + "\"></td>" +
						"<td class=\"center aligned closingFlag\" data-value=\"" + companyList[i].closingFlag + "\"></td>" +
						"<td>" + companyList[i].companyName + "</td>" +
						"<td class=\"businessType\" data-value=\"" + companyList[i].businessTypeCode + "\"></td>" +
						"<td>" + companyList[i].companyAddress + "</td>" +
						"<td class=\"center aligned\">" + companyList[i].foundingDate + "</td>" +
						"<td class=\"right aligned\">" + companyList[i].workersCount + "</td>" +
						"<td>" + companyList[i].companyDomain + "</td>" +
						"<td>" + companyList[i].userNickName + "</td>" +
						"<td class=\"center aligned\">" + companyList[i].appDate + "</td></tr>";
			}
			tbody.innerHTML = html;
			setTableByCodeToName(tbody);
			html = "<div class=\"ui pagination menu\"";
			if (navi.startPage < navi.pagination) {
				html += " style=\"visibility: hidden;\"><div class=\"item\">前へ</div></div>";
			} else {
				html += "><a class=\"item\" href=\"javascript:getCompanyListByPage(" + String(navi.startPage - 1) +
					");\">前へ</a></div>";
			}
			html += "<div class=\"ui pagination menu\">";
			for (let page = navi.startPage; page <= navi.endPage; ++page) {
				if (page === navi.currentPage) {
					html += "<div class=\"active item\">" + page + "</div>";
				} else {
					html += "<a class=\"item\" href=\"javascript:getCompanyListByPage(" + page + ");\">" + page + "</a>";
				}
			}
			html += "</div><div class=\"ui pagination menu\"";
			if (navi.endPage < navi.totalPage) {
				html += "><a class=\"item\" href=\"javascript:getCompanyListByPage(" + String(navi.endPage + 1) +
					");\">次へ</a></div>";
			} else {
				html += " style=\"visibility: hidden;\"><div class=\"item\">次へ</div></div>";
			}
			pagination.innerHTML = html;
			const url = new URL(location.href);
			if (searchParams.get("page") === "1") {
				searchParams.delete("page");
			}
			if (searchParams.get("verifyFlag") === "0") {
				searchParams.delete("verifyFlag");
			}
			if (searchParams.get("closingFlag") === "0") {
				searchParams.delete("closingFlag");
			}
			searchParams.delete("ajax");
			url.search = searchParams;
			history.pushState({
				"tbody": tbody.innerHTML,
				"pagination": pagination.innerHTML
			}, "", url.toString());
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}

	function checkSelectedList() {
		const checkboxList = document.querySelectorAll("td > input[type=checkbox]:checked");
		const checkboxListLength = checkboxList.length;
		if (checkboxListLength) {
			checkedList = [];
			for (let i = 0; i < checkboxListLength; ++i) {
				const td = checkboxList[i].closest("tr").children;
				const hidden = td[0].children;
				checkedList.push({
					"companyId": Number(hidden[0].dataset.id),
					"verifyFlag": td[1].dataset.value,
					"closingFlag": td[2].dataset.value,
					"companyName": td[3].innerText.trim(),
					"searchCompanyName": hidden[1].value.trim(),
					"businessTypeCode": td[4].dataset.value,
					"companyAddress": td[5].innerText.trim(),
					"foundingDate": td[6].innerText,
					"workersCount": td[7].innerText.trim(),
					"companyDomain": td[8].innerText.trim(),
					"userNickName": td[9].innerText,
					"appDate": td[10].innerText,
					"companyHomepage": hidden[2].value.trim(),
					"companyExplain": hidden[3].value.trim()
				});
			}
			openEditCompanyListModal();
		} else {
			alert("1つ以上の項目を選択してください");
		}
	}

	function editCompany(index) {
		document.getElementById("comInfo").dataset.id = String(checkedList[index].companyId);
		document.getElementById("verifyFlag").innerText = getVerifyFlagName(checkedList[index].verifyFlag);
		document.getElementById("foundingDate").value = checkedList[index].foundingDate;
		document.getElementById("closingFlag").options[checkedList[index].closingFlag].selected = true;
		const businessTypeCodeOptions = document.getElementById("businessTypeCode").children;
		for (let i = businessTypeCodeOptions.length - 1; i > -1; --i) {
			if (businessTypeCodeOptions[i].value === checkedList[index].businessTypeCode) {
				businessTypeCodeOptions[i].selected = true;
				break;
			}
		}
		document.getElementById("companyName").value = checkedList[index].companyName;
		document.getElementById("searchCompanyName").value = checkedList[index].searchCompanyName;
		document.getElementById("workersCount").value = checkedList[index].workersCount;
		document.getElementById("companyAddress").value = checkedList[index].companyAddress;
		document.getElementById("companyDomain").value = checkedList[index].companyDomain;
		document.getElementById("companyHomepage").value = checkedList[index].companyHomepage;
		document.getElementById("companyExplain").value = checkedList[index].companyExplain;
		document.getElementById("userNickName").innerText = checkedList[index].userNickName;
		document.getElementById("appDate").innerText = checkedList[index].appDate;
		$("#comInfo").modal("show");
	}

	function openEditCompanyListModal() {
		const comSubmit = document.getElementById("comSubmit");
		comSubmit.setAttribute("onclick", "updateCompany();");
		comSubmit.innerText = "更新";
		document.getElementById("comInfo").dataset.index = "0";
		editCompany(0);
	}

	async function companySubmit(method, data) {
		let result = -1;
		await fetch(location.pathname, {
			method: method,
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify(data)
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

	function isSearchCompanyName(searchCompanyName) {
		return searchCompanyName.match(/^[0-9A-Za-zァ-ヶー]*$/);
	}

	function approveCompanyList() {
		checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
		const checkedListLength = checkedList.length;
		if (checkedListLength < 1) {
			alert("1つ以上の項目を選択してください");
		} else {
			const unfilledCheckedList = [];
			const companyIdList = [];
			for (let i = 0; i < checkedListLength; ++i) {
				const td = checkedList[i].closest("tr").children;
				const hidden = td[0].children;
				if (td[1].innerText === "ERROR" || td[2].innerText === "ERROR" || !td[3].innerText.trim().length ||
					!hidden[1].value.trim().length || !isSearchCompanyName(hidden[1].value.trim()) || td[4].innerText === "ERROR" ||
					!td[5].innerText.trim().length || !td[6].innerText.length || !td[7].innerText.trim().length ||
					!td[8].innerText.trim().length || !td[9].innerText.length || !td[10].innerText.length
				) {
					unfilledCheckedList.push({
						"companyId": Number(hidden[0].dataset.id),
						"verifyFlag": td[1].dataset.value,
						"closingFlag": td[2].dataset.value,
						"companyName": td[3].innerText.trim(),
						"searchCompanyName": hidden[1].value.trim(),
						"businessTypeCode": td[4].dataset.value,
						"companyAddress": td[5].innerText.trim(),
						"foundingDate": td[6].innerText,
						"workersCount": td[7].innerText.trim(),
						"companyDomain": td[8].innerText.trim(),
						"userNickName": td[9].innerText,
						"appDate": td[10].innerText,
						"companyHomepage": hidden[2].value.trim(),
						"companyExplain": hidden[3].value.trim()
					});
				} else {
					companyIdList.push(Number(hidden[0].dataset.id));
				}
			}
			if (unfilledCheckedList.length) {
				alert("申請の内容を確認してください");
				checkedList = unfilledCheckedList;
				openEditCompanyListModal();
			} else if (confirm("承認しますか？")) {
				companySubmit("PATCH", {
					"companyIdList": companyIdList,
					"verifyFlag": "1"
				}).then(function (result) {
					if (result === companyIdList.length) {
						alert("申請を承認しました");
						for (let i = 0; i < checkedListLength; ++i) {
							const verifyFlag = checkedList[i].closest("td").nextElementSibling;
							verifyFlag.dataset.value = "1";
							verifyFlag.innerText = "承認";
						}
						checkAllCompanyRows(false);
					} else if (result) {
						alert("一部の承認に失敗しました");
						if (confirm("ページをリフレッシュします")) {
							location.reload();
						}
					} else if (result > -1) {
						alert("承認に失敗しました");
					}
				});
			}
		}
	}

	function setRejectReason(selection) {
		const reason = document.getElementById("reason");
		const index = selection.value;
		if (index === "2") {
			reason.closest("div").className = "ui fluid input";
			reason.value = "";
			reason.readOnly = false;
			reason.focus();
		} else {
			reason.closest("div").className = "ui fluid disabled input";
			reason.value = selection.options[index].innerText;
			reason.readOnly = true;
		}
	}

	function openRejectionModal() {
		checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
		if (checkedList.length) {
			$("#rejection").modal("show");
		} else {
			alert("1つ以上の項目を選択してください");
		}
	}

	function rejectCompanyList() {
		const reason = document.getElementById("reason").value.trim();
		if (!reason.length) {
			alert("理由を入力してください");
			document.getElementById("reason").focus();
		} else if (confirm("却下しますか？")) {
			let companyIdList = [];
			const length = checkedList.length;
			for (let i = 0; i < length; ++i) {
				companyIdList.push(Number(checkedList[i].dataset.id));
			}
			companySubmit("PATCH", {
				"companyIdList": companyIdList,
				"verifyFlag": "2",
				"reason": reason
			}).then(function (result) {
				if (result === length) {
					alert("申請を却下しました");
					for (let i = 0; i < length; ++i) {
						const verifyFlag = checkedList[i].closest("td").nextElementSibling;
						verifyFlag.dataset.value = "2";
						verifyFlag.innerText = "却下";
					}
					checkAllCompanyRows(false);
					$("#rejection").modal("hide");
				} else if (result > 0) {
					alert("一部の却下に失敗しました");
				} else if (result > -1) {
					alert("申請の却下に失敗しました");
				}
			});
		}
	}

	function checkForm() {
		const foundingDate = document.getElementById("foundingDate");
		if (!foundingDate.value.length) {
			alert("設立日を入力してください");
			foundingDate.focus();
			return false;
		}
		const companyName = document.getElementById("companyName");
		if (!companyName.value.trim().length) {
			alert("企業名を入力してください");
			companyName.focus();
			return false;
		}
		const searchCompanyName = document.getElementById("searchCompanyName");
		if (!searchCompanyName.value.trim().length) {
			alert("検索名を入力してください");
			searchCompanyName.focus();
			return false;
		}
		if (!isSearchCompanyName(searchCompanyName.value.trim())) {
			alert("検索名は半角アルファベット、半角数字、全角カタカナ、長音符のみ入力できます");
			searchCompanyName.focus();
			return false;
		}
		const workersCount = document.getElementById("workersCount");
		if (!workersCount.value.trim().length) {
			alert("従業員数を入力してください");
			workersCount.focus();
			return false;
		}
		const companyAddress = document.getElementById("companyAddress");
		if (!companyAddress.value.trim().length) {
			alert("所在地を入力してください");
			companyAddress.focus();
			return false;
		}
		const companyDomain = document.getElementById("companyDomain");
		if (!companyDomain.value.trim().length) {
			alert("ドメインを入力してください");
			companyDomain.focus();
			return false;
		}
		const companyHomepage = document.getElementById("companyHomepage");
		if (!companyHomepage.value.trim().length) {
			alert("ホームページを入力してください");
			companyHomepage.focus();
			return false;
		}
		const companyExplain = document.getElementById("companyExplain");
		if (!companyExplain.value.trim().length) {
			alert("詳細を入力してください");
			companyExplain.focus();
			return false;
		}
		return true;
	}

	function getCompanyData() {
		return {
			"foundingDate": document.getElementById("foundingDate").value,
			"closingFlag": document.getElementById("closingFlag").value,
			"businessTypeCode": document.getElementById("businessTypeCode").value,
			"companyName": document.getElementById("companyName").value.trim(),
			"searchCompanyName": document.getElementById("searchCompanyName").value.trim(),
			"workersCount": document.getElementById("workersCount").value.trim(),
			"companyAddress": document.getElementById("companyAddress").value.trim(),
			"companyDomain": document.getElementById("companyDomain").value.trim(),
			"companyHomepage": document.getElementById("companyHomepage").value.trim(),
			"companyExplain": document.getElementById("companyExplain").value.trim()
		};
	}

	function getClosingFlagName(closingFlag) {
		switch (closingFlag) {
			case "0":
				return "営業";
			case "1":
				return "廃業";
			default:
				return "ERROR";
		}
	}

	function updateCompany() {
		if (checkForm() && confirm("会社の情報を更新しますか？")) {
			const company = getCompanyData();
			const companyId = document.getElementById("comInfo").dataset.id;
			company.companyId = Number(companyId);
			companySubmit("PUT", company).then(function (result) {
				if (result > 0) {
					const checkboxList = document.querySelectorAll("td > input[type=checkbox]:checked");
					for (let i = checkboxList.length - 1; i > -1; --i) {
						if (companyId === checkboxList[i].dataset.id) {
							const td = checkboxList[i].closest("tr").children;
							const hidden = td[0].children;
							hidden[1].value = company.searchCompanyName;
							hidden[2].value = company.companyHomepage;
							hidden[3].value = company.companyExplain;
							td[2].dataset.value = company.closingFlag;
							td[2].innerText = getClosingFlagName(company.closingFlag);
							td[3].innerText = company.companyName;
							td[4].dataset.value = company.businessTypeCode;
							td[4].innerText = getBusinessTypeName(company.businessTypeCode);
							td[5].innerText = company.companyAddress;
							td[6].innerText = company.foundingDate;
							td[7].innerText = company.workersCount;
							td[8].innerText = company.companyDomain;
							break;
						}
					}
					alert("更新に成功しました");
					$("#comInfo").modal("hide");
				} else if (result > -1) {
					alert("更新に失敗しました");
				}
			});
		}
	}

	function openApplyCompanyModal() {
		document.getElementById("verifyFlag").innerText = "待機";
		document.getElementById("closingFlag").options[0].selected = true;
		document.getElementById("businessTypeCode").options[0].selected = true;
		document.getElementById("foundingDate").value = document.getElementById("companyName").value =
			document.getElementById("searchCompanyName").value = document.getElementById("workersCount").value =
			document.getElementById("companyAddress").value = document.getElementById("companyDomain").value =
			document.getElementById("companyHomepage").value = document.getElementById("companyExplain").value =
			document.getElementById("userNickName").innerText = document.getElementById("appDate").innerText = "";
		const comSubmit = document.getElementById("comSubmit");
		comSubmit.setAttribute("onclick", "applyCompany();");
		comSubmit.innerText = "申請";
		checkedList = [];
		$("#comInfo").modal("show");
	}

	function applyCompany() {
		if (checkForm() && confirm("新しい会社を申請します。承認は自動的に行われます。")) {
			const company = getCompanyData();
			company.verifyFlag = "1";
			companySubmit("POST", company).then(function (result) {
				if (result) {
					alert("生成に成功しました");
					$("#comInfo").modal("hide");
				} else if (result > -1) {
					alert("生成に失敗しました");
				}
			});
		}
	}

	addEventListener("DOMContentLoaded", function () {
		<%-- 検索 --%>
		const verifyFilter = document.getElementById("verifyFilter");
		const closingFilter = document.getElementById("closingFilter");
		const searchTarget = document.getElementById("searchTarget");
		const inputSearchKeyword = document.getElementById("searchKeyword");
		const searchParams = new URLSearchParams(location.search);
		const setSearchParameter = function () {
			verifyFilter.value = searchParams.has("verifyFlag") ? searchParams.get("verifyFlag") : "0";
			closingFilter.value = searchParams.has("closingFlag") ? searchParams.get("closingFlag") : "0";
			if (searchParams.has("searchKeyword")) {
				searchTarget.value = searchParams.get("searchTarget");
				inputSearchKeyword.value = searchParams.get("searchKeyword");
			} else {
				searchTarget.options[0].selected = true;
				inputSearchKeyword.value = "";
			}
		};
		setSearchParameter();
		const getCompanyListByChangedFilter = function (flagName, flag) {
			if (flag === "0") {
				searchParams.delete(flagName);
			} else {
				searchParams.set(flagName, flag);
			}
			searchParams.delete("page");
			searchParams.delete("searchTarget");
			searchParams.delete("searchKeyword");
			searchTarget.options[0].selected = true;
			inputSearchKeyword.value = "";
			getCompanyList(searchParams);
		};
		verifyFilter.addEventListener("change", function () {
			getCompanyListByChangedFilter("verifyFlag", this.value);
		});
		closingFilter.addEventListener("change", function () {
			getCompanyListByChangedFilter("closingFlag", this.value);
		});
		const search = function () {
			const searchKeyword = inputSearchKeyword.value.trim();
			if (searchKeyword.length > 0) {
				const searchParams = new URLSearchParams(location.search);
				searchParams.delete("page");
				searchParams.set("searchTarget", searchTarget.value);
				searchParams.set("searchKeyword", searchKeyword);
				getCompanyList(searchParams);
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
		document.getElementById("foundingDate").setAttribute("max", new Date().toISOString().substring(0, 10));
		$("#comInfo").modal({
			duration: 100,
			closable: false,
			autofocus: false,
			onVisible: function () {
				document.getElementById("companyName").focus();
			},
			onHidden: function () {
				const comInfo = document.getElementById("comInfo");
				const index = Number(comInfo.dataset.index) + 1;
				if (index < checkedList.length) {
					comInfo.dataset.index = String(index);
					editCompany(index);
				}
			}
		});
		$("#rejection").modal({
			duration: 100,
			closable: false,
			autofocus: false,
			onVisible: function () {
				document.getElementById("reason").focus();
			}
		});

		<%-- Pjax --%>
		onpopstate = function (event) {
			document.querySelector("tbody").innerHTML = event.state.tbody;
			document.getElementById("pagination").innerHTML = event.state.pagination;
			setSearchParameter();
		};
	});
</script>
</body>
</html>