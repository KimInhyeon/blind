<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title></title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/semantic.css"/>
</head>
<body>
<div class="ui grid container">
	<div class="row">
		<div class="left floated two wide column">
			<h2>테스트</h2>
		</div>
		<div class="right floated four wide column">
			<form action="${pageContext.request.contextPath}/manage/company" method="get">
				<div class="ui selection dropdown">
					<input type="hidden" name="gender">
					<i class="dropdown icon"></i>
					<div class="default text">Gender</div>
					<div class="menu">
						<div class="item" data-value="companyName">企業名</div>
						<div class="item" data-value="businessType">業種</div>
						<div class="item" data-value="ompanyAddress">所在地</div>
						<div class="item" data-value="companyDomain">ドメイン</div>
					</div>
				</div>
				<%--				<div class="right floated three wide column"></div>--%>
			</form>
		</div>
	</div>
	<div class="row">
		<c:forEach items="${companyList}" var="company">
			<div class="column">company_id : ${company.companyId}</div>
			<div class="column">user_id : ${company.userId}</div>
			<div class="column">company_name : ${company.companyName}</div>
			<div class="column">business_type_code : ${company.businessTypeCode}</div>
			<div class="column">company_address : ${company.companyAddress}</div>
			<div class="column">founding_date : <fmt:formatDate value="${company.foundingDate}"
																pattern="yyyy-MM-dd"/></div>
			<div class="column">workers_count : ${company.workersCount}</div>
			<div class="column">app_date : <fmt:formatDate value="${company.appDate}" pattern="yyyy-MM-dd"/></div>
			<div class="column">company_domain : ${company.companyDomain}</div>
			<div class="column">company_homepage : ${company.companyHomepage}</div>
			<div class="column">company_explain : ${company.companyExplain}</div>
			<div class="column">verify_flag : ${company.verifyFlag}</div>
			<div class="column">closing_flag : ${company.closingFlag}</div>
		</c:forEach>
	</div>
	<div class="row">
		페이지랑 버튼
	</div>
</div>
</body>
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/dist/semantic.js"></script>
</html>