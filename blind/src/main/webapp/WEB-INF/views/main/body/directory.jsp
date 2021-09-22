<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<title>ディレクトリ</title>
</head>
<style>
	.ui.container > .ui.header {
		padding: 1%;
	}

	section.ui.grid {
		margin-top: 1.5%;
		margin-bottom: 1.5%;
	}

	.ui.huge.bulleted.link.link > .column.item {
		padding: 0.5%;
	}
</style>
<body>
<article class="ui container">
	<h2 class="ui header">ディレクトリ</h2>
	<section class="ui message">
		<div class="ui horizontal link list">
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('ア')">ア</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('カ')">カ</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('サ')">サ</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('タ')">タ</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('ナ')">ナ</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('ハ')">ハ</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('マ')">マ</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('ヤ')">ヤ</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('ラ')">ラ</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('ワ')">ワ</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('A')">A~Z</a>
			<a class="item" href="javascript:getDirectoryListBySearchKeyword('0')">0-9</a>
		</div>
	</section>
	<section class="ui huge left icon input fluid">
		<input type="text" placeholder="キーワードを入力してください" id="searchKeyword">
		<i class="search icon link"></i>
	</section>
	<section class="ui two column grid ui huge bulleted link list" id="directoryLinkList">
	<c:forEach var="company" items="${companyList}">
		<a class="column item" href="companyIntroduction?companyId=${company.companyId}">${company.companyName}　紹介</a>
		<a class="column item" href="companyShowReview?companyId=${company.companyId}">${company.companyName}　レビュー</a>
		<a class="column item">${company.companyName}　掲示板</a>
		<a class="column item" href="annualIncome?selectCompanyId=${company.companyId}">${company.companyName}　年収</a>
		<a class="column item">${company.companyName}　採用</a>
		<a class="column item" href="companyNews/${company.companyId}">${company.companyName}　ニュース</a>
	</c:forEach>
	</section>
	<div class="ui divider"></div>
	<section class="ui grid">
		<div class="center aligned column" id="pagination">
		<c:choose>
			<c:when test="${navi.startPage gt navi.pagination}">
				<div class="ui pagination menu">
					<a class="item" href="javascript:getDirectoryListByPage(${navi.startPage - navi.pagination});">前へ</a>
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
					<a class="item" href="javascript:getDirectoryListByPage(${page})">${page}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		</div>
		<c:choose>
			<c:when test="${navi.totalPage gt navi.endPage}">
				<div class="ui pagination menu">
					<a class="item" href="javascript:getDirectoryListByPage(${navi.endPage + 1})">次へ</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="ui pagination menu" style="visibility: hidden;"><a class="item">次へ</a></div>
			</c:otherwise>
		</c:choose>
		</div>
	</section>
</article>
<script>
	function getDirectoryListByPage (page) {
		const searchParams = new URLSearchParams(location.search);
		searchParams.set("page", String(page));
		getDirectoryList(searchParams);
	}

	function getDirectoryListBySearchKeyword (searchKeyword) {
		const searchParams = new URLSearchParams(location.search);
		searchParams.set("page", "1");
		searchParams.set("searchKeyword", searchKeyword);
		getDirectoryList(searchParams);
	}

	function getDirectoryList (searchParams) {
		const url = new URL(location.href);
		searchParams.set("ajax", "true");
		url.search = searchParams.toString();
		fetch(url.toString(), {
			method: "GET"
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			}
			throw response.status;
		}).then(function (directory) {
			const directoryLinkList = document.getElementById("directoryLinkList");
			const pagination = document.getElementById("pagination");
			history.replaceState({
				"directoryLinkList": directoryLinkList.innerHTML,
				"pagination": pagination.innerHTML
			}, "");

			let html = "";
			const companyList = directory.companyList;
			for (let i = 0, companyListLength = companyList.length; i < companyListLength; ++i) {
				html += "<a class=\"column item\" href=\"companyIntroduction?companyId=" + companyList[i].companyId +
						"\">" + companyList[i].companyName + "　紹介</a>" +
						"<a class=\"column item\" href=\"companyShowReview?companyId=" + companyList[i].companyId +
						"\">" + companyList[i].companyName + "　レビュー</a>" +
						"<a class=\"column item\">" + companyList[i].companyName + "　掲示板</a>" +
						"<a class=\"column item\" href=\"companyShowReview?companyId=" + companyList[i].companyId +
						"\">" + companyList[i].companyName + "　年収</a>" +
						"<a class=\"column item\">" + companyList[i].companyName + "　採用</a>" +
						"<a class=\"column item\" href=\"companyNews/" + companyList[i].companyName +
						"\">" + companyList[i].companyName + "　ニュース</a>";
			}
			directoryLinkList.innerHTML = html;

			html = "<div class=\"ui pagination menu\"";
			const navi = directory.navi;
			if (navi.startPage < navi.pagination) {
				html += " style=\"visibility: hidden;\"><div class=\"item\">前へ</div></div>";
			} else {
				html += "><a class=\"item\" href=\"javascript:getDirectoryListByPage(" + String(navi.startPage - 1) +
						");\">前へ</a></div>";
			}
			html += "<div class=\"ui pagination menu\">";
			for (let page = navi.startPage; page <= navi.endPage; ++page) {
				if (page === navi.currentPage) {
					html += "<div class=\"active item\">" + page + "</div>";
				} else {
					html += "<a class=\"item\" href=\"javascript:getDirectoryListByPage(" + page +
							");\">" + page + "</a>";
				}
			}
			html += "</div><div class=\"ui pagination menu\"";
			if (navi.endPage < navi.totalPage) {
				html += "><a class=\"item\" href=\"javascript:getDirectoryListByPage(" + String(navi.endPage + 1) +
						");\">次へ</a></div>";
			} else {
				html += " style=\"visibility: hidden;\"><div class=\"item\">次へ</div></div>";
			}
			pagination.innerHTML = html;

			if (searchParams.get("page") === "1") {
				searchParams.delete("page");
			}
			if (searchParams.get("searchKeyword") === "ア") {
				searchParams.delete("searchKeyword");
			}
			searchParams.delete("ajax");
			url.search = searchParams.toString();
			history.pushState({
				"directoryLinkList": directoryLinkList.innerHTML,
				"pagination": pagination.innerHTML
			}, "", url.toString());
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}

	addEventListener("DOMContentLoaded", function () {
		const searchKeyword = document.getElementById("searchKeyword");
		const search = function () {
			searchKeyword.value = searchKeyword.value.trim();
			if (!searchKeyword.value) {
				alert("キーワードを入力してください");
				searchKeyword.focus();
				return;
			}
			getDirectoryListBySearchKeyword(searchKeyword.value);
		};
		searchKeyword.addEventListener("keydown", function (event) {
			if (event.key === "Enter") {
				search();
			}
		});
		searchKeyword.nextElementSibling.addEventListener("click", search);

		const directoryLinkList = document.getElementById("directoryLinkList");
		const pagination = document.getElementById("pagination");
		addEventListener("popstate", function (event) {
			directoryLinkList.innerHTML = event.state.directoryLinkList;
			pagination.innerHTML = event.state.pagination;
		});
	});
</script>
</body>
</html>