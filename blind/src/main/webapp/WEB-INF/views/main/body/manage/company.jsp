<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>企業管理</title>
</head>
<style>
	.ui.grid > .row {
		padding-bottom: 0;
	}

	.ui.table thead th {
		padding: 0;
	}

	.ui.table td {
		padding: .78571429em .2em .78571429em .2em;
	}

	.ui.compact.selection.dropdown {
		font-weight: 700;
		padding: 0;
	}

	.ui.modal > .actions {
		text-align: center;
	}
</style>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<div class="left floated two wide column">
				<h3 class="ui header">企業管理</h3>
			</div>
			<div class="right floated six wide column right aligned">
				<div class="ui fluid icon input">
					<select class="ui compact selection dropdown">
						<option value="companyName">企業名</option>
						<option value="businessTypeName">業種</option>
						<option value="companyAddress">所在地</option>
						<option value="companyDomain">ドメイン</option>
					</select>
					<input type="text" placeholder="キーワードを入力">
					<i class="search icon"></i>
				</div>
			</div>
		</div>
		<div class="row">
			<table class="ui selectable single line celled table">
				<thead class="center aligned">
				<tr>
					<th style="width: 2%">
						<input type="checkbox" class="ui checkbox" id="checkAll">
					</th>
					<th style="width: 5%">
						<select class="ui compact selection dropdown">
							<option value="0">待機</option>
							<option value="1">承認</option>
							<option value="2">却下</option>
							<option value="3">全部</option>
						</select>
					</th>
					<th style="width: 5%">
						<select class="ui compact selection dropdown">
							<option value="0">営業</option>
							<option value="1">廃業</option>
							<option value="2">全部</option>
						</select>
					</th>
					<th>企業名</th>
					<th>業種</th>
					<th>所在地</th>
					<th style="width: 7%">設立日</th>
					<th>従業員数</th>
					<th>ドメイン</th>
					<th>申請者</th>
					<th style="width: 7%">申請日</th>
				</tr>
				</thead>
				<tbody>
				<c:forEach items="${companyList}" var="company">
					<tr>
						<td class="center aligned">
							<input type="checkbox" class="ui checkbox" name="companyID" value="${company.companyID}">
						</td>
						<td class="center aligned">
							<c:choose>
								<c:when test="${company.verifyFlag eq '0'}">待機</c:when>
								<c:when test="${company.verifyFlag eq '1'}">承認</c:when>
								<c:otherwise>却下</c:otherwise>
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
<%--				<tr>--%>
<%--					<td class="negative">John</td>--%>
<%--					<td class="warning">John</td>--%>
<%--					<td class="positive">John</td>--%>
<%--				</tr>--%>
<%--				<tr class="warning"></tr>--%>
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="five wide column"></div>
			<div class="six wide column center aligned">
				<div class="ui pagination menu">
					<a class="item">前へ</a>
					<a class="active item" href="${pageContext.request.contextPath}/manage/company">1</a>
					<a class="item">2</a>
					<a class="item">3</a>
					<a class="item">4</a>
					<a class="item">5</a>
					<a class="item">次へ</a>
				</div>
			</div>
			<div class="five wide column right aligned">
				<button class="ui green button">承認</button>
				<button class="ui red button" onclick="openModal('#rejection')">却下</button>
				<button class="ui yellow button" onclick="openModal('#comInfo')">変更</button>
				<button class="ui grey button" onclick="openModal('#comInfo')">新規</button>
			</div>
		</div>
	</div>
	<div class="ui modal" id="comInfo">
		<i class="close cancel icon"></i>
		<div class="header">申請情報</div>
		<div class="content">
			<div class="ui grid middle aligned">
				<div class="row">
					<div class="two wide column">処理状況</div>
					<div class="six wide column">
						<div class="ui fluid disabled input">
							<p>test</p>
						</div>
					</div>
					<div class="two wide column">営業状況</div>
					<div class="six wide column">
						<select class="ui compact selection dropdown">
							<option value="0">営業</option>
							<option value="1">廃業</option>
						</select>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">企業名</div>
					<div class="six wide column">
						<div class="ui fluid disabled input">
							<input type="text">
						</div>
					</div>
					<div class="two wide column">設立日</div>
					<div class="six wide column">
						<div class="ui input">
							<input type="date">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">業種</div>
					<div class="six wide column">
						<div class="ui fluid disabled input">
							<select class="ui compact selection dropdown">
								<option value="0">test1ddasdf</option>
								<option value="1">test2</option>
							</select>
						</div>
					</div>
					<div class="two wide column">従業員数</div>
					<div class="six wide column">
						<div class="ui fluid input">
							<input type="text">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">所在地</div>
					<div class="six wide column">
						<div class="ui fluid input">
							<input type="text">
						</div>
					</div>
					<div class="two wide column">ドメイン</div>
					<div class="six wide column">
						<div class="ui fluid input">
							<input type="text">
						</div>
					</div>
				</div>
				<div class="row">
					<div class="two wide column">申請者</div>
					<div class="six wide column">
						<div class="ui fluid disabled input">
							<p>123</p>
						</div>
					</div>
					<div class="two wide column">申請日</div>
					<div class="six wide column">
						<div class="ui fluid disabled input">
							<p>456</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="actions">
			<button class="ui primary button" onclick="confirm()">更新</button>
		</div>
	</div>
	<div class="ui tiny modal" id="rejection">
		<i class="close cancel icon"></i>
		<div class="header">却下事由</div>
		<div class="content">
			<div class="ui grid">
				<div class="three wide column">
					<select class="ui compact selection dropdown">
						<option>確認不能</option>
						<option>既申請</option>
						<option>その他</option>
					</select>
				</div>
				<div class="thirteen wide column">
					<div class="ui fluid input">
						<input type="text">
					</div>
				</div>
			</div>
		</div>
		<div class="actions">
			<button class="ui primary button">更新</button>
		</div>
	</div>
</div>
</body>
<script>
	function confirm() {
		if (window.confirm('更新しますか？')) {
			console.log('test');
		}
	}

	function openModal(target) {
		$(target).modal('show');
	}

	$(function () {
		$('#checkAll').change(function () {
			if ($(this).is(':checked')) {
				$('input[name=companyID]').not(':checked').click();
			} else {
				$('input[name=companyID]').click();
			}
		});

		$('input[name=companyID]').change(function () {
			const $checkbox = $(this);
			if ($checkbox.is(':checked')) {
				$checkbox.closest('tr').addClass('warning');
			} else {
				$checkbox.closest('tr').removeClass('warning');
			}
		});
	});
</script>
</html>