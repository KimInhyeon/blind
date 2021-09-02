<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>--%>
<%--<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>--%>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>KSINFOSYS BLIND</title>
</head>
<body>
	<table style="width: 700px">
	<c:forEach items="${readReply}" var="readReply">
		<tr>
			<td>${readReply.userId} ( <fmt:formatDate value="${readReply.recCreateDate}"
					pattern="yyyy-MM-dd" />) <br> ${readReply.replyContents}
			</td>
		</tr>
	</c:forEach>
	</table>
</body>
</html>