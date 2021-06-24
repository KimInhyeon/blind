<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="Expires" content="0"/>
	<meta http-equiv="Pragma" content="no-cache"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/messageId.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/swiper-bundle.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/swiper-bundle.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/dist/semantic.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/dist/semantic.min.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/swiper-bundle.css"/>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/swiper-bundle.min.css"/>
	<script>
        $(document).ready(function () {
            $('.ui.dropdown.item').dropdown();

            $('.message .close')
                .on('click', function () {
                    $(this)
                        .closest('.message')
                        .transition('fade');
                });

            $('.clickMenu').click(function () {
                $(this).children('a').get(0).click();
            });
        });
	</script>

	<title>KSINFOSYS_BLIND PROTOTYPE</title>
</head>

<body>
<%
	response.setHeader("Cache-Control", "no-store");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>
<div class="ui stackable menu" style="font-weight: bold; font-size: 1.4em; line-height: 1.0em;  margin-top:-5px">
	<div class="item" style="width: 200px;height: 75px">
		<a href="${pageContext.request.contextPath}/main"><img
				src="${pageContext.request.contextPath}/resources/images/logo.png" style="margin-left:-25px"/></a>
	</div>
	<a class="browse item" href="javascript:location.href='${pageContext.request.contextPath}/topicMain'"
	   style="color: black">トピック</a>
	<a class="browse item" href="javascript:location.href='${pageContext.request.contextPath}/companyMain'"
	   style="color: black">企業情報</a>
	<!--  Message Area -->
	<c:if test="${not empty exception.message}">
		<div class="ui negative message" style="width: 350px!important;font-size: 0.6em !important; position:absolute;
			    top: 4%; left: 50%; transform: translateY(-50%) translateX(-50%); -webkit- transform: translateY(-50%) translateX(-50%); z-index:999;">
			<i class="close icon"></i>
			<div class="header">${exception.message}</div>
		</div>
	</c:if>
	<c:if test="${not empty exceptionMessage}">
		<div class="ui negative message" style="width: 350px!important;font-size: 0.6em !important; position:absolute;
			    top: 4%; left: 50%; transform: translateY(-50%) translateX(-50%); -webkit- transform: translateY(-50%) translateX(-50%); z-index:999;">
			<i class="close icon"></i>
			<div class="header">${exceptionMessage}</div>
		</div>
	</c:if>
	<c:if test="${not empty successMessage}">
		<div class="ui success message" style="width: 350px!important;font-size: 0.8em !important; position:absolute;
			    top: 4%; left: 50%; transform: translateY(-50%) translateX(-50%); -webkit- transform: translateY(-50%) translateX(-50%); z-index:999;">
			<i class="close icon"></i>
			<div class="header">${successMessage}</div>
		</div>
	</c:if>

</div>

</body>
</html>