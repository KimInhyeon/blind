<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<base href="${pageContext.request.contextPath}/">
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="Expires" content="-1">
<%--
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<%
		response.setHeader("Cache-Control", "no-store");
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Expires", 0);
		if (request.getProtocol().equals("HTTP/1.1")) {
			response.setHeader("Cache-Control", "no-cache");
		}
	%>
--%>
	<title>${title}</title>
	<link rel="stylesheet" href="resources/dist/semantic.min.css">
	<style>
		main {
			padding-top: 1%;
			padding-bottom: 1%;
			min-height: 80%;
		}
	<sec:authorize access="hasAnyRole('RM','SV')">
		.ce-block__content, .ce-toolbar__content {
			max-width: 97%;
		}

		.cdx-input.cdx-simple-image__caption {
			display: none;
		}
	</sec:authorize>
	</style>
	<script src="resources/js/jquery.min.js"></script>
	<script src="resources/dist/semantic.min.js"></script>
	<script src="resources/js/common.js"></script>
	<script src="resources/js/messageId.js"></script>
	<script>
		"use strict";
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
<header>
	<tiles:insertAttribute name="header"/> <%-- /WEB-INF/views/common/layout/header.jsp --%>
</header>
<main>
	<tiles:insertAttribute name="body"/> <%-- body --%>
</main>
<footer class="ui footer segment">
	<tiles:insertAttribute name="footer"/> <%-- /WEB-INF/views/common/layout/footer.jsp --%>
</footer>
<sec:authorize access="hasAnyRole('RM','SV')">
	<%@ include file="/WEB-INF/views/main/board/postModal.jsp" %>
</sec:authorize>
</body>
</html>