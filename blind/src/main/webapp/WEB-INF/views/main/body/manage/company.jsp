<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
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
		max-width: 100%;
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
				<thead class="center aligned"><tr>
					<th style="width: 2%;">
						<input type="checkbox" class="ui checkbox" onclick="checkAllCompanyRows(this.checked)">
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
				</tr></thead>
				<tbody><tr><td class="center aligned" colspan="11">データが存在しません</td></tr></tbody>
			</table>
		</div>
		<div class="row">
			<div class="five wide column"></div>
			<div class="six wide column center aligned" id="pagination">
				<div class="ui pagination menu" style="visibility: hidden;"><a class="item">前へ</a></div>
				<div class="ui pagination menu"><div class="active item">1</div></div>
				<div class="ui pagination menu" style="visibility: hidden;"><a class="item">次へ</a></div>
			</div>
			<div class="five wide column right aligned">
				<button class="ui green button" onclick="approveCompanyList()">承認</button>
				<button class="ui red button" onclick="openRejectionModal()">却下</button>
				<button class="ui yellow button" onclick="checkSelectedList()">編集</button>
				<button class="ui grey button" onclick="openApplyCompanyModal()">新規</button>
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
					<div class="two wide column">申請番号</div>
					<div class="six wide column" id="companyId"></div>
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
						<select class="ui compact selection dropdown" id="businessTypeCode"></select>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">企業名</div>
					<div class="six wide column">
						<div class="ui fluid input"><input type="text" id="companyName"></div>
					</div>
					<div class="two wide column">設立日</div>
					<div class="six wide column">
						<div class="ui input"><input type="date" id="foundingDate"></div>
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
					<textarea class="fourteen wide column fluid" rows="5" id="companyExplain"></textarea>
				</div>
				<div class="row">
					<div class="two wide column">申請者</div>
					<div class="six wide column" id="userNickName"></div>
					<div class="two wide column">申請日</div>
					<div class="six wide column" id="appDate"></div>
				</div>
			</div>
		</div>
		<div class="actions"><button class="ui primary button" id="comSubmit"></button></div>
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
					<div class="ui fluid disabled input"><input type="text" id="reason" value="確認不能"></div>
				</div>
			</div>
		</div>
		<div class="actions"><button class="ui primary button" onclick="rejectCompanyList()">却下</button></div>
	</div>
</div>
<script>
	const companyList = [];
	<c:forEach var="company" items="${companyList}">
	companyList.push({
		"companyId": ${company.companyId},
		"companyHomepage": "${company.companyHomepage}",
		"companyExplain": "${company.companyExplain}",
		"verifyFlag": "${company.verifyFlag}",
		"closingFlag": "${company.closingFlag}",
		"companyName": "${company.companyName}",
		"businessTypeCode": "${company.businessTypeCode}",
		"companyAddress": "${company.companyAddress}",
		"foundingDate": "${company.foundingDate}",
		"workersCount": "${company.workersCount}",
		"companyDomain": "${company.companyDomain}",
		"userNickName": "${company.userNickName}",
		"appDate": "${company.appDate}"
	});
	</c:forEach>
	const businessType = new Map();
	<c:forEach var="businessType" items="${businessTypeList}">
		businessType.set("${businessType.businessTypeCode}", "${businessType.businessTypeName}");
	</c:forEach>
	let checkedList;

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

	function checkCompanyRow(checkbox) {
		if (checkbox.checked) {
			checkbox.closest("tr").setAttribute("class", "warning");
			if (companyList.length === document.querySelectorAll("td > input[type=checkbox]:checked").length) {
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

	function checkSelectedList() {
		checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
		const checkedListLength = checkedList.length;
		if (checkedListLength < 1) {
			alert("1つ以上の項目を選択してください");
		} else {
			openEditCompanyListModal();
		}
	}

	function editCompany(checkedListIndex) {
		const index = checkedList[checkedListIndex].dataset.index;
		document.getElementById("verifyFlag").innerText = getVerifyFlagName(companyList[index].verifyFlag);
		document.getElementById("companyId").innerText = String(companyList[index].companyId);
		document.getElementById("closingFlag").options[companyList[index].closingFlag].selected = true;
		const businessTypeCodeOptions = document.getElementById("businessTypeCode").children;
		for (let i = businessTypeCodeOptions.length - 1; i > -1; --i) {
			if (businessTypeCodeOptions[i].value === companyList[index].businessTypeCode) {
				businessTypeCodeOptions[i].selected = true;
				break;
			}
		}
		document.getElementById("companyName").value = companyList[index].companyName;
		document.getElementById("foundingDate").value = companyList[index].foundingDate;
		document.getElementById("workersCount").value = companyList[index].workersCount;
		document.getElementById("companyAddress").value = companyList[index].companyAddress;
		document.getElementById("companyDomain").value = companyList[index].companyDomain;
		document.getElementById("companyHomepage").value = companyList[index].companyHomepage;
		document.getElementById("companyExplain").value = companyList[index].companyExplain;
		document.getElementById("userNickName").innerText = companyList[index].userNickName;
		document.getElementById("appDate").innerText = companyList[index].appDate;
		$("#comInfo").modal("show");
	}

	function openEditCompanyListModal() {
		const comSubmit = document.getElementById("comSubmit");
		comSubmit.setAttribute("onclick", "updateCompany()");
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

	function approveCompanyList() {
		checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
		const checkedListLength = checkedList.length;
		if (checkedListLength < 1) {
			alert("1つ以上の項目を選択してください");
		} else {
			let unfilledCheckedList = [];
			let companyIdList = [];
			for (let i = 0; i < checkedListLength; ++i) {
				let isAllFilled = true;
				const index = Number(checkedList[i].dataset.index);
				const values = Object.values(companyList[index]);
				for (let j = values.length - 1; j > -1 && isAllFilled; --j) {
					switch (typeof values[j]) {
						case "number":
							break;
						case "string":
							if (values[j].trim().length < 1) {
								unfilledCheckedList.push(checkedList[i]);
								isAllFilled = false;
							}
							break;
						default:
							unfilledCheckedList.push(companyList[index]);
							isAllFilled = false;
							break;
					}
				}
				if (isAllFilled) {
					companyIdList.push(companyList[index].companyId);
				}
			}
			if (unfilledCheckedList.length > 0) {
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
					} else if (result > 0) {
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
			reason.closest("div").setAttribute("class", "ui fluid input");
			reason.value = "";
			reason.focus();
		} else {
			reason.closest("div").setAttribute("class", "ui fluid disabled input");
			reason.value = selection.options[index].innerText;
		}
	}

	function openRejectionModal() {
		checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
		if (checkedList.length < 1) {
			alert("1つ以上の項目を選択してください");
		} else {
			$("#rejection").modal("show");
		}
	}

	function rejectCompanyList() {
		const reason = document.getElementById("reason").value.trim();
		if (reason.length < 1) {
			alert("理由を入力してください");
			document.getElementById("reason").focus();
		} else if (confirm("却下しますか？")) {
			let companyIdList = [];
			for (let i = checkedList.length - 1; i > -1; --i) {
				companyIdList.push(companyList[Number(checkedList[i].dataset.index)].companyId);
			}
			companySubmit("PATCH", {
				"companyIdList": companyIdList,
				"verifyFlag": "2",
				"reason": reason
			}).then(function (result) {
				if (result === companyIdList.length) {
					alert("申請を却下しました");
					for (let i = checkedList.length - 1; i > -1; --i) {
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
		const companyName = document.getElementById("companyName");
		if (companyName.value.trim().length < 1) {
			alert("企業名を入力してください");
			companyName.focus();
			return false;
		}
		const foundingDate = document.getElementById("foundingDate");
		if (foundingDate.value.length < 1) {
			alert("設立日を入力してください");
			foundingDate.focus();
			return false;
		}
		const workersCount = document.getElementById("workersCount");
		if (workersCount.value.trim().length < 1) {
			alert("従業員数を入力してください");
			workersCount.focus();
			return false;
		}
		const companyAddress = document.getElementById("companyAddress");
		if (companyAddress.value.trim().length < 1) {
			alert("所在地を入力してください");
			companyAddress.focus();
			return false;
		}
		const companyDomain = document.getElementById("companyDomain");
		if (companyDomain.value.trim().length < 1) {
			alert("ドメインを入力してください");
			companyDomain.focus();
			return false;
		}
		const companyHomepage = document.getElementById("companyHomepage");
		if (companyHomepage.value.trim().length < 1) {
			alert("ホームページを入力してください");
			companyHomepage.focus();
			return false;
		}
		const companyExplain = document.getElementById("companyExplain");
		if (companyExplain.value.trim().length < 1) {
			alert("詳細を入力してください");
			companyExplain.focus();
			return false;
		}
		return true;
	}

	function getCompanyData() {
		return {
			"closingFlag": document.getElementById("closingFlag").value,
			"businessTypeCode": document.getElementById("businessTypeCode").value,
			"companyName": document.getElementById("companyName").value.trim(),
			"foundingDate": document.getElementById("foundingDate").value,
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
			const companyId = Number(document.getElementById("companyId").innerText);
			company.companyId = companyId;
			companySubmit("PUT", company).then(function (result) {
				if (result > 0) {
					alert("更新に成功しました");
					for (let i = companyList.length - 1; i > -1; --i) {
						if (companyId === companyList[i].companyId) {
							const td = document.querySelectorAll("tbody > tr")[i].children;
							td[0].checked = false;
							checkCompanyRow(td[0]);
							companyList[i].closingFlag = td[2].dataset.value = company.closingFlag;
							td[2].innerText = getClosingFlagName(company.closingFlag);
							companyList[i].companyName = td[3].innerText = company.companyName;
							companyList[i].businessTypeCode = company.businessTypeCode;
							td[4].innerText = businessType.get(company.businessTypeCode);
							companyList[i].companyAddress = td[5].innerText = company.companyAddress;
							companyList[i].foundingDate = td[6].innerText = company.foundingDate;
							companyList[i].workersCount = td[7].innerText = company.workersCount;
							companyList[i].companyDomain = td[8].innerText = company.companyDomain;
							companyList[i].companyHomepage = company.companyHomepage;
							companyList[i].companyExplain = company.companyExplain;
							break;
						}
					}
					$("#comInfo").modal("hide");
				} else if (result > -1) {
					alert("更新に失敗しました");
				}
			});
		}
	}

	function openApplyCompanyModal() {
		document.getElementById("verifyFlag").innerText = "待機";
		document.getElementById("companyId").innerText = "";
		document.getElementById("closingFlag").options[0].selected = true;
		document.getElementById("businessTypeCode").options[0].selected = true;
		document.getElementById("companyName").value = "";
		document.getElementById("foundingDate").value = "";
		document.getElementById("workersCount").value = "";
		document.getElementById("companyAddress").value = "";
		document.getElementById("companyDomain").value = "";
		document.getElementById("companyHomepage").value = "";
		document.getElementById("companyExplain").value = "";
		document.getElementById("userNickName").innerText = "";
		document.getElementById("appDate").innerText = "";
		const comSubmit = document.getElementById("comSubmit");
		comSubmit.setAttribute("onclick", "applyCompany()");
		comSubmit.innerText = "申請";
		checkedList = [];
		$("#comInfo").modal("show");
	}

	function applyCompany() {
		if (checkForm() && confirm("新しい会社を申請します。承認は自動的に行われます。")) {
			const company = getCompanyData();
			company.verifyFlag = "1";
			companySubmit("POST", company).then(function (result) {
				if (result > 0) {
					alert("生成に成功しました");
					$("#comInfo").modal("hide");
				} else if (result > -1) {
					alert("生成に失敗しました");
				}
			});
		}
	}

	onload = function () {
		// テーブル
		let html = "";
		const companyListLength = companyList.length;
		if (companyListLength > 0) {
			for (let i = 0; i < companyListLength; ++i) {
				html += "<tr><td class=\"center aligned\"><input type=\"checkbox\" class=\"ui checkbox\" " +
						"data-index=\"" + i + "\" onclick=\"checkCompanyRow(this)\"></td>" +
						"<td class=\"center aligned verifyFlag\" data-value=\"" + companyList[i].verifyFlag +
						"\">" + getVerifyFlagName(companyList[i].verifyFlag) + "</td>" +
						"<td class=\"center aligned closingFlag\">" +
						getClosingFlagName(companyList[i].closingFlag) + "</td>" +
						"<td>" + companyList[i].companyName + "</td>";
				if (businessType.has(companyList[i].businessTypeCode)) {
					html += "<td>" + businessType.get(companyList[i].businessTypeCode) + "</td>";
				} else {
					html += "<td>ERROR</td>";
				}
				html += "<td>" + companyList[i].companyAddress + "</td>" +
						"<td class=\"center aligned\">" + companyList[i].foundingDate + "</td>" +
						"<td>" + companyList[i].workersCount + "</td>" +
						"<td>" + companyList[i].companyDomain + "</td>" +
						"<td>" + companyList[i].userNickName + "</td>" +
						"<td class=\"center aligned\">" + companyList[i].appDate + "</td></tr>";
			}
			document.querySelector("tbody").innerHTML = html;
		}
		const verifyFlagList = document.getElementsByClassName("verifyFlag");
		for (let i = verifyFlagList.length - 1; i > -1; --i) {
			setVerifiedColor(verifyFlagList[i]);
		}

		// 検索
		const searchParams = new URLSearchParams(location.search);
		const searchTarget = document.getElementById("searchTarget");
		const inputSearchKeyword = document.getElementById("searchKeyword");
		const inputSearchIcon = document.getElementById("searchIcon");
		const searchTargetParameter = searchParams.get("searchTarget");
		if (searchTargetParameter !== null) {
			const searchKeyword = searchParams.get("searchKeyword");
			for (let i = searchTarget.options.length - 1; i > -1; --i) {
				if (searchTarget.options[i].value === searchTargetParameter) {
					searchTarget.options[i].selected = true;
				}
			}
			inputSearchKeyword.value = searchKeyword;
		}
		inputSearchKeyword.addEventListener("keydown", function (event) {
			if (event.key === "Enter") {
				const searchKeyword = inputSearchKeyword.value.trim();
				if (searchKeyword.length > 0) {
					searchParams.delete("page");
					searchParams.set("searchTarget", searchTarget.value);
					searchParams.set("searchKeyword", searchKeyword);
					location.search = searchParams.toString();
				} else {
					alert("キーワードを入力してください");
				}
			}
		});
		inputSearchIcon.addEventListener("click", function (event) {
			const searchKeyword = inputSearchKeyword.value.trim();
			if (searchKeyword.length > 0) {
				searchParams.delete("page");
				searchParams.set("searchTarget", searchTarget.value);
				searchParams.set("searchKeyword", searchKeyword);
				location.search = searchParams.toString();
			} else {
				alert("キーワードを入力してください");
			}
		});		
		const verifyFilter = document.getElementById("verifyFilter");
		const verifyFlag = searchParams.get("verifyFlag");
		if (verifyFlag !== null) {
			verifyFilter.options[Number(verifyFlag)].selected = true;
		}
		verifyFilter.addEventListener("change", function () {
			searchParams.delete("page");
			if (verifyFilter.value === "0") {
				searchParams.delete("verifyFlag");
			} else {
				searchParams.set("verifyFlag", this.value);
			}
			location.search = searchParams.toString();
		});
		const closingFilter = document.getElementById("closingFilter");
		const closingFlag = searchParams.get("closingFlag");
		if (closingFlag !== null) {
			document.getElementById("closingFilter").options[Number(closingFlag)].selected = true;
		}
		closingFilter.addEventListener("change", function () {
			searchParams.delete("page");
			if (closingFlag === "0") {
				searchParams.delete("closingFlag");
			} else {
				searchParams.set("closingFlag", this.value);
			}
			location.search = searchParams.toString();
		});

		// ページナビゲーター
		const endPage = ${navi.endPage};
		if (endPage > 1) {
			const pathname = location.pathname;
			searchParams.delete("page");
			const parameter = searchParams.toString();
			const parameterIsExist = parameter.length > 0;
			const getParameterHtml = function (page) {
				if (page > 1) {
					let parameterHtml = "?page=" + page
					if (parameterIsExist) {
						parameterHtml += "&" + parameter;
					}
					return parameterHtml
				} else if (parameterIsExist) {
					return "?" + parameter;
				}
				return "";
			};
			let page = ${navi.startPage};
			if (page === 1) {
				html = "<div class=\"ui pagination menu\" style=\"visibility: hidden\;\">" +
						"<div class=\"item\">前へ</div></div>";
			} else {
				html = "<div class=\"ui pagination menu\"><a class=\"item\" href=\"" + pathname +
						getParameterHtml(page - ${navi.pagination}) + "\">前へ</a></div>";
			}
			html += "<div class=\"ui pagination menu\">";
			while (page <= endPage) {
				if (page === ${navi.currentPage}) {
					html += "<div class=\"active item\">" + page + "</div>";
				} else {
					html += "<a class=\"item\" href=\"" + pathname + getParameterHtml(page) + "\">" + page + "</a>";
				}
				++page;
			}
			html += "</div>";
			if (endPage === ${navi.totalPage}) {
				html += "<div class=\"ui pagination menu\" style=\"visibility: hidden\;\">" +
						"<div class=\"item\">次へ</div></div>";
			} else {
				html += "<div class=\"ui pagination menu\"><a class=\"item\" href=\"" + pathname + "?page=" + page;
				if (parameterIsExist) {
					html += "&" + parameter;
				}
				html += "\">次へ</a></div>";
			}
			document.getElementById("pagination").innerHTML = html;
		}

		// モーダル
		html = "";
		businessType.forEach(function (name, code) {
			html += "<option value =\"" + code + "\">" + code + ". " + name + "</option>";
		});
		document.getElementById("foundingDate").setAttribute("max", new Date().toISOString().substring(0, 10));
		$("#comInfo").modal({
			duration: 100,
			closable: false,
			onHidden: function () {
				const comInfo = document.getElementById("comInfo");
				const index = Number(comInfo.dataset.index) + 1;
				if (index < checkedList.length) {
					comInfo.dataset.index = String(index);
					editCompany(index);
				}
			}
		});
		document.getElementById("businessTypeCode").innerHTML = html;
		$("#rejection").modal({
			duration: 100,
			closable: false
		});
		addEventListener("keydown", function (event) {
			if (event.key === "Escape") {
				$(".ui.modal").modal("hide");
			}
		});
	};
</script>
</body>
</html>