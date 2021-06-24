<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>トピック管理</title>
</head>
<style>
	.ui.grid > .middle.aligned.row {
		padding-bottom: 0;
	}

	.ui.table thead th {
		padding: 0;
	}

	td.center.aligned {
		padding: 0 .2em 0 .2em;
	}

	.ui.compact.selection.dropdown {
		font-weight: 700;
		padding: 0;
		text-align-last: center;
	}

	.ui.container {
		max-width: 40% !important;
	}

	.ui.yellow.button {
		margin: 0;
	}

	.edit {
		width: 9%;
	}
</style>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<h3 class="ui header">トピック管理</h3>
		</div>
		<div class="row">
			<table class="ui selectable single line celled table">
				<thead class="center aligned">
				<tr>
					<th style="width: 7%">順序</th>
					<th style="width: 10%">
						<select class="ui compact selection dropdown fluid">
							<option value="0">正常</option>
							<option value="1">閉鎖</option>
							<option value="2">全部</option>
						</select>
					</th>
					<th width="10%">
						<select class="ui compact selection dropdown fluid">
							<option value="0">一般</option>
							<option value="1">匿名</option>
							<option value="2">全部</option>
						</select>
					</th>
					<th>トピック名</th>
					<th class="edit">編集</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
</div>
</body>
</html>