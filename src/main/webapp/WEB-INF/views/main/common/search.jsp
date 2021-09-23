<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.company_review_sample > * {
		padding: 5px;
	}

	html, body {
		position: relative;
		height: 100%;
	}

	body {
		font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
		font-size: 14px;
		color: #000;
		margin: 0;
		padding: 0;
	}

	.bookmarkcontent a {
		color: black;
		display: block;
		padding-bottom: 8px;
	}

	.bookmarkcontent a span {
		font-size: 80%;
	}

	.bookmarkcontent p {
		padding-top: 12px;
		font-size: 90%;
	}

	#searchBox {
		border-radius: 50px;
		font-size: 23px;
	}

	#searchBox::placeholder {
		font-size: 18px;
	}

	#searchIcon {
		padding-left: 70px;
	}

	.font_company_search {
		font-weight: bolder;
		font-size: 1.2em;
	}

	article.column {
		border-style: solid;
		border-width: thin;
		border-color: #d4d4d5;
	}

	article.column > .row {
		padding: 1%;
	}

	article.column a {
		color: black;
	}

	a.ui.grid.row > div.column {
		margin-top: 5%;
	}

	a.ui.grid.row > div.thirteen.wide.column > div.row {
		overflow: hidden;
		padding-top: 5%;
		max-height: 4em;
	}

	a.ui.grid.row > div.thirteen.wide.column > div.row > p {
		margin: 0;
		word-wrap: break-word;
	}

	i.bookmark.link.icon {
		margin-left: 7%;
	}

	.postInfo {
		margin: 2%;
	}
</style>

<div class="ui container">
	<div class="bookmarkcontent">
		<%-- 검색창 --%>
		<div class="inputSearchKeyword">
			<div class="ui fluid massive left icon input">
				<input type="text" placeholder="Search" id="searchBox" value="${title}">
				<i class="search link icon" id="searchIcon"></i>
				<div class="results"></div>
			</div>
		</div>

		<%-- 검색결과출력페이지(전체) --%>
		<div style="margin-top: 2.5%;margin-bottom: 2.5%; margin-left: 1.4%;">
			<span style="font-size: 2em; font-weight: bolder;"> ${title}</span>
			<span style="font-size: 2em;"> 検索結果</span>
		</div>
		<%-- 검색결과1. 기업정보 / 검색어가 기업이 아닌경우 출력되지 않는다. --%>
		<c:if test="${not empty company}">
			<div class="font_company_search" style="border: 1px solid #cccccc; border-radius: 0.5em; padding: 2%;">
				<h3>企業</h3>
				<div style="height: auto; width: 100%; padding: 2%;">
					<%-- 검색결과1.1. 기업의 기본정보페이지(총평점 및 리뷰/게시글/연봉링크) --%>
					<%-- 회사이름,별점 안내 및 리뷰,게시글,연봉 버튼 생성 --%>
					<div class="company_profile_part"> <%-- onclick 통해 div영역 클릭시 페이지 이동(''내에 이동할 URL 기입) --%>
						<div class="logo_and_companyName" style="float: left; display: inline;">
							<div style="display: flex;">
								<img src="resources/images/company/${company.companyId}.png" width="40" height="40"
										style="margin: 5px;" align="top">
								<div style="margin-left: 10px;">
									<%-- 기업로고 오른쪽-윗라인 : 기업명, 기업총평점의 평균점수--%>
										${company.companyName}
									<div class="ui star rating disabled" data-rating="1" data-max-rating="1"
											style="margin-left: 10px;">
										<i class="icon active"></i>
									</div>
										${company.allPointAvg}

									<%-- 기업로고 오른쪽-아래라인 : 해당 기업의 기업리뷰파트의 리뷰/기업게시판/급여 탭으로 이동.--%>
									<div style="display: flex;">
										<a href="company/review/${company.companyId}" style="margin-right: 10px;">
											<span style="color: #3d698e;"> レビュー </span>
										</a>
										<a href=company/post/${company.companyId}" style="margin-right: 10px;">
											<span style="color: #3d698e;"> 企業ポスト </span>
										</a>
										<a href="company/post/${company.companyId}?searchKeyword=給料"
												style="margin-right: 10px;">
											<span style="color: #3d698e;"> 給料 </span>
										</a>
									</div>
								</div>
							</div>
						</div>
					</div>

					<%-- 검색결과1.2. 일하고 싶은 기업인지 추천/비추천버튼 출력. 투표완료시 투표결과(기업선호도)를 출력하는 페이지로 변경. --%>
					<div style="margin-top: 10%;">
						<div style="width: 100%; margin-top: 11%; margin-bottom: 5%; text-align: center;"
								id="company_vote_and_recommend_percent">
								${company.companyName}は働きたい企業ですか
							<button style="color: blue;" class="ui icon button company_recommend_button" value="1">
								<i class="thumbs up outline icon"></i>
							</button>
							<button style="color: red;" class="ui icon button company_recommend_button" value="0">
								<i class="thumbs down outline icon"></i>
							</button>
						</div>

						<div class="company_review_sample" style="background-color: #b1d4e3; margin-top: 2%;">

							<%-- 기존의 총평점(float형) 값을 int형으로 변환(소수점이하 삭제)--%>
							<fmt:parseNumber var="show_star_point" value="${company.allPoint}" integerOnly="true"/>
							<%--소수점을 버리고 정수(int)로 만든다. int형이 아니면 div_star의 별점표현이 작동을 못한다.--%>
							<%-- 논의사항: 3.9같은 경우에는 4.0으로 올림처리를 해야 맞는가? --%>
							<%-- show_star_point:${show_star_point} 정상작동 체크(값확인용) 코드.--%>

							<div class="div_star">
								<div class="ui star rating disabled" data-max-rating="5">
								<c:forEach begin="1" end="5" step="1" varStatus="status">
									<c:choose>
										<c:when test="${show_star_point ge status.count}">
											<i class="icon active"></i>
										</c:when>
										<c:otherwise>
											<i class="icon"></i>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								</div>
							</div>

					<%--<c:set var="show_star_point" value="${company.allPoint}"/>--%>
					<%-- 구분선 끝 --%>
							<c:choose>
								<c:when test="${empty company.allPoint}">
									<div>この企業のレビューはありません。</div>
									<div>一番に作成しませんか。</div>
									<div style="float: right;">
										<button class="mini ui blue button"
												onclick="location.href='company/review?companyId=${company.companyId}'">
											この企業のレビューを作成する
										</button>
									</div>
								</c:when>
								<c:otherwise>
									<a href="company/review/${company.companyId}">
										<div style="display: inline-block; margin-top: 1.2%;
												margin-bottom: 1.2%; margin-left: 1%;">
											${company.allPoint}
										</div>
										<div style="display: block; float:Right; margin-top: 1.2%;
												margin-bottom: 1.2%; padding-right: 2%;">
											レビュー全部見る >
										</div>
										<div style="margin-top: 1.2%; margin-bottom: 1.2%; margin-left: 1%;">
											${company.jobGroupName}
										</div>
										<div style="margin-top: 1.2%; margin-bottom: 1.2%; margin-left: 1%;">
											${company.simpleComment}
										</div>
										<div style="margin-top: 1.2%; margin-bottom: 1.2%; margin-left: 1%;">
											${company.disadvantages}
										</div>
									</a>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
			<div class="ui divider"></div>
		</c:if>

		<%-- 검색결과2. 토픽(게시글) --%>
		<%-- 드롭버튼 - 토픽선택, 정렬설정 --%>
		<%-- 드롭버튼(1)토픽선택 --%>
		<div>
			<select id="viewPostsSelectedTopic" class="ui dropdown" style="width: 200px; height: 50px;">
			<%-- 모든 토픽들과 포스트들의 이름, 갯수들을 출력.--%>
			<c:forEach var="board" items="${boardList}">
				<option value="${board.boardId}"> ${board.boardTopicName} ( ${board.postCount} )</option>
			</c:forEach>
			</select>

			<%-- 드롭버튼(2)정렬설정 --%>
			<select id="sortPosts" style="float: right; width: 100px; height: 50px;">
				<option value="date">最新順</option>
				<option value="recommend">推薦順</option>
			</select>
		</div>
		<hr width="100%" color="#000000" size="5">
		<%-- 게시글(포스트)들 출력 --%>
		<%@ include file="/WEB-INF/views/main/board/postList.jsp" %>
	</div>
</div>

<script>
	addEventListener("DOMContentLoaded", function () {
		const getArticleHtml = function (post) {
			let html = "<article class=\"column\" data-id=\"" + post.postId + "\"><a class=\"ui grid row\" " +
				"href=\"${pageContext.request.contextPath}/post/" + post.postId + "\" target=\"_blank\">" +
				"<div class=\" thirteen wide column\"><h3 class=\"ui header row\">" + post.postTitle +
				"</h3><div class=\"row\">";
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
					post.companyName + "</a><span>・" + post.userNickname + "</span></div><div class=\"ui stakable " +
					"two column grid row\"><div class=\"column\"><span class=\"postInfo\"><i class=\"eye icon\"></i>" +
					post.postCount  + "</span><span class=\"postInfo\"><i class=\"thumbs up outline icon\"></i>" +
					post.postRecommendCount + "</span><span class=\"postInfo\"><i class=\"comment outline icon\"></i>" +
					post.replyCount + "</span></div><div class=\"right aligned column\"><span>" + post.postCreateDate +
					"</span><i class=\"bookmark link icon ";
			if (!post.bookmarked) {
				html += "outline ";
			}
			html += "data-id=\"" + post.postId + "\" onclick=\"bookmark(this);\"></i></div></div></article>";

			return html;
		};

		const url = new URL(location.href);
		const searchParams = url.searchParams;
		const postList = document.getElementById("postList");
		let articleCount = postList.childElementCount;
		let postId = articleCount ? postList.lastElementChild.dataset.id : "0";
		let boardId = searchParams.has("boardId") ? searchParams.get("boardId") : "0";
		let sort = searchParams.has("sort") ? searchParams.get("sort") : "date";
		const sortPosts = document.getElementById("sortPosts");
		sortPosts.value = sort;
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
					if (Number(searchParams.get("postId"))) {
						postList.innerHTML += html;
					} else {
						postList.innerHTML = html;
					}
					articleCount += postListLength;
					postId = newPostList[postListLength - 1].postId;
					addNewObserve();
					searchParams.delete("ajax");
					searchParams.delete("postId");
					url.search = searchParams.toString();
				}
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
						title: document.title,
						boardId: boardId,
						postId: postId,
						postList: postList.innerHTML,
						sort: sort
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

		document.getElementById("viewPostsSelectedTopic").addEventListener("change", function () {
			intersectionObserver.disconnect();
			articleCount = postId = 0;
			boardId = this.value;
			if (boardId === "0") {
				searchParams.delete("boardId");
			} else {
				searchParams.set("boardId", boardId);
			}
			getNewArticle();
			addNewObserve();
			history.pushState({
				title: document.title,
				boardId: boardId,
				postId: postId,
				postList: postList.innerHTML,
				sort: sort
			}, "", url.toString());
		});

		history.replaceState({
			title: document.title,
			boardId: boardId,
			postId: postId,
			postList: postList.innerHTML,
			sort: sort
		}, "");
		addEventListener("popstate", function (event) {
			intersectionObserver.disconnect();
			document.title = event.state.title,
			boardId = event.state.boardId;
			postId = event.state.postId;
			postList.innerHTML = event.state.postList;
			sort = event.state.sort;
			articleCount = postList.childElementCount;
			addNewObserve();
		});

		const searchBox = document.getElementById("searchBox");
		const goSearch = function () {
			const searchKeyword = searchBox.value.trim();
			if (searchKeyword) {
			<%--
				intersectionObserver.disconnect();
				articleCount = boardId = postId = 0;
				searchKeyword.delete("boardId");
				searchKeyword.delete("postId");
				searchParams.set("searchKeyword", searchKeyword);
				getNewArticle();
				addNewObserve();
				history.pushState({
					title: searchKeyword,
					boardId: boardId,
					postId: postId,
					postList: postList.innerHTML,
					sort: sort
				}, "", url.toString());
				document.title = searchKeyword;
			 --%>
				searchParams.delete("boardId");
				searchParams.delete("postId");
				searchParams.delete("sort");
				searchParams.set("searchKeyword", searchKeyword);
				location.search = searchParams.toString();
			} else {
				alert("検索語を入力してください");
			}
		};
		document.getElementById("searchIcon").addEventListener("click", goSearch);
		searchBox.addEventListener("keydown", function (event) {
			if (event.key === "Enter") {
				goSearch();
			}
		});

		sortPosts.addEventListener("change", function () {
			intersectionObserver.disconnect();
			articleCount = postId = 0;
			sort = this.value;
			if (sort === "date") {
				searchParams.delete("sort");
			} else {
				searchParams.append("sort", sort);
			}
			getNewArticle();
			addNewObserve();
			history.pushState({
				title: document.title,
				boardId: boardId,
				postId: postId,
				postList: postList.innerHTML,
				sort: sort
			}, "", url.toString());
		});

		<%--기업추천여부(기업에 일하고 싶은가 여부) - 좋아요 버튼 클릭시--%>
		$(".company_recommend_button").on('click', function () {

			var companyName = '${company.companyName}'; <%--기업명 저장. append할 때 로드하여 기업명 출력시 사용.--%>
			$.ajax({
				type: "POST",
				url: "company/recommend",
				data: {
					companyId: "${company.companyId}"
					, companyVoteValue: $(this).val() <%--기업추천여부. 1:기업추천 0:기업비추천--%>
				},
				dataType: "json",
				success: function (result) { <%--투표결과(기업선호도)를 출력하도록 변경.--%>

					<%--초기화(기업선호도 투표를 위한 추천/비추천 버튼등을 삭제)--%>
					$(company_vote_and_recommend_percent).html("");

					$(company_vote_and_recommend_percent).append(companyName + "は働きたい企業ですか"
						+ "<button style='color: blue;' class='ui icon button company_recommend_button'>"
						+ "<i class='thumbs up outline icon'></i>" + result[0].voteCountOfGood + '%'
						+ "</button>"
						+ "<button style='color: red;' class='ui icon button company_recommend_button'>"
						+ "<i class='thumbs down outline icon'></i>" + result[0].voteCountOfBad + '%'
						+ "</button>"
					);
				},
				error: function () {
					alert("에러");
				}
			});
		});
	});
</script>