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

	.ui.modal > .actions {
		text-align: center;
	}

	textarea {
		margin: 0;
		max-width: 100%;
		-webkit-box-flex: 1;
		-ms-flex: 1 0 auto;
		flex: 1 0 auto;
		outline: 0;
		-webkit-tap-highlight-color: rgba(255, 255, 255, 0);
		text-align: left;
		line-height: 1.21428571em;
		font-family: Lato, 'Helvetica Neue', Arial, Helvetica, sans-serif;
		padding: .67857143em 1em;
		background: #fff;
		border: 1px solid rgba(34, 36, 38, .15);
		color: rgba(0, 0, 0, .87);
		border-radius: .28571429rem;
		-webkit-transition: border-color .1s ease, -webkit-box-shadow .1s ease;
		transition: border-color .1s ease, -webkit-box-shadow .1s ease;
		transition: box-shadow .1s ease, border-color .1s ease;
		transition: box-shadow .1s ease, border-color .1s ease, -webkit-box-shadow .1s ease;
		-webkit-box-shadow: none;
		box-shadow: none;
	}
</style>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<div class="left floated two wide column">
				<h3 class="ui header">企業管理</h3>
			</div>
			<div class="right floated six wide column right aligned">
				<div class="ui fluid icon input">
					<select class="ui compact selection dropdown" id="searchTarget">
						<option value="companyName">企業名</option>
						<option value="businessTypeName">業種</option>
						<option value="companyAddress">所在地</option>
						<option value="companyDomain">ドメイン</option>
					</select>
					<input type="hidden" id="searchKeyword">
					<input type="text" placeholder="キーワードを入力">
					<i class="search icon"></i>
				</div>
			</div>
		</div>
		<div class="row">
			<table class="ui selectable single line celled table">
				<thead class="center aligned">
				<tr>
					<th style="width: 2%">
						<input type="checkbox" class="ui checkbox" onclick="checkAll(this.checked)">
					</th>
					<th style="width: 5%">
						<select class="ui compact selection dropdown" onchange="search()" id="verifyFilter">
							<option value="0">待機</option>
							<option value="1">承認</option>
							<option value="2">却下</option>
							<option value="3">全部</option>
						</select>
					</th>
					<th style="width: 5%">
						<select class="ui compact selection dropdown" onchange="search()" id="closingFilter">
							<option value="0">営業</option>
							<option value="1">廃業</option>
							<option value="2">全部</option>
						</select>
					</th>
					<th>企業名</th>
					<th>業種</th>
					<th>所在地</th>
					<th style="width: 7%">設立日</th>
					<th>従業員数</th>
					<th>ドメイン</th>
					<th>申請者</th>
					<th style="width: 7%">申請日</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach var="company" items="${companyList}">
					<tr>
						<td class="center aligned">
							<input type="checkbox" class="ui checkbox" onclick="check(this)">
							<input type="hidden" name="companyId" value="${company.companyId}">
							<input type="hidden" value="${company.companyHomepage}">
							<input type="hidden" value="${company.companyExplain}">
						</td>
						<td class="center aligned verifyFlag" data-value="${company.verifyFlag}"></td>
						<td class="center aligned closingFlag" data-value="${company.closingFlag}"></td>
						<td>${company.companyName}</td>
						<td class="businessType" data-value="${company.businessTypeCode}"></td>
						<td>${company.companyAddress}</td>
						<td class="center aligned">${company.foundingDate}</td>
						<td>${company.workersCount}</td>
						<td>${company.companyDomain}</td>
						<td>${company.userNickName}</td>
						<td class="center aligned">${company.appDate}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="five wide column"></div>
			<div class="six wide column center aligned">
				<div class="ui pagination menu">
					<c:if test="${navi.startPageGroup gt navi.pagePerGroup}">
						<a class="item navi"
						   href="${pageContext.request.contextPath}/manage/company?page=${navi.currentPage - navi.pagePerGroup}">前へ</a>
					</c:if>
					<c:forEach var="page" begin="${navi.startPageGroup}" end="${navi.endPageGroup}">
						<c:choose>
							<c:when test="${page eq navi.currentPage}">
								<div class="active item">${page}</div>
							</c:when>
							<c:otherwise>
								<a class="item navi"
								   href="${pageContext.request.contextPath}/manage/company?page=${page}">${page}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${navi.endPageGroup lt navi.totalPageCount}">
						<a class="item navi"
						   href="${pageContext.request.contextPath}/manage/company?page=${navi.currentPage + navi.pagePerGroup}">次へ</a>
					</c:if>
				</div>
			</div>
			<div class="five wide column right aligned">
				<button class="ui green button" onclick="approveList()">承認</button>
				<button class="ui red button" onclick="openRejectModal()">却下</button>
				<button class="ui yellow button" onclick="openEditModal()">編集</button>
				<button class="ui grey button" onclick="openApplyModal()">新規</button>
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
						<select class="ui compact selection dropdown" id="businessTypeCode">
							<c:forEach var="businessType" items="${businessTypeList}">
								<option value="${businessType.businessTypeCode}"></option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">企業名</div>
					<div class="six wide column">
						<div class="ui fluid input">
							<input type="text" id="companyName">
						</div>
					</div>
					<div class="two wide column">設立日</div>
					<div class="six wide column">
						<div class="ui input">
							<input type="date" id="foundingDate">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">従業員数</div>
					<div class="six wide column">
						<div class="ui fluid input">
							<input type="text" id="workersCount">
						</div>
					</div>
					<div class="two wide column">所在地</div>
					<div class="six wide column">
						<div class="ui fluid input">
							<input type="text" id="companyAddress">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">ドメイン</div>
					<div class="six wide column">
						<div class="ui fluid input">
							<input type="text" id="companyDomain">
						</div>
					</div>
					<div class="two wide column">ホームページ</div>
					<div class="six wide column">
						<div class="ui fluid input">
							<input type="text" id="companyHomepage">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">詳細</div>
					<textarea class="fourteen wide column" rows="5" id="companyExplain"></textarea>
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
					<select class="ui compact selection dropdown" onchange="rejectReason(this)">
						<option value="0">確認不能</option>
						<option value="1">既申請</option>
						<option value="2" selected>その他</option>
					</select>
				</div>
				<div class="thirteen wide column">
					<div class="ui fluid input">
						<input type="text" id="reason">
					</div>
				</div>
			</div>
		</div>
		<div class="actions">
			<button class="ui primary button" onclick="rejectList()">却下</button>
		</div>
	</div>
</div>
</body>
<script>
	window.onload = function () {
		const verifyFlag = document.getElementsByClassName("verifyFlag");
		for (let i = verifyFlag.length - 1; i > -1; --i) {
			verifyFlag[i].innerText = getVerifyFlagName(Number(verifyFlag[i].dataset.value));
			setVerifiedColor(verifyFlag[i]);
		}
		const closingFlag = document.getElementsByClassName("closingFlag");
		for (let i = closingFlag.length - 1; i > -1; --i) {
			closingFlag[i].innerText = getClosingFlagName(Number(closingFlag[i].dataset.value));
		}
		const businessType = document.getElementsByClassName("businessType");
		for (let i = businessType.length - 1; i > -1; --i) {
			businessType[i].innerText = getBusinessTypeName(businessType[i].dataset.value);
		}
		const businessTypeSelector = document.getElementById("businessTypeCode");
		for (let i = businessTypeSelector.length - 1; i > -1; --i) {
			const value = businessTypeSelector.options[i].value;
			businessTypeSelector.options[i].innerText = value + ' ' + getBusinessTypeName(value);
		}
		const searchKeyword = document.getElementById("searchKeyword");
		const inputSearchKeyword = searchKeyword.nextElementSibling;
		searchKeyword.value = inputSearchKeyword.value = "${searchMap.searchKeyword}";
		const searchTarget = document.getElementById("searchTarget");
		switch ("${searchMap.searchTarget}") {
			case "businessTypeName":
				searchTarget.options[1].selected = true;
				break;
			case "companyAddress":
				searchTarget.options[2].selected = true;
				break;
			case "companyDomain":
				searchTarget.options[3].selected = true;
				break;
			default:
				break;
		}
		document.getElementById("verifyFilter").options[Number(${searchMap.verifyFlag})].selected = true;
		document.getElementById("closingFilter").options[Number(${searchMap.closingFlag})].selected = true;
		const parameter = getParameter();
		if (parameter.length > 0) {
			const page = document.getElementsByClassName("navi");
			for (let i = page.length - 1; i > -1; --i) {
				console.log(page[i].getAttribute("href"));
				const href = page[i].getAttribute("href") + '&' + parameter;
				page[i].setAttribute("href", href);
			}
		}
		document.getElementById("verifyFilter").options[${searchMap.verifyFlag}].selected = true;
		document.getElementById("closingFilter").options[${searchMap.closingFlag}].selected = true;
		inputSearchKeyword.addEventListener("keyup", function (event) {
			if (event.keyCode === 13) {
				if (inputSearchKeyword.value.length > 0) {
					searchKeyword.value = inputSearchKeyword.value;
					search();
				} else {
					alert("キーワードを入力してください");
				}
			}
		});
		if (${navi.totalRecordsCount lt 1}) {
			document.querySelector(".ui.pagination.menu").innerHTML = '<div class="active item">1</div>';
			document.querySelector("tbody").innerHTML = '<tr><td class="center aligned" colspan="11">データが存在しません</td></tr>';
		}
	};

	function getVerifyFlagName(verifyFlag) {
		switch (verifyFlag) {
			case 0:
				return "待機";
			case 1:
				return "承認";
			case 2:
				return "却下";
			default:
				return "Error";
		}
	}

	function getClosingFlagName(closingFlag) {
		switch (closingFlag) {
			case 0:
				return "営業";
			case 1:
				return "廃業";
			default:
				return "Error";
		}
	}

	function setVerifiedColor(verifyFlag) {
		switch (Number(verifyFlag.dataset.value)) {
			case 1:
				verifyFlag.closest("tr").setAttribute("class", "positive");
				break;
			case 2:
				verifyFlag.closest("tr").setAttribute("class", "negative");
				break;
			default:
				verifyFlag.closest("tr").removeAttribute("class");
				break;
		}
	}

	function getBusinessTypeName(businessTypeCode) {
		switch (businessTypeCode) {
			<c:forEach var="businessType" items="${businessTypeList}">
			case "${businessType.businessTypeCode}":
				return "${businessType.businessTypeName}";
			</c:forEach>
			default:
				return "Error";
		}
	}

	function checkAll(checked) {
		if (checked) {
			const checkbox = document.querySelectorAll("td > input[type=checkbox]");
			for (let i = checkbox.length - 1; i > -1; --i) {
				if (!checkbox[i].checked) {
					checkbox[i].checked = true;
					check(checkbox[i]);
				}
			}
		} else {
			const checkbox = document.querySelectorAll("td > input[type=checkbox]:checked");
			for (let i = checkbox.length - 1; i > -1; --i) {
				checkbox[i].checked = false;
				check(checkbox[i]);
			}
		}
	}

	function check(checkbox) {
		if (checkbox.checked) {
			checkbox.closest("tr").setAttribute("class", "warning");
			const checkboxLength = document.querySelectorAll("td > input[type=checkbox]").length;
			const checkedLength = document.querySelectorAll("td > input[type=checkbox]:checked").length;
			if (checkboxLength === checkedLength) {
				document.querySelector("th > input[type=checkbox]").checked = true;
			}
		} else {
			document.querySelector("th > input[type=checkbox]").checked = false;
			setVerifiedColor(checkbox.closest("td").nextElementSibling);
		}
	}

	function getCompanyList() {
		let companyList = [];
		const checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
		if (checkedList.length < 1) {
			alert("1つ以上の項目を選択してください");
		} else {
			for (let i = checkedList.length - 1; i > -1; --i) {
				const td = checkedList[i].closest("tr").children;
				const hidden = td[0].children;
				const companyId = hidden[1].value;
				const companyHomepage = hidden[2].value;
				const companyExplain = hidden[3].value;
				const verifyFlag = td[1].dataset.value;
				const closingFlag = td[2].dataset.value;
				const companyName = td[3].innerText;
				const businessTypeCode = td[4].dataset.value;
				const companyAddress = td[5].innerText;
				const foundingDate = td[6].innerText
				const workersCount = td[7].innerText
				const companyDomain = td[8].innerText
				const userNickName = td[9].innerText
				const appDate = td[10].innerText
				const company = {
					"companyId": companyId,
					"verifyFlag": verifyFlag,
					"closingFlag": closingFlag,
					"companyName": companyName,
					"businessTypeCode": businessTypeCode,
					"companyAddress": companyAddress,
					"foundingDate": foundingDate,
					"workersCount": workersCount,
					"companyDomain": companyDomain,
					"companyHomepage": companyHomepage,
					"userNickName": userNickName,
					"appDate": appDate,
					"companyExplain": companyExplain
				};
				companyList.push(company);
			}
		}
		return companyList;
	}

	function openEditModal() {
		const companyList = getCompanyList();
		if (companyList.length > 0) {
			setModalForEdit(companyList);
		}
	}

	function setModalForEdit(companyList) {
		const comSubmit = document.getElementById("comSubmit");
		comSubmit.setAttribute("onclick", "update()");
		comSubmit.innerText = "更新";
		document.getElementById("comInfo").dataset.index = '0';
		$('#comInfo').modal({
			duration: 100,
			closable: false,
			onHidden: function () {
				const comInfo = document.getElementById("comInfo");
				comInfo.dataset.index = String(Number(comInfo.dataset.index) + 1);
				setTimeout(editCompany(companyList), 100);
			}
		});
		editCompany(companyList);
	}

	function editCompany(companyList) {
		const index = document.getElementById("comInfo").dataset.index;
		if (index < companyList.length) {
			const verifyFlag = document.getElementById("verifyFlag");
			verifyFlag.dataset.value = companyList[index].verifyFlag;
			verifyFlag.innerText = getVerifyFlagName(Number(companyList[index].verifyFlag));
			document.getElementById("companyId").innerText = companyList[index].companyId;
			document.getElementById("closingFlag").options[companyList[index].closingFlag].selected = true;
			const businessTypeCode = document.getElementById("businessTypeCode");
			businessTypeCode.options[Number(companyList[index].businessTypeCode) - 1].selected = true;
			document.getElementById("companyName").value = companyList[index].companyName;
			document.getElementById("foundingDate").value = companyList[index].foundingDate;
			document.getElementById("workersCount").value = companyList[index].workersCount;
			document.getElementById("companyAddress").value = companyList[index].companyAddress;
			document.getElementById("companyDomain").value = companyList[index].companyDomain;
			document.getElementById("companyHomepage").value = companyList[index].companyHomepage;
			document.getElementById("companyExplain").value = companyList[index].companyExplain;
			document.getElementById("userNickName").innerText = companyList[index].userNickName;
			document.getElementById("appDate").innerText = companyList[index].appDate;
			$('#comInfo').modal('show');
		}
	}

	function openApplyModal() {
		const verifyFlag = document.getElementById("verifyFlag");
		verifyFlag.dataset.value = '0';
		verifyFlag.innerText = "待機";
		document.getElementById("companyId").innerText = '';
		document.getElementById("closingFlag").options[0].selected = true;
		document.getElementById("businessTypeCode").options[0].selected = true;
		document.getElementById("companyName").value = '';
		document.getElementById("foundingDate").value = '';
		document.getElementById("workersCount").value = '';
		document.getElementById("companyAddress").value = '';
		document.getElementById("companyDomain").value = '';
		document.getElementById("companyHomepage").value = '';
		document.getElementById("companyExplain").value = '';
		document.getElementById("userNickName").innerText = '';
		document.getElementById("appDate").innerText = '';
		const comSubmit = document.getElementById("comSubmit");
		comSubmit.setAttribute("onclick", "apply()");
		comSubmit.innerText = "申請";
		$('#comInfo').modal({
			duration: 100,
			closable: false
		}).modal('show');
	}

	function apply() {
		if (checkForm() && confirm("新しい会社を申請します。承認は自動的に行われます。")) {
			const company = {
				"userId": ${userId}, // TODO: 臨時にSessionより取得
				"verifyFlag": '1',
				"closingFlag": document.getElementById("closingFlag").value,
				"businessTypeCode": document.getElementById("businessTypeCode").value,
				"companyName": document.getElementById("companyName").value,
				"foundingDate": document.getElementById("foundingDate").value,
				"workersCount": document.getElementById("workersCount").value,
				"companyAddress": document.getElementById("companyAddress").value,
				"companyDomain": document.getElementById("companyDomain").value,
				"companyHomepage": document.getElementById("companyHomepage").value,
				"companyExplain": document.getElementById("companyExplain").value
			}
			fetch("${pageContext.request.contextPath}/manage/company/apply", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(company)
			}).then(function (response) {
				return response.json();
			}).then(function (result) {
				if (result) {
					alert("生成に成功しました");
					$('#comInfo').modal('hide');
				} else {
					alert("生成に失敗しました");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.log(error);
			});
		}
	}

	function checkForm() {
		const companyName = document.getElementById("companyName");
		if (companyName.value.length < 1) {
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
		if (workersCount.value.length < 1) {
			alert("従業員数を入力してください");
			workersCount.focus();
			return false;
		}
		const companyAddress = document.getElementById("companyAddress");
		if (companyAddress.value.length < 1) {
			alert("所在地を入力してください");
			companyAddress.focus();
			return false;
		}
		const companyDomain = document.getElementById("companyDomain");
		if (companyDomain.value.length < 1) {
			alert("ドメインを入力してください");
			companyDomain.focus();
			return false;
		}
		const companyHomepage = document.getElementById("companyHomepage");
		if (companyHomepage.value.length < 1) {
			alert("ホームページを入力してください");
			companyHomepage.focus();
			return false;
		}
		const companyExplain = document.getElementById("companyExplain");
		if (companyExplain.value.length < 1) {
			alert("詳細を入力してください");
			companyExplain.focus();
			return false;
		}
		return true;
	}

	function update() {
		if (checkForm() && confirm("会社の情報を更新しますか？")) {
			const company = {
				"userId": ${userId}, // TODO: 臨時にSessionより取得
				"companyId": document.getElementById("companyId").innerText,
				"closingFlag": document.getElementById("closingFlag").value,
				"businessTypeCode": document.getElementById("businessTypeCode").value,
				"companyName": document.getElementById("companyName").value,
				"foundingDate": document.getElementById("foundingDate").value,
				"workersCount": document.getElementById("workersCount").value,
				"companyAddress": document.getElementById("companyAddress").value,
				"companyDomain": document.getElementById("companyDomain").value,
				"companyHomepage": document.getElementById("companyHomepage").value,
				"companyExplain": document.getElementById("companyExplain").value
			}
			fetch("${pageContext.request.contextPath}/manage/company/update", {
				method: "PUT",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(company)
			}).then(function (response) {
				return response.json();
			}).then(function (result) {
				if (result) {
					alert("更新に成功しました");
					const companyId = document.getElementsByName("companyId");
					for (let i = companyId.length - 1; i > -1; --i) {
						if (companyId[i].value === company.companyId) {
							const td = companyId[i].closest("tr").children;
							const hidden = td[0].children;
							hidden[2] = company.companyHomepage;
							hidden[3] = company.companyExplain;
							td[2].dataset.value = company.closingFlag
							td[2].innerText = getClosingFlagName(Number(td[2].dataset.value));
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
					$('#comInfo').modal('hide');
				} else {
					alert("更新に失敗しました");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.log(error);
			});
		}
	}

	function approveList() {
		const companyList = getCompanyList();
		let incompleteList = [];
		let companyIdList = [];
		for (let i = companyList.length - 1; i > -1; --i) {
			if (companyList[i].companyName.length < 1 || companyList[i].companyAddress.length < 1
				|| companyList[i].foundingDate.length < 1 || companyList[i].workersCount.length < 1
				|| companyList[i].companyDomain.length < 1 || companyList[i].companyHomepage.length < 1
				|| companyList[i].companyExplain.length < 1) {
				incompleteList.push(companyList[i]);
			} else {
				companyIdList.push(companyList[i].companyId);
			}
		}
		if (incompleteList.length > 0) {
			alert("申請の内容を確認してください");
			setModalForEdit(incompleteList);
		} else if (confirm("承認しますか？")) {
			const data = {
				"userId": ${userId}, // TODO: 臨時にSessionより取得
				"companyIdList": companyIdList,
				"verifyFlag": '1'
			}
			fetch("${pageContext.request.contextPath}/manage/company/update", {
				method: "PATCH",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(data)
			}).then(function (response) {
				return response.json();
			}).then(function (result) {
				if (result) {
					alert("申請を承認しました");
					const checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
					for (let i = checkedList.length - 1; i > -1; --i) {
						const verifyFlag = checkedList[i].closest("td").nextElementSibling;
						verifyFlag.dataset.value = '1';
						verifyFlag.innerText = getVerifyFlagName(1);
					}
				} else {
					alert("承認に失敗しました");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.log(error);
			});
		}
	}

	function openRejectModal() {
		const checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
		if (checkedList.length < 1) {
			alert("1つ以上の項目を選択してください");
		} else {
			$('#rejection').modal({
				duration: 100,
				closable: false
			}).modal('show');
		}
	}

	function rejectList() {
		if (confirm("却下しますか？")) {
			let companyIdList = [];
			const checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
			for (let i = checkedList.length - 1; i > -1; --i) {
				companyIdList.push(checkedList[i].nextElementSibling.value);
			}
			const reason = document.getElementById("reason").value;
			const data = {
				"userId": ${userId}, // TODO: 臨時にSessionより取得
				"companyIdList": companyIdList,
				"verifyFlag": '2',
				"reason": reason
			}
			fetch("${pageContext.request.contextPath}/manage/company/update", {
				method: "PATCH",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(data)
			}).then(function (response) {
				return response.json();
			}).then(function (result) {
				if (result) {
					alert("申請を却下しました");
					for (let i = checkedList.length - 1; i > -1; --i) {
						const verifyFlag = checkedList[i].closest("td").nextElementSibling;
						verifyFlag.dataset.value = '2';
						verifyFlag.innerText = getVerifyFlagName(2);
					}
				} else {
					alert("申請の却下に失敗しました");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.log(error);
			});
		}
	}

	function rejectReason(selection) {
		const reason = document.getElementById("reason");
		switch (Number(selection.value)) {
			case 0:
			case 1:
				reason.closest("div").setAttribute("class", "ui fluid disabled input");
				reason.value = selection.options[Number(selection.value)].innerText;
				break;
			default:
				reason.closest("div").setAttribute("class", "ui fluid input");
				reason.value = '';
				break;
		}
	}

	function search() {
		let href = "${pageContext.request.contextPath}/manage/company";
		const parameter = getParameter();
		if (parameter.length > 0) {
			href += '?' + parameter;
		}
		location.href = href;
	}

	function getParameter() {
		let parameter = '';
		let isNotFirstParameter = false;
		const verifyFlag = document.getElementById("verifyFilter").value;
		const closingFlag = document.getElementById("closingFilter").value;
		const searchTarget = document.getElementById("searchTarget").value;
		const searchKeyword = document.getElementById("searchKeyword").value;
		if (verifyFlag !== '0') {
			parameter += "verifyFlag=" + verifyFlag;
			isNotFirstParameter = true;
		}
		if (closingFlag !== '0') {
			if (isNotFirstParameter) {
				parameter += '&';
				isNotFirstParameter = false;
			}
			parameter += "closingFlag=" + closingFlag;
		}
		if (searchKeyword.length > 0) {
			if (isNotFirstParameter) {
				parameter += '&';
			}
			parameter += "searchTarget=" + searchTarget + "&searchKeyword=" + searchKeyword;
		}
		return parameter;
	}
</script>
</html>