<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>企業ニュース</title>
</head>
<body>
<div class="ui fluid container" id="reviewHeader" style="padding:80px 0; background-color:black"></div>
<div class="ui container">
	<div style="padding-top:20px;">
		<button onclick="location.href='${pageContext.request.contextPath}/companyReviewWrite?companyId=${companyIntroduction.companyId}';"
				style="margin-top:30px;" class="blue ui right floated button">この会社をレビューする</button>
		<img src="${pageContext.request.contextPath}/resources/images/company/${companyIntroduction.companyId}.png"
				class="ui left floated image" width="90px" height="90px">
		<div style="margin-top:10px;">
			<h2>${companyIntroduction.companyName}</h2>
			<p>★${companyIntroduction.realAllPoint} (${reviewCount}個のレビュー)</p>
		</div>
	</div>
</div>
<div class="ui container">
	<div class="ui top attached tabular menu" style="font-size:1.2rem;">
		<div onclick="location.href='${pageContext.request.contextPath}/companyIntroduction?companyId=${companyIntroduction.companyId}'"
				class="item" style="display:flex; justify-content:center; width:15%; cursor:pointer;">紹介</div>
		<div onclick="location.href='${pageContext.request.contextPath}/companyShowReview?companyId=${companyIntroduction.companyId}'"
				class="item" style="display:flex; justify-content:center; width:15%; cursor:pointer;">レビュー</div>
		<div class="item" style="display: flex; justify-content:center; width:15%; cursor:pointer;">掲示板</div>
		<div onclick="location.href='${pageContext.request.contextPath}/annualIncome?selectCompanyId=${companyIntroduction.companyId}'"
				class="item" style="display: flex; justify-content:center; width:15%; cursor:pointer;">年俸</div>
		<div class="active item" style="display: flex; justify-content:center; width:15%; cursor:pointer;">ニュース</div>
	</div>
</div>
<div>${articles}</div>
<div>${navi}</div>
</body>
</html>