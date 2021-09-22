<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<section id="reply">
	<h3 class="ui header">コメント ${post.replyCount}</h3>
	<div id="writeReply">
		<button class="ui massive fluid basic button" onclick="openReplyBox(this, null, 0);">
			<i class="camera icon"></i><span>コメントを書き込む</span>
		</button>
	</div>
	<div class="ui internally celled grid">
	<c:forEach var="reply" items="${replyList}">
		<article class="ui grid row" data-id="${reply.replyId}" data-blind="${reply.replyBlindFlag}"
			<c:if test="${reply.depth gt 0}">
				style="padding-left: ${reply.depth * 4}%; background: whitesmoke;"
			</c:if>>
			<div class="row">
			<c:if test="${not empty reply.targetNickname}">
				<span class="targetNickname" onclick="findTargetReply(${reply.targetReplyId});">
					${reply.targetNickname}
				</span>
			</c:if>
				<a href="${pageContext.request.contextPath}/company/${reply.companyId}">${reply.companyName}</a>
				<span>・${reply.userNickname}</span>
			</div>
			<div class="row">
				<div class="sixteen wide column">
				<c:if test="${not empty reply.replyFileUrl}">
					<img class="ui image" src="${reply.replyFileUrl}" onclick="enlargeImage(this.src);">
				</c:if>
				<c:forEach var="replyLine" items="${reply.replyContents}">
					<p class="replyLine">${replyLine}</p><br>
				</c:forEach>
				</div>
			</div>
			<div class="middle aligned row">
				<div class="thirteen wide column">
					<i class="clock outline icon"></i>
					<span style="padding-right: 2%;">${reply.recCreateDate}</span>
					<i class="thumbs up icon<c:if test="${not reply.replyRecommended}"> outline</c:if>
					<sec:authorize access="isAuthenticated()">
						link" onclick="recommendReply(${reply.replyId});
					</sec:authorize>"></i>
					<span style="padding-right: 2%;">${reply.replyRecommendCount}</span>
					<i class="comment outline icon
					<c:if test="${reply.visible}">
						<sec:authorize access="hasAnyRole('RM', 'SV')">
							link" onclick="openReplyBox(this, ${reply.replyId}, ${reply.replyBlindFlag});
						</sec:authorize>
					</c:if>"></i>
					<span>${reply.nestedCount}</span>
				</div>
				<c:if test="${reply.visible}">
					<sec:authorize access="isAuthenticated()">
						<div class="right floated right aligned three wide column">
							<div class="ui compact menu">
								<div class="ui dropdown item">
									<i class="ellipsis horizontal icon"></i>
									<div class="left menu">
									<sec:authorize access="hasAnyRole('RM', 'SV')">
										<div class="item" onclick="restoreMenuItem(this);
												openReplyBox(this, ${reply.replyId}, ${reply.replyBlindFlag});">
											<i class="reply icon"></i><span>コメント作成</span>
										</div>
									</sec:authorize>
									<c:choose>
										<c:when test="${reply.writer}">
											<div class="item" onclick="restoreMenuItem(this);">
												<i class="edit outline icon"></i><span>コメント修正</span>
											</div>
											<div class="item" onclick="restoreMenuItem(this);">
												<i class="trash alternate outline icon"></i><span>コメント削除</span>
											</div>
										</c:when>
										<c:otherwise>
											<div class="item" onclick="restoreMenuItem(this);">
												<i class="bullhorn icon"></i><span>通報する</span>
											</div>
										</c:otherwise>
									</c:choose>
									</div>
								</div>
							</div>
						</div>
					</sec:authorize>
				</c:if>
			</div>
		</article>
	</c:forEach>
	<c:choose>
		<c:when test="${post.replyCount gt 10}">
			<div class="row">
				<button class="ui massive fluid basic button" onclick="checkAuthForgetReplyList();">
					<span style="padding-right: 1%;">さらに${post.replyCount - 10}個のコメントを読む</span>
					<i class="sync icon"></i>
				</button>
			</div>
		</c:when>
		<c:otherwise>

		</c:otherwise>
	</c:choose>
	</div>
</section>