<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="field" align="center">
	<h2 class="card-title text-center" style="color: #113366;">Sign In PAGE</h2>
	<form name="registerForm" action="member/register" method="post">
		<table>
			<tr>
				<td>E-MAIL</td>
				<td>
					<div class="ui input">
						<input type="email" class="form-control" name="username" id="username" maxlength="50"
								placeholder="E-MAIL">
					</div>
				</td>
				<td rowspan="3">
					<button type="button" class="ui blue button" style="height: 80px;" id="regBtn">登録</button>
				</td>
			</tr>
			<tr>
				<td>パスワード</td>
				<td>
					<div class="ui input">
						<input type="password" class="form-control" name="password" id="password" maxlength="20"
								placeholder="パスワード">
					</div>
				</td>
			</tr>
			<tr>
				<td>ニックネーム</td>
				<td>
					<div class="ui input">
						<input type="text" class="form-control" name="nickname" id="nickname" maxlength="20"
								placeholder="ニックネーム">
					</div>
				</td>
			</tr>
		</table>
		<label>一般会員<input type="radio" name="role" value="NM"></label>
		<label>正会員<input type="radio" name="role" value="RM"></label>
		<label>管理者<input type="radio" name="role" value="SV"></label>
	</form>
</div>
<script>
	addEventListener("DOMContentLoaded", function () {
		const submitForm = function () {
			if (!checkIsNull('username','E-MAIL') || !checkIsNull('password','パスワード') ||
				!checkCharLength('password', '4', '20', 'パスワード') || !checkIsAlphaNum('password') ||
				!checkIsNull('nickname', 'ニックネーム')
			) {
				return;
			}
			if (document.querySelectorAll("input[name=role]:checked").length) {
				document.registerForm.submit();
			} else {
				alert("権限を選択してください");
			}
		};
		document.getElementById("regBtn").addEventListener("click", submitForm);
		document.querySelectorAll("main form input").forEach(function (input) {
			input.addEventListener("keydown", function (event) {
				if (event.key === "Enter") {
					submitForm();
				}
			});
		});
	});
</script>