<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>企業管理</title>
</head>
<style>
	.ui.table thead th {
		padding: 0;
	}

	.ui.table td {
		padding: .78571429em .2em .78571429em .2em;
	}
</style>
<body>
<div class="ui container">
	<table class="ui selectable celled table">
		<thead class="center aligned">
		<tr>
			<th style="width: 1px">
				<input type="checkbox" class="ui checkbox">
			</th>
			<th>
				<div class="ui compact selection dropdown">
					<i class="dropdown icon"></i>
					<div class="text">待機</div>
					<div class="menu">
						<div class="item">待機</div>
						<div class="item">承認</div>
						<div class="item">拒否</div>
						<div class="item">全部</div>
					</div>
				</div>
			</th>
			<th>
				<div class="ui compact selection dropdown">
					<i class="dropdown icon"></i>
					<div class="text">営業</div>
					<div class="menu">
						<div class="item">営業</div>
						<div class="item">廃業</div>
					</div>
				</div>
			</th>
			<th>企業名</th>
			<th>業種</th>
			<th>所在地</th>
			<th>設立日</th>
			<th>従業員数</th>
			<th>ドメイン</th>
			<th>申請者</th>
			<th>申請日</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach items="${companyList}" var="company">
			<tr>
				<td class="center aligned"><input type="checkbox" class="ui checkbox"></td>
				<td class="center aligned">
					<c:choose>
						<c:when test="${company.verifyFlag eq '0'}">待機</c:when>
						<c:when test="${company.verifyFlag eq '1'}">承認</c:when>
						<c:otherwise>拒否</c:otherwise>
					</c:choose>
				</td>
				<td class="center aligned">
					<c:choose>
						<c:when test="${company.closingFlag eq '0'}">営業</c:when>
						<c:otherwise>廃業</c:otherwise>
					</c:choose>
				</td>
				<td>${company.companyName}</td>
				<td>${company.businessTypeName}</td>
				<td>${company.companyAddress}</td>
				<td class="center aligned">${company.foundingDate}</td>
				<td>${company.workersCount}</td>
				<td>${company.companyDomain}</td>
				<td>${company.userNickName}</td>
				<td class="center aligned">${company.appDate}</td>
			</tr>
		</c:forEach>
		<tr>
			<td></td>
			<td></td>
			<td class="negative">John</td>
			<td>John</td>
			<td class="warning">John</td>
			<td>John</td>
			<td>John</td>
			<td class="positive">John</td>
			<td>No Action</td>
			<td>None</td>
			<td>None</td>
		</tr>
		<tr class="warning">
			<td></td>
			<td></td>
			<td></td>
			<td>testcompasdfany2testcomp</td>
			<td>None</td>
			<td>None</td>
			<td>None</td>
			<td>None</td>
			<td>None</td>
			<td>None</td>
			<td>None</td>
		</tr>
		</tbody>
	</table>
</div>
</body>
</html>