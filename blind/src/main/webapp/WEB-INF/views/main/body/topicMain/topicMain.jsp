<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="jp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KSINFOSYS BLIND</title>
<style>
body {
	padding: 2rem;
}

.tit {
	padding: 6px 0 8px;
	font-size: 150%;
	font-weight: 700;
}

.bookmarkcontent a {
	color: black;
	display: block;
	padding-bottom: 8px;
}

.bookmarkcontent a span {
	font-size: 80%;
}

.bookmarkcontent p {
	padding-top: 12px;
	font-size: 90%;
}
</style>
<!-- <style type="text/css">
body>.grid {
	height: 100%;
}

.image {
	margin-top: -100px;
}

.column {
	max-width: 1000px;
}

.view_btn {
	cursor: pointer;
}
</style> -->
<style>
/*토픽메뉴바*/
#menu {
	width: 2000px;
	height: 50px;
	overflow: auto;
	white-space: nowrap;
	margin-left: auto;
	margin-right: auto;
}

#menu ul li {
	list-style: none;
	color: gray;
	float: left;
	line-height: 30px;
	vertical-align: middle;
	text-align: center;
	display: inline;
}

#menu .menuLink {
	text-decoration: none;
	color: gray;
	display: inline-block;
	width: 100px;
	font-size: 13px;
	font-weight: normal;
	font-family: "Trebuchet MS", Dotum, Arial;
}
</style>
<style>
html, body {
	position: relative;
	height: 100%;
}

body {
	font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
	font-size: 14px;
	color: #000;
	margin: 0;
	padding: 0;
}

::-webkit-scrollbar {
	display: none;
}

.swiper-container {
	width: 100%;
	height: 100%;
	cursor: url('./resources/images/cursor.cur'), auto;
}

.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
	/* Center slide text vertically */
	display: -webkit-box;
	display: -ms-flexbox;
	display: -webkit-flex;
	display: flex;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	-webkit-justify-content: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	-webkit-align-items: center;
	align-items: center;
}
</style>
</head>
<body>
	<!-- <h2>KSINFOSYS BLIND PROJECT</h2> -->
	<!-- <div>${topicMainMessage[0].boardId}</div> -->
	<%-- 	<div class="ui middle aligned center aligned grid">
		<h2 class="ui teal image header">TOPIC MAIN</h2>
		<div class="ui large form"></div>
	</div>
	<table class="ui celled table">
		<thead>
			<tr>
				<th>#</th>
				<th>トピック名</th>
				<th>作成日</th>
				<th>更新日</th>
			</tr>
		</thead>
		<tbody id="list">
		</tbody>
		<c:forEach items="${topicMainMessage }" var="topicMainMessage">
			<tr>
				<td><c:out value="${topicMainMessage.boardOrder }" /></td>
				<td><c:out value="${topicMainMessage.boardTopicName }" /></td>
				<td><fmt:formatDate
						value="${topicMainMessage.boardCreateDate }"
						pattern="YYYY-MM-dd" /></td>
				<td><fmt:formatDate
						value="${topicMainMessage.boardUpdateDate }"
						pattern="YYYY-MM-dd" /></td>
			</tr>
		</c:forEach>
	</table> --%>

	<!-- 토픽메뉴바 -->
	<%-- 	<nav id="menu">
		<ul>
			<c:forEach items="${topicMainMessage }" var="topicMainMessage">
				<li><a class="menuLink"
					href="${topicMainMessage.boardTopicName }">${topicMainMessage.boardTopicName }</a></li>
			</c:forEach>
		</ul>
	</nav> --%>
	<!-- Swiper -->

	<div class="swiper-container">
		<div class="swiper-wrapper">
		    <c:set var="i" value="0" />
		    <c:forEach items="${topicMainMessage }" var="topicMainMessage" varStatus="status">
		    	<c:if test="${i%7==0}">
		    		<div class="swiper-slide">
		    		<i class="angle double left icon"></i>
		    	</c:if>
					<a href="javascript:location.href='${pageContext.request.contextPath}/searchBoardName?searchKeyword=${topicMainMessage.boardId}'">${topicMainMessage.boardTopicName}</a>&nbsp;&nbsp;&nbsp;
					<c:set var="i" value="${i+1 }"/>
		    	<c:if test="${i%7==0 || i==listSize}">
		    		<i class="angle double right icon"></i>
		    		</div>
		    	</c:if>
			</c:forEach>
		</div>
	</div>
	<!-- Initialize Swiper -->
	<script>
		var swiper = new Swiper('.swiper-container', {
			scrollbar : {
				el : '.swiper-scrollbar',
				hide : true,
			},
		});
	</script>
	<div class="ui container">
		<div class="ui fitted divider" style="border-width: medium;">
			<!--fit 되는 얇은 선-->
		</div>
		<div class="bookmarkcontent">
			<div class="ui internally grid" style="box-shadow: none; margin: 0; width: 100%;">
				<c:forEach items="${searchResultPosts }" var="searchResultPosts" varStatus="status">
					<!--1행-->
					<c:if test="${status.index%2==0}">
						<div class="eight wide column" style="border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;border-right-style: inset;">
					</c:if>	
					<c:if test="${status.index%2==1}">
						<div class="eight wide column" style="border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;">
					</c:if>					
						<!-- 두개의 쿼리문을 조인해서 사용하자 -->
						<a href="searchBoardName?searchKeyword=${searchResultPosts.boardId}"><span>${searchResultPosts.boardTopicName }</span></a> 
						<a href="/blind/topicDetail?postId=${searchResultPosts.postId}"><span style="font-size: 130%; font-weight: 700;">${searchResultPosts.postTitle }</span></a>
						<div class="ui grid">
							<div class="thirteen wide column">
								<a href="/blind/topicDetail?postId=${searchResultPosts.postId }"><p>${searchResultPosts.postContents }</p></a>
							</div>
							<div class="three wide column">
								<img class="ui tiny right floated image" src="bookmarkimage.png">

							</div>
							<a href="/blind/companyIntroduction?companyId=${searchResultPosts.companyId}"><span>${searchResultPosts.companyName }・${searchResultPosts.userId }</span></a>
							<div class="ui left floated horizontal list">
								<a class="item" href="/blind/topicDetail?postId=${searchResultPosts.postId }"><i class="eye icon"></i><span style="padding: 0 5px;">${searchResultPosts.postCount }</span></a>
								<a class="item" href="/blind/topicDetail?postId=${searchResultPosts.postId }"><i class="thumbs up outline icon"></i><span style="padding-left: 5px;">0</span></a>
								<a class="item" href="/blind/topicDetail?postId=${searchResultPosts.postId }"><i class="comment outline icon"></i><span style="padding: 0 5px;">${searchResultPosts.replyCount }</span></a>
							</div>
							<div class="ui right floated horizontal list">
								<a class="item" href="http://naver.com"><span
									style="padding-left: 5px; color: gray;"><fmt:formatDate
											value="${searchResultPosts.postCreateDate }" pattern="MM.dd" />
								</span></a> <a class="item" href="#"><i class="bookmark outline icon"></i><span
									style="padding: 0 5px;"></span></a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
		<!--1행 끝-->
	</div>
</body>
</html>
