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
<script>
	function copyTextToClipboard(text) {
		var textArea = document.createElement("textarea");

		textArea.style.position = 'fixed';
		textArea.style.top = 0;
		textArea.style.left = 0;
		textArea.style.width = '2em';
		textArea.style.height = '2em';
		textArea.style.padding = 0;
		textArea.style.border = 'none';
		textArea.style.outline = 'none';
		textArea.style.boxShadow = 'none';
		textArea.style.background = 'transparent';
		textArea.value = text;

		document.body.appendChild(textArea);

		textArea.select();

		try {
			var successful = document.execCommand('copy');
			var msg = successful ? '성공했습니다.' : '실패했습니다.';
			console.log('현재 url복사가 ' + msg);
			alert("url복사가 성공했습니다.");
		} catch (err) {
			console.log('현재 url복사가 ');
		}

		document.body.removeChild(textArea);
	}

	function CopyLink() {
		copyTextToClipboard(location.href);
	}
</script>
<style>
button.btn { <i class="list ul icon"></i>
	
}
</style>
<body>
	<div class="ui text container">
		<br>
		<div class="column">
			토픽 > <a class="boardTopicName" href="/blind/searchBoardName?searchKeyword=${postDetailDto.boardId }">${postDetailDto.boardTopicName }</a>
		</div>
		<br>
		<div class="column">
			<span style="font-size: 130%; font-weight: 700;">${postDetailDto.postTitle }</span>
		</div>
		<br>
		<div class="column">
			<a class="companyName" href="/blind/companyIntroduction?companyId=${postDetailDto.companyId}">${postDetailDto.companyName }</a> ・
			${postDetailDto.userId }
		</div>
		<br>

		<div class="column">
			<i class="clock outline icon"></i>
			<fmt:formatDate value="${postDetailDto.postCreateDate }"
				pattern="MM-dd" />
			&nbsp;&nbsp;&nbsp; <i class="eye icon"></i>${postDetailDto.postCount }
		</div>
		<div class="ui right floated horizontal list">
			<div class="item">
				<i class="bookmark outline icon"></i>
			</div>
			<div class="item" onclick="CopyLink()">
				<i class="ellipsis horizontal icon"></i>
			</div>
		</div>

	</div>
	<br>
	<br>
	<div class="ui container divider"></div>
	<div class="ui text container">
		<div class="column">${postDetailDto.postContents }</div>
		<br> <br>
		<div class="column">
			<i class="thumbs up outline icon"></i>0 &nbsp;&nbsp;&nbsp; <i
				class="comment outline icon"></i> <input type="text"
				value="${resultCount}" id="resultCount" style="border-width: 0px;"/> <br>
		</div>
	</div>
	<br>
	<div class="ui container divider"></div>
	<div class="ui container">
		<br>
		<div class="column">
			<%@ include file="../topicMain/reply.jsp"%>
		</div>
	</div>
	<br>
	<br>
	<div class="ui container">
		<div class="column"></div>
	</div>

</body>
</html>