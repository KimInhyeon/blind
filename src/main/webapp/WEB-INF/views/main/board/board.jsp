<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="resources/css/swiper-bundle.min.css"/>
<style>
	div.ui.container > section {
		margin-top: 2%;
	}

	.swiper-slide {
		cursor: pointer;
		text-align: center;
		font-size: 18px;
		color: gray;
		background: #fff;
		display: -webkit-box;
		display: -ms-flexbox;
		display: -webkit-flex;
		display: flex;
		-webkit-box-pack: center;
		-ms-flex-pack: center;
		-webkit-justify-content: center;
		justify-content: center;
		-webkit-box-align: center;
		-ms-flex-align: center;
		-webkit-align-items: center;
		align-items: center;
	}
</style>
<script src="resources/js/swiper-bundle.min.js"></script>

<div class="ui container">
	<section class="swiper">
		<div class="swiper-button-prev"></div>
		<div class="swiper-wrapper">
		<c:forEach var="board" items="${boardList}">
			<a class="swiper-slide" data-id="${board.boardId}">${board.boardTopicName}</a>
		</c:forEach>
		</div>
		<div class="swiper-button-next"></div>
	</section>
	<script>
		const swiper = new Swiper(".swiper", {
			navigation: {
				prevEl: ".swiper-button-prev",
				nextEl: ".swiper-button-next"
			},
			slidesPerView: 7
		});
		swiper.slideTo(${slideIndex}, 0, false);
	</script>
	<%@ include file="/WEB-INF/views/main/board/postList.jsp" %>
</div>

<script>
	function bookmark(bookmark) {
	<sec:authorize access="isAnonymous()">
		alert("ログインしていない");
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		fetch("bookmark", {
			method: "POST",
			headers: {
				"Content-Type": "application/json"
			},
			body: bookmark.dataset.id
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			}
			throw response.status;
		}).then(function (result) {
			bookmark.className = result ? "bookmark link icon red" : "bookmark link icon outline";
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	</sec:authorize>
	}

	addEventListener("DOMContentLoaded", function () {
		const getArticleHtml = function (post) {
			let html = "<article class=\"column\" data-id=\"" + post.postId +
						"\"><a class=\"ui grid row\" href=\"post/" + post.postId +
						"\" target=\"_blank\"><div class=\" thirteen wide column\"><h3 class=\"ui header row\">" +
						post.postTitle + "</h3><div class=\"row\">";
			const postBlockList = post.postContents;
			for (let i = 0, postBlockListLength = postBlockList.length; i < postBlockListLength; ++i) {
				html += "<p>" + postBlockList[i].data.text + "</p>";
			}
			html += "</div></div>";
			if (post.postFileUrl !== null) {
				html += "<div class=\"three wide column\"><img class=\"ui fluid image\" src=\"" +
						post.postFileUrl + "\"></div>";
			}
			html += "</a><div class=\"row\"><a href=\"company/introduction/" + post.companyId + "\">" +
					post.companyName + "</a><span>・" + post.userNickname +
					"</span></div><div class=\"ui stakable two column grid row\"><div class=\"column\">" +
					"<span class=\"postInfo\"><i class=\"eye icon\"></i>" + post.postCount  +
					"</span><span class=\"postInfo\"><i class=\"thumbs up outline icon\"></i>" +
					post.postRecommendCount + "</span><span class=\"postInfo\"><i class=\"comment outline icon\"></i>" +
					post.replyCount + "</span></div><div class=\"right aligned column\"><span>" + post.postCreateDate +
					"</span><i class=\"bookmark link icon ";
			html += post.bookmarked ? "red" : "outline";
			html += "\" data-id=\"" + post.postId + "\" onclick=\"bookmark(this);\"></i></div></div></article>";

			return html;
		};

		const url = new URL(location.href);
		const searchParams = url.searchParams;
		if (searchParams.has("boardId")) {
			searchParams.append("boardId", searchParams.get("boardId"));
		}
		const postList = document.getElementById("postList");
		let articleCount = postList.childElementCount;
		let postId = articleCount ? postList.lastElementChild.dataset.id : "0";
		const getNewArticle = async function () {
			searchParams.append("postId", postId);
			searchParams.append("ajax", "true");
			url.search = searchParams.toString();
			await fetch(url.toString(), {
				method: "GET"
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				}
				throw response.status;
			}).then(function (newPostList) {
				const postListLength = newPostList.length;
				if (postListLength) {
					let html = "";
					for (let i = 0; i < postListLength; ++i) {
						html += getArticleHtml(newPostList[i]);
					}
					postList.className = "ui stackable two column grid";
					if (Number(searchParams.get("postId"))) {
						postList.innerHTML += html;
					} else {
						postList.innerHTML = html;
					}
					articleCount += postListLength;
					postId = newPostList[postListLength - 1].postId;
					addNewObserve();
				} else {
					postList.className = "ui one column grid";
					postList.innerHTML =
						"<div class=\"ui divider\"></div><div class=\"center aligned column\">データがありません</div>";
				}
				searchParams.delete("ajax");
				searchParams.delete("postId");
				url.search = searchParams.toString();
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
			});
		};

		const intersectionObserver = new IntersectionObserver(function (entries, observer) {
			entries.forEach(async function (entry) {
				if (entry.isIntersecting) {
					observer.unobserve(entry.target);
					await getNewArticle();
					history.replaceState({
						slideIndex: history.state.slideIndex,
						postList: postList.innerHTML
					}, "");
				}
			});
		});
		const addNewObserve = function () {
			<%-- 読み込むポストが20個の故 --%>
			if (articleCount > 19) {
				intersectionObserver.observe(postList.children[articleCount - 5]);
			}
		};
		addNewObserve();

		const slide = document.getElementsByClassName("swiper-slide");
		const style = slide[0].getAttribute("style");
		let slideIndex = ${slideIndex};
		slide[slideIndex].style = "color: black; font-weight: bold; " + style;
		const getNewTitleAndSlider = function (oldIndex, newIndex) {
			document.title = slide[newIndex].innerText;
			slide[oldIndex].style = style;
			slide[newIndex].style = "color: black; font-weight: bold; " + style;
		};
		for (let i = slide.length - 1; i > -1; --i) {
			slide[i].addEventListener("click", async function () {
				intersectionObserver.disconnect();
				searchParams.set("boardId", this.dataset.id);
				articleCount = postId = 0;
				await getNewArticle();
				slideIndex = i;
				getNewTitleAndSlider(history.state.slideIndex, slideIndex);
				history.pushState({
					slideIndex: slideIndex,
					postList: postList.innerHTML
				}, "", url.toString());
			});
		}

		history.replaceState({
			slideIndex: slideIndex,
			postList: postList.innerHTML
		}, "");
		addEventListener("popstate", function (event) {
			intersectionObserver.disconnect();
			getNewTitleAndSlider(slideIndex, event.state.slideIndex);
			slideIndex = event.state.slideIndex;
			swiper.slideTo(slideIndex, 0, false);
			postList.innerHTML = event.state.postList;
			searchParams.set("boardId", slide[slideIndex].dataset.id);
			articleCount = postList.childElementCount;
			postId = postList.lastElementChild.dataset.id;
			addNewObserve();
		});
	});
</script>