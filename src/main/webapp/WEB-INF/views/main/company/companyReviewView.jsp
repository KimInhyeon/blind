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

	.link-icon { position: relative; display: inline-block; width: auto;
		font-size: 11px; font-weight: 200; color: #333; margin-right: 10px; padding-top: 50px; }
	.link-icon.twitter { background-image: url(resources/images/icon-twitter.png); background-repeat: no-repeat; }
	.link-icon.facebook { background-image: url(resources/images/icon-facebook.png); background-repeat: no-repeat; }



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
	<c:forEach var="company" items="${companyList}">
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
							<div class="column" data-position="bottom left">
								<div class="ui button" style="background: white;">申告</div>
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
							<i class="lock icon" style="position: absolute;z-index: 1;left:30%;font-size:80px;display: inline-block;"></i>
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

							<button style="position: absolute;z-index: 1;left:28%;font-size:20px;display: inline-block;">レビューを書く</button>

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
					<td>
					<c:if test="${not empty company.advantages}">
						<button data-id="${company.companyReviewId}" onclick="countUp(this);">
							<div style="display: flex;<c:if test="${company.recommended}"> color: red</c:if>">
								<i class="thumbs up outline icon"></i><span>いいね(${company.helpfulCount})</span>
							</div>
						</button>
					</c:if>
					</td>
					<td></td>
				<c:if test="${not company.recommended}">　<%-- おすすめしなかった時には表示しない理由は？ --%>
					<td style="float: right !important;">

						<div style="display: flex">
						<button class="circular ui icon button" class="link-icon copy" onclick="copy()" style="width:50px;"><i class="copy outline icon" onclick="copy()"></i></button>

						<a style="width:50px;" id=btnTwitter" class="link-icon twitter" href="javascript:shareTwitter();"></a>

						<a style="width:50px;" id="btnFacebook" class="link-icon facebook" href="javascript:shareFacebook('http://localhost:8282/blind/company/review/${companyId}');"></a>

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
					<a class="item"
					   href="javascript:getReviewListByPage(${navi.startPage - navi.pagination})">前へ</a>
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



	function shareFacebook(url) {

		window.open("http://www.facebook.com/sharer/sharer.php?u=" + url);
	}
	function shareTwitter() {
		var sendUrl = "http://localhost:8282/blind/company/review/" +${companyId}; // 전달할 URL
		window.open("https://twitter.com/intent/tweet?url=" + sendUrl);
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
		copyToClipboard('http://localhost:8282/blind/company/review/${companyMenu.companyId}');
	}

	addEventListener("DOMContentLoaded", function () {
		$('.button').popup({
			inline: true,
			hoverable: true
		});

		$('.ui.rating').rating('disable');
	});
</script>