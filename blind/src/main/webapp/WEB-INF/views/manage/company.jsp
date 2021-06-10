<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>企業管理</title>
</head>
<body>
<div class="ui container">
	<div class="ui grid segments">
		<div class="row segment">
			<div class="four wide column">
				<div class="ui grid center aligned">
					<div class="two wide column"><input type="checkbox" class="ui checkbox"></div>
					<div class="seven wide column">処理状態</div>
					<div class="seven wide column">営業状況</div>
				</div>
			</div>
			<div class="twelve wide column">
				<div class="ui grid">
					<div class="four wide column">企業名</div>
					<div class="four wide column">業種</div>
					<div class="three wide column">所在地</div>
					<div class="two wide column center aligned">設立日</div>
					<div class="three wide column">ドメイン名</div>
				</div>
			</div>
		</div>
		<c:forEach items="${companyList}" var="company">
			<div class="row segment">
				<div class="four wide column">
					<div class="ui grid center aligned">
						<div class="two wide column"><input type="checkbox" class="ui checkbox"></div>
						<div class="seven wide column">
							<c:choose>
								<c:when test="${company.verifyFlag eq '0'}">待機</c:when>
								<c:when test="${company.verifyFlag eq '1'}">承認</c:when>
								<c:otherwise>拒否</c:otherwise>
							</c:choose>
						</div>
						<div class="seven wide column">
							<c:choose>
								<c:when test="${company.closingFlag eq '0'}">営業中</c:when>
								<c:otherwise>廃業</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<div class="twelve wide column">
					<div class="ui grid">
						<div class="four wide column">${company.companyName}</div>
						<div class="four wide column">${company.businessTypeName}</div>
						<div class="three wide column">${company.companyAddress}</div>
						<div class="two wide column center aligned">${company.foundingDate}</div>
						<div class="three wide column">@${company.companyDomain}</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
</body>
</html>