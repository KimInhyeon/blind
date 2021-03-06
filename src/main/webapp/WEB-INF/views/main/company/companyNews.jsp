<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	section.ui.grid.container .row {
		padding: 2%;
	}

	article.ui.grid.row .row {
		padding: 1%;
	}

	div.ui.segment.items.row {
		padding: 0;
		margin: 1%;
	}
</style>

<%@ include file="/WEB-INF/views/main/company/companyMenu.jsp" %>
<div class="ui grid container" style="padding: 1%;">
	<section class="eleven wide column">
		<div class="row">
			<h2 class="ui header">${companyMenu.companyName} ニュース</h2>
		</div>
		<div class="row" id="article">
		<c:forEach var="article" items="${articles}">
			<div class="ui divider"></div>
			<article class="ui grid row">
				<div class="ui items row">
					<div class="item">
						<img class="ui mini image" src="resources/images/company/${companyMenu.companyId}.png">
						<div class="middle aligned content">
							<div class="header">${companyMenu.companyName}</div>
							<div class="extra">${article.author} / ${article.publishedAt}</div>
						</div>
					</div>
				</div>
				<div class="row">${article.description}</div>
				<div class="row"><a href="${article.url}" target="_blank">${article.url}</a></div>
				<div class="ui segment items row">
					<div class="item">
						<img class="ui small image" src="${article.urlToImage}">
						<div class="middle aligned content">
							<a class="description" href="${article.url}" target="_blank">${article.title}</a>
							<p class="extra" style="padding-top: 3%;">${article.author}</p>
						</div>
					</div>
				</div>
			</article>
		</c:forEach>
		</div>
		<div class="ui section divider"></div>
		<div class="ui grid row">
			<div class="center aligned column" id="pagination">
			<c:choose>
				<c:when test="${navi.startPage gt navi.pagination}">
					<div class="ui pagination menu">
						<a class="item" href="javascript:getNewsList(${navi.startPage - navi.pagination})">前へ</a>
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
							<a class="item" href="javascript:getNewsList(${page})">${page}</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<c:choose>
				<c:when test="${navi.totalPage gt navi.endPage}">
					<div class="ui pagination menu">
						<a class="item" href="javascript:getNewsList(${navi.endPage + 1})">次へ</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="ui pagination menu" style="visibility: hidden;"><a class="item">次へ</a></div>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
	</section>
	<section class="five wide column"></section>
</div>

<script>
	function getNewsList(page) {
		const url = new URL(location.href);
		const searchParams = new URLSearchParams();
		searchParams.set("ajax", "true");
		if (page > 1) {
			searchParams.set("page", String(page));
		}
		url.search = searchParams.toString();
		fetch(url.toString(), {
			method: "GET"
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			}
			throw response.status;
		}).then(function (companyNews) {
			const articles = companyNews.articles;
			const navi = companyNews.navi;
			const article = document.getElementById("article");
			const pagination = document.getElementById("pagination");

			let html = "";
			for (let i = 0, length = articles.length; i < length; ++i) {
				html += "<div class=\"ui divider\"></div><article class=\"ui grid row\"><div class=\"ui items row\">" +
						"<div class=\"item\"><img class=\"ui mini image\" src=\"resources/images/company/" +
						"${companyMenu.companyId}.png\"><div class=\"middle aligned content\">" +
						"<div class=\"header\">${companyMenu.companyName}</div><div class=\"extra\">" +
						articles[i].author + " / " + articles[i].publishedAt + "</div></div></div></div>" +
						"<div class=\"row\">" + articles[i].description + "</div><div class=\"row\"><a href=\"" +
						articles[i].url + "\">" + articles[i].url + "</a></div><div class=\"ui segment items row\">" +
						"<div class=\"item\"><img class=\"ui small image\" src=\"" + articles[i].urlToImage +
						"\"><div class=\"middle aligned content\"><a class=\"description\" href=\"" + articles[i].url +
						"\">" + articles[i].title + "</a><p class=\"extra\" style=\"padding-top: 3%;\">" +
						articles[i].author + "</p></div></div></div></article>";
			}
			article.innerHTML = html;

			if (navi.startPage > navi.pagination) {
				html = "<div class=\"ui pagination menu\"><a class=\"item\" href=\"javascript:getNewsList(" +
						(navi.startPage - navi.pagination) + ");\">前へ</a></div><div class=\"ui pagination menu\">";
			} else {
				html = "<div class=\"ui pagination menu\" style=\"visibility: hidden;\">" +
						"<a class=\"item\">前へ</a></div><div class=\"ui pagination menu\">";
			}
			do {
				if (navi.startPage === navi.currentPage) {
					html += "<div class=\"active item\">" + navi.startPage + "</div>";
				} else {
					html += "<a class=\"item\" href=\"javascript:getNewsList(" + navi.startPage + ");\">" +
							navi.startPage + "</a>";
				}
			} while (++navi.startPage <= navi.endPage);
			if (navi.totalPage > navi.endPage) {
				html += "</div><div class=\"ui pagination menu\"><a class=\"item\" href=\"javascript:getNewsList(" +
						navi.startPage + ");\">次へ</a></div>";
			} else {
				html += "</div><div class=\"ui pagination menu\" style=\"visibility: hidden;\">" +
						"<a class=\"item\">次へ</a></div>";
			}
			pagination.innerHTML = html;

			scrollTo(0, 0);
			searchParams.delete("ajax");
			url.search = searchParams.toString();
			history.pushState({
				"article": article.innerHTML,
				"pagination": pagination.innerHTML
			}, "", url.toString());
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}

	addEventListener("DOMContentLoaded", function () {
		const article = document.getElementById("article");
		const pagination = document.getElementById("pagination");
		if (!document.querySelectorAll("article.ui.grid.row").length) {
			article.innerHTML = "<div class=\"ui section divider\"></div>" +
								"<div style=\"text-align: center;\">該当する記事がありません。</div>";
		}
		history.replaceState({
			"article": article.innerHTML,
			"pagination": pagination.innerHTML
		}, "");
		onpopstate = function (event) {
			article.innerHTML = event.state.article;
			pagination.innerHTML = event.state.pagination;
		};
	});
</script>