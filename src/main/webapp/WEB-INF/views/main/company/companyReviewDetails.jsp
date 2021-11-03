<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	<%--모든 div들은 공통적으로 아래의 간격으로 거리를 띄우도록 설정.--%>
	div {
		margin: 1.2%;
	}

	<%--드래그를 방지하는 CSS--%>
	div.stop-dragging {
		-ms-user-select: none;
		-moz-user-select: none;
		-webkit-user-select: none;
		user-select: none;
	}

	.star-ratings {
		color: #aaa9a9;
		position: relative;
		unicode-bidi: bidi-override;
		width: max-content;
		-webkit-text-fill-color: transparent; <%-- Will override color (regardless of order) --%>
		-webkit-text-stroke-width: 1.3px;
		-webkit-text-stroke-color: #2b2a29;
	}

	.star-ratings-fill {
		color: #fff58c;
		padding: 0;
		position: absolute;
		z-index: 1;
		display: flex;
		top: 0;
		left: 0;
		overflow: hidden;
		-webkit-text-fill-color: gold;
	}

	.star-ratings-base {
		z-index: 0;
		padding: 0;
	}

	.right.aligned.column div.ui.dropdown.item {
		background: none;
	}

</style>

<%@ include file="/WEB-INF/views/main/company/companyMenu.jsp" %>
<div class="u container">
	<%-- 기업리뷰 페이지 전체를 wrap 하는 div--%>
	<div style="margin: 3%;">
		<%-- 1.기업리뷰 1개 출력부분.--%>
		<div style="padding: 2%;">
			<%-- 1.1.기업리뷰1개-헤더부분. 별점/제목(한줄평)/작성자정보(닉네임,업종,작성일)/신고버튼 배치.--%>
			<%-- 추가옵션 버튼(신고하기 등) --%>
			<div style="float: right;">
				<div class="ui button" style="background: white; margin: 0;" data-position="bottom center">
					<i class="ellipsis horizontal icon" style="font-size: 1.2em;"></i></div>
				<div class="ui flowing popup top left transition hidden">
					<div class="column" data-position="bottom left">
						<div class="reportModalStart item"
							 onclick="reportModalStart(
									 '0008'
									 ,0
									 ,'${companyReviewLists[0].companyReviewId}'
									 ,0
									 ,'${companyReviewLists[0].userNickname}'
									 ,'${companyReviewLists[0].simpleComment}'
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
				</div>
			</div>
			<div style="padding: 0.5%;">
				<div style="padding: 1%; display: flex;">
					<%-- 헤더파트1.별점 정보& 신고버튼 배치--%>
					<div style="font-size: 1.6em;">
						${companyReviewLists[0].allPoint}
					</div>
					<div class="div_star" style="display: inline-block;">
						<div class="ui star rating" data-rating="${companyReviewLists[0].allPoint}" data-max-rating="5">
						</div>
					</div>

					<%-- 별점(별이미지로 표현) 다음으로 각 항목 볼수 있도록 하는 드롭다운.--%>
					<div>
						<div class="div_star">
							<div class="ui button" style="background: white; margin: 0;" data-position="bottom center">
								<i class="angle down icon"></i>
							</div>
							<div class="ui flowing popup top left transition hidden">
								<div class="column" data-position="bottom left">
									<div class="div_star">
										<div class="ui star rating" data-rating="${companyReviewLists[0].careerPoint}"
											 data-max-rating="5" style="margin-right: 10px;">
										</div>
										<span style="margin-right: 10px;">キャリア向上</span>
									</div>
									<div class="div_star">
										<div class="ui star rating" data-max-rating="5" style="margin-right: 10px;"
											 data-rating="${companyReviewLists[0].workLifeBalancePoint}">
										</div>
										<span style="margin-right: 10px;">ワークライフバランス</span>
									</div>
									<div class="div_star">
										<div class="ui star rating"
											 data-rating="${companyReviewLists[0].companyCulturePoint}"
											 data-max-rating="5" style="float: left; margin-right: 10px;">
										</div>
										<span style="margin-right: 10px;">社内文化</span>
									</div>
									<div class="div_star">
										<div class="ui star rating" data-rating="${companyReviewLists[0].payPoint}"
											 data-max-rating="5" style="float: left; margin-right: 10px;">
										</div>
										<span style="margin-right: 10px;">給料と福祉</span>
									</div>
									<div class="div_star">
										<div class="ui star rating" data-rating="${companyReviewLists[0].headPoint}"
											 data-max-rating="5" style="float: left; margin-right: 10px;">
										</div>
										<span style="margin-right: 10px;">経営陣</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<%-- 1.2.기업리뷰1개-본문내용. --%>
				<%-- <div style="background-color: #573A08; padding: 0.5%;"> --%>
				<div style="padding: 0.5%;">
					<%-- 기업리뷰1개-본문-1.한줄평&작성자 정보 (구)헤더파트2.한줄평&작성자 정보--%>
					<div style="padding: 0.5%;">
						<%-- 기업리뷰의 제목(한줄평)--%>
						<span style="font-size: 2em; font-weight: bold;">${companyReviewLists[0].simpleComment}</span>

						<%-- 기업리뷰 작성자의 정보를 출력 --%>
						<div style="padding-top: 1.2%;">
							<span style="padding-right: 1.3%;"></span>  <%-- 리뷰 작성자의 현직원/전직원 여부 --%>
							<span style="padding-right: 1.3%;">${companyReviewLists[0].userNickname}</span>
							<%-- 리뷰 작성자의 닉네임--%>
							<span style="padding-right: 1.3%;"></span>  <%-- 리뷰 작성자의 직군 .--%>
							<span style="padding-right: 1.3%;">${companyReviewLists[0].recCreateDate}</span>
							<%-- 리뷰 작성일 --%>

						</div>
					</div>
					<%-- 기업리뷰1개-본문-2.기업 장점 출력--%>
					<div style="padding-top: 1.2%;">
						<span style="font-size: 1.5em; font-weight: bold;">長所</span>
						<div style="font-size: 1.3em;">${companyReviewLists[0].advantages}</div>
					</div>
					<%-- 기업리뷰1개-본문-2.기업 단점 출력--%>
					<div style="padding-top: 1.2%;">
						<span style="font-size: 1.2em; font-weight: bold;">短所</span>
						<div style="font-size: 1.3em;">${companyReviewLists[0].disadvantages}</div>
					</div>
				</div>

				<%-- 1.3.기업리뷰1개-푸터역할. 추천(도움이됩니다)버튼, 공유(트윗/페북/URL복사)기능--%>
				<%-- <div style="background-color: plum; padding-bottom : 10%;">--%>
				<div style="padding-bottom : 10%;">
					<div style="float: left;">
						<div class="ui primary button" onclick="helpfulSet('${companyReviewLists[0].companyReviewId}')">
							<i class="thumbs up icon"></i>
							役立ちます(${companyReviewLists[0].helpfulCount})
						</div>
					</div>

					<%-- share Link to twitter, facebook, URL copy --%>
					<div style="float: right;">
						<a id="btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();">
							<i class="twitter icon" style="font-size: 2.5em;"></i>
						</a>
						<a id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook();">
							<i class="facebook icon" style="font-size: 2.5em;"></i>
						</a>
						<button onclick="copy()">
							<i class="external alternate icon" style="font-size: 2.5em;"></i>
						</button>
					</div>
				</div>


			</div>
			<%--1.1개의 기업리뷰(샘플역할) div영역 종료 --%>

			<%-- 2.리뷰페이지로 리턴하는 버튼 --%>
			<div style="background-color: #3d698e; cursor: pointer; margin-top: 2.0%;
					margin-bottom: 2.0%; padding: 1.2%;">
				<%-- 클릭영역 넓히기 위해 패딩적용.--%>
				<i class="arrow left icon"></i>
				「${companyMenu.companyName}」のレビューをすべて見る
			</div>

			<%-- 3.이외기업리뷰글들 리스트형으로 출력.--%>
			<div>
				<div style="padding : 2%; border-color: #d4d4d5; border-width: thin !important;
						border-bottom-style: inset;">
				</div>

				<c:forEach var="reviews" items="${companyReviewLists}">
					<%-- 1.1.기업리뷰1개-헤더부분. 별점/제목(한줄평)/작성자정보(닉네임,업종,작성일)/신고버튼 배치.--%>
				<div style="padding: 0.5%;">
					<div style="padding: 1%; display: flex;">
							<%-- 헤더파트1.별점 정보& 신고버튼 배치--%>
						<div style="font-size: 1.6em;">${companyReviewLists[0].allPoint}</div>
						<div class="div_star" style="display: inline-block;">
							<div class="ui star rating" data-rating="${companyReviewLists[0].allPoint}"
								 data-max-rating="5">
							</div>
						</div>

							<%-- 별점(별이미지로 표현) 다음으로 각 항목 볼수 있도록 하는 드롭다운.--%>
						<div>
							<div class="div_star">
								<div class="ui button" style="background: white; margin: 0;"
									 data-position="bottom center">
									<i class="angle down icon"></i>
								</div>
								<div class="ui flowing popup top left transition hidden">
									<div class="column" data-position="bottom left">
										<div class="div_star">
											<div class="ui star rating" style="margin-right: 10px;" data-max-rating="5"
												 data-rating="${companyReviewLists[0].careerPoint}">
											</div>
											<span style="margin-right: 10px;">キャリア向上</span>
										</div>

										<div class="div_star">
											<div class="ui star rating" data-max-rating="5" style="margin-right: 10px;"
												 data-rating="${companyReviewLists[0].workLifeBalancePoint}">
											</div>
											<span style="margin-right: 10px;">ワークライフバランス</span>
										</div>

										<div class="div_star">
											<div class="ui star rating" data-max-rating="5"
												 style="float: left; margin-right: 10px;"
												 data-rating="${companyReviewLists[0].companyCulturePoint}">
											</div>
											<span style="margin-right: 10px;">社内文化</span>
										</div>

										<div class="div_star">
											<div class="ui star rating" style="float: left; margin-right: 10px;"
												 data-rating="${companyReviewLists[0].payPoint}" data-max-rating="5">
											</div>
											<span style="margin-right: 10px;">給料と福祉</span>
										</div>

										<div class="div_star">
											<div class="ui star rating" style="float: left; margin-right: 10px;"
												 data-rating="${companyReviewLists[0].headPoint}" data-max-rating="5">
											</div>
											<span style="margin-right: 10px;">経営陣</span>
										</div>
									</div>
								</div>
							</div>
						</div>

							<%-- 헤더파트2.한줄평&작성자 정보 / '(구)헤더파트2.한줄평&작성자 정보'가 업데이트되면 변경예정. --%>
						<div style="padding: 1.5%;">
							<span style="font-size: 1.3em;">${companyReviewLists[0].simpleComment}</span>
								<%-- 리뷰작성자 근무기업, 닉네임, 작성일자 등등...  --%>
								<%-- 리뷰작성자 근무기업은 미기재/리뷰작성자의 근무기업이름 갖고오도록 sql 갱신할 것.--%>
							<div>${companyReviewLists[0].userNickname}</div>
							<div>${companyReviewLists[0].recCreateDate}</div>
						</div>
					</div>

						<%-- 1.2.기업리뷰1개-본문내용. --%>
					<div style="background-color : #555555; padding-top: 5%; padding-bottom: 5%;">
							<%--원래 부모역할(위로 먼저나옴. 리뷰작성을 독려하는 멘트 및 버튼 배치)--%>
						<div style="position: relative;"> <%-- new 부모--%>
								<%--자식역할(기업리뷰내용. 블러등으로 내용 못보게 처리.) --%>
							<div class="stop-dragging"
								 style="position: absolute; -webkit-filter: blur(3px); padding: 0.5%;">
									<%-- -webkit-filter : css 블러(글씨흐림)효과 --%>
									<%-- 블러가 적용되는 구간(시작) --%>
								<div>
									<span style="font-size: 1.2em;">長所</span>
									<div>${companyReviewLists[0].advantages}</div>
								</div>
								<div>
									<span style="font-size: 1.2em;">短所</span>
									<div>${companyReviewLists[0].disadvantages}</div>
								</div>
									<%-- 블러가 적용되는 구간(종료) --%>
							</div>

							<div style="position: relative;">
								<div style="text-align: center;">
									<i class="lock icon" style="color: #ffffff; font-size: 5em;"></i>
								</div>
								<div style="text-align: center; color: #ffffff; font-weight: bold; font-size: 1.5em;">
									企業のレビューを書いたら、すべてのレビューを読むことができます！
								</div>
								<div style="text-align: center;">
									<button class="ui primary button" style="margin-top: 3%; padding: 2%;">
										企業のレビューを書く
									</button>
								</div>
							</div>
						</div>
					</div>


						<%-- 1.3.기업리뷰1개-푸터역할. 추천(도움이됩니다)버튼, 공유(트윗/페북/URL복사)기능--%>

				</div>
			</div>
			<div style="padding: 2%; border-color: #d4d4d5; border-width: thin !important;
					border-bottom-style: inset;">
			</div>
			</c:forEach>
		</div>


		<div style="background-color: gray;">
			<%-- jstl의 foreach문을 통하여 계속 출력하도록 설정예정. --%>

			<%--
			<p>블러효과&드래그방지 적용</p>
			<div class='stop-dragging'
				 style="-webkit-filter: blur(3px);      /*-webkit-filter : css 블러(글씨흐림)효과 */
						 background-color: #c86f11;">
				블러효과 테스트
			</div>
			--%>

			<%-- 예제2-블러 및 드래그방지까지적용. 주석을 쓸 수 없어 id에 주석사항을 기재.id내용 참고바람.--%>
			<%--
			<div id="부모역할">
				 <div id="새 부모역할" style="position: relative;">
					 <div id="자식역할(기업리뷰내용. 블러등으로 내용 못보게 처리.)"
						  class="stop-dragging"
						  style="position: absolute;
						 -webkit-filter: blur(3px);">
						 [!]기업리뷰내용(밑에 깔리고 블러로 가려질 글)
					 </div>

					<div style="position: relative;">
						<div style="text-align: center;">
							<i class="lock icon"></i>
						</div>
						<div style="text-align: center;">
							企業のレビューを書いたら、すべてのレビューを読むことができます！
						</div>
						<div style="text-align: center;">
							<button class="ui primary button">
								企業のレビューを書く
							</button>
						</div>
					</div>
				</div>
			</div>
			--%>
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
			 style="padding: 2%; background-color:#ffffff;">
			<div class="warp_report_modal">
				<div class="inf_title">
					<h2 style="display:inline;">通報する</h2>
					<div style="float:right;" id="modal_close_btn"> X </div>

					<div style="text-align:left; margin-top: 5%;">
						<span>作成者</span>
						<span id="targetUserNickname"><%-- 通報するポストのニックネームが入力される。--%></span>
					</div>

					<div style="text-align:left; margin-top: 5%;">
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

		function shareFacebook() {
			var sendUrl = "https://devpad.tistory.com/53"; // 전달할 URL
			window.open("http://www.facebook.com/sharer/sharer.php?u=" + sendUrl);
		}

		function shareTwitter() {
			var sendUrl = "devpad.tistory.com/"; // 전달할 URL
			window.open("https://twitter.com/intent/tweet?text=" + sendText + "&url=" + sendUrl);
		}

		function restoreMenuItem(item) {
			setTimeout(function () {
				item.className = "item";
			}, 0);
		}

		<%--役立ちます(도움이 되었습니다/기업리뷰추천수)를 카운트 및 출력하는 기능.--%>
		function helpfulSet(companyReviewId) {
			fetch("company/review/recommend", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: companyReviewId
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				}
				throw response.status;
			}).then(function (responseBody) {
				<%--responseBody.helpfulCount === ユーザーの行為を反映したhelpfulCountの最新情報--%>

				if (responseBody.helpful === 1) { <%--1:DB 추가완료
				alert('「役立ちます」登録完了。');
				<%--$(bookmarkId).html("<a><i class='bookmark icon'></i></a>");--%>
				} else {
					alert('「役立ちます」解除完了。 ');
					<%--$(bookmarkId).html("<a><i class='bookmark outline icon'></i></a>");--%>
				}
			}).catch(function (error) {
				console.error(error);
				alert("システムエラーです。");
			});
		}

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

					//2.신고할 사항들의 리스트
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

		$(function () {
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

				//テストコード（send_reportをクリックして送信するでーたを確認。）
				//alert("send_reportType : " + reportType);
				//alert("send_postId : " + postId);
				//alert("send_currentCompanyReviewId : " + companyReviewId);
				//alert("send_replyId : " + replyId);

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
	</script>