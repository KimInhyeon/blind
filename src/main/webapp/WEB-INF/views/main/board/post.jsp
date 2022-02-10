<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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

	#reply p {
		display: inline;
	}

	#reply img {
		max-height: 30em;
	}

	#imageModal {
		max-height: 100%;
		overflow-y: auto;
	}
</style>

<div class="ui grid container">
	<section class="eleven wide column">
		<section id="post">
			<article class="row">
				<div class="row">
					<a class="ui small header" href="search?boardId=0">トピック</a>
					<i class="angle right icon"></i>
					<a class="ui small header" href="search?boardId=${post.boardId}">${post.boardTopicName}</a>
				</div>
				<div class="row">
					<h2 class="ui header"><c:out value="${post.postTitle}" escapeXml="true" /></h2>
				</div>
				<div class="row">
				<c:if test="${not empty post.companyName}">
					<a href="company/introduction/${post.companyId}" target="_blank">${post.companyName}</a>
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
						<i class="bookmark <sec:authorize access="isAuthenticated()">link </sec:authorize>icon
							<c:choose>
								<c:when test="${post.bookmarked}">red</c:when>
								<c:otherwise>outline</c:otherwise>
							</c:choose>">
						</i>
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
												<div class="reportModalStart item" onclick="restoreMenuItem(this);">
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
								src="${postBlock.data.url}" onclick="enlargeImage(this.src);">
					</c:otherwise>
				</c:choose>
			</c:forEach>
			</article>
			<article class="row" style="padding-top: 2em;">
				<i class="thumbs up<c:if test="${not post.postRecommended}"> outline</c:if>
						<sec:authorize access="hasAnyRole('SV', 'RM')">link </sec:authorize>icon"></i>
				<span class="data">${post.postRecommendCount}</span>
				<i class="comment outline <sec:authorize access="hasAnyRole('SV', 'RM')">link </sec:authorize>icon"></i>
				<span>${post.replyCount}</span>
			</article>
		</section>
		<div class="ui section divider"></div>
		<section id="reply">
			<h3 class="ui header">コメント ${post.replyCount}</h3>
			<div id="writeReply">
				<button class="ui massive fluid basic button" onclick="openReplyBox(this, null, 0);">
					<i class="camera icon"></i><span>コメントを書き込む</span>
				</button>
			</div>
			<div class="ui internally celled grid">
			<c:forEach var="reply" items="${replyList}">
				<article class="ui grid row" data-id="${reply.replyId}" data-blind="${reply.replyBlindFlag}"
				<c:if test="${reply.depth gt 0}">
					style="padding-left: ${reply.depth * 4}%; background: whitesmoke;"
				</c:if>>
					<div class="row">
					<c:if test="${not empty reply.targetNickname}">
						<span class="targetNickname" onclick="findTargetReply(${reply.targetReplyId});">
							${reply.targetNickname}
						</span>
					</c:if>
						<a href="company/${reply.companyId}">${reply.companyName}</a>
						<span>・${reply.userNickname}</span>
					</div>
					<div class="row">
						<div class="sixteen wide column">
						<c:if test="${not empty reply.replyFileUrl}">
							<img class="ui image" src="${reply.replyFileUrl}" onclick="enlargeImage(this.src);">
						</c:if>
						<c:forEach var="replyLine" items="${reply.replyContents}">
							<p class="replyLine"><c:out value="${replyLine}" escapeXml="true" /></p><br>
						</c:forEach>
						</div>
					</div>
					<div class="middle aligned row">
						<div class="thirteen wide column">
							<i class="clock outline icon"></i>
							<span style="padding-right: 2%;">${reply.recCreateDate}</span>
							<i class="thumbs up icon<c:if test="${not reply.replyRecommended}"> outline</c:if>
								<sec:authorize access="isAuthenticated()">
									link" onclick="recommendReply(this);" data-id="${reply.replyId}
								</sec:authorize>"></i>
							<span style="padding-right: 2%;">${reply.replyRecommendCount}</span>
							<i class="comment outline icon
								<c:if test="${reply.visible}">
									<sec:authorize access="hasAnyRole('RM', 'SV')">
										link" onclick="openReplyBox(this, ${reply.replyId}, ${reply.replyBlindFlag});
									</sec:authorize>
								</c:if>"></i>
							<span>${reply.nestedCount}</span>
						</div>
					<c:if test="${reply.visible}">
						<sec:authorize access="isAuthenticated()">
							<div class="right floated right aligned three wide column">
								<div class="ui compact menu">
									<div class="ui dropdown item">
										<i class="ellipsis horizontal icon"></i>
										<div class="left menu">
										<sec:authorize access="hasAnyRole('RM', 'SV')">
											<div class="item" onclick="restoreMenuItem(this);
													openReplyBox(this, ${reply.replyId}, ${reply.replyBlindFlag});">
												<i class="reply icon"></i>
												<span>コメント作成</span>
											</div>
										</sec:authorize>
										<c:choose>
											<c:when test="${reply.writer}">
												<div class="item" onclick="restoreMenuItem(this); editReply(this);">
													<i class="edit outline icon"></i>
													<span>コメント修正</span>
												</div>
												<div class="item" onclick="restoreMenuItem(this); deleteReply(this);">
													<i class="trash alternate outline icon"></i>
													<span>コメント削除</span>
												</div>
											</c:when>
											<c:otherwise>
												<div class="item" onclick="restoreMenuItem(this);">
													<i class="bullhorn icon"></i>
													<span>通報する</span>
												</div>
											</c:otherwise>
										</c:choose>
										</div>
									</div>
								</div>
							</div>
						</sec:authorize>
					</c:if>
					</div>
				</article>
			</c:forEach>
			<c:choose>
				<c:when test="${post.replyCount gt 10}">
					<div class="row">
						<button class="ui massive fluid basic button" onclick="getNewReplyList();">
							<span style="padding-right: 1%;">さらに${post.replyCount - 10}個のコメントを読む</span>
							<i class="sync icon"></i>
						</button>
					</div>
				</c:when>
				<c:otherwise>

				</c:otherwise>
			</c:choose>
			</div>
		</section>
	</section>
	<section class="five wide column"></section>
</div>
<div class="ui large modal" id="imageModal">
	<i class="window close outline icon"></i>
	<div class="image content">
		<img class="ui fluid image" onclick="$('#imageModal').modal('hide');">
	</div>
</div>


<%-- javascriptの'send_report'メソッドを通して送信するデータ（通報するポスト）を臨時セーブ。--%>
<input type="hidden" value="" id="currentReportType"/>
<input type="hidden" value="" id="currentPostId"/>
<input type="hidden" value="" id="currentCompanyReviewId"/>
<input type="hidden" value="" id="currentReplyId"/>

<div style="display: none">
	<%--「通報する」のモーダルウィンドウ。--%>
	<div id="report_modal" data-backdrop="static" data-keyboard="false"
			style="padding: 2%; background-color: #ffffff;">
		<div class="warp_report_modal">
			<div class="inf_title">
				<h2 style="display: inline;">通報する</h2>
				<div style="float: right;" id="modal_close_btn"> X </div>

				<div style="text-align: left; margin-top: 5%;">
					<span>作成者</span>
					<span id="targetUserNickname"><%-- 通報するポストのニックネームが入力される。--%></span>
				</div>

				<div style="text-align: left; margin-top: 5%;">
					<span style="display: inline;">タイトル</span>
					<span id="reportTitle"><%-- 通報するポストのタイトルが入力される。--%></span>
				</div>
			</div>

			<div class="ui inverted divider"></div>

			<div id="report_reason_list">
				<%-- タイプに対応する通報リスト出力する。 --%>
			</div>

			<div id="report_reason_textarea">
				<%-- textarea를 로드 --%>
			</div>

			<button class="ui primary button" id="send_report"
					style="width: 100%; height: 50px; text-align: center; margin-top: 20px;">
				通報する
			</button>
		</div>
	</div>
</div>

<script>
	<%--1.通報するモーダルウィンドウをポップアップする。--%>
	function reportModalStart(reportType, postId, companyReviewId, replyId, targetUserNickname, targetTitle) {
		<%--신고하기 전에 hidden에 미리 정보를 저장. send_report 함수를 실행때 사용할 수 있도록 저장.--%>
		document.getElementById("currentReportType").value = reportType;
		document.getElementById("currentPostId").value = postId;
		document.getElementById("currentCompanyReviewId").value = companyReviewId;
		document.getElementById("currentReplyId").value = replyId;

		<%--DB에서 신고유형(포스트/기업리뷰/댓글)에 따라 신고할 목록을 로드.--%>
		$.ajax({
			type: "POST",
			url: "report/list",
			data: {reportType},
			dataType: "json",
			success: function (result) {
				<%--1.신고할 포스트의 제목과 작성자 닉네임을 로드 및 모달창에 삽입.--%>
				var selectedReportType = $('#currentReportType').val();

				if (selectedReportType == "0006") {
					document.getElementById("reportTitle").innerHTML =  targetTitle;
					document.getElementById("targetUserNickname").innerHTML = targetUserNickname;
				} else if (selectedReportType == "0008") {
					document.getElementById("reportTitle").innerHTML =  targetTitle;
					document.getElementById("targetUserNickname").innerHTML = targetUserNickname;
				} else if (selectedReportType == "0012") {
					document.getElementById("reportTitle").innerHTML =  targetTitle;
					document.getElementById("targetUserNickname").innerHTML = targetUserNickname;
				}

				<%--2.신고할 사항들의 리스트--%>
				$(report_reason_list).html(""); <%--신고목록(라디오버튼)을 출력할 부분 초기화--%>
				$(report_reason_textarea).html(""); <%--기타입력시 부분 초기화.--%>

				<%--신고목록(라디오버튼)배치--%>
				$.each(result, function (key, value) {
					$(report_reason_list).append(
						"<div style=\"text-align: left; margin-bottom: 5%;\"><input type=\"radio\" onclick=\"textOnOff();\" " +
						"name=\"report_post_reason\" id=\"" + value.reportReasonCode + "\" value=" +
						value.reportReasonCode + ">" + value.reportReasonContents + "</div>"
					);
				});

				<%--textarea 배치--%>
				$(report_reason_textarea).append(
					"<textarea id=\"report_reason_content\" " +
                    <%--"onKeyup=\"checkInputTextByte('その他',document.getElementById('report_reason_content').value ,5)\" "+　--%>
					"style=\"width: 100%; height: 150px; resize: none;\" disabled></textarea>"
				);

				$('#report_modal').modal({closable: false}); <%--모달밖을 클릭해도 닫히지 않도록 설정.--%>
				$('#report_modal').modal('show');
			},
			error: function () {
				alert("システムのエラーです。管理者にお問い合わせください。");
			}
		});
	}

<sec:authorize access="isAuthenticated()">
	function setReplyReportEvent() {
		document.querySelectorAll("#reply i.bullhorn.icon").forEach(function (icon) {
			icon.closest("div").addEventListener("click", function () {
				const article = this.closest("article.row");
				const replyId = Number(article.dataset.id);
				const userNickname = article.firstElementChild.lastElementChild.innerText.substring(1);
				reportModalStart("0012", 0, 0, replyId, userNickname, 0);
			});
		})
	}
</sec:authorize>

    <%--ユーザーが入力したテキストのbyteをチェック。maxsize以上ならストップ。 --%>
    function checkInputTextByte(typeName,inputText,maxSize) {
        if(inputText.length>maxSize) {
            alert(typeName+"の入力は"+maxSize+"字まで入力できます。");
            return false;
        }
        else{
            return true;
        }
    }

	$(function () {
	<sec:authorize access="isAuthenticated()">
		<c:if test="${not post.writer}">
			document.querySelector("#post i.bullhorn.icon").closest("div").addEventListener("click", function () {
				<%-- 通報のタイプ。0006はポストを意味。-->
				<%-- 通報するポストのid。--%>
				<%-- replyId。ここではするポストの通報ので’０’を入力して動作しないに設定する。--%>
				<%-- companyReviewId。ここではするポストの通報ので’０’を入力して動作しないに設定する。--%>
				<%-- 通報するポストを作成したユーザのニックネーム。--%>
				<%-- 通報するポストのタイトル。--%>
				reportModalStart("0006", ${post.postId}, 0, 0, "${post.userNickname}", "<c:out value="${post.postTitle}" escapeXml="true" />");
			});
		</c:if>
		setReplyReportEvent();
	</sec:authorize>

		<%--2.신고를 하는 코드--%>
		$("#send_report").on("click", function () {
			<%--신고정보들을 집계.--%>
			<%--2.1.신고사유 및 유형--%>
			var reportType = $('#currentReportType').val();
			var reportReasonCode = $('input[name=report_post_reason]:checked').val(); <%--유저가 라디오 버튼에서 선택한 신고사유.--%>

			<%--2.2.신고대상ID(0이 입력된 경우는 없음과 같음.)--%>
			var postId = $('#currentPostId').val();
			var companyReviewId = $('#currentCompanyReviewId').val();
			var replyId = $('#currentReplyId').val();

            <%--2.3. その他を選んだ時、確認するため使う情報。--%>
            var reportReasonContent = $('#report_reason_content').val();

			<%--テストコード（send_reportをクリックして送信するでーたを確認。）--%>
			<%--alert("send_reportType : " + reportType);--%>
			<%--alert("send_postId : " + postId);--%>
			<%--alert("send_currentCompanyReviewId : " + companyReviewId);--%>
			<%--alert("send_replyId : " + replyId);--%>
			<%--alert("reportReasonContent : " + reportReasonContent);--%>
            if (typeof reportReasonCode == "undefined" || reportReasonCode == "" || reportReasonCode == null) {
                alert("通報する理由を選んでください。"); <%--선택된 신고사항이 없기에 선택을 요청--%>
                return false;
			}
			if (reportReasonCode == 20 &&  reportReasonContent == "") {
				alert("その他の理由をテキストに入力してください。"); <%--선택된 신고사항이 없기에 선택을 요청--%>
				return false;
			}
            if (reportReasonCode ==20 && !(checkInputTextByte('その他',reportReasonContent ,200)) ) {
				<%--入力が400byteが最大。そして200字に制限（１字＝2byte）。--%>
                <%--案内文（alert）はcheckInputTextByteで出力。--%>
                return false;
            }
            else {
				$.ajax({
					type: "POST",
					url: "report",
					data: {
						postId
						, companyReviewId
						, replyId
						, reportReasonCode
						, reportType
						, report_reason_content: $("#report_reason_content").val()
					},
					dataType: "json",
					success: function (result) {
						if (result == 1) {
							alert("通報の受付を完了しました。");
							$('#report_modal').modal('hide');
						} else if (result == 0) {
							alert("システムのエラーです。管理者にお問い合わせください。");
						}
					},
					error: function () {
						alert("システムのエラーです。管理者にお問い合わせください。");
					}
				});
			}
		});

		$("#modal_close_btn").on("click", function () { <%--신고되면 모달창을 닫도록 함.--%>
			$('#report_modal').modal('hide');
		});

	});

	<%--report_reason_content(textarea)의 입력 활성화/비활성화 설정--%>
	function textOnOff() {
		var reportReasonCode = $('input[name=report_post_reason]:checked').val();
		if (reportReasonCode == 20) {
			<%--その外 선택시 textarea 활성화--%>
			$(report_reason_textarea).html(""); <%--초기화--%>
			$(report_reason_textarea).append(
				"<textarea id=\"report_reason_content\" style=\"width: 100%; height: 150px; resize: none;\"></textarea>"
			);
		} else {
			<%--その外가 아닌 다른 라디오버튼을 클릭시 textarea 비활성화--%>
			$(report_reason_textarea).html(""); <%--초기화--%>
			$(report_reason_textarea).append(
				"<textarea id=\"report_reason_content\" style=\"width: 100%; height: 150px; " +
				"resize: none;\" disabled></textarea>"
			);
		}
	}

	<%--신고하기 관련 AJAX 끝.--%>
</script>


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

	async function getNewReplyList() {
	<sec:authorize access="isAnonymous()">
		alert("ログインしてください");
	</sec:authorize>
	<sec:authorize access="hasRole('NM')">
		alert("権限がありません");
	</sec:authorize>
	<sec:authorize access="hasAnyRole('SV', 'RM')">
		await fetch("reply?postId=${post.postId}", {
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
				html += "<a href=\"company/" + reply.companyId + "\">" +
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
				html += "link\" onclick=\"recommendReply(this); data-id=\"" + reply.replyId + "\"></i>" +
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
						html += "<div class=\"item\" onclick=\"restoreMenuItem(this); editReply(this)\"><i class=\"" +
								"edit outline icon\"></i><span>コメント修正</span></div><div class=\"item\" onclick=\"" +
								"restoreMenuItem(this); deleteReply(this)\"><i class=\"trash alternate outline " +
								"icon\"></i><span>コメント削除</span></div></div></div></div></div></div></article>";
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
					"onclick=\"getNewReplyList();\"><i class=\"sync icon\"></i></button></div></div>";
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
			setReplyReportEvent();
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	</sec:authorize>
	}

	function openReplyBox(button, targetReplyId, replyBlindFlag) {
		<sec:authorize access="hasRole('NM')">
		alert("権限がありません");
		</sec:authorize>
		<sec:authorize access="hasAnyRole('RM', 'SV')">
		const replyBox = document.getElementById("replyBox");
		if (replyBox) {
			replyBox.remove();
		}
		let html = "<div class=\"row\" id=\"replyBox\"><div class=\"sixteen wide column ui form\">" +
					"<div class=\"fields\"><div class=\"center aligned one wide field\">" +
					"<input type=\"file\" accept=\"image/*\" onchange=\"uploadReplyFile(this)\" hidden>" +
					"<i class=\"large camera link icon\" onclick=\"this.previousElementSibling.click();\"></i></div>" +
					"<div class=\"fourteen wide field\"><textarea rows=\"5\"></textarea>";
		if (replyBlindFlag === 0) {
			html += "<div class=\"ui checkbox\"><input type=\"checkbox\" id=\"blindFlag\">";
		} else {
			html += "<div class=\"ui disabled checkbox\"><input type=\"checkbox\" id=\"blindFlag\" checked disabled>";
		}
		html += "<label for=\"blindFlag\">コメントを非公開にする（本人、ポスト作成者、返信対象のコメント作成者は読めます）</label>" +
				"</div><button class=\"ui right floated basic primary button\" onclick=\"writeNewReply(this, " +
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
		}
		document.querySelector("#replyBox textarea").addEventListener("input", checkReplyLength);
		</sec:authorize>
	}
<sec:authorize access="hasAnyRole('SV', 'RM')">
	function checkReplyLength() {
		const textarea = document.querySelector("#replyBox textarea");
		const replyContents = textarea.value.trim();
		if (replyContents.length > 400) {
			alert("コメントは４００文字以内にしてください");
			textarea.value = replyContents.substring(0, 400);
		}
	}

	function closeReplyBox(element) {
		element.closest("div.row").remove();
		document.getElementById("writeReply").innerHTML =
			"<button class=\"ui massive fluid basic button\" onclick=\"openReplyBox(this, null, 0);\">" +
			"<i class=\"camera icon\"></i><span>コメントを書き込む</span></button>";
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
		let replyFileUrl = await fetch("image?fileHash=" + fileHash, {
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
			replyFileUrl = await fetch("image", {
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

		const element = input.closest("div.fields").lastChild.firstChild;
		if (element.tagName === "IMG") {
			element.src = element.nextElementSibling.dataset.url = replyFileUrl;
		} else {
			const html = "<img class=\"ui image\" src=\"" + replyFileUrl + "\">";
			element.insertAdjacentHTML("beforebegin", html);
			element.dataset.url = replyFileUrl;
		}
	}

	function writeNewReply(button, targetReplyId) {
		const textarea = button.previousElementSibling.previousElementSibling;
		if (!textarea.value.trim() && !textarea.dataset.url) {
			alert("コメントを入力してください");
			return;
		}
		console.log(textarea.value.trim());
		fetch("reply", {
			method: "POST",
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify({
				postId: ${post.postId},
				targetReplyId: targetReplyId,
				replyFileUrl: textarea.dataset.url ? textarea.dataset.url : null,
				replyContents: textarea.value.trim(),
				replyBlindFlag: button.previousElementSibling.firstElementChild.checked ? "1" : "0"
			})
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			}
			throw response.status;
		}).then(function (replyId) {
			getNewReplyList().then(function () {
				const replyList = document.querySelectorAll("#reply article");
				for (let i = 0, length = replyList.length; i < length; ++i) {
					if (replyId === Number(replyList[i].dataset.id)) {
						replyList[i].scrollIntoView(true);
						break;
					}
				}
			});
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}

	function editReply(button) {
		const replyBox = document.getElementById("replyBox");
		if (replyBox) {
			replyBox.remove();
		}
		const article = button.closest("article.row");
		const reply = button.closest("div.row").previousElementSibling.firstElementChild.children;
		let replyFile = null;
		let i;
		if (reply[0].tagName === "IMG") {
			replyFile = {
				className: reply[0].className,
				src: reply[0].src
			};
			i = 1;
		} else {
			i = 0;
		}
		let replyContents = "";
		for (const length = reply.length; i < length; ++i) {
			replyContents += reply[i].tagName === "P" ? reply[i].innerText : "\n";
		}
		if (replyContents) {
			replyContents = replyContents.slice(0, replyContents.length - 1);
		}
		let html = "<div class=\"row\" id=\"replyBox\"><div class=\"sixteen wide column ui form\">" +
					"<div class=\"fields\"><div class=\"center aligned one wide field\">" +
					"<input type=\"file\" accept=\"image/*\" onchange=\"uploadReplyFile(this)\" hidden>" +
					"<i class=\"large camera link icon\" onclick=\"this.previousElementSibling.click();\"></i></div>" +
					"<div class=\"fourteen wide field\">";
		if (replyFile) {
			html += "<img class=\"" + replyFile.className + "\" src=\"" + replyFile.src + "\">";
		}
		html += "<textarea rows=\"5\">" + replyContents +
				"</textarea><div class=\"ui disabled checkbox\"><input type=\"checkbox\" id=\"blindFlag\" ";
		if (article.dataset.blind === "1") {
			html += "checked ";
		}
		html += "disabled><label for=\"blindFlag\">コメントの公開・非公開は変更できません</label></div>" +
				"<button class=\"ui right floated basic primary button\" onclick=\"updateReply(this, " +
				article.dataset.id + ");\">修正</button><button class=\"ui right floated basic button\" " +
				"onclick=\"closeReplyBox(this);\">キャンセル</button></div></div></div></div>";
		article.insertAdjacentHTML("afterend", html);
		document.querySelector("#replyBox textarea").addEventListener("input", checkReplyLength);
	}

	function updateReply(button, replyId) {
		const textarea = button.previousElementSibling.previousElementSibling;
		if (!textarea.value.trim() && !textarea.dataset.url) {
			alert("コメントを入力してください");
			return;
		}
		fetch("reply", {
			method: "PUT",
			headers: {
				"Content-Type": "application/json"
			},
			body: JSON.stringify({
				replyId: replyId,
				replyFileUrl: textarea.dataset.url ? textarea.dataset.url : null,
				replyContents: textarea.value.trim(),
			})
		}).then(function (response) {
			if (!response.ok) {
				throw response.status;
			}
		}).then(function () {
			getNewReplyList().then(function () {
				const replyList = document.querySelectorAll("#reply article");
				for (let i = 0, length = replyList.length; i < length; ++i) {
					if (replyId === Number(replyList[i].dataset.id)) {
						replyList[i].scrollIntoView(true);
						break;
					}
				}
			});
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}

	function deleteReply(button) {
		if (confirm("コメントを削除しますか？")) {
			fetch("reply", {
				method: "DELETE",
				headers: {
					"Content-Type": "application/json"
				},
				body: button.closest("article.row").dataset.id
			}).then(function (response) {
				if (!response.ok) {
					throw response.status;
				}
			}).then(getNewReplyList).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
			});
		}
	}

	function recommendReply(recommendIcon) {
		fetch("reply/recommend", {
			method: "POST",
			headers: {
				"Content-Type": "application/json"
			},
			body: recommendIcon.dataset.id
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			}
			throw response.status;
		}).then(function (replyRecommendResult) {
			if (replyRecommendResult.recommended) {
				recommendIcon.className = "thumbs up link icon";
			} else {
				recommendIcon.className = "thumbs up outline link icon";
			}
			recommendIcon.nextElementSibling.innerText = replyRecommendResult.replyRecommendCount;
		}).catch(function (error) {
			alert("予期しないエラーが発生しました");
			console.error(error);
		});
	}
</sec:authorize>

	addEventListener("DOMContentLoaded", function () {
		const controlMenu = document.querySelectorAll(".left.menu > .item");
		controlMenu[0].addEventListener("click", function () {
			navigator.clipboard.writeText(location.href).then(function () {
				alert("アドレスをコピーしました。\n" + location.href);
			});
		});
	<sec:authorize access="hasAnyRole('SV', 'RM')">
		document.querySelector("#post i.comment.outline.link.icon").addEventListener("click", function () {
			document.querySelector('#writeReply > button').click();
		});
		const bookmarkIcon = document.querySelector("#post i.bookmark.link.icon");
		bookmarkIcon.addEventListener("click", function () {
			fetch("bookmark", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: ${post.postId}
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				}
				throw response.status;
			}).then(function (result) {
				bookmarkIcon.className = result ? "bookmark link icon red" : "bookmark link icon outline";
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
			});
		});
		const postRecommendIcon = document.querySelector("#post i.thumbs.up.link.icon");
		postRecommendIcon.addEventListener("click", function () {
			fetch("post/recommend", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: ${post.postId}
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				}
				throw response.status;
			}).then(function (responseBody) {
				if (responseBody.recommended) {
					postRecommendIcon.className = "thumbs up link icon";
				} else {
					postRecommendIcon.className = "thumbs up outline link icon";
				}
				postRecommendIcon.nextElementSibling.innerText = responseBody.postRecommendCount;
			}).catch(function (error) {
				alert("予期しないエラーが発生しました");
				console.error(error);
			});
		});
		<c:if test="${post.writer}">
			document.querySelector("#post .edit.icon").closest("div").addEventListener("click", async function () {
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
						$("#postModalTopic").closest("div").dropdown("set selected", "${post.boardId}");
					}).catch(function (error) {
						alert("予期しないエラーが発生しました");
						console.error(error);
					});
				} else {
					$("#postModalTopic").closest("div").dropdown("set selected", "${post.boardId}");
				}
				const postFileList = await fetch("image/${post.postId}", {
					method: "GET"
				}).then(function (response) {
					if (response.ok) {
						return response.json();
					}
					throw response.status;
				}).catch(function (error) {
					alert("予期しないエラーが発生しました");
					console.error(error);
				});
				document.getElementById("postModalContents").innerHTML = "";
				editor = new EditorJS({
					holder: "postModalContents",
					tools: {
						underline: Underline,
						marker: Marker,
						image: SimpleImage
					},
					data: {
						blocks: [
						<c:forEach var="postBlock" items="${post.postContents}">
							{
							<c:choose>
								<c:when test="${postBlock.type eq 'paragraph'}">
									type: "paragraph",
									data: {
										text: '${postBlock.data.text}'
									}
								</c:when>
								<c:otherwise>
									type: "image",
									data: {
										url: '${postBlock.data.url}',
										caption: '${postBlock.data.caption}',
										withBorder: ${postBlock.data.withBorder},
										withBackground: ${postBlock.data.withBackground},
										stretched: ${postBlock.data.stretched}
									}
								</c:otherwise>
							</c:choose>
							},
						</c:forEach>
						]
					}
				});
				const postUploadFiles = document.getElementById("postUploadFiles");
				postUploadFiles.value = "";
				document.querySelectorAll("#postModal > .actions > span").forEach(function (span) {
					span.remove();
				});
				let html = "";
				totalFileSize = 0;
				for (const postFile of postFileList) {
					html += "<span>" + postFile.postFileOriginName + "<i class=\"window close outline link icon\" " +
							"onclick=\"cancelUpload(this);\" data-id=\"" + postFile.postFileId + "\"></i></span>";
					totalFileSize += postFile.postFileSize;
				}
				postUploadFiles.insertAdjacentHTML("afterend", html);
				document.getElementById("postModal").dataset.id = "${post.postId}";
				document.getElementById("postModalTitle").value = "${post.postTitle}";
				$("#postModal").modal("show");
			});

			document.querySelector("#post .trash.icon").closest("div").addEventListener("click", function () {
				if (confirm("ポストを削除しますか？")) {
					fetch("post", {
						method: "DELETE",
						headers: {
							"Content-Type": "application/json"
						},
						body: ${post.postId}
					}).then(function (response) {
						if (!response.ok) {
							throw response.status;
						}
					}).then(function () {
						location.href = "";
					}).catch(function (error) {
						alert("予期しないエラーが発生しました");
						console.error(error);
					});
				}
			});
		</c:if>
	</sec:authorize>
	});
</script>