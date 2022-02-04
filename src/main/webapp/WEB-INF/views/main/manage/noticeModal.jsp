<%@ page contentType="text/html; charset=UTF-8" %>
<div class="ui modal" id="postModal">
	<div class="header">
		<div class="ui grid middle aligned">
			<div class="two wide column left aligned">
				<i class="close link icon" id="closePostModal"></i>
			</div>
			<div class="twelve wide column center aligned">公知事項作成</div>
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
					<div class="default text">公知事項のタイプを選んでください。</div>
					<div class="menu"></div>
				</div>
			</div>

			<div class="field">
				<input type="text" placeholder="公知事項のタイトルを入力してください。" id="postModalTitle">
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

<script src="resources/js/editor/editor.js"></script>
<script src="resources/js/editor/underline.js"></script>
<script src="resources/js/editor/marker.js"></script>
<script src="resources/js/editor/simple-image.js"></script>
<script>
	let editor;
	let totalFileSize;

	async function deleteFile(postFileId) {
		return await fetch("image", {
			method: "DELETE",
			headers: {
				"Content-Type": "application/json"
			},
			body: postFileId
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			}
			throw response.status;
		});
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

	async function getFileHash(file) {
		return await file.arrayBuffer().then(function (arrayBuffer) {
			const byteArray = new Int8Array(arrayBuffer);
			return crypto.subtle.digest("SHA-256", byteArray);
		}).then(function (digest) {
			const hashArray = Array.from(new Uint8Array(digest));
			let fileHash = "";
			for (let j = 0, arrayLength = hashArray.length; j < arrayLength; ++j) {
				fileHash += hashArray[j].toString(16).padStart(2, "0");
			}
			return fileHash;
		});
	}

	addEventListener("DOMContentLoaded", function () {
		<%-- モーダル --%>
		const postModal = document.getElementById("postModal");
		$(postModal).modal({
			duration: 100,
			closable: false,
			autofocus: false
		});
		const postModalTopic = document.getElementById("postModalTopic");
		const postModalTitle = document.getElementById("postModalTitle");
		const postUploadFiles = document.getElementById("postUploadFiles");
		document.getElementById("openNoticeModal").addEventListener("click", function () {
			totalFileSize = 0;
			postModal.dataset.id = "0";
			$(postModal).modal("show");
			if (editor === undefined) {
				fetch("board", {
					method: "GET"
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					}
					throw response.status;
				}).then(function (topicList) {
					let topicOptionList = "";
					for (let i = 0, length = topicList.length; i < length; ++i) {
						topicOptionList += "<div class=\"item\" data-value=\"" + topicList[i].boardId + "\">" +
							topicList[i].boardTopicName + "</div>";
					}
					document.querySelector(".ui.selection.dropdown > .menu").innerHTML = topicOptionList;
					$(postModalTopic).closest("div").dropdown();
				}).catch(function (error) {
					alert("予期しないエラーが発生しました");
					$(postModal).modal("hide");
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
			} else {
				$(postModalTopic).closest("div").dropdown("restore defaults");
				postModalTitle.value = postUploadFiles.value = "";
				editor.blocks.clear();
				document.querySelectorAll("#postModal > .actions > span").forEach(function (span) {
					span.remove();
				});
				deleteFile(postModal.dataset.id).catch(function (error) {
					alert("予期しないエラーが発生しました");
					$(postModal).modal("hide");
					console.error(error);
				});
			}
		});
		document.getElementById("closePostModal").addEventListener("click", function () {
			$(postModal).modal("hide");
		});
		postModalTitle.addEventListener("input", function () {
			const title = this.value.trim();
			if (title.length > 200) {
				alert("タイトルは２００文字以内にしてください");
				this.value = title.substring(0, 200);
			}
		});
		addEventListener("keydown", function (event) {
			if (event.key === "Escape") {
				$(".ui.modal").modal("hide");
			}
		});

		<%-- ファイルアップロード --%>
		const fileSizeLimit = 10485760;
		const totalLimit = 104857600;
		const uploadingText = document.getElementById("uploadingText");
		postUploadFiles.previousElementSibling.addEventListener("click", function () {
			postUploadFiles.click();
		});
		postUploadFiles.addEventListener("change", async function () {
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
			if (totalFileSize + size > totalLimit) {
				alert("ファイルサイズの合計は100MB以下にしてください");
				this.value = "";
				return;
			}

			const postId = postModal.dataset.id;
			const searchParams = new URLSearchParams();
			searchParams.append("postId", postId);
			const type = "image";
			const config = SimpleImage;
			const needToFocus = false;
			uploadingText.className = "ui active dimmer";
			for (let i = 0; i < filesLength; ++i) {
				const file = this.files[i];
				const fileHash = await getFileHash(file);

				searchParams.set("fileHash", fileHash);
				searchParams.set("originName", file.name);

				let postFile = await fetch("image?" + searchParams.toString(), {
					method: "GET"
				}).then(function (response) {
					if (response.ok) {
						return response.text();
					}
					throw response.status;
				}).then(function (responseBody) {
					console.log(responseBody);
					if (responseBody) {
						return JSON.parse(responseBody);
					}
					return null;
				}).catch(function (error) {
					alert("予期しないエラーが発生しました");
					console.error(error);
					postUploadFiles.value = "";
					uploadingText.className = "ui disabled dimmer";
				});

				if (postFile === null) {
					const formData = new FormData();
					formData.append("postId", postId);
					formData.append("file", file);
					postFile = await fetch("image", {
						method: "POST",
						body: formData
					}).then(function (response) {
						if (response.ok) {
							return response.json();
						}
						throw response.status;
					}).catch(function (error) {
						alert("予期しないエラーが発生しました");
						console.error(error);
						postUploadFiles.value = "";
						uploadingText.className = "ui disabled dimmer";
					});
				}

				const data = {
					"url": postFile.postFileUrl,
					"caption": postFile.postFileId,
					"withBorder": false,
					"withBackground": false,
					"stretched": false
				};
				const index = editor.blocks.getBlocksCount();
				editor.blocks.insert(type, data, config, index, needToFocus);
				const html = "<span>" +  file.name + "<i class=\"window close outline link icon\" " +
							"onclick=\"cancelUpload(this);\" data-id=\"" + data.caption + "\"></i></span>";
				this.closest("div").insertAdjacentHTML("beforeend", html);
				totalFileSize += file.size;
			}
			this.value = "";
			uploadingText.className = "ui disabled dimmer";
		});

		document.getElementById("postSubmit").addEventListener("click", function () {
			if (!postModalTopic.value.length) {
				alert("トピックを選択してください");
				postModalTopic.closest("div").focus();
				return;
			}
			postModalTitle.value = postModalTitle.value.trim();
			if (!postModalTitle.value.length) {
				alert("タイトルを入力してください");
				postModalTitle.focus();
				return;
			}
			if (postModalTitle.value.length > 200) {
				alert("タイトルは２００文字以内にしてください");
				postModalTitle.focus();
				return;
			}
			editor.save().then(function (savedData) {
				if (!savedData.blocks.length) {
					alert("内容を入力してください");
					editor.focus();
					return;
				}
				if (postModal.dataset.id === "0") {
					if (confirm("ポストを作成しますか？")) {
						const blockList = savedData.blocks;
						for (let i = blockList.length - 1; i > -1; --i) {
							delete blockList[i].id;
						}
						uploadingText.firstElementChild.innerText = "ポストをアップロードしています";
						uploadingText.className = "ui active dimmer";
						fetch("post", {
							method: "POST",
							headers: {
								"Content-Type": "application/json"
							},
							body: JSON.stringify({
								postTitle: postModalTitle.value,
								boardId: postModalTopic.value,
								postBlindFlag: "0", <%-- 確認必要 --%>
								postContents: savedData.blocks
							})
						}).then(function (response) {
							if (response.ok) {
								return response.json();
							}
							throw response.status;
						}).then(function (postId) {
							location.href = "post/" + postId;
						}).catch(function (error) {
							uploadingText.className = "ui disabled dimmer";
							uploadingText.firstElementChild.innerText = "ファイルをアップロードしています";
							alert("予期しないエラーが発生しました");
							console.error(error);
						});
					}
				} else {
					if (confirm("ポストを修正しますか？")) {
						const blockList = savedData.blocks;
						for (let i = blockList.length - 1; i > -1; --i) {
							delete blockList[i].id;
						}
						uploadingText.firstElementChild.innerText = "ポストを修正しています";
						uploadingText.className = "ui active dimmer";
						fetch("post", {
							method: "PUT",
							headers: {
								"Content-Type": "application/json"
							},
							body: JSON.stringify({
								postId: postModal.dataset.id,
								postTitle: postModalTitle.value,
								boardId: postModalTopic.value,
								postBlindFlag: "0", <%-- 確認必要 --%>
								postContents: savedData.blocks
							})
						}).then(function (response) {
							if (!response.ok) {
								throw response.status;
							}
						}).then(function () {
							location.reload();
						}).catch(function (error) {
							uploadingText.className = "ui disabled dimmer";
							uploadingText.firstElementChild.innerText = "ファイルをアップロードしています";
							alert("予期しないエラーが発生しました");
							console.error(error);
						});
					}
				}
			});
		});
	});
</script>