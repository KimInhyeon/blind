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
					<div class="seven wide column">
						<div class="ui compact menu">
							<div class="ui simple dropdown item">
								<div>待機</div>
								<i class="dropdown icon"></i>
								<div class="menu">
									<div class="item" data-value="0">待機</div>
									<div class="item" data-value="1">承認</div>
									<div class="item" data-value="2">拒否</div>
									<div class="item" data-value="3">全部</div>
								</div>
							</div>
						</div>
					</div>
					<div class="seven wide column">
						<div class="ui compact menu">
							<div class="ui simple dropdown item">
								<div>営業</div>
								<i class="dropdown icon"></i>
								<div class="menu">
									<div class="item" data-value="0">営業</div>
									<div class="item" data-value="1">廃業</div>
								</div>
							</div>
						</div>
					</div>
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
<%--<div class="ui container">--%>
<%--<table class="ui selectable celled table" style="margin: 0px">--%>
<%--	<thead>--%>
<%--	<tr>--%>
<%--		<th style="width: 1%">--%>
<%--			<input type="checkbox" class="ui checkbox">--%>
<%--		</th>--%>
<%--		<th style="width: 9%">--%>
<%--&lt;%&ndash;			<div class="ui compact selection dropdown">&ndash;%&gt;--%>
<%--&lt;%&ndash;				<i class="dropdown icon"></i>&ndash;%&gt;--%>
<%--&lt;%&ndash;				<div class="text">待機</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;				<div class="menu">&ndash;%&gt;--%>
<%--&lt;%&ndash;					<div class="item">待機</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;					<div class="item">承認</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;					<div class="item">拒否</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;					<div class="item">全部</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;				</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;			</div>&ndash;%&gt;--%>
<%--		</th>--%>
<%--		<th style="width: 9%">--%>
<%--&lt;%&ndash;			<div class="ui compact selection dropdown">&ndash;%&gt;--%>
<%--&lt;%&ndash;				<i class="dropdown icon"></i>&ndash;%&gt;--%>
<%--&lt;%&ndash;				<div class="text">営業</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;				<div class="menu">&ndash;%&gt;--%>
<%--&lt;%&ndash;					<div class="item">営業</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;					<div class="item">廃業</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;				</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;			</div>&ndash;%&gt;--%>
<%--		</th>--%>
<%--		<th>Notes</th>--%>
<%--		<th>Notes</th>--%>
<%--		<th>Notes</th>--%>
<%--		<th>Notes</th>--%>
<%--		<th>Notes</th>--%>
<%--		<th>Notes</th>--%>
<%--		<th>Notes</th>--%>
<%--		<th>Notes</th>--%>
<%--	</tr>--%>
<%--	</thead>--%>
<%--	<tbody>--%>
<%--	<tr>--%>
<%--		<td></td>--%>
<%--		<td></td>--%>
<%--		<td class="negative">John</td>--%>
<%--		<td>John</td>--%>
<%--		<td class="warning">John</td>--%>
<%--		<td>John</td>--%>
<%--		<td>John</td>--%>
<%--		<td class="positive">John</td>--%>
<%--		<td>No Action</td>--%>
<%--		<td>None</td>--%>
<%--		<td>None</td>--%>
<%--	</tr>--%>
<%--	<tr class="warning">--%>
<%--		<td></td>--%>
<%--		<td></td>--%>
<%--		<td>None</td>--%>
<%--		<td>None</td>--%>
<%--		<td>None</td>--%>
<%--		<td>None</td>--%>
<%--		<td>None</td>--%>
<%--		<td>None</td>--%>
<%--		<td>None</td>--%>
<%--		<td>None</td>--%>
<%--		<td>None</td>--%>
<%--	</tr>--%>
<%--	</tbody>--%>
<%--</table>--%>
<%--</div>--%>
</body>
</html>