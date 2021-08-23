<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<!--<meta name="viewport" content="width=device-width, initial-scale=1.0">-->
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
</head>
<style>
	main {
		padding: 1%;
		min-height: 80%;
	}
</style>
<body>
<header>
	<tiles:insertAttribute name="header"/> <!-- /WEB-INF/views/common/layout/header.jsp -->
</header>
<main>
	<tiles:insertAttribute name="body"/> <!-- body -->
</main>
<footer class="ui footer segment">
	<tiles:insertAttribute name="footer"/> <!-- /WEB-INF/views/common/layout/footer.jsp -->
</footer>
</body>
</html>