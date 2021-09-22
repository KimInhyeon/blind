<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<%--<meta name="viewport" content="width=device-width, initial-scale=1.0">--%>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/dist/semantic.min.css"/>
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
	<script>"use strict";</script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/dist/semantic.min.js"></script>
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
	<%@ include file="/WEB-INF/views/main/body/board/postModal.jsp" %>
</sec:authorize>
</body>
</html>