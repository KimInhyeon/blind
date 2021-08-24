<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>レビュー管理</title>
	<style>
		.ui.grid > .middle.aligned.row {
			padding-bottom: 0;
		}

		.ui.compact.selection.dropdown {
			font-weight: 700;
			padding: 0;
		}

		select.fluid {
			text-align-last: center;
		}

		.ui.table thead th {
			padding: 0;
		}

		.ui.table td {
			padding: .78571429em .2em .78571429em .2em;
		}
	</style>
</head>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<div class="left floated two wide column">
				<h3 class="ui header">レビュー管理</h3>
			</div>
			<div class="right floated six wide column right aligned">
				<div class="ui fluid icon input">
					<select class="ui compact selection dropdown" id="searchTarget">
						<option value="companyName">企業名</option>
						<option value="contents">内容</option>
						<option value="jobGroupName">職種</option>
						<option value="userNickname">作成者</option>
					</select>
					<input type="text" placeholder="キーワードを入力" id="searchKeyword">
					<i class="search link icon" id="searchIcon"></i>
				</div>
			</div>
		</div>
		<div class="row">
			<table class="ui selectable fixed single line celled table">
				<thead class="center aligned">
					<tr>
						<th class="center aligned" style="width: 2%;">
							<input type="checkbox" class="ui checkbox" onclick="checkAllReviewRows(this.checked)">
						</th>
						<th style="width: 5%;">
							<select class="ui compact selection dropdown fluid" id="verifyFilter">
								<option value="0">待機</option>
								<option value="1">承認</option>
								<option value="2">却下</option>
								<option value="3">全部</option>
							</select>
						</th>
						<th style="width: 5%;">
							<select class="ui compact selection dropdown fluid" id="workingFilter">
								<option value="2">全部</option>
								<option value="1">在職</option>
								<option value="0">退職</option>
							</select>
						</th>
						<th style="width: 9%;">レーティング</th>
						<th>企業名</th>
						<th>職種</th>
						<th>内容</th>
						<th>作成者</th>
						<th style="width: 9%;">作成日</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="review" items="${reviewList}">
					<tr>
						<td class="center aligned">
							<input type="checkbox" class="ui checkbox" onclick="checkReviewRow(this)"
									data-id="${review.companyReviewId}">
						</td>
						<td class="center aligned verifyFlag">
						<c:choose>
							<c:when test="${review.completeFlag eq '0'}">待機</c:when>
							<c:when test="${review.verifyFlag eq '1'}">承認</c:when>
							<c:otherwise>却下</c:otherwise>
						</c:choose>
						</td>
						<td class="center aligned">
						<c:choose>
							<c:when test="${review.workingFlag}">在職</c:when>
							<c:otherwise>退職</c:otherwise>
						</c:choose>
						</td>
						<td class="center aligned">
							<div class="ui star rating" data-rating="${review.allPoint}" data-max-rating="5"></div>
						</td>
						<td>${review.companyName}</td>
						<td>${review.jobGroupName}</td>
						<td><a href="javascript:readReview(${review.companyReviewId});">${review.simpleComment}</a></td>
						<td>${review.userNickname}</td>
						<td class="center aligned">${review.recCreateDate}</td>
					</tr>
				</c:forEach>
				</tbody>
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
							$(".rating").rating("disable");
						} else {
							tbody.innerHTML = "<tr><td class=\"center aligned\" colspan=\"9\">データが存在しません</td></tr>";
						}
					}());
				</script>
			</table>
		</div>
		<div class="row">
			<div class="five wide column"></div>
			<div class="six wide column center aligned">
			<c:choose>
				<c:when test="${navi.startPage gt navi.pagination}">
					<div class="ui pagination menu">
						<a class="item" href="javascript:getReviewListByPage(${navi.startPage - navi.pagination});">前へ</a>
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
							<a class="item" href="javascript:getReviewListByPage(${page});">${page}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</div>
			<c:choose>
				<c:when test="${navi.totalPage gt navi.endPage}">
					<div class="ui pagination menu">
						<a class="item" href="javascript:getReviewListByPage(${navi.endPage + 1})">次へ</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="ui pagination menu" style="visibility: hidden;"><a class="item">次へ</a></div>
				</c:otherwise>
			</c:choose>
			</div>
			<div class="five wide column right aligned">
				<button class="ui green button" onclick="verifyReviewList(true, false)">承認</button>
				<button class="ui red button" onclick="verifyReviewList(false, false)">却下</button>
				<button class="ui yellow button" onclick="openInputReasonModal()">直接処理</button>
			</div>
		</div>
	</div>
	<div class="ui modal" id="contents">
		<i class="close cancel icon"></i>
		<div class="header">臨時コンテンツ</div>
		<div class="content">
			<div class="ui grid">
				<div class="row">
					<div class="two wide column">作成者</div>
					<div class="six wide column" id="userNickname"></div>
					<div class="two wide column">企業名</div>
					<div class="six wide column" id="companyName"></div>
				</div>
				<div class="row">
					<div class="two wide column">職種</div>
					<div class="six wide column" id="jobGroupName"></div>
					<div class="two wide column">内容</div>
					<div class="six wide column" id="simpleComment"></div>
				</div>
			</div>
		</div>
		<div class="actions">臨時コンテンツ</div>
	</div>
	<div class="ui small modal" id="verifyModal">
		<i class="close cancel icon"></i>
		<div class="content ui form">
			<textarea class="field" id="verifyMessage"></textarea>
		</div>
		<div class="actions">
			<button class="ui left floated button" onclick="setDefaultAcceptMessage()">基本承認メッセージ</button>
			<button class="ui left floated button" onclick="setDefaultRejectMessage()">基本却下メッセージ</button>
			<button class="ui green button" onclick="verifyReviewList(true, true)">承認</button>
			<button class="ui red button" onclick="verifyReviewList(false, true)">却下</button>
		</div>
	</div>
</div>
<script>
	function checkReviewRow(checkbox) {
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

	function checkAllReviewRows(checked) {
		if (checked) {
			const checkboxList = document.querySelectorAll("td > input[type=checkbox]");
			for (let i = checkboxList.length - 1; i > -1; --i) {
				if (!checkboxList[i].checked) {
					checkboxList[i].checked = true;
					checkReviewRow(checkboxList[i]);
				}
			}
		} else {
			const checkboxList = document.querySelectorAll("td > input[type=checkbox]:checked");
			for (let i = checkboxList.length - 1; i > -1; --i) {
				checkboxList[i].checked = false;
				checkReviewRow(checkboxList[i]);
			}
		}
	}

	function readReview(companyReviewId) {
		fetch(location.pathname + "/" + companyReviewId, {
			method: "GET"
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			} else {
				throw response.status;
			}
		}).then(function (result) {
			document.getElementById("userNickname").innerText = result.userNickname;
			document.getElementById("companyName").innerText = result.companyName;
			document.getElementById("jobGroupName").innerText = result.jobGroupName;
			document.getElementById("simpleComment").innerText = result.simpleComment;
			$("#contents").modal("show");
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}

	function getReviewList(searchParams) {
		const url = new URL(location.href);
		url.search = searchParams;
		location.href = url;
	}

	function getReviewListByChangedFilter(element, filterName) {
		const searchParams = new URLSearchParams(location.search);
		if (element.value === "0") {
			searchParams.delete(filterName);
		} else {
			searchParams.set(filterName, element.value);
		}
		searchParams.delete("page");
		searchParams.delete("searchTarget");
		searchParams.delete("searchKeyword");
		getReviewList(searchParams);
	}

	function getReviewListByPage(page) {
		const searchParams = new URLSearchParams(location.search);
		if (page > 1) {
			searchParams.set("page", page);
		} else {
			searchParams.delete("page");
		}
		getReviewList(searchParams);
	}

	function openInputReasonModal() {
		if (document.querySelectorAll("td > input[type=checkbox]:checked").length > 0) {
			$("#verifyModal").modal("show");
		} else {
			alert("1つ以上の通報を選択してください。");
		}
	}

	function getDefaultAcceptMessage() {
		return "レビューが承認されました。";
	}

	function getDefaultRejectMessage() {
		return "レビューが却下されました。";
	}

	function setDefaultAcceptMessage() {
		document.getElementById("verifyMessage").value = getDefaultAcceptMessage();
	}

	function setDefaultRejectMessage() {
		document.getElementById("verifyMessage").value = getDefaultRejectMessage();
	}

	function verifyReviewList(isAccept, isCustomMessage) {
		const checkboxList = document.querySelectorAll("td > input[type=checkbox]:checked");
		const length = checkboxList.length;
		if (length < 1) {
			alert("1つ以上の通報を選択してください。");
			return;
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
			let verifyName;
			if (isAccept) {
				verifyFlag = "1";
				verifyName = "承認";
			} else {
				verifyFlag = "2";
				verifyName = "却下";
			}
			const reviewIdList = [];
			for (let i = 0; i < length; ++i) {
				reviewIdList.push(Number(checkboxList[i].dataset.id));
			}

			fetch(location.pathname, {
				method: "PATCH",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify({
					"verifyFlag": verifyFlag,
					"reason": reason,
					"reviewIdList": reviewIdList
				})
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				} else {
					throw response.status;
				}
			}).then(function (result) {
				if (result === length) {
					for (let i = 0; i < length; ++i) {
						checkboxList[i].closest("td").nextElementSibling.innerText = verifyName;
					}
					checkAllReviewRows(false);
					alert("すべての" + verifyName + "に成功しました。");
					$("#verifyModal").modal("hide");
				} else if (result > 0) {
					alert("一部の" + verifyName + "に失敗しました。");
				}
			}).catch(function (error) {
				alert("予期しないエラーが発生しました。");
				console.error(error);
			});
		}
	}

	onload = function () {
		// 検索
		const searchParams = new URLSearchParams(location.search);
		const searchTarget = document.getElementById("searchTarget");
		const inputSearchKeyword = document.getElementById("searchKeyword");
		const verifyFilter = document.getElementById("verifyFilter");
		const workingFilter = document.getElementById("workingFilter");
		if (searchParams.has("verifyFlag")) {
			verifyFilter.value = searchParams.get("verifyFlag");
		}
		if (searchParams.has("workingFlag")) {
			workingFilter.value = searchParams.get("workingFlag");
		}
		if (searchParams.has("searchKeyword")) {
			inputSearchKeyword.value = searchParams.get("searchKeyword");
			searchTarget.value = searchParams.get("searchTarget")
		}
		const getReviewListByChangedFilter = function (flagName, flag) {
			if ((flagName === "verifyFlag" && flag === "0") || (flagName === "workingFlag" && flag === "2")) {
				searchParams.delete(flagName);
			} else {
				searchParams.set(flagName, flag);
			}
			searchParams.delete("page");
			searchParams.delete("searchTarget");
			searchParams.delete("searchKeyword");
			getReviewList(searchParams);
		};
		verifyFilter.addEventListener("change", function (event) {
			getReviewListByChangedFilter("verifyFlag", event.target.value);
		});
		workingFilter.addEventListener("change", function (event) {
			getReviewListByChangedFilter("workingFlag", event.target.value);
		});
		const search = function () {
			const searchKeyword = inputSearchKeyword.value.trim();
			if (searchKeyword.length > 0) {
				searchParams.delete("page");
				searchParams.set("searchTarget", searchTarget.value);
				searchParams.set("searchKeyword", searchKeyword);
				getReviewList(searchParams);
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

		// モーダル
		$("#contents, #verifyModal").modal({
			duration: 100,
			closable: false
		});
	};
</script>
</body>
</html>