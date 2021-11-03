<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#searchBox {
		border-radius: 50px;
		font-size: 23px;
	}

	#searchBox::placeholder {
		font-size: 18px;
	}

	.mainTitle {
		padding: 6px 0;
		font-size: 20px;
		font-weight: 700;
		float: left;
	}

	.titleLine {
		border: 0;
		height: 2px;
		background: #dfe1e4;
		margin-top: 45px;
	}

	.mainBest .ui.mini.horizontal.label {
		background: white;
		border: solid 1px #dfe1e4;
		margin-bottom: 10px;
	}

	.seeMore {
		float: right;
		padding-top: 15px;
	}

	#searchIcon {
		padding-left: 70px;
	}

	#mainBest {
		padding-top: 8px;
	}

	.mainTitle span {
		padding-left: 5px;
	}

	#mainBestTitle {
		padding-top: 50px;
	}

	.seeMore a, .mainBest span, .mainBest i {
		color: gray;
	}
</style>

<div class="ui container">
	<div class="ui fluid massive left icon input">
		<input type="text" placeholder="関心のある内容を検索してください。" id="searchBox">
		<i class="search link icon" id="searchIcon"></i>
	</div>

	<div id="mainBestTitle">
		<div class="mainTitle">
			<i class="chess queen icon"></i>
			<span>トピックベスト</span>
			<br style="clear: both;">
		</div>
		<div class="seeMore">
			<a href="search?boardId=0">もっと見る＞</a>
			<br style="clear: both;">
		</div>
		<hr class="titleLine">
	</div>

	<c:choose>
		<c:when test="${empty bestMainPostList}">
			<div id="mainBest"><%-- topic best --%>
				<h3>Can not found best topic</h3>
			</div><%-- topic best container --%>
		</c:when>
		<c:otherwise>
			<div id="mainBest"><%-- topic best --%>
			<c:forEach var="bestMainPost" items="${bestMainPostList}">
				<div class="mainBest">
					<div class="ui right floated horizontal list">
						<i class="thumbs up outline icon item" style="position: absolute; right: 20%;"></i>
						<span class="item" style="position: absolute; right: 17%;">${bestMainPost.postRecommendCount}</span>
						<i class="comment outline icon item" style="position: absolute; right: 15%;"></i>
						<span class="item">${bestMainPost.replyCount}</span>
					</div>
					<div class="ui horizontal list">
						<a class="item" href="search?boardId=${bestMainPost.boardId}">
							<div class="ui mini horizontal label">${bestMainPost.boardTopicName}</div>
						</a>
						<a class="item" href="post/${bestMainPost.postId}">
							<span style="color: black; margin-left: -5px;">${bestMainPost.postTitle}</span>
						</a>
						<br>
					</div>
				</div>
			</c:forEach>
			</div><%-- topic best container --%>
		</c:otherwise>
	</c:choose>

	<div class="ui two column grid container"><%-- sub --%>
	<c:forEach var="subMainPost" items="${subMainPostList}" varStatus="status">
		<c:if test="${status.first or subMainPostList[status.index - 1].boardId ne subMainPost.boardId}">
			<div class="column"><%-- 첫번째 --%>
				<div style="padding-top: 50px;">
					<div class="mainTitle">
						<i class="money icon"></i>
						<span>${subMainPost.boardTopicName}</span>
					</div>
					<div class="seeMore">
						<a href="search?boardId=${subMainPost.boardId}">もっと見る＞</a>
					</div>
					<hr class="titleLine">
				</div>
				<div>
		</c:if>
					<div class="mainBest">
						<div class="ui horizontal list" style="padding-left: 10px;">
							<a class="item" href="post/${subMainPost.postId}">
								<span style="color: black; margin-left: -5px;">${subMainPost.postTitle}</span>
							</a>
							<br>
						</div>
						<div class="ui right floated horizontal list">
							<i class="eye icon item" style="position: absolute; right: 60px;"></i>
							<span class="item" style="padding: 0 10px;">${subMainPost.postCount}</span>
						</div>
					</div>
		<c:if test="${status.last or subMainPostList[status.index + 1].boardId ne subMainPost.boardId}">
				</div>
			</div>
		</c:if>
	</c:forEach>
	</div><%-- subtopic --%>

</div><%-- main container --%>

<script>
	addEventListener("DOMContentLoaded", function () {
		const goSearch = function () {
			const searchKeyword = document.getElementById("searchBox").value.trim();
			if (searchKeyword) {
				location.href = "search?searchKeyword=" + searchKeyword;
			}
		};

		const searchBox = document.getElementById("searchBox");
		document.getElementById("searchIcon").addEventListener("click", goSearch);
		searchBox.addEventListener("keydown", function (event) {
			if (event.key === "Enter") {
				goSearch();
			}
		});

		searchBox.addEventListener("focus", function () {
			this.style.borderColor = "black";
			this.style.borderWidth = "3px";
		});
		searchBox.addEventListener("blur", function () {
			this.style.borderColor = this.style.borderWidth = "";
		})
	});
</script>