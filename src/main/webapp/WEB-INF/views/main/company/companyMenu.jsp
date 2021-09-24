<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="ui fluid container" id="reviewHeader" style="padding: 80px 0; background-color: black"></div>
<div class="ui container">
	<div style="padding-top: 20px;">
		<button class="blue ui right floated button" style="margin-top: 30px;"
				onclick="location.href='company/review?companyId=${companyMenu.companyId}';">
			この会社をレビューする
		</button>
		<img src="resources/images/company/${companyMenu.companyId}.png"
				class="ui left floated image" width="90px" height="90px">
		<div style="margin-top: 10px;">
			<h2>${companyMenu.companyName}</h2>
			<p>★${companyMenu.allPointAvg} (${companyMenu.reviewCount}個のレビュー)</p>
		</div>
	</div>
	<div class="ui top attached tabular menu" style="font-size: 1.2rem;">
		<div class="<c:if test="${companyIntroduction ne null}">active </c:if>item"
				onclick="location.href='company/introduction/${companyMenu.companyId}'"
				style="display: flex; justify-content: center; width: 15%; cursor: pointer;">
			紹介
		</div>
		<div class="<c:if test="${companyList ne null}">active </c:if>item"
				onclick="location.href='company/review/${companyMenu.companyId}'"
				style="display: flex; justify-content: center; width: 15%; cursor: pointer;">
			レビュー
		</div>
		<div class="<c:if test="${companyPostList ne null}">active </c:if>item"
				onclick="location.href='company/post/${companyMenu.companyId}'"
				style="display: flex; justify-content: center; width: 15%; cursor: pointer;">
			掲示板
		</div>
		<div class="<c:if test="${annualIncome ne null}">active </c:if>item"
				onclick="location.href='company/annualIncome/${companyMenu.companyId}'"
				style="display: flex; justify-content: center; width: 15%; cursor: pointer;">
			年収
		</div>
		<div class="<c:if test="${articles ne null}">active </c:if>item"
				onclick="location.href='company/news/${companyMenu.companyId}'"
				style="display: flex; justify-content: center; width: 15%; cursor: pointer;">
			ニュース
		</div>
	</div>
</div>