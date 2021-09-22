<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
	span {
		margin-left: 1%;
		font-size: 1.3em;
	}

	a {
		margin: 0.5%;
	}
</style>

<%@ include file="/WEB-INF/views/main/company/companyMenu.jsp" %>
<div class="ui container">
	<div class="ui bottom attached active tab segment">
		<div style="margin: 2%; width: 100%;"> <%-- 기업리뷰의 게시글 전체 감싸기 div --%>
			<%-- 1.기업리뷰의 게시글의 헤더(검색창&추천키워드)부분 --%>
			<div style="margin-top: 5%; margin-bottom: 5%; width: 90%;">
				<h2 style="margin-bottom: 3%;">${companyMenu.companyName}のポスト</h2>
				<%-- 1.1.검색창 --%>
				<div class="inputSearchKeyword">
					<div class="ui fluid massive left icon input" style="width: 90%;">
						<input type="text" placeholder="Search" id="searchBox" name="searchKeyword">
						<i class="search link icon" id="searchIcon"></i>
						<div class="results"></div>
					</div>
				</div>

				<%-- 1.2.추천 키워드 출력 --%>
				<div style="margin: 2%;">
					<span style="font-weight: bold;">おすすめキーワード</span>
				<%-- 처우 --%>
					<span>
						<a href="company/post/${companyMenu.companyId}?searchKeyword=處遇">
							${companyMenu.companyName}の處遇
						</a>
					</span>
				<%-- 연봉 --%>
					<span>
						<a href="company/post/${companyMenu.companyId}?searchKeyword=給料">
							${companyMenu.companyName}の給料
						</a>
					</span>
				<%-- 경력 --%>
					<span>
						<a href="company/post/${companyMenu.companyId}?searchKeyword=キャリア">
							${companyMenu.companyName}のキャリア
						</a>
					</span>
				<%-- 대우(직장에서의 지위나 급료 등 근무자에 대한 처우(處遇).) --%>
					<span>
						<a href="company/post/${companyMenu.companyId}?searchKeyword=待遇">
							${companyMenu.companyName}の待遇
						</a>
					</span>
				<%-- 분위기 --%>
					<span>
						<a href="company/post/${companyMenu.companyId}?searchKeyword=雰圍氣">
							${companyMenu.companyName}の雰圍氣
						</a>
					</span>
				<%-- 면접 --%>
					<span>
						<a href="company/post/${companyMenu.companyId}?searchKeyword=面接">
							${companyMenu.companyName}の面接
						</a>
					</span>
				<%-- 개발 --%>
					<span>
						<a href="company/post/${companyMenu.companyId}?searchKeyword=開發">
							${companyMenu.companyName}の開發
						</a>
					</span>
				</div>
			</div>
			<%-- 2.포스터출력 --%>
			<%-- 구현(1)컨트롤러에서 기업명으로 검색을 한 결과를 가져와서 출력하도록 실시.
				 구현(2)모든 토픽들을 검색하며, 현재는 제목에 검색어가 있는 경우만 실실.
				 구현(3)검색결과 출력할 글이 20개 이하면 페이징 않고 전체 출력.(패이징 컨트롤러도 출력얺음)20개 초과시 페이징실시 & 하단에 페이지컨트롤러 배치.
			 --%>
			<div style="margin-top: 5%;">
				<%-- 게시글(포스트)들 출력 --%>
				<%-- https://semantic-ui.com/collections/grid.html --%>
				<div id="postList" style="background-color: #ffffff; padding : 2%;width: 90%;">
					<div class="ui divider" style="border-color: #d4d4d5;"></div>
					<%--포스트 구분에 사용되는 가로선을 긋기위한 div(감싸는 구간없음)--%>
				<c:forEach var="post" items="${companyPostList}">
					<div style="padding : 2%; border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;">
						<a href="post/${post.postId}">
							<span style="font-size: 150%;">${post.postTitle}</span>
						</a>

						<div>
							<a href="post/${post.postId}">
							<c:forEach var="postBlock" items="${post.postContents}">
								<p>${postBlock.data.text}</p>
							</c:forEach>
							</a>
						<c:if test="${not empty post.companyName}">
							<a href="company/introduction/${post.companyId}">
								<p>${post.companyName} - ${post.userNickname}</p>
							</a>
						</c:if>
						</div>

						<div style="padding: 10px;">
							<div style="display: flex;"> <%-- 조회수, 좋아요 갯수, 댓글 수 출력  --%>
								<a href="post/${post.postId}">
									<i class="eye icon" style="margin: 0 5px 0 5px;"></i>${post.postCount}
								</a>
								<a href="post/${post.postId}">
									<i class="thumbs up outline icon" style="margin: 0 5px 0 5px;"></i>${post.postRecommendCount}
								</a>
								<a href="post/${post.postId}">
									<i class="comment outline icon" style="margin: 0 5px 0 5px;"></i>${post.replyCount}
								</a>
							</div>

							<div style="float: right;">${post.postCreateDate}
								<%--검색결과 최초 출력시 북마크의 on/off 표시 위한 jstl조건문--%>
								<div style="display: inline; margin: 0 5px 0 5px;">
									<a style="color: #000000; margin: 0;">
										<i class="bookmark link icon<c:if test="${not post.bookmarked}"> outline</c:if>"
											data-id="${post.postId}" onclick="bookmark(this);"></i>
									</a>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
		</div>

		<%-- 페이징 버튼 배치. 정렬옵션을 주어 배치를 맞춰야 한다. --%>
		<div id="pagination" style="text-align: center; margin-bottom: 5%;">
		<c:choose>
			<c:when test="${navi.startPage gt navi.pagination}">
				<div class="ui pagination menu">
					<a class="item" href="javascript:getPosts(${navi.startPage - navi.pagination})">前へ</a>
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
						<a class="item" href="javascript:getPosts(${page})">${page}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<c:choose>
			<c:when test="${navi.totalPage gt navi.endPage}">
				<div class="ui pagination menu">
					<a class="item" href="javascript:getPosts(${navi.endPage + 1})">次へ</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="ui pagination menu" style="visibility: hidden;"><a class="item">次へ</a></div>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
</div>

<script>
	function bookmark(bookmark) {
	<sec:authorize access="isAuthenticated()">
		fetch("addBookmark", {
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
			bookmark.className = result ? "bookmark link icon" : "bookmark link icon outline";
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	</sec:authorize>
	}

	function getPosts(page) {
		const searchParams = new URLSearchParams(location.search)
		if (page > 1) {
			searchParams.set("page", page);
		} else {
			searchParams.delete("page");
		}
		location.search = searchParams.toString();
	}

	addEventListener("DOMContentLoaded", function () {
		const searchParams = new URLSearchParams(location.search);
		const searchBox = document.getElementById("searchBox");
		searchBox.value = searchParams.get("searchKeyword")
		const goSearch = function () {
			const searchKeyword = searchBox.value.trim();
			if (searchKeyword) {
				searchParams.set("searchKeyword", searchKeyword);
				location.search = searchParams.toString();
			}
		};

		document.getElementById("searchIcon").addEventListener("click", goSearch);
		searchBox.addEventListener("keydown", function (event) {
			if (event.key === "Enter") {
				goSearch();
			}
		});
	});
</script>