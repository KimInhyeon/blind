<%@ page contentType="text/html; charset=UTF-8" %>
<style>
	.tabtable tr td {
		border: none;
		padding-top: 10px;
		font-weight: bold;
	}
</style>

<%@ include file="/WEB-INF/views/main/company/companyMenu.jsp" %>
<div class="ui container">
	<div class="ui bottom attached active tab segment">
		<div style="width: 100%; border: 1px;">
			<table class="tabtable" border="1" style="width: 100%; margin: 0 auto; padding: 30px"><%--마진은되도록 쓰지말자  --%>
				<tr>
					<td>${companyIntroduction.companyName} 会社紹介</td>
				</tr>
				<tr>
					<td style="width:25%;"> ホムページ</td>
					<td style="width:35%;"><a target="_blank" href="${companyIntroduction.companyHomepage}">${companyIntroduction.companyHomepage}</a></td>
					<td>業界</td>
					<td>${companyIntroduction.businessTypeName}</td>
				</tr>

				<tr>
					<td>本社</td>
					<td>${companyIntroduction.companyAddress}</td>
					<td>設立</td>
					<td>${companyIntroduction.foundingDate}</td>
				</tr>
				<tr>
					<td>職員数</td>
					<td>${companyIntroduction.workersCount}</td>
				</tr>
				<tr>
					<td>${companyIntroduction.companyExplain}</td>
				</tr>
			</table>
		</div>
	</div>
</div>