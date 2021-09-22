<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>${post.postTitle}</title>
	<style>
		#post:first-child .row {
			padding-top: 1%;
			padding-bottom: 1%;
		}

		.right.aligned.column > div.ui.compact.menu {
			background: none;
			border: none;
			box-shadow: 0 0;
		}

		.right.aligned.column div.ui.dropdown.item {
			background: none;
		}

		#postContents > p {
			word-wrap: break-word;
		}

		span.data {
			padding-right: 3%;
		}

		#writeReply > button {
			min-height: 4em;
			font-size: medium;
			text-align: left;
		}

		#reply article > .row {
			padding: 0.5%;
		}

		#reply article > .row > .column {
			padding: 0;
		}

		.targetNickname {
			padding-right: 2%;
			color: gray;
			cursor: pointer;
		}

		.replyLine {
			padding: 0;
			word-wrap: break-word;
		}

		.ui.form > .fields {
			padding: 2%;
		}

		.ui.form > .fields > .center.aligned.one.wide.field {
			margin-top: 2%;
		}

		.fourteen.wide.field > *:not(button) {
			margin-bottom: 2%;
		}
	</style>
</head>
<body>
<div class="ui grid container">
	<section class="eleven wide column">
		<section id="post">
			<article class="row">
				<div class="row">
					<a class="ui small header" href="${pageContext.request.contextPath}/board/0">トピック</a>
					<i class="angle right icon"></i>
					<a class="ui small header" href="${pageContext.request.contextPath}/board/${post.boardId}">
						${post.boardTopicName}
					</a>
				</div>
				<div class="row">
					<h2 class="ui header">${post.postTitle}</h2>
				</div>
				<div class="row">
				<c:if test="${not empty post.companyName}">
					<a href="${pageContext.request.contextPath}/companyIntroduction?companyId=${post.companyId}"
						target="_blank">${post.companyName}</a>
					<span>・</span>
				</c:if>
					<span>${post.userNickname}</span>
				</div>
				<div class="ui grid row">
					<div class="twelve wide column">
						<i class="clock outline icon"></i><span class="data">${post.postCreateDate}</span>
						<i class="eye icon"></i><span class="data">${post.postCount}</span>
						<i class="comment outline icon"></i><span>${post.replyCount}</span>
					</div>
					<div class="four wide right aligned column">
						<i class="bookmark<c:if test="${not post.bookmarked}"> outline</c:if>
							<sec:authorize access="isAuthenticated()">link</sec:authorize> icon"></i>
						<div class="ui compact menu">
							<div class="ui dropdown item">
								<i class="ellipsis horizontal icon"></i>
								<div class="left menu">
									<div class="item" onclick="restoreMenuItem(this);">
										<i class="linkify icon"></i><span>アドレスコピー</span>
									</div>
						<sec:authorize access="isAuthenticated()">
							<c:choose>
								<c:when test="${post.writer}">
									<div class="item" onclick="restoreMenuItem(this);">
										<i class="edit outline icon"></i><span>ポスト修正</span>
									</div>
									<div class="item" onclick="restoreMenuItem(this);">
										<i class="trash alternate outline icon"></i><span>ポスト削除</span>
									</div>
								</c:when>
								<c:otherwise>
									<div class="item" onclick="restoreMenuItem(this);">
										<i class="bullhorn icon"></i><span>通報する</span>
									</div>
								</c:otherwise>
							</c:choose>
						</sec:authorize>
								</div>
							</div>
						</div>
					</div>
				</div>
			</article>
			<div class="ui divider row" style="margin: 0"></div>
			<article class="row" id="postContents">
			<c:forEach var="postBlock" items="${post.postContents}">
				<c:choose>
					<c:when test="${postBlock.type eq 'paragraph'}">
						<p>${postBlock.data.text}</p>
					</c:when>
					<c:otherwise>
						<img class="ui<c:if test="${postBlock.data.stretched}"> fluid</c:if> image"
							src="${postBlock.data.url}">
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</article>
			<article class="row" style="padding-top: 2em;">
				<i class="thumbs up<c:if test="${not post.postRecommended}"> outline</c:if>
					<sec:authorize access="isAuthenticated()">link </sec:authorize>icon"></i>
				<span class="data">${post.postRecommendCount}</span>
				<i class="comment outline link icon"></i><span>${post.replyCount}</span>
			</article>
		</section>
		<div class="ui section divider"></div>
		<%@ include file="/WEB-INF/views/main/body/board/reply.jsp" %>
	</section>
	<section class="five wide column"></section>
</div>
<div class="ui large modal" id="imageModal">
	<i class="window close outline icon"></i>
	<div class="image content">
		<img class="ui fluid image" onclick="$('#imageModal').modal('hide');">
	</div>
</div>
<script>
	function restoreMenuItem(item) {
		setTimeout(function () {
			item.className = "item";
		}, 0);
	}

	function enlargeImage(src) {
		document.querySelector("#imageModal img").src = src;
		$("#imageModal").modal("show");
	}

	function openReplyBox(button, targetReplyId, replyBlindFlag) {
	<sec:authorize access="isAnonymous()">
		alert("ログインしてください");
	</sec:authorize>
	<sec:authorize access="hasRole('NM')">
		alert("権限がありません");
	</sec:authorize>
	<sec:authorize access="hasAnyRole('RM', 'SV')">
		let html = "<div class=\"row\"><div class=\"sixteen wide column ui form\"><div class=\"fields\">" +
					"<div class=\"center aligned one wide field\"><input type=\"file\" accept=\"image/*\" " +
					"onchange=\"uploadReplyFile(this)\" hidden><i class=\"large camera link icon\" " +
					"onclick=\"this.previousElementSibling.click();\"></i></div><div class=\"fourteen wide field\">" +
					"<textarea rows=\"5\"></textarea>";
		if (replyBlindFlag === 0) {
			html += "<div class=\"ui checkbox\"><input type=\"checkbox\" id=\"blindFlag\">";
		} else {
			html += "<div class=\"ui disabled checkbox\"><input type=\"checkbox\" id=\"blindFlag\" checked disabled>";
		}
		html += "<label for=\"blindFlag\">コメントを非公開にする（本人、ポスト作成者、返信対象のコメント作成者は読めます）" +
				"</label></div><button class=\"ui right floated basic primary button\" onclick=\"writeNewReply(" +
				targetReplyId + ");\">登録</button><button class=\"ui right floated basic button\" " +
				"onclick=\"closeReplyBox(this);\">キャンセル</button></div></div></div></div>";
		if (targetReplyId === null) {
			const writeReply = document.getElementById("writeReply");
			writeReply.innerHTML = html;
			const option = {
				behavior: "smooth"
			};
			writeReply.scrollIntoView(option);
		} else {
			const replyList = document.querySelectorAll("article.ui.grid.row");
			for (let i = replyList.length - 1; i > -1; --i) {
				if (Number(replyList[i].dataset.id) === targetReplyId) {
					replyList[i].insertAdjacentHTML("afterend", html);
					break;
				}
			}
			button.setAttribute("onclick", "closeReplyBox(this)");
		}
	</sec:authorize>
	}

	function closeReplyBox(element) {
		if (element.tagName === "BUTTON") {
			element.closest("div.row").remove();
			document.getElementById("writeReply").innerHTML =
				"<button class=\"ui massive fluid basic button\" onclick=\"openReplyBox(this, null, 0);\">" +
				"<i class=\"camera icon\"></i><span>コメントを書き込む</span></button>";
		} else {
			const article = element.closest("article");
			article.nextElementSibling.remove();
			const func = "openReplyBox(this, " + article.dataset.id + ", " + article.dataset.blind + ");";
			if (element.tagName === "I") {
				element.setAttribute("onclick", func);
			} else {
				element.setAttribute("onclick", "restoreMenuItem(this);" + func);
				restoreMenuItem(element);
			}
		}
	}

	async function uploadReplyFile(input) {
		const file = input.files[0];
		const fileSizeLimit = 10485760;
		if (file.size > fileSizeLimit) {
			alert("10MB以上のファイルはアップロードできません");
			input.value = "";
			return;
		}

		const fileHash = await getFileHash(file);
		const url = new URL(location.origin + "${pageContext.request.contextPath}/image");
		url.search = "fileHash=" + fileHash;
		let replyFileUrl = await fetch(url.toString(), {
			method: "GET"
		}).then(function (response) {
			if (response.ok) {
				return response.text();
			}
			throw response.status;
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
		if (!replyFileUrl) {
			const formData = new FormData();
			formData.append("file", file);
			url.search = "";
			replyFileUrl = await fetch(url.toString(), {
				method: "POST",
				body: formData
			}).then(function (response) {
				if (response.ok) {
					return response.text();
				}
				throw response.status;
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
			});
		}

		const html = "<img class=\"ui image\" src=\"" + replyFileUrl + "\">";
		const textarea = document.querySelector("#writeReply textarea");
		if (textarea.previousElementSibling !== null) {
			textarea.previousElementSibling.remove();
		}
		textarea.insertAdjacentHTML("beforebegin", html);
		textarea.dataset.url = replyFileUrl;
	}

	function findTargetReply(targetReplyId) {
		const replyList = document.querySelectorAll("#reply article");
		for (let i = 0, length = replyList.length; i < length; ++i) {
			if (targetReplyId === Number(replyList[i].dataset.id)) {
				const option = {
					behavior: "smooth"
				};
				replyList[i].scrollIntoView(option);
				break;
			}
		}
	}

	function checkAuthForgetReplyList() {
	<sec:authorize access="isAnonymous()">
		alert("ログインしてください");
	</sec:authorize>
	<sec:authorize access="isAuthenticated()">
		fetch("${pageContext.request.contextPath}/reply?postId=${post.postId}", {
			method: "GET"
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			}
			throw response.status;
		}).then(function (result) {
			let html = "<h3 class=\"ui header\">コメント " + result.replyCount + "</h3><div id=\"writeReply\">" +
						"<button class=\"ui massive fluid basic button\" onclick=\"openReplyBox(this, null, 0);\">" +
						"<i class=\"camera icon\"></i><span>コメントを書き込む</span></button></div>" +
						"<div class=\"ui internally celled grid\">";
			for (const reply of result.replyList) {
				if (reply.depth) {
					html += "<article class=\"ui grid row\" data-id=\"" + reply.replyId + "\" data-blind=\"" +
							reply.replyBlindFlag + "\" style=\"padding-left: " + (reply.depth * 4) + "%; " +
							"background: whitesmoke;\"><div class=\"row\">";
				} else {
					html += "<article class=\"ui grid row\" data-id=\"" + reply.replyId + "\" data-blind=\"" +
							reply.replyBlindFlag + "\"><div class=\"row\">";
				}
				if (reply.targetNickname) {
					html += "<span class=\"targetNickname\" onclick=\"findTargetReply(" +
							reply.targetReplyId + ");\">" + reply.targetNickname + "</span>";
				}
				html += "<a href=\"${pageContext.request.contextPath}/company/" + reply.companyId + "\">" +
						reply.companyName + "</a><span>・" + reply.userNickname + "</span></div>" +
						"<div class=\"row\"><div class=\"sixteen wide column\">";
				if (reply.replyFileUrl) {
					html += "<img class=\"ui image\" src=\"" + reply.replyFileUrl +
							"\" onclick=\"enlargeImage(this.src);\">";
				}
				for (const replyLine of reply.replyContents) {
					html += "<p class=\"replyLine\">" + replyLine + "</p><br>";
				}
				html += "</div></div><div class=\"middle aligned row\"><div class=\"thirteen wide column\">" +
						"<i class=\"clock outline icon\"></i><span style=\"padding-right: 2%;\"> " +
						reply.recCreateDate + " </span><i class=\"thumbs up icon ";
				if (!reply.replyRecommended) {
					html += "outline ";
				}
				html += "link\" onclick=\"recommendReply(" + reply.replyId + ");\"></i>" +
						"<span style=\"padding-right: 2%;\"> " + reply.replyRecommendCount +
						" </span><i class=\"comment outline icon";
				if (reply.visible) {
					html += " link\" onclick=\"openReplyBox(this, " + reply.replyId + ", " + reply.replyBlindFlag +
							");\"></i><span> " + reply.nestedCount + " </span></div><div class=\"right floated right " +
							"aligned three wide column\"><div class=\"ui compact menu\"><div class=\"ui dropdown " +
							"item\"><i class=\"ellipsis horizontal icon\"></i><div class=\"left menu\"><div class=\"" +
							"item\" onclick=\"restoreMenuItem(this); openReplyBox(this, " + reply.replyId + ", " +
							reply.replyBlindFlag + ");\"><i class=\"reply icon\"></i><span>コメント作成</span></div>";
					if (reply.writer) {
						html += "<div class=\"item\" onclick=\"restoreMenuItem(this);\"><i class=\"edit outline " +
								"icon\"></i><span>コメント修正</span></div><div class=\"item\" onclick=\"" +
								"restoreMenuItem(this);\"><i class=\"trash alternate outline icon\"></i>" +
								"<span>コメント削除</span></div></div></div></div></div></div></article>";
					} else {
						html += "<div class=\"item\" onclick=\"restoreMenuItem(this);\"><i class=\"bullhorn icon\">" +
								"</i><span>通報する</span></div></div></div></div></div></div></article>";
					}
				} else {
					html += "\"></i><span> " + reply.nestedCount + " </span></div></div></article>";
				}
			}
			html += "<div class=\"row\"><button class=\"ui massive fluid basic button\"><i class=\"camera icon\"></i>" +
					"<span>コメントを書き込む</span></button><button class=\"ui massive fluid basic button\" " +
					"onclick=\"checkAuthForgetReplyList();\"><i class=\"sync icon\"></i></button></div></div>";
			document.getElementById("reply").innerHTML = html;
			document.querySelector("#post .eye.icon").nextElementSibling.innerText = result.postCount;
			document.querySelector("#post .thumbs.up.icon").nextElementSibling.innerText = result.postRecommendCount;
			document.querySelectorAll("#post .comment.outline.icon").forEach(function (icon) {
				icon.nextElementSibling.innerText = result.replyCount;
			});
			document.querySelector("#reply > h3").innerText = "コメント " + result.replyCount;
			document.querySelector("#reply .row:last-child > button").addEventListener("click", function () {
				const button = document.querySelector("#writeReply > button");
				if (button === null) {
					const option = {
						behavior: "smooth"
					};
					document.getElementById("writeReply").scrollIntoView(option);
				} else {
					button.click();
				}
			});
			$("#reply .ui.dropdown").dropdown();
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	</sec:authorize>
	}

	function test() {
		console.log(document.querySelector("#writeReply > .ui.massive.fluid.basic.button"));
	}
	function recommendReply(replyId) {
		console.log(replyId);
	}

	function writeNewReply(targetReplyId) {
		console.log(targetReplyId);
	}

	addEventListener("DOMContentLoaded", function () {
		const controlMenu = document.querySelectorAll(".left.menu > .item");
		controlMenu[0].addEventListener("click", function () {
			navigator.clipboard.writeText(location.href).then(function () {
				alert("アドレスをコピーしました。\n" + location.href);
			});
		});
	});
</script>
</body>
</html>