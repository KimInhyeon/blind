<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.box1 {
		padding: 10px 15px 10px 16px;
		width: 200px;
	}

	#title1 {
		padding: 20px 0 10px 0;
		margin-bottom: 28px;
	}

	.div_star {
		padding-bottom: 20px;
	}

	.field0 {
		font-size: 15px;
		font-weight: 700;
		padding-top: 5px;
	}

	.field {
		font-size: 15px;
	}
</style>

<div class="ui fluid container" style="background-color: #f6f7fa;">
	<div class="ui container" style="padding: 50px 0;">
		<div class="ui segment">
			<div style="padding: 40px;">
				<form class="ui form" id="reviewForm" name="reviewForm" method="post" action="company/review"
						onsubmit="return check();">
					<div>
						<h2 id="title1" style="padding-bottom: 30px;">企業レビューを作成</h2>
						<img class="ui tiny left floated image" Id="companyReviewImg" width="90" height="90"
								src="resources/images/company/
								<c:choose>
									<c:when test="${empty companyId}">0</c:when>
									<c:otherwise>${companyId}</c:otherwise>
								</c:choose>.png">
						<h4>会社名</h4>
						<div class="ui fluid input">
						<input type="hidden" id="hdnCompanyFlag" value="
							<c:choose>
								<c:when test="${empty companyId}">-1</c:when>
								<c:otherwise>1</c:otherwise>
							</c:choose>">
							<input type="hidden" name="companyId" id="companyId"
								<c:if test="${not empty companyId}">
									   value="${companyId}"
								</c:if>>
							<input type="text" class="box1" placeholder="会社名前で検索してください" id="companyName"
								<c:if test="${not empty companyName}">
									value="${companyName}"
								</c:if>>
							<div id="selectList" style="position: absolute; top: 50px;
									left: 5px; width: 100%; border-radius: 50px;">
							</div>
						</div>

						<h4 class="ui dividing header" style="padding-top: 30px;"></h4>

						<h3 style="font-size: 22px; padding: 10px 0;">会社評価</h3>
						<div style="padding-left: 40px;">
							<div class="field0" style="float: left; width: 120px;"><label>キャリア向上</label></div>
							<div class="div_star">
								<input type="hidden" name="careerPoint">
								<div class="ui massive star rating" data-rating="0" data-max-rating="5" id="stars1">
								</div>
							</div>

							<div class="field0" style="float: left; width: 120px;"><label>ワークバランス</label></div>
							<div class="div_star">
								<input type="hidden" name="workLifeBalancePoint">
								<div class="ui massive star rating" data-rating="0" data-max-rating="5" id="stars2">
								</div>
							</div>

							<div class="field0" style="float: left; width: 120px;"><label>給料と福祉</label></div>
							<div class="div_star">
								<input type="hidden" name="payPoint">
								<div class="ui massive star rating" data-rating="0" data-max-rating="5" id="stars3">
								</div>
							</div>

							<div class="field0" style="float: left; width: 120px;"><label>社内文化</label></div>
							<div class="div_star">
								<input type="hidden" name="companyCulturePoint">
								<div class="ui massive star rating" data-rating="0" data-max-rating="5" id="stars4">
								</div>
							</div>

							<div class="field0" style="float: left; width: 120px;"><label>経営陣</label></div>
							<div class="div_star">
								<input type="hidden" name="headPoint">
								<div class="ui massive star rating" data-rating="0" data-max-rating="5" id="stars5">
								</div>
							</div>
						</div>

						<h4 class="ui dividing header" style="margin-top: 50px;"></h4>

						<h3 style="padding: 15px 0; font-size: 20px;">レビューを作成する</h3>
						<div class="field">
							<label>簡単なコメント</label>
							<input type="text" class="box1" placeholder="例:ワークバランスをよく守る部署" maxlength="60"
									id="oneWriteReview" name="simpleComment">
						</div>
						<div class="field">
							<label>長所</label>
							<textarea cols="10" rows="5" placeholder="この会社に働きながら一番良かったのは何でしょうか"
									id="strongPoint" name="advantages" style="resize: none;"></textarea>
						</div>
						<div class="field"><label>短所</label>
							<textarea cols="10" rows="5" placeholder="この会社に働きながら一番大変だったのは何でしょうか"
									id="weakPoint" name="disadvantages" style="resize: none;"></textarea>
						</div>
						<div class="field"><label>転職理由</label>
							<textarea cols="10" rows="5" placeholder="この会社止めるきっかけは 何でしょうか?"
									id="resignReason" name="resignReason" style="resize:none;"></textarea>
						</div>
						<h4 class="ui dividing header" style="margin-top: 50px;"></h4>
						<h3 style="font-size: 20px; padding: 10px 0;">作成者の情報</h3>

						<div class="field">
							<label>認証状態</label>
							<div class="field">
								<input type="text" readonly placeholder="前社員">
							</div>
						</div>

						<div class="two fields">
							<div class="field">
								<label>勤務開始日</label>
								<select id="startDate" class="ui fluid dropdown" name="workStartDate">
									<option>選んでください</option>
									<option value="2021">2021</option>
									<option value="2020">2020</option>
									<option value="2019">2019</option>
									<option value="2018">2018</option>
									<option value="2017">2017</option>
									<option value="2016">2016</option>
									<option value="2015">2015</option>
									<option value="2014">2014</option>
									<option value="2013">2013</option>
									<option value="2012">2012</option>
									<option value="2011">2011</option>
									<option value="2010">2010</option>
									<option value="2009">2009</option>
									<option value="2008">2008</option>
									<option value="2007">2007</option>
									<option value="2006">2006</option>
									<option value="2005">2005</option>
									<option value="2004">2004</option>
									<option value="2003">2003</option>
									<option value="2002">2002</option>
									<option value="2001">2001</option>
									<option value="2000">2000</option>
									<option value="1999">1999</option>
									<option value="1998">1998</option>
									<option value="1997">1997</option>
									<option value="1996">1996</option>
									<option value="1995">1995</option>
									<option value="1994">1994</option>
								</select>
							</div>
							<div class="field">
								<label>勤務終業日</label>
								<select id="finishDate" class="ui fluid dropdown" name="workEndDate">
									<option>選んでください</option>
									<option value="2021">2021</option>
									<option value="2020">2020</option>
								</select>
							</div>
						</div>

						<div class="field">
							<label>勤務先</label>
							<div class="field">
								<input type="text" name="workArea" id="workArea" placeholder="例: 東京">
							</div>
						</div>

						<h4 class="ui dividing header" style="margin-top: 50px;"></h4>
						<button class="ui primary button" type="submit" style="padding: 15px 80px; margin-top: 30px;">
							提出
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script>
	addEventListener("DOMContentLoaded", function () {
		document.querySelectorAll(".ui.massive.star.rating").forEach(function (star) {
			star.addEventListener("click", function () {
				const icons = this.children;
				setTimeout(function () {
					let count = 0;
					for (let i = icons.length - 1; i > -1; --i) {
						if (icons[i].className === "icon active") {
							++count;
						}
					}
					star.previousElementSibling.value = count;
				}, 0);
			});
		});

		$('.ui.rating').rating();

		$("#companyName").on('keyup', function () {
			$('#hdnCompanyFlag').val("-1");
			var companyName = $("#companyName").val();

			$.ajax({
				type: "GET",
				url: "company/search?companyName=" + companyName,
				success: function (result) {
					var resultHtml = "";

					$('#selectList').html("");

					if (companyName != "") {
						$.each(result, function (key, value) {
							console.log(key);
							console.log(value.companyName);
							resultHtml += '<div class="item" style="background-color:white; display:flex; ' +
											'border-radius:50px;" onclick="companyNameClick(\'' + value.companyId +
											'★' + value.companyName + '\')"><img class="ui left floated image" ' +
											'style="margin:10px;" src="resources/images/company/' + value.companyId +
											'.png" width="70" height="70"><div class="content"><div class="header" ' +
											'style="padding-top: 25px;">' + value.companyName + '</div><div style="' +
											'padding-top: 5px;"><i class="star icon" style="color: yellow;"></i>' +
											value.companyName + '</div></div></div>';
							$('#selectList').attr(
								"style", "position:absolute; top:50px; width:100%; box-shadow: 0px 0px 15px #999999;"
							);

						});
						$('#selectList').append(resultHtml);
					} else {
						document.getElementById("companyReviewImg").src = "resources/images/company/0.png";
					}
				},
				error: function () {
					alert("에러");
				}
			});
		});
	});

	function companyNameClick(companyInfo) {
		var companyArr = companyInfo.split('★'); <%--리턴형이 어레이 배열형--%>

		var imgPath = "resources/images/company/" + companyArr[0] + ".png";
		$("#companyReviewImg").attr("src", imgPath);

		$('#companyName').val(companyArr[1]);
		$('#selectList').html("");
		$('#selectList').attr("style", "border: 0px;")
		$('#hdnCompanyFlag').val(1);
		$('#hdnCompanyId').val(companyArr[0]);

		document.getElementById("companyId").value = companyArr[0];
	}

	function check() {
		var companyFlag = $('#hdnCompanyFlag').val();
		if (companyFlag == -1 || companyFlag == "") {
			alert("会社名を入力してください");
			return false;
		}

		if ($("#hdnCareerPoint").val() == -1) {
			alert("キャリア向上の点数を入力してください");
			return false;
		}

		if ($("#hdnWorkLifeBalancePoint").val() == -1) {
			alert("ワークライフバランスの点数を入力してください");
			return false;
		}

		if ($("#hdnPayPoint").val() == -1) {
			alert("給料と福祉の点数を入力してください");
			return false;
		}

		if ($("#hdnCompanyCulturePoint").val() == -1) {
			alert("社内文化の点数を入力してください");
			return false;
		}

		if ($("#hdnHeadPoint").val() == -1) {
			alert("経営陣の点数を入力してください");
			return false;
		}

		var oneWriteReview = document.getElementById("oneWriteReview");
		if (!oneWriteReview.value.trim()) {
			alert("簡単なコメントを入力してください");
			return false;
		}
		if (oneWriteReview.value.trim().length > 60) {
			alert("簡単なコメントは６０文字以内にしてください");
			return false;
		}
		oneWriteReview.value = oneWriteReview.value.trim();

		var strongPoint = document.getElementById("strongPoint");
		if (strongPoint.value.trim().length == 0) {
			alert("長所は１６０文字以内にしてください");
			return false;
		}
		strongPoint.value = strongPoint.value.trim();

		var weakPoint = document.getElementById("weakPoint");
		if (!weakPoint.value.trim()) {
			alert("短所を入力してください");
			return false;
		}
		if (weakPoint.value.trim().length > 400) {
			alert("短所は４００文字以内にてください");
			return false;
		}
		weakPoint.value = weakPoint.value.trim();

		var resignReason = document.getElementById("resignReason");
		if (!resignReason.value.trim()) {
			alert("転職理由を入力してください");
			return false;
		}
		if (resignReason.value.trim().length > 100) {
			alert("転職理由は１００文字以内にてください");
			return false;
		}
		resignReason.value = resignReason.value.trim();

		if ($("#hdnStartDate").val() == -1) {
			alert("勤務開始日をチェックしてください");
			return false;
		}

		if ($("#hdnFinishDate").val() == -1) {
			alert("終業日をチェックしてください");
			return false;
		}

		var workArea = document.getElementById("workArea");
		if (workArea.value.trim().length == 0) {
			alert("勤務先を入力してください");
			return false;
		}
		if (workArea.value.trim().length > 50) {
			alert("勤務先は１００文字以内にてください");
			return false;
		}
		workArea.value = workArea.value.trim();

		return true;
	}
</script>