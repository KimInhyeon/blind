<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.tit {
		padding: 30px 0 8px 0;
		font-size: 150%;
		font-weight: 700;
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

	.bmcomname a {
		font-size: 80%;
	}

	.bmcomname span {
		font-size: 80%;
	}

	#icn1 a {
		color: gray;
	}

	#icn1 a i:hover {
		color: gray;
	}

	#icn2 a {
		color: gray;
	}

	#icn2 a i:hover {
		color: gray;
	}
</style>

<div class="ui container">
	<h3 class="tit">ブックマーク</h3>
	<div class="ui fitted divider" style="border-width: medium;"><%--fit 되는 얇은 선--%></div>
	<div class="bookmarkcontent">
		<div class="ui internally celled grid">
			<div class="row">
			<c:forEach var="post" items="${postList}" varStatus="status">
				<c:choose>
					<c:when test="${status.count % 2 == 1}">
						<div class="eight wide column">
							<a href="search?boardId=${post.boardId}">
								<span>${post.boardTopicName}</span>
							</a>
							<a href="post/${post.postId}">
								<span style="font-size: 130%; font-weight: 700;">${post.postTitle}</span>
							</a>
							<div class="ui grid">
								<div class="thirteen wide column">
									<div style="height: 60px; overflow: hidden;">
										<a href="post/${post.postId}">
										<c:forEach var="postBlock" items="${post.postContents}">
											<p style="word-wrap: break-word;">${postBlock.data.text}</p>
										</c:forEach>
										</a>
									</div>
								</div>
								<c:if test="${not empty post.postFileUrl}">
									<div class="three wide column">
										<a href="post/${post.postId}">
											<img class="ui tiny right floated image" src="${post.postFileUrl}">
										</a>
									</div>
								</c:if>
							</div>

							<div class="bmcomname">
							<c:choose>
								<c:when test="${empty post.companyName}">
									<a style="display: inline-block; padding: 5px 0 15px 0;"
											href="company/introduction/${post.companyId}">${post.companyName}</a>
								</c:when>
								<c:otherwise>
									<a style="display: inline-block; padding: 5px 0 15px 0;"></a>
								</c:otherwise>
							</c:choose>
								<span class="left floated">・${post.userNickname}</span>
							</div>
							<div class="ui left floated horizontal list" id="icn1">
								<a class="item" href="#">
									<i class="eye icon"></i>
									<span style="padding:0 5px;">${post.postCount}</span>
								</a>
								<a class="item">
								<c:choose>
									<c:when test="${post.recommended}">
										<i class="thumbs up red icon" data-id="${post.postId}"></i>
									</c:when>
									<c:otherwise>
										<i class="thumbs up outline icon" data-id="${post.postId}"></i>
									</c:otherwise>
								</c:choose>
									<span style="padding-left: 5px;">${post.postRecommendCount}</span>
								</a>
								<a class="item" href="#">
									<i class="comment outline icon"></i>
									<span style="padding: 0 5px;">${post.replyCount}</span>
								</a>
							</div>
							<div class="ui right floated horizontal list">
								<a class="item" href="#">
									<span style="padding-left: 5px; color: gray;">${post.postCreateDate}</span>
								</a>
								<a class="item">
									<i class="bookmark icon red" data-id="${post.postId}"></i>
									<span style="padding: 0 5px;"></span>
								</a>
							</div>
						</div>
						<c:if test="${status.last eq true}">
							<div class="eight wide column"></div>
						</c:if>
					</c:when>
					<c:when test="${status.count % 2 == 0}">
						<div class="eight wide column">
							<a href="search?boardId=${post.boardId}">
								<span>${bookmark.boardTopicName}</span>
							</a>
							<a href="post/${post.postId}">
								<span style="font-size: 130%; font-weight: 700;">${post.postTitle}</span>
							</a>
							<div class="ui grid">
								<div class="thirteen wide column">
									<div style="height: 60px; overflow: hidden;">
										<a href="post/${post.postId}">
										<c:forEach var="postBlock" items="${post.postContents}">
											<p style="word-wrap: break-word;">${postBlock.data.text}</p>
										</c:forEach>
										</a>
									</div>
								</div>
								<c:if test="${not empty post.postFileUrl}">
									<div class="three wide column">
										<a href="post/${post.postId}">
											<img class="ui tiny right floated image" src="${post.postFileUrl}">
										</a>
									</div>
								</c:if>
							</div>
							<div class="bmcomname">
							<c:choose>
								<c:when test="${empty post.companyName}">
									<a style="display: inline-block; padding: 5px 0 15px 0;"
											href="company/introduction/${post.companyId}">${post.companyName}</a>
								</c:when>
								<c:otherwise>
									<a style="display: inline-block; padding: 5px 0 15px 0;"></a>
								</c:otherwise>
							</c:choose>
								<span class="left floated">・${post.userNickname}</span>
							</div>
							<div class="ui left floated horizontal list" id="icn2">
								<a class="item" href="post/${post.postId}">
									<i class="eye icon"></i>
									<span style="padding: 0 5px;">${post.postCount}</span>
								</a>
								<a class="item">
								<c:choose>
									<c:when test="${post.recommended}">
										<i class="thumbs up red icon" data-id="${post.postId}"></i>
									</c:when>
									<c:otherwise>
										<i class="thumbs up outline icon" data-id="${post.postId}"></i>
									</c:otherwise>
								</c:choose>
									<span style="padding-left: 5px;">${post.postRecommendCount}</span>
								</a>
								<a class="item" href="post/${post.postId}">
									<i class="comment outline icon"></i>
									<span style="padding: 0 5px;">${post.replyCount}</span>
								</a>
							</div>
							<div class="ui right floated horizontal list">
								<a class="item" href="#">
									<span style="padding-left: 5px; color: gray;">${post.postCreateDate}</span>
								</a>
								<a class="item">
									<i class="bookmark icon red" data-id="${post.postId}"></i>
									<span style="padding: 0 5px;"></span>
								</a>
							</div>
						</div>
					</c:when>
				</c:choose>
			</c:forEach>
			</div>
		</div>
	</div>
	<div class="ui fitted divider" style="border-width: medium;"><%--하선--%></div>
</div>

<script>
	addEventListener("DOMContentLoaded", function () {
		document.querySelectorAll("i.bookmark.icon").forEach(function (icon) {
			icon.addEventListener("click", function () {
				fetch(location.pathname, {
					method: "POST",
					headers: {
						"Content-Type": "application/json"
					},
					body: this.dataset.id
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					}
					throw  response.status;
				}).then(function (result) {
					icon.className = result ? "bookmark red icon" : "bookmark outline icon";
				}).catch(function (error) {
					alert("予期しないエラーが発生しました");
					console.error(error);
				});
			});
		});

		document.querySelectorAll("i.thumbs.up.icon").forEach(function (icon) {
			icon.addEventListener("click", function () {
				console.log(this.dataset.id);
				fetch("post/recommend", {
					method: "POST",
					headers: {
						"Content-Type": "application/json"
					},
					body: this.dataset.id
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					}
					throw  response.status;
				}).then(function (recommendResult) {
					icon.className = recommendResult.recommended ? "thumbs up red icon" : "thumbs up outline icon";
					icon.nextElementSibling.innerText = recommendResult.postRecommendCount;
				}).catch(function (error) {
					alert("予期しないエラーが発生しました");
					console.error(error);
				});
			});
		});
	});
</script>