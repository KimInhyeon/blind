<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>KSINFOSYS BLIND</title>
	<style>
		#searchbox{border-radius:50px; font-size:23px;}
		#searchbox::placeholder{font-size:18px;}
		.maintit{padding: 6px 0; font-size: 20px; font-weight: 700; float:left;}
		.titline{border: 0; height:2px; background: #dfe1e4;}
		#searchicon{padding-left:70px;}
		.maintopicbest{padding-top:8px;}
		.maintit span{padding-left:5px;}
		.topicbesttit{padding-top:50px;}
		#topicbestlabel{background:white; border:solid 1px #dfe1e4; margin-bottom:10px;}
		.seemore a {color:gray;}
		.topicbest span{color:gray;}
		.topicbest i{color:gray;}
	</style>
	<script>
		function goSearch(){
			var searchKeyword = $("#searchbox").val();

			if (searchKeyword === "" || searchKeyword === null || searchKeyword === undefined) {
				return false;
			}

			location.href='${pageContext.request.contextPath}/search?searchKeyword=' + searchKeyword;
		}
	</script>
</head>
<body>
<div class="ui container">
	<div class="ui fluid massive left icon input">
		<input type="text" placeholder="関心のある内容を検索してください。" id="searchbox"
				onKeypress="javascript:if (event.keyCode==13) { goSearch() }">
		<i class="search link icon" id="searchicon" onclick="goSearch();"></i>
	</div>

	<div class="topicbesttit">
		<div class="maintit">
			<i class="chess queen icon"></i>
			<span>トピックベスト</span>
			<br style="clear:both;">
		</div>
		<div class="seemore" style="float:right; padding-top:15px;">
			<a href="${pageContext.request.contextPath}/searchBoardName?searchKeyword=-1">もっと見る＞</a>
			<br style="clear:both;">
		</div>
		<hr class="titline" style="margin-top:45px;">
	</div>

	<c:choose>
		<c:when test="${!empty topicBestList}">
			<div class="maintopicbest"><!--topic best-->
			<c:forEach var="topicbest" items="${topicBestList}">
				<div class="topicbest">
					<div class="ui right floated horizontal list">
						<i class="thumbs up outline icon item" style="position:absolute; right:28.5%;"></i>
						<span class="item" style="position:absolute; right:27%;">${topicbest.recommendCount}</span>
						<i class="comment outline icon item" style="position:absolute; right:25%;"></i>
						<span class="item">${topicbest.replyCount }</span>
					</div>
					<div class="ui horizontal list">
						<a class="item" href="#">
							<div class="ui mini horizontal label" id="topicbestlabel">${topicbest.boardTopicname}</div>
						</a>
						<a class="item" href="${pageContext.request.contextPath}/topicDetail?postId=${topicbest.postId}">
							<span style="color:black; margin-left:-5px;">${topicbest.postTitle }</span>
						</a>
						<br>
					</div>
				</div>
			</c:forEach>
			</div><!--topic best container-->
		</c:when>
		<c:when test="${empty topicBestList}">
			<div class="maintopicbest"><!--topic best-->
				<h3>Can not found best topic</h3>
			</div><!--topic best container-->
		</c:when>
	</c:choose>

	<c:set var="subtitleveri" value="${topicSubList[0].boardId}"/>
	<c:set var="rowCount" value="0" />
	<div class="ui two column grid container"><!--sub -->
	<c:forEach var="topicSub" items="${topicSubList}">
		<c:choose>
			<c:when test="${subtitleveri eq topicSub.boardId}">
				<div class="column"><!-- 첫번째 -->
				<c:set var="subtitleveri" value="${subtitleveri + 1}"/>
				<c:set var="rowCount" value="0" />
					<div class="maintopictit" style="padding-top:50px;">
						<div class="maintit">
							<i class="money icon"></i>
							<span>${topicSub.boardTopicname}</span>
							<br style="clear:both;">
						</div>
						<div class="seemore" style="float:right; padding-top:15px;">
							<a href="${pageContext.request.contextPath}/searchBoardName?searchKeyword=${topicSub.boardId}">もっと見る＞</a>
							<br style="clear:both;">
						</div>
						<hr class="titline" style="margin-top:45px;">
					</div>

					<div class="subtopicbest">
						<div class="topicbest">
						<c:if test="${topicSub.postCount ne null}">
							<div class="ui right floated horizontal list" style="">
								<i class="eye icon item" style="position:absolute; right:60px;"></i>
								<span class="item" style="padding:0 10px;">${topicSub.postCount}</span>
							</div>
						</c:if>
							<div class="ui horizontal list" style="padding-left:10px;">
								<a class="item" href="${pageContext.request.contextPath}/topicDetail?postId=${topicSub.postId}">
									<span style="color:black; margin-left:-5px;">${topicSub.postTitle }</span>
								</a>
								<br>
							</div>
						</div>
			<c:if test="${topicSub.recordCount eq 1 || topicSub.recordCount eq 0}">
					</div>
				</div>
			</c:if>
			</c:when>
			<c:when test="${subtitleveri ne topicSub.boardId}">
				<div class="topicbest">
					<div class="ui right floated horizontal list">
						<i class="eye icon item" style="position:absolute; right:60px;"></i>
						<span class="item" style="padding:0 10px;">${topicSub.postCount}</span>
					</div>
					<div class="ui horizontal list" style="padding-left:10px;">
						<a class="item" href="${pageContext.request.contextPath}/topicDetail?postId=${topicSub.postId}">
							<span style="color:black; margin-left:-5px;">${topicSub.postTitle}</span>
						</a>
						<br>
					</div>
				</div>
			<c:set var="rowCount" value="${rowCount + 1}"/>
			<c:if test="${rowCount eq 4 || topicSub.recordCount - 1 eq rowCount}">
					</div>
				</div>
			</c:if>
			</c:when>
		</c:choose>
	</c:forEach>
	</div><!--subtopic-->

</div><!-- main container -->
<script>
	$("#searchbox").focus(function (){
		$(this).css("border-color", "black");
		$(this).css("border-width", "3px");
	});
	$("#searchbox").blur(function (){
		$(this).css("border-color", "");
		$(this).css("border-width", "");
	});
</script>
</body>
</html>