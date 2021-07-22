<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>ニックネーム変更</title>
</head>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="row">
			<div class="sixteen wide column"><h3 class="ui header">ニックネーム変更</h3></div>
		</div>
		<div class="row ui form">
			<div class="six wide column field">
				<label>ニックネーム</label>
				<div class="ui transparent huge icon input disabled">
					<input type="text" value="${userNickname}" id="nickname" oninput="checkNickname(this)">
				</div>
			</div>
		</div>
		<div class="row">
			<div class="five wide column ui message" id="nicknameCheckMessage">ニックネームは3か月ごとに変更できます。</div>
			<div class="two wide column">
				<button class="ui positive button disabled" id="nicknameSubmit" onclick="nickChangeSubmit(this)">変更</button>
			</div>
		</div>
	</div>
</div>
<script>
	let possibleDate;

	function checkNickname(nickname) {
		const newNickname = nickname.value.trim();
		const nicknameSubmit = document.getElementById("nicknameSubmit");
		const nicknameCheckMessage = document.getElementById("nicknameCheckMessage");
		if (newNickname.toLowerCase() === "${userNickname}".toLowerCase()) {
			nicknameSubmit.className = "ui positive button disabled";
			nicknameCheckMessage.className = "five wide column ui negative message";
			nicknameCheckMessage.innerText = "同じニックネームです。";
		} else {
			const length = newNickname.length;
			if (length > 30) {
				alert("ニックネームは30文字以内にしてください。");
				nickname.value = newNickname.substring(0, 30);
			}　else if (length < 1) {
				nicknameSubmit.className = "ui positive button disabled";
				nicknameCheckMessage.className = "five wide column ui negative message";
				nicknameCheckMessage.innerText = "ニックネームを入力してください。";
			} else {
				fetch(location.pathname, {
					method: "POST",
					headers: {
						"Content-Type": "application/json"
					},
					body: newNickname
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					} else {
						throw response.status;
					}
				}).then(function (isDuplicated) {
					const nicknameCheckMessage = document.getElementById("nicknameCheckMessage");
					if (isDuplicated) {
						nicknameCheckMessage.className = "five wide column ui negative message";
						nicknameCheckMessage.innerText = "使えないニックネームです。";
						nicknameSubmit.className = "ui positive button disabled";
					} else {
						nicknameCheckMessage.className = "five wide column ui positive message";
						nicknameCheckMessage.innerText = "変更可能なニックネームです。";
						nicknameSubmit.className = "ui positive button";
					}
				}).catch(function (error) {
					console.error(error);
				});
			}
		}
	}

	function nickChangeSubmit(nicknameSubmit) {
		const nickname = document.getElementById("nickname");
		const newNickname = nickname.value.trim();
		if (confirm("ニックネームを'" + newNickname + "'に変更しますか？")) {
			fetch(location.pathname, {
				method: "PATCH",
				headers: {
					"Content-Type": "application/json"
				},
				body: newNickname
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				} else {
					throw response.status;
				}
			}).then(function (isChanged) {
				if (isChanged) {
					setPossibleDate(new Date());
					const nicknameCheckMessage = document.getElementById("nicknameCheckMessage");
					nickname.closest("div").className = "ui transparent huge icon input disabled";
					nicknameSubmit.className = "ui positive button disabled";
					nicknameCheckMessage.className = "five wide column ui message";
					nicknameCheckMessage.innerText = "ニックネームは3か月ごとに変更できます。";
					alert("ニックネームの変更に成功しました");
				} else {
					alert("ニックネームの変更に失敗しました。");
				}
			}).catch(function (error) {
				console.error(error);
			});
		}
	}

	function setPossibleDate(nicknameChangeDate) {
		const month = nicknameChangeDate.getMonth() + 4;
		if (nicknameChangeDate.getDate() > new Date(nicknameChangeDate.getFullYear(), month, 0).getDate()) {
			nicknameChangeDate.setDate(1);
			nicknameChangeDate.setMonth(month);
		} else {
			nicknameChangeDate.setMonth(month - 1);
		}
		possibleDate = nicknameChangeDate;
	}

	onload = function () {
		setPossibleDate(new Date(${nicknameChangeDate}));

		const nickname = document.getElementById("nickname");
		const inputDiv = nickname.closest("div");
		const nicknameCheckMessage = document.getElementById("nicknameCheckMessage");
		const nicknameSubmit = document.getElementById("nicknameSubmit");
		const resetNickname = function (inputDiv, nickname) {
			nicknameSubmit.className = "ui positive button disabled";
			inputDiv.className = "ui transparent huge icon input disabled";
			nickname.value = "${userNickname}";
			nicknameCheckMessage.className = "five wide column ui message";
			nicknameCheckMessage.innerText = "ニックネームは3か月ごとに変更できます。";
		};

		nickname.addEventListener("keyup", function (event) {
			const key = event.key;
			if (key === "Escape") {
				resetNickname(inputDiv, nickname);
				this.blur();
			} else if (key === "Enter") {
				const newNickname = nickname.value.trim();
				if (newNickname.length > 0 && newNickname !== "${userNickname}") {
					nickChangeSubmit(nicknameSubmit);
				}
			}
		});

		addEventListener("click", function (event) {
			if (new Date() > possibleDate) {
				const target = event.target;
				if (target === inputDiv) {
					const userNickname = nickname.value;
					inputDiv.className = "ui transparent huge icon input";
					nickname.focus();
					nickname.value = "";
					nickname.value = userNickname;
				} else if (target !== nickname && target !== nicknameSubmit) {
					resetNickname(inputDiv, nickname);
				}
			} else if (event.target === inputDiv) {
				nicknameCheckMessage.className = "five wide column ui negative message";
				nicknameCheckMessage.innerText = "ニックネームは3か月ごとに変更できます。";
			}
		});
	};
</script>
</body>
</html>