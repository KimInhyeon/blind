<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
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

<section class="ui stackable two column grid" id="postList">
<c:forEach var="post" items="${postList}">
	<article class="column" data-id="${post.postId}">
		<a class="ui grid row" href="post/${post.postId}" target="_blank">
			<div class="thirteen wide column">
				<h3 class="ui header row">${post.postTitle}</h3>
				<div class="row">
				<c:forEach var="postBlock" items="${post.postContents}">
					<p>${postBlock.data.text}</p>
				</c:forEach>
				</div>
			</div>
			<c:if test="${not empty post.postFileUrl}">
				<div class="three wide column">
					<img class="ui fluid image" src="${post.postFileUrl}">
				</div>
			</c:if>
		</a>
		<div class="row">
			<c:if test="${not empty post.companyName}">
				<a href="company/introduction/${post.companyId}" target="_blank">${post.companyName}</a>
				<span>・</span>
			</c:if>
			<span>${post.userNickname}</span>
		</div>
		<div class="ui stackable two column grid row">
			<div class="column">
				<span class="postInfo"><i class="eye icon"></i>${post.postCount}</span>
				<span class="postInfo"><i class="thumbs up outline icon"></i>${post.postRecommendCount}</span>
				<span class="postInfo"><i class="comment outline icon"></i>${post.replyCount}</span>
			</div>
			<div class="right aligned column">
				<span>${post.postCreateDate}</span>
				<i class="bookmark link icon<c:if test="${not post.bookmarked}"> outline</c:if>"
					data-id="${post.postId}" onclick="bookmark(this);"></i>
			</div>
		</div>
	</article>
</c:forEach>
</section>