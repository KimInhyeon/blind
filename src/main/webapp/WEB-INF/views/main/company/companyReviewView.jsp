<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.tabtable tr td {
		border: none;
		padding-top: 10px;

	}

	#writtenReview{
		color: transparent;
		text-shadow: 0 0 5px #000;
		transition: all 250ms ease-in;
		-ms-user-select: none;
		-moz-user-select: none;
		-webkit-user-select: none;
		user-select: none;
		z-index: 9;
	}
</style>

<%@ include file="/WEB-INF/views/main/company/companyMenu.jsp" %>
<div class="ui container">
	<div class="ui bottom attached active tab segment">
		<div style="width: 100%; border: 1px;">
			<table class="tabtable" border="1" style="width: 100%; margin: 15px auto; padding: 30px"><%--마진은되도록 쓰지말자  --%>
				<tr>
					<td>${companyMenu.companyName}レビュー</td>
				</tr>
				<tr>
					<td>${companyMenu.allPointAvg}</td>
					<td>
						<div class="div_star">
							<div class="ui star rating" data-rating="${allPointAvg}" data-max-rating="5"></div>
						</div>
					</td>
					<td>(${companyMenu.reviewCount}個のレビュー)</td>
					<td>項目別平均点数</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td>${reviewAverage.careerPoint}
						<div class="ui star rating" data-rating="1" data-max-rating="1" style="margin-right: 10px;">
						</div>
						キャリア向上
					</td>
					<td></td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td>${reviewAverage.workLifeBalancePoint}
						<div class="ui star rating" data-rating="1" data-max-rating="1" style="margin-right: 10px;">
						</div>
						ワークライフバランス
					</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td>${reviewAverage.companyCulturePoint}
						<div class="ui star rating" data-rating="1" data-max-rating="1" style="margin-right: 10px;">
						</div>
						社内文化
					</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td>${reviewAverage.payPoint}
						<div class="ui star rating" data-rating="1" data-max-rating="1" style="margin-right: 10px;">
						</div>
						給料と福祉
					</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td>${reviewAverage.headPoint}
						<div class="ui star rating" data-rating="1" data-max-rating="1" style="margin-right: 10px;">
						</div>
						経営陣
					</td>
				</tr>
			</table>
		</div>
	<c:forEach var="company" items="${companyList}" begin="0" step="1" varStatus="status">
		<div id="showCompanyList">
			<table class="tabtable" border="1" style="width: 100%; margin: 15px auto; padding: 30px">
					<%--마진은되도록 쓰지말자  --%>
				<tr>
					<td style="width: 20%;">${company.allPoint}</td>
					<td style="width: 65%;"><h4>"${company.simpleComment}"</h4></td>
					<td>${company.recCreateDate}</td>
					<td style="width: 5%;">
						<div class="ui button" style="background: white; margin: 0;" data-position="bottom center">
							<i class="ellipsis horizontal icon"></i>
						</div>
						<div class="ui flowing popup top left transition hidden">
							<div class="reportModalStart item"
									onclick="reportModalStart(
											'0008'
											,0
											,0
											,'${companyList[status.count].companyReviewId}'
											,'${companyList[status.count].userNickname}'
											,'${companyList[status.count].simpleComment}'
											)">
									<%-- 通報のタイプ。0008は企業レビューを意味。-->
									<%-- postid。ここではするポストの通報ので’０’を入力して動作しないに設定する。--%>
									<%-- replyId。ここではするポストの通報ので’０’を入力して動作しないに設定する。--%>
									<%-- companyReviewId。（通報する企業レビューのID）　--%>
									<%-- 通報するポストを作成したユーザのニックネーム。--%>
									<%-- 通報するポストのタイトル。--%>
								<i class="bullhorn icon"></i><span>通報する</span>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td>
						<div class="div_star">
							<div class="ui star rating" data-rating="${company.allPoint}" data-max-rating="5"></div>
							<div class="ui button" style="background: white; margin: 0;" data-position="bottom center">
								<i class="angle down icon"></i>
							</div>
							<div class="ui flowing popup top left transition hidden">
								<div class="column" data-position="bottom left">
									<div class="div_star">
										<div class="ui star rating" data-rating="${company.careerPoint}"
												data-max-rating="5" style="margin-right: 10px;">
										</div>
										<span style="margin-right: 10px;">キャリア向上</span>
									</div>
									<div class="div_star">
										<div class="ui star rating" data-rating="${company.workLifeBalancePoint}"
												data-max-rating="5" style="margin-right: 10px;">
										</div>
										<span style="margin-right: 10px;">ワークライフバランス</span>
									</div>
									<div class="div_star">
										<div class="ui star rating" data-rating="${company.companyCulturePoint}"
												data-max-rating="5" style="float: left; margin-right: 10px;">
										</div>
										<span style="margin-right:10px;">社内文化</span>
									</div>
									<div class="div_star">
										<div class="ui star rating" data-rating="${company.payPoint}"
												data-max-rating="5" style="float: left; margin-right: 10px;">
										</div>
										<span style="margin-right: 10px;">給料と福祉</span>
									</div>
									<div class="div_star">
										<div class="ui star rating" data-rating="${company.headPoint}"
												data-max-rating="5" style="float: left; margin-right: 10px;">
										</div>
										<span style="margin-right: 10px;">経営陣</span>
									</div>
								</div>
							</div>
						</div>
					</td>
					<td>
					<c:choose>
						<c:when test="${empty company.advantages}">
							<i style="position: absolute; z-index: 1; left: 30%; font-size: 80px; display: inline-block;"
									class="lock icon">
							</i>
							<div id="writtenReview"><h5>長所</h5></div>
						</c:when>
						<c:otherwise>
							<h5>長所</h5>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
					<c:choose>
						<c:when test="${empty company.advantages}">
							<div id="writtenReview">DDDDDDDDDDDDDDDDDDDDDDDDDDDD</div>
						</c:when>
						<c:otherwise>
							${company.advantages}
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td></td>
					<td style="align:center;">
					<c:choose>
						<c:when test="${empty company.advantages}">
							<div id="writtenReview"><h5>短所</h5></div>
							<button onclick="location.href=
								<c:choose>
									<c:when test="${companyId gt 0}">'company/review?companyId=${companyId}'</c:when>
									<c:otherwise>'member/login'</c:otherwise>
								</c:choose>"
									style="position: absolute; z-index: 1; left:28%; font-size:20px; display: inline-block;">
								レビューを書く
							</button>
						</c:when>
						<c:otherwise>
							<h5>短所</h5>
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
					<td></td>
					<td>
					<c:choose>
						<c:when test="${empty company.advantages}">
							<div id="writtenReview">DDDDDDDDDDDDDDDDDDDDDDDDDDDD</div>
						</c:when>
						<c:otherwise>
							${company.disadvantages}
						</c:otherwise>
					</c:choose>
					</td>
				</tr>
				<tr>
				<c:if test="${not empty company.advantages}">
					<td>
						<button data-id="${company.companyReviewId}" onclick="countUp(this);">
							<div style="display: flex;<c:if test="${company.recommended}"> color: red</c:if>">
								<i class="thumbs up outline icon"></i><span>いいね(${company.helpfulCount})</span>
							</div>
						</button>
					</td>
					<td></td>
					<td style="float: right !important;">
						<div style="display: flex">
							<button class="circular ui icon button link-icon copy" onclick="copy();">
								<i class="copy outline icon"></i>
							</button>
							<button class="ui circular facebook icon button" onclick="shareFacebook();">
								<i class="facebook icon"></i>
							</button>
							<button class="ui circular twitter icon button" onclick="shareTwitter();">
								<i class="twitter icon"></i>
							</button>
						</div>
					</td>
				</c:if>
				</tr>
			</table>
		</div>
	</c:forEach>
	</div>

	<div class="ui grid">
		<div class="center aligned column">
		<c:choose>
			<c:when test="${navi.startPage gt navi.pagination}">
				<div class="ui pagination menu">
					<a class="item" href="javascript:getReviewListByPage(${navi.startPage - navi.pagination})">前へ</a>
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
						<a class="item" href="javascript:getReviewListByPage(${page})">${page}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<c:choose>
			<c:when test="${navi.totalPage gt navi.endPage}">
				<div class="ui pagination menu">
					<a class="item" href="javascript:getReviewListByPage(${navi.endPage + 1})">次へ</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="ui pagination menu" style="visibility: hidden;"><a class="item">次へ</a></div>
			</c:otherwise>
		</c:choose>
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


</div>

<script>
	function getReviewListByPage(page) {
		const searchParams = new URLSearchParams(location.search);
		if (page > 1) {
			searchParams.set("page", page);
		} else {
			searchParams.delete("page");
		}
		location.search = searchParams.toString();
	}

	function shareFacebook() {
		window.open("http://www.facebook.com/sharer/sharer.php?u=" + location.href);
	}
	function shareTwitter() {
		window.open("https://twitter.com/intent/tweet?url=" + location.href);
	}

	function countUp(button) {
		fetch("company/review/recommend", {
			method: "POST",
			headers: {
				"Content-Type": "application/json"
			},
			body: button.dataset.id
		}).then(function (response) {
			if (response.ok) {
				return response.json();
			}
			throw response.status;
		}).then(function (responseBody) {
			let html = "<div style=\"display: flex;";
			if (responseBody.helpful) {
				html += " color: red";
			}
			html += "\"><i class=\"thumbs up outline icon\"></i>" +
					"<span>いいね(" + responseBody.helpfulCount + ")<span></div>";
			button.innerHTML = html;
		}).catch(function (error) {
			console.error(error);
		});
	}

	function copyToClipboard(val) {
		const t = document.createElement("textarea");
		document.body.appendChild(t);
		t.value = val;
		t.select();
		document.execCommand('copy');
		document.body.removeChild(t);
	}

	function copy() {
		copyToClipboard('company/review/${companyMenu.companyId}');
	}

	function restoreMenuItem(item) {
		setTimeout(function () {
			item.className = "item";
		}, 0);
	}
	function enlargeImage(src) {
		document.querySelector("#imageModal img").src = src;
		$("#imageModal").modal("show");
	}

	<%--1.通報するモーダルウィンドウをポップアップする。--%>
	<%--1.通報するモーダルウィンドウをポップアップする。--%>
	function reportModalStart(reportType, postId, companyReviewId, replyId, targetUserNickname, targetTitle) {
		<%--신고하기 전에 hidden에 미리 정보를 저장. send_report 함수를 실행때 사용할 수 있도록 저장.--%>
		document.getElementById("currentReportType").value = reportType;
		document.getElementById("currentPostId").value = postId;
		document.getElementById("currentCompanyReviewId").value = companyReviewId;
		document.getElementById("currentReplyId").value = replyId;

		<%--テストコード（hiddenに臨時セーブしたデータを確認。）--%>
		<%--alert("currentReportType : " + $('#currentReportType').val() );--%>
		<%--alert("send_postId : " + $('#currentPostId').val() );--%>
		<%--alert("send_currentCompanyReviewId : " + $('#currentCompanyReviewId').val() );--%>
		<%--alert("send_replyId : " + $('#currentReplyId').val() );--%>

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
							"<div style=\"text-align:left; margin-bottom: 5%;\"><input type=\"radio\" onclick=\"textOnOff();\" " +
							"name=\"report_post_reason\" id=\"" + value.reportReasonCode + "\" value=" +
							value.reportReasonCode + ">" + value.reportReasonContents + "</div>"
					);
				});

				<%--textarea 배치--%>
				$(report_reason_textarea).append(
						"<textarea id=\"report_reason_content\" " +
						"style=\"width:100%; height:150px; resize: none;\" disabled></textarea>"
				);

				$('#report_modal').modal({closable: false}); <%--모달밖을 클릭해도 닫히지 않도록 설정.--%>
				$('#report_modal').modal('show');
			},
			error: function () {
				alert("システムのエラーです。管理者にお問い合わせください。");
			}
		});
	}

	<%--report_reason_content(textarea)의 입력 활성화/비활성화 설정--%>
	function textOnOff() {
		var reportReasonCode = $('input[name=report_post_reason]:checked').val();
		if (reportReasonCode == 20) {
			<%--その外 선택시 textarea 활성화--%>
			$(report_reason_textarea).html(""); <%--초기화--%>
			$(report_reason_textarea).append(
					"<textarea id=\"report_reason_content\" style=\"width:100%; height:150px; resize: none;\"></textarea>"
			);
		} else {
			<%--その外가 아닌 다른 라디오버튼을 클릭시 textarea 비활성화--%>
			$(report_reason_textarea).html(""); <%--초기화--%>
			$(report_reason_textarea).append(
					"<textarea id=\"report_reason_content\" style=\"width:100%; height:150px; " +
					"resize: none;\" disabled></textarea>"
			);
		}
	}
	<%--신고하기 관련 AJAX 끝.--%>

	addEventListener("DOMContentLoaded", function () {
		$('.button').popup({
			inline: true,
			hoverable: true
		});

		$('.ui.rating').rating('disable');

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

			<%--テストコード（send_reportをクリックして送信するでーたを確認。）--%>
			<%--alert("send_reportType : " + reportType);--%>
			<%--alert("send_postId : " + postId);--%>
			<%--alert("send_currentCompanyReviewId : " + companyReviewId);--%>
			<%--alert("send_replyId : " + replyId);--%>

			if (typeof reportReasonCode == "undefined" || reportReasonCode == "" || reportReasonCode == null) {
				alert("通報する理由を選んでください。"); <%--선택된 신고사항이 없기에 선택을 요청--%>
			} else {
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
</script>