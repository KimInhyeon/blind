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

	textarea {
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

	textarea:focus {
		border-color: #85B7D9;
		background: #FFFFFF;
		color: rgba(0, 0, 0, 0.8);
		-webkit-box-shadow: none;
		box-shadow: none;
	}

	th.check {
		width: 2%;
	}

	th.date {
		width: 7%;
	}

	th.filter {
		width: 5%;
	}

	th.address {
		width: 15%;
	}

	th.businessType {
		width: 21%;
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
						<th class="check">
							<input type="checkbox" class="ui checkbox" onclick="checkAllCompanyRows(this.checked)">
						</th>
						<th class="filter">
							<select class="ui compact selection dropdown fluid" onchange="search()" id="verifyFilter">
								<option value="0">待機</option>
								<option value="1">承認</option>
								<option value="2">却下</option>
								<option value="3">全部</option>
							</select>
						</th>
						<th class="filter">
							<select class="ui compact selection dropdown fluid" onchange="search()" id="closingFilter">
								<option value="0">営業</option>
								<option value="1">廃業</option>
								<option value="2">全部</option>
							</select>
						</th>
						<th>企業名</th>
						<th class="businessType">業種</th>
						<th class="address">所在地</th>
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
							<input type="checkbox" class="ui checkbox" onclick="checkSingleCompanyRow(this)">
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
				<div class="ui pagination menu" id="prevNavi"></div>
				<div class="ui pagination menu" id="pageNavi"></div>
				<div class="ui pagination menu" id="nextNavi"></div>
			</div>
			<div class="five wide column right aligned">
				<button class="ui green button" onclick="approveCompanyList()">承認</button>
				<button class="ui red button" onclick="openRejectCompanyModal()">却下</button>
				<button class="ui yellow button" onclick="openEditCompanyModal()">編集</button>
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
						<option value="1">既申請</option>
						<option value="2" selected>その他</option>
					</select>
				</div>
				<div class="thirteen wide column">
					<div class="ui fluid input"><input type="text" id="reason"></div>
				</div>
			</div>
		</div>
		<div class="actions">
			<button class="ui primary button" onclick="rejectCompanyList()">却下</button>
		</div>
	</div>
</div>
</body>
<script>
	window.onload = function () {
		const tbody = document.querySelector("tbody");
		if (tbody.children.length < 1) {
			tbody.innerHTML = '<tr><td class="center aligned" colspan="11">データが存在しません</td></tr>';
			document.getElementById("pageNavi").innerHTML = '<div class="active item">1</div>';
			document.getElementById("prevNavi").setAttribute("style", "border: 0\; box-shadow: none\;");
			document.getElementById("nextNavi").setAttribute("style", "border: 0\; box-shadow: none\;");
		} else {
			const contextHref = getContextHref();
			const pagination = ${navi.pagination};
			const endPage = ${navi.endPage};
			let page = ${navi.startPage};
			if (pagination + 1 === page) {
				document.getElementById("prevNavi").innerHTML = '<a class="item navi" href="' + contextHref + '">前へ</a>';
			} else if (page > 1) {
				const pageNum = page - pagination;
				const html = '<a class="item navi" href="' + contextHref + '?page=' + pageNum + '">前へ</a>';
				document.getElementById("prevNavi").innerHTML = html;
			} else {
				const prevNavi = document.getElementById("prevNavi");
				prevNavi.innerHTML = '<a class="item navi" style="visibility: hidden">前へ</a>';
				prevNavi.setAttribute("style", "border: 0\; box-shadow: none\;");
			}
			let html = '';
			while (page <= endPage) {
				if (page === ${navi.currentPage}) {
					html += '<div class="active item">' + page + '</div>';
				} else {
					html += '<a class="item navi" href="' + contextHref;
					if (page !== 1) {
						html += '?page=' + page;
					}
					html += '">' + page + '</a>';
				}
				++page;
			}
			document.getElementById("pageNavi").innerHTML = html;
			if (endPage < ${navi.totalPage}) {
				html = '<a class="item navi" href="' + contextHref + '?page=' + page + '">次へ</a>';
				document.getElementById("nextNavi").innerHTML = html;
			} else {
				const nextNavi = document.getElementById("nextNavi");
				nextNavi.innerHTML = '<a class="item navi" style="visibility: hidden">次へ</a>';
				nextNavi.setAttribute("style", "border: 0\; box-shadow: none\;");
			}
		}
		const verifyFlag = document.getElementsByClassName("verifyFlag");
		for (let i = verifyFlag.length - 1; i > -1; --i) {
			verifyFlag[i].innerText = getVerifyFlagName(verifyFlag[i].dataset.value);
			setVerifiedColor(verifyFlag[i]);
		}
		const closingFlag = document.getElementsByClassName("closingFlag");
		for (let i = closingFlag.length - 1; i > -1; --i) {
			closingFlag[i].innerText = getClosingFlagName(closingFlag[i].dataset.value);
		}
		const businessTypeList = getBusinessTypeList();
		const businessType = document.querySelectorAll("td.businessType");
		for (let i = businessType.length - 1; i > -1; --i) {
			if (businessTypeList.has(businessType[i].dataset.value)) {
				businessType[i].innerText = businessTypeList.get(businessType[i].dataset.value);
			} else {
				businessType[i].innerText = "ERROR";
			}
		}
		const searchKeyword = document.getElementById("searchKeyword");
		const inputSearchKeyword = searchKeyword.nextElementSibling;
		searchKeyword.value = inputSearchKeyword.value = "${search.searchKeyword}";
		const searchTarget = document.getElementById("searchTarget");
		switch ("${search.searchTarget}") {
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
		document.getElementById("verifyFilter").options[Number(${search.verifyFlag})].selected = true;
		document.getElementById("closingFilter").options[Number(${search.closingFlag})].selected = true;
		const parameter = getParameter();
		if (parameter.length > 0) {
			const page = document.getElementsByClassName("navi");
			const href = function (naviElement) {
				switch (naviElement.innerText) {
					case '1':
					case "前へ":
						return naviElement.getAttribute("href") + '?' + parameter;
					default:
						return naviElement.getAttribute("href") + '&' + parameter;
				}
			};
			for (let i = page.length - 1; i > -1; --i) {
				page[i].setAttribute("href", href(page[i]));
			}
		}
		let option = '';
		for (const businessType of businessTypeList) {
			option += '<option value="' + businessType[0] + '">' + businessType[0] + ". " + businessType[1] + '</option>';
		}
		document.getElementById("businessTypeCode").innerHTML = option;
		inputSearchKeyword.addEventListener("keyup", function (event) {
			if (event.key === "Enter") {
				if (inputSearchKeyword.value.length > 0) {
					searchKeyword.value = inputSearchKeyword.value;
					search();
				} else {
					alert("キーワードを入力してください");
				}
			}
		});
		window.addEventListener("keyup", function (event) {
			if (event.key === "Escape") {
				$('.ui.modal').modal('hide');
			}
		});
	};

	function getContextHref() {
		return "${pageContext.request.contextPath}/manage/company";
	}

	function getVerifyFlagName(verifyFlag) {
		switch (verifyFlag) {
			case '0':
				return "待機";
			case '1':
				return "承認";
			case '2':
				return "却下";
			default:
				return "ERROR";
		}
	}

	function getClosingFlagName(closingFlag) {
		switch (closingFlag) {
			case '0':
				return "営業";
			case '1':
				return "廃業";
			default:
				return "ERROR";
		}
	}

	function setVerifiedColor(verifyFlag) {
		switch (verifyFlag.dataset.value) {
			case '1':
				verifyFlag.closest("tr").setAttribute("class", "positive");
				break;
			case '2':
				verifyFlag.closest("tr").setAttribute("class", "negative");
				break;
			default:
				verifyFlag.closest("tr").removeAttribute("class");
				break;
		}
	}

	function getBusinessTypeList() {
		let businessTypeList = new Map();
		<c:forEach var="businessType" items="${businessTypeList}">
			businessTypeList.set("${businessType.businessTypeCode}", "${businessType.businessTypeName}");
		</c:forEach>
		return businessTypeList;
	}

	function checkAllCompanyRows(checked) {
		if (checked) {
			const checkbox = document.querySelectorAll("td > input[type=checkbox]");
			for (let i = checkbox.length - 1; i > -1; --i) {
				if (!checkbox[i].checked) {
					checkbox[i].checked = true;
					checkSingleCompanyRow(checkbox[i]);
				}
			}
		} else {
			const checkbox = document.querySelectorAll("td > input[type=checkbox]:checked");
			for (let i = checkbox.length - 1; i > -1; --i) {
				checkbox[i].checked = false;
				checkSingleCompanyRow(checkbox[i]);
			}
		}
	}

	function checkSingleCompanyRow(checkbox) {
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
			const businessTypeList = getBusinessTypeList();
			for (let i = checkedList.length - 1; i > -1; --i) {
				const td = checkedList[i].closest("tr").children;
				const hidden = td[0].children;
				const companyId = hidden[1].value;
				const companyHomepage = hidden[2].value;
				const companyExplain = hidden[3].value;
				const verifyFlag = td[1].dataset.value;
				const closingFlag = td[2].dataset.value;
				const companyName = td[3].innerText;
				const businessTypeCode = function (businessTypeCode) {
					if (businessTypeList.has(businessTypeCode)) {
						return businessTypeCode;
					} else {
						return "01";
					}
				};
				const companyAddress = td[5].innerText;
				const foundingDate = td[6].innerText;
				const workersCount = td[7].innerText;
				const companyDomain = td[8].innerText;
				const userNickName = td[9].innerText;
				const appDate = td[10].innerText;
				const company = {
					"companyId": companyId,
					"verifyFlag": verifyFlag,
					"closingFlag": closingFlag,
					"companyName": companyName,
					"businessTypeCode": businessTypeCode(td[4].dataset.value),
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

	function openEditCompanyModal() {
		const companyList = getCompanyList();
		if (companyList.length > 0) {
			setModalForEditCompany(companyList);
		}
	}

	function setModalForEditCompany(companyList) {
		const comSubmit = document.getElementById("comSubmit");
		comSubmit.setAttribute("onclick", "updateCompany()");
		comSubmit.innerText = "更新";
		document.getElementById("comInfo").dataset.index = '0';
		const businessTypeList = getBusinessTypeList();
		$('#comInfo').modal({
			duration: 100,
			closable: false,
			onHidden: function () {
				const comInfo = document.getElementById("comInfo");
				comInfo.dataset.index = String(Number(comInfo.dataset.index) + 1);
				setTimeout(editCompany(companyList, businessTypeList), 100);
			}
		});
		editCompany(companyList, businessTypeList);
	}

	function editCompany(companyList, businessTypeList) {
		const index = document.getElementById("comInfo").dataset.index;
		if (index < companyList.length) {
			const verifyFlag = document.getElementById("verifyFlag");
			verifyFlag.dataset.value = companyList[index].verifyFlag;
			verifyFlag.innerText = getVerifyFlagName(companyList[index].verifyFlag);
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

	function openApplyCompanyModal() {
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
		comSubmit.setAttribute("onclick", "applyCompany()");
		comSubmit.innerText = "申請";
		$('#comInfo').modal({
			duration: 100,
			closable: false
		}).modal('show');
	}

	function applyCompany() {
		if (checkForm() && confirm("新しい会社を申請します。承認は自動的に行われます。")) {
			const company = {
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
			};
			fetch(getContextHref() + "/apply", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(company)
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				} else {
					throw response.status;
				}
			}).then(function (result) {
				if (result) {
					alert("生成に成功しました");
					$('#comInfo').modal('hide');
				} else {
					alert("生成に失敗しました");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
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

	function updateCompany() {
		if (checkForm() && confirm("会社の情報を更新しますか？")) {
			const company = {
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
			};
			fetch(getContextHref() + "/update", {
				method: "PUT",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(company)
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				} else {
					throw response.status;
				}
			}).then(function (result) {
				if (result) {
					alert("更新に成功しました");
					const companyId = document.getElementsByName("companyId");
					for (let i = companyId.length - 1; i > -1; --i) {
						if (companyId[i].value === company.companyId) {
							const td = companyId[i].closest("tr").children;
							const hidden = td[0].children;
							hidden[2].value = company.companyHomepage;
							hidden[3].value = company.companyExplain;
							td[2].dataset.value = company.closingFlag;
							td[2].innerText = getClosingFlagName(td[2].dataset.value);
							td[3].innerText = company.companyName;
							td[4].dataset.value = company.businessTypeCode;
							td[4].innerText = getBusinessTypeList().get(company.businessTypeCode);
							td[5].innerText = company.companyAddress;
							td[6].innerText = company.foundingDate;
							td[7].innerText = company.workersCount;
							td[8].innerText = company.companyDomain;
							hidden[0].checked = false;
							checkSingleCompanyRow(hidden[0]);
							break;
						}
					}
					$('#comInfo').modal('hide');
				} else {
					alert("更新に失敗しました");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
			});
		}
	}

	function approveCompanyList() {
		const companyList = getCompanyList();
		const companyListLength = companyList.length;
		if (companyListLength > 0) {
			let incompleteList = [];
			let companyIdList = [];
			for (let i = 0; i < companyListLength; ++i) {
				if (companyList[i].companyName.length < 1 || companyList[i].companyAddress.length < 1
					|| companyList[i].foundingDate.length < 1 || companyList[i].workersCount.length < 1
					|| companyList[i].companyDomain.length < 1 || companyList[i].companyHomepage.length < 1
					|| companyList[i].companyExplain.length < 1
				) {
					incompleteList.push(companyList[i]);
				} else {
					companyIdList.push(companyList[i].companyId);
				}
			}
			if (incompleteList.length > 0) {
				alert("申請の内容を確認してください");
				setModalForEditCompany(incompleteList);
			} else if (confirm("承認しますか？")) {
				const data = {
					"companyIdList": companyIdList,
					"verifyFlag": '1'
				};
				fetch(getContextHref() + "/update", {
					method: "PATCH",
					headers: {
						"Content-Type": "application/json"
					},
					body: JSON.stringify(data)
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					} else {
						throw response.status;
					}
				}).then(function (result) {
					const length = companyIdList.length;
					if (result === length) {
						alert("申請を承認しました");
						const checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
						for (let i = checkedList.length - 1; i > -1; --i) {
							const verifyFlag = checkedList[i].closest("td").nextElementSibling;
							verifyFlag.dataset.value = '1';
							verifyFlag.innerText = getVerifyFlagName('1');
						}
						checkAllCompanyRows(false);
					} else if (result > 0) {
						alert("一部の承認に失敗しました");
					} else {
						alert("承認に失敗しました");
					}
				}).catch(function (error) {
					alert("予期しないエラーが発生しました");
					console.error(error);
				});
			}
		}
	}

	function openRejectCompanyModal() {
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

	function rejectCompanyList() {
		const reason = document.getElementById("reason").value;
		if (reason.length < 1) {
			alert("理由を入力してください");
			document.getElementById("reason").focus();
		} else if (confirm("却下しますか？")) {
			let companyIdList = [];
			const checkedList = document.querySelectorAll("td > input[type=checkbox]:checked");
			for (let i = checkedList.length - 1; i > -1; --i) {
				companyIdList.push(checkedList[i].nextElementSibling.value);
			}
			const data = {
				"companyIdList": companyIdList,
				"verifyFlag": '2',
				"reason": reason
			};
			fetch(getContextHref() + "/update", {
				method: "PATCH",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(data)
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				} else {
					throw response.status;
				}
			}).then(function (result) {
				if (result === companyIdList.length) {
					alert("申請を却下しました");
					for (let i = checkedList.length - 1; i > -1; --i) {
						const verifyFlag = checkedList[i].closest("td").nextElementSibling;
						verifyFlag.dataset.value = '2';
						verifyFlag.innerText = getVerifyFlagName('2');
					}
					$('#rejection').modal('hide');
					checkAllCompanyRows(false);
				} else if (result > 0) {
					alert("一部の却下に失敗しました");
				} else {
					alert("申請の却下に失敗しました");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
			});
		}
	}

	function setRejectReason(selection) {
		const reason = document.getElementById("reason");
		switch (selection.value) {
			case '0':
			case '1':
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
		const parameter = getParameter();
		if (parameter.length > 0) {
			location.href = getContextHref() + '?' + parameter;
		} else {
			location.href = getContextHref();
		}
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
			}
			parameter += "closingFlag=" + closingFlag;
			isNotFirstParameter = true;
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