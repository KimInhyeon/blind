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


</head>

<body>
	<div class="ui text container">
		<br>
		<div class="column">
			토픽 > <a
				class="boardTopicName" href="">${postDetailDto.boardTopicName }</a>
		</div>
		<br>
		<div class="column">
			<span style="font-size: 130%; font-weight: 700;">${postDetailDto.postTitle }</span>
		</div>
		<br>
		<div class="column"><a class="companyName" href="">${postDetailDto.companyName }</a> ・ ${postDetailDto.userId }</div>
		<br>

		<div class="column">
			<i class="clock outline icon"></i>${postDetailDto.postCreateDate } &nbsp;&nbsp;&nbsp; <i
				class="eye icon"></i>${postDetailDto.postCount }
		</div>
		<div class="ui right floated horizontal list">

			<a class="item" href="#"><i class="bookmark outline icon"></i> <span
				style="padding: 0 5px;"></span></a> <a class="item"> <span
				style="padding-left: 5px; color: gray;"> <i class="list icon"></i></span>
			</a>
		</div>

	</div>
	<br>
	<br>
	<div class="ui container divider"></div>
	<div class="ui text container">
		<div class="column">
			${postDetailDto.postContents }
		</div>
		<br> <br>
		<div class="column">
			<i class="thumbs up outline icon"></i>0 &nbsp;&nbsp;&nbsp; <i
				class="comment outline icon"></i>댓글<br>
		</div>
	</div>
	<br>
	<div class="ui container divider"></div>
	<div class="ui text container">
		<div class="column">댓글 ${postDetailDto.boardTopicName }</div>
		<br>
		<div class="ui button">
			<button class="item">
				<i class="camera retro icon"></i>댓글을 남겨주세요.
			</button>
		</div>
	</div>
	<br>
	<br>
	<div class="ui container">
		<div class="column">
			<b>토픽 베스트</b>
		</div>
	</div>
</body>
</html>