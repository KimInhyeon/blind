<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>通報管理</title>
</head>
<style>
	.ui.compact.selection.dropdown {
		font-weight: 700;
		padding: 0;
	}
</style>
<body>
<div class="ui container">
	<div class="ui grid">
		<div class="middle aligned row">
			<div class="left floated two wide column">
				<h3 class="ui header">通報管理</h3>
			</div>
			<div class="right floated six wide column right aligned">
				<div class="ui fluid icon input">
					<select class="ui compact selection dropdown" id="searchTarget">
						<option value="contents">内容</option>
						<option value="category">トピック・企業名</option>
						<option value="reason">理由</option>
						<option value="writer">作成者</option>
						<option value="reporter">通報者</option>
					</select>
					<input type="hidden" id="searchKeyword">
					<input type="text" placeholder="キーワードを入力">
					<i class="search icon"></i>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>