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

	th.sequence {
		width: 7%;
	}

	th.filter {
		width: 10%;
	}

	th.edit {
		width: 9%;
	}

	.row.scroll {
		height: 50em;
		overflow: auto;
	}

	.ui.modal > .actions {
		text-align: center;
	}
</style>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<h3 class="ui header">トピック管理</h3>
		</div>
		<div class="row scroll">
			<table class="ui selectable single line celled table">
				<thead class="center aligned">
				<tr>
					<th class="sequence">順序</th>
					<th class="filter">
						<select class="ui compact selection dropdown fluid">
							<option value="0">正常</option>
							<option value="1">閉鎖</option>
							<option value="2">全部</option>
						</select>
					</th>
					<th class="filter">
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
				<%--				--%>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<tr>
					<td class="center aligned">1</td>
					<td class="center aligned">sss</td>
					<td class="center aligned">ddd</td>
					<td>fff</td>
					<td class="center aligned">
						<button class="ui yellow button">編集</button>
					</td>
				</tr>
				<%--				--%>
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="three wide column right floated right aligned">
				<button class="ui grey button">新規</button>
			</div>
		</div>
		<div class="ui tiny modal active">
			<i class="close cancel icon"></i>
			<div class="content">
				<div class="ui grid middle aligned">
					<div class="row">
						<div class="two wide column">順位</div>
						<div class="six wide column">
							<div class="ui input fluid"><input type="number"></div>
						</div>
						<div class="eight wide column">
							<div class="ui grid right aligned">
								<div class="eight wide column">
									<select class="ui compact selection dropdown">
										<option value="0">　正常　</option>
										<option value="1">　閉鎖　</option>
									</select>
								</div>
								<div class="eight wide column">
									<select class="ui compact selection dropdown">
										<option value="0">　一般　</option>
										<option value="1">　匿名　</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="five wide column">
							<div class="ui grid middle aligned">
								<div class="six wide column">順位</div>
								<div class="ten wide column">
									<div class="ui input fluid"><input type="number"></div>
								</div>
							</div>
						</div>
						<div class="eleven wide column">
							<div class="ui grid middle aligned">
								<div class="five wide column">トピック名</div>
								<div class="eleven wide column">
									<div class="ui fluid input"><input type="text"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="actions center aligned">
				<button class="ui primary button">編集</button>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>