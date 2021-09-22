<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ja">
<head>
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
		href="${pageContext.request.contextPath}/board/0">トピック</a>
	<a class="browse item" style="color: black;"
		href="${pageContext.request.contextPath}/companyReviewMain">企業情報</a>
	<div class="right menu">
	<sec:authorize access="hasAnyRole('RM','SV')">
		<a class="item" id="openPostModal">ポスト作成</a>
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
			<sec:authorize access="hasRole('SV')">
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