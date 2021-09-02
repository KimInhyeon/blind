<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%--<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>--%>
<%--<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>--%>
<%--<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>--%>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>KSINFOSYS BLIND</title>
</head>

<script>
	$(document).ready(function() {
		var replyList = new Array();
	<c:forEach items="${readReply}" var="readReply" varStatus="vs">
		replyList.push({
			replyId : "${readReply.replyId}",
			postId : "${readReply.postId}",
			userId : "${readReply.userId}",
			replyContents : `${readReply.replyContents}`,
			recCreateDate :"${readReply.recCreateDate}",
			companyName:"${readReply.companyName}",
			replyCount:"${readReply.replyCount}"
		});
	</c:forEach>
		$.each(replyList, function(key, value) {
			$("#replyArea").append(
				"<div class='ui container divider'></div><br>" + value.userId + "<br><br>" +
				"<div class='column' style='white-space:pre;'>" + value.replyContents + "</div><br>" +
				"<div class='column'><i class='clock outline icon'></i>" + value.recCreateDate +
				"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='thumbs up outline icon'></i>좋아요" +
				"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='comment outline icon'></i>대댓글" +
				"<input type='button' class='replyButton' name='replyButton' value='대댓글쓰기' style='float:right'/>"
			);
		});
	});

	$(function() {
		$("#replyButton").click(function() {
			reply();
		});
	});

	function reply() {
		var replyContents = $("#replyContents").val();
		var postId = "${postDetailDto.postId}";
		var param = {
			"replyContents" : replyContents,
			"postId" : postId
		};
		$.ajax({
			type : "post",
			url : "/blind/reply/insertReply",
			data : param,
			success : function(result) {
				$("#replyArea").html("");
				$.each(result, function(key, value) {
					$("#replyArea").append(
						"<div class='ui container divider'></div><br>" + value.userId + "<br><br>" +
						"<div class='column' style='white-space:pre;'>" + value.replyContents + "</div>" + "<br>" +
						"<div class='column'><i class='clock outline icon'></i>" + value.recCreateDate +
						"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='thumbs up outline icon'></i>" + "좋아요" +
						"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i class='comment outline icon'></i>대댓글" +
						"<input type='button' class='replyButton' name='replyButton' value='대댓글쓰기' " +
						"style='float:right'/>"
					);
				});
				$("#resultCount").val(result[0].replyCount);
			}
		});
	}
/*
	function replyList() {
		var postId = "${postDetailDto.postId}";

		$.ajax({
			type : "post",
			url : "/blind/reply/replyList",
			data : {"postId" : postId},
			dataType : "json",
			success : function(result) {
				var $replyArea = $("#replyArea");

				if(result == "") {
					$replyArea.html("<li>등록된 댓글이 없습니다</li>");
				} else {
					$replyArea.html("");

					$.each(result : function(i) {
						var $list = $("<li>");
						var $userId = $("<span>").prop("class","userId").html(result[i].userId);
						var $recCreateDate = $("<span>").prop("class","recCreateDate").html(result[i].recCreateDate);
						var $replyContents = $("<p>").prop("class","replyContents").html(rList[i].replyContent)
						var $hr = $("<hr>");

						$li.append($userId).append($recCreateDate).append("$replyContents");

						$replyArea.append($list).append($hr);
					});
				}
			},
			error : function(){
				console.log("댓글 목록 조회 ajax 통신 실패");
			}
		});
	}

	$(function(){
		replyList();

		setInterval(function(){
			replyList
		}, 10000);
	});
*/
</script>
<body>
	<div class="container">
		<form method="post" action="/reply/insertReply">
			<br><br>
			<div>
				<div><span><strong>댓글</strong></span> <span id="cCnt"></span></div>
				<div>
					<table class="table">
						<tr>
							<td>
								<textarea style="width: 1100px" rows="3" cols="30" id="replyContents"
										name="replyContents" placeholder="댓글을 입력하세요"></textarea>
								<br>
								<div><input type="button" id="replyButton" value="댓글 등록하기"></div>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<input type="hidden" id="post_id" name="post_id" value="${topicDetail.postId}">
		</form>
	</div>
	<div id="replyArea"></div>
	<div class="container">
		<form id="replyListForm" name="replyListForm" method="post">
			<div id="replyList"></div>
		</form>
	</div>
</body>
</html>