<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
<%--
	<title>KSINFOSYS_BLIND PROTOTYPE</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/swiper-bundle.css"/>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/swiper-bundle.js"></script>
--%>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/dist/semantic.min.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/swiper-bundle.min.css"/>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/dist/semantic.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/swiper-bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/messageId.js"></script>
	<script>
		$(function () {
			$('.ui.dropdown.item').dropdown();

			$('.message .close').on('click', function () {
				$(this).closest('.message').transition('fade');
			});

			$('.clickMenu').click(function () {
				$(this).children('a').get(0).click();
			});
		});
	</script>
	<style>
		.ce-block__content, .ce-toolbar__content {
			max-width: 97%;
		}

		.cdx-input.cdx-simple-image__caption {
			display: none;
		}
	</style>
</head>
<body>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1")) {
		response.setHeader("Cache-Control", "no-cache");
	}
%>
<div class="ui stackable menu" style="font-weight: bold; font-size: 1.4em; line-height: 1.0em; margin-top:-5px;">
	<div class="item" style="width: 200px; height: 75px;">
		<a href="${pageContext.request.contextPath}/main">
			<img src="${pageContext.request.contextPath}/resources/images/logo.png" style="margin-left:-25px;"/>
		</a>
	</div>
	<a class="browse item" style="color: black;"
		href="${pageContext.request.contextPath}/searchBoardName?searchKeyword=-1">トピック</a>
	<a class="browse item" style="color: black;"
		href="${pageContext.request.contextPath}/companyReviewMain">企業情報</a>
	<div class="right menu">
	<sec:authorize access="hasAnyRole(\"RM\",\"SV\")">
		<a class="item" id="openPostModal">ポスト作成</a>
		<div class="ui modal" id="postModal">
			<div class="header">
				<div class="ui grid middle aligned">
					<div class="two wide column left aligned">
						<i class="close link icon" id="closePostModal"></i>
					</div>
					<div class="twelve wide column center aligned">ポスト作成</div>
					<div class="two wide column right aligned">
						<button class="ui positive button" id="postSubmit">登録</button>
					</div>
				</div>
			</div>
			<div class="scrolling content">
				<div class="ui big form">
					<div class="field">
						<div class="ui selection dropdown">
							<input type="hidden" id="postModalTopic">
							<i class="dropdown icon"></i>
							<div class="default text">トピックを選択してください</div>
							<div class="menu"></div>
						</div>
					</div>
					<div class="field">
						<input type="text" placeholder="タイトルを入力してください" id="postModalTitle">
					</div>
					<div class="ui divider"></div>
					<div id="postModalContents"></div>
				</div>
			</div>
			<div class="actions" style="text-align: left;">
				<i class="file image outline icon"></i>
				<button>ファイル選択</button>
				<input type="file" accept="image/*" id="postUploadFiles" multiple hidden>
			</div>
			<div class="ui disabled dimmer" id="uploadingText">
				<div class="ui indeterminate text loader">ファイルをアップロードしています</div>
			</div>
		</div>
		<script src="${pageContext.request.contextPath}/resources/js/editor/editor.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/editor/underline.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/editor/marker.js"></script>
		<script src="${pageContext.request.contextPath}/resources/js/editor/simple-image.js"></script>
		<script>
			let editor;

			async function deleteFile(postFileId) {
				let isDeleted = false;
				await fetch("${pageContext.request.contextPath}" + "/upload", {
					method: "DELETE",
					headers: {
						"Content-Type": "application/json"
					},
					body: JSON.stringify(postFileId)
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					} else {
						throw response.status;
					}
				}).then(function (result) {
					isDeleted = result > 0;
				})
				return isDeleted;
			}

			function cancelUpload(icon) {
				const fileName = icon.closest("span").innerText;
				if (confirm(fileName + "のアップロードをキャンセルしますか？")) {
					const postFileId = icon.dataset.id;
					deleteFile(postFileId).then(function (isDeleted) {
						if (isDeleted) {
							const caption = document.querySelectorAll(".cdx-input.cdx-simple-image__caption");
							for (let i = caption.length - 1; i > -1; --i) {
								if (caption[i].innerText === postFileId) {
									caption[i].closest("div.ce-block").remove();
									break;
								}
							}
							icon.closest("span").remove();
						} else {
							alert("ファイルの削除に失敗しました");
						}
					}).catch(function (error) {
						alert("予期しないエラーが発生しました");
						console.error(error);
					});
				}
			}

			addEventListener("DOMContentLoaded", function () {
				// モーダル
				fetch("${pageContext.request.contextPath}" + "/board", {
					method: "GET"
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					} else {
						throw response.status;
					}
				}).then(function (topicList) {
					let topicOptionList = "";
					for (let i = 0, length = topicList.length; i < length; ++i) {
						topicOptionList += "<div class=\"item\" data-value=\"" + topicList[i].boardId + "\">" +
							topicList[i].boardTopicName + "</div>";
					}
					document.querySelector(".ui.selection.dropdown > .menu").innerHTML = topicOptionList;
				}).catch(function (error) {
					alert("予期しないエラーが発生しました");
					console.error(error);
				});
				editor = new EditorJS({
					holder: "postModalContents",
					tools: {
						underline: Underline,
						marker: Marker,
						image: SimpleImage
					}
				});
				const postModal = document.getElementById("postModal");
				$(postModal).modal({
					duration: 100,
					closable: false,
					autofocus: false
				});
				const postModalTopic = document.getElementById("postModalTopic");
				const postModalTitle = document.getElementById("postModalTitle");
				const postUploadFiles = document.getElementById("postUploadFiles");
				document.getElementById("openPostModal").addEventListener("click", function () {
					$(postModalTopic).closest("div").dropdown("restore defaults");
					postModalTitle.value = postUploadFiles.value = "";
					postModal.dataset.id = "0";
					editor.isReady.then(function () {
						editor.blocks.clear();
					});
					document.querySelectorAll("#postModal > .actions > span").forEach(function (span) {
						span.remove();
					});
					$(postModal).modal("show");
					deleteFile(postModal.dataset.id).catch(function (error) {
						alert("予期しないエラーが発生しました");
						$(postModal).modal("hide");
						console.error(error);
					});
				});
				document.getElementById("closePostModal").addEventListener("click", function () {
					$(postModal).modal("hide");
				});
				addEventListener("keydown", function (event) {
					if (event.key === "Escape") {
						$(".ui.modal").modal("hide");
					}
				});

				// ファイルアップロード
				const fileSizeLimit = 10485760;
				const totalLimit = 104857600;
				let totalFileSize = 0;
				const uploadingText = document.getElementById("uploadingText");
				postUploadFiles.previousElementSibling.addEventListener("click", function () {
					postUploadFiles.click();
				});
				postUploadFiles.addEventListener("change", function () {
					let size = 0;
					const filesLength = this.files.length;
					for (let i = 0; i < filesLength; ++i) {
						if (this.files[i].size > fileSizeLimit) {
							alert("10MB以上のファイルはアップロードできません");
							this.value = "";
							return;
						}
						size += this.files[i].size;
					}
					totalFileSize += size;
					if (totalFileSize > totalLimit) {
						alert("ファイルサイズの合計は100MB以下にしてください");
						this.value = "";
						totalFileSize -= size;
						return;
					}

					uploadingText.className = "ui active dimmer";
					const formData = new FormData();
					formData.append("postId", postModal.dataset.id);
					for (let i = 0; i < filesLength; ++i) {
						formData.append("files", this.files[i]);
					}
					fetch("${pageContext.request.contextPath}" + "/upload", {
						method: "POST",
						body: formData
					}).then(function (response) {
						if (response.ok) {
							return response.json();
						} else {
							throw response.status;
						}
					}).then(function (postFileList) {
						for (let i = 0; i < filesLength; ++i) {
							const type = "image";
							const data = {
								"url" : postFileList[i].postFileUrl,
								"caption" : postFileList[i].postFileId,
								"withBorder" : false,
								"withBackground" : false,
								"stretched" : false
							};
							const config = SimpleImage;
							const index = editor.blocks.getBlocksCount();
							const needToFocus = false;
							editor.blocks.insert(type, data, config, index, needToFocus);
							const span = document.createElement("span");
							span.innerHTML = postUploadFiles.files[i].name + "<i class=\"window close outline " +
								"link icon\" onclick=\"cancelUpload(this)\" data-id=\"" + data.caption + "\"></i>";
							postUploadFiles.closest("div").appendChild(span);
						}
					}).catch(function (error) {
						alert("予期しないエラーが発生しました");
						console.error(error);
					}).finally(function () {
						postUploadFiles.value = "";
						uploadingText.className = "ui disabled dimmer";
					});
				});

				document.getElementById("postSubmit").addEventListener("click", function () {
					if (postModalTopic.value.length < 1) {
						alert("トピックを選択してください");
						postModalTopic.closest("div").focus();
						return;
					}
					postModalTitle.value = postModalTitle.value.trim();
					if (postModalTitle.value.length < 1) {
						alert("タイトルを入力してください");
						postModalTitle.focus();
						return;
					}
					editor.save().then(function (savedData) {
						if (savedData.blocks.length < 1) {
							alert("内容を入力してください");
							editor.focus();
							return;
						}
						if (confirm("ポストを作成しますか？")) {
							uploadingText.className = "ui active dimmer";
							const blockList = savedData.blocks;
							for (let i = blockList.length - 1; i > -1; --i) {
								delete blockList[i].id;
							}
							fetch("${pageContext.request.contextPath}" + "/post", {
								method: "POST",
								headers: {
									"Content-Type": "application/json"
								},
								body: JSON.stringify({
									title: postModalTitle.value,
									boardId: postModalTopic.value,
									blindFlag: "0", // 確認必要
									contents: savedData.blocks
								})
							}).then(function (response) {
								if (response.ok) {
									return response.json();
								} else {
									throw response.status;
								}
							}).then(function (postId) {
								location.href = "${pageContext.request.contextPath}" + "/topicDetail?postId=" + postId;
							}).catch(function (error) {

							});
						}
					});
				});
			});
		</script>
	</sec:authorize>
		<div class="ui dropdown item">TestMenu<i class="dropdown icon"></i>
			<div class="menu">
			<sec:authorize access="isAnonymous()">
				<a class="item" href="${pageContext.request.contextPath}/login">ログインSample</a><br>
				<a class="item" href="${pageContext.request.contextPath}/registMember">会員登録Sample</a>
			</sec:authorize>
			<sec:authorize access="isAuthenticated()">
				<a class="item" href="${pageContext.request.contextPath}/logout">ログアウト</a>
				<div class="ui divider"></div>
				<a class="item" href="${pageContext.request.contextPath}/bookmark">ブックマーク</a><br>
				<a class="item" href="${pageContext.request.contextPath}/mytopic">私のトピック</a><br>
				<a class="item" href="${pageContext.request.contextPath}/mytask">進行中のタスク</a><br>
				<a class="item" href="${pageContext.request.contextPath}/directory">ディレクトリ</a><br>
				<a class="item" href="${pageContext.request.contextPath}/member/nick-change">ニックネーム変更</a>
			</sec:authorize>
			<sec:authorize access="hasRole(\"SV\")">
				<div class="ui divider"></div>
				<a class="item" href="${pageContext.request.contextPath}/manage/company">管理者(企業管理)</a><br>
				<a class="item" href="${pageContext.request.contextPath}/manage/board">管理者(トピック管理)</a><br>
				<a class="item" href="${pageContext.request.contextPath}/manage/report">管理者(通報管理)</a><br>
				<a class="item" href="${pageContext.request.contextPath}/manage/review">管理者(レビュー管理)</a>
			</sec:authorize>
			</div>
		</div>
	</div>
	<!-- Message Area -->
	<c:if test="${not empty exception.message}">
		<div class="ui negative message" style="width: 350px!important; font-size: 0.6em !important;
				position:absolute; top: 4%; left: 50%; transform: translateY(-50%) translateX(-50%);
				-webkit-transform: translateY(-50%) translateX(-50%); z-index:999;">
			<i class="close icon"></i>
			<div class="header">${exception.message}</div>
		</div>
	</c:if>
	<c:if test="${not empty exceptionMessage}">
		<div class="ui negative message" style="width: 350px!important;font-size: 0.6em !important;
				position:absolute; top: 4%; left: 50%; transform: translateY(-50%) translateX(-50%);
				-webkit-transform: translateY(-50%) translateX(-50%); z-index:999;">
			<i class="close icon"></i>
			<div class="header">${exceptionMessage}</div>
		</div>
	</c:if>
	<c:if test="${not empty successMessage}">
		<div class="ui success message" style="width: 350px!important;font-size: 0.8em !important;
				position:absolute; top: 4%; left: 50%; transform: translateY(-50%) translateX(-50%);
				-webkit-transform: translateY(-50%) translateX(-50%); z-index:999;">
			<i class="close icon"></i>
			<div class="header">${successMessage}</div>
		</div>
	</c:if>
</div>
</body>
</html>