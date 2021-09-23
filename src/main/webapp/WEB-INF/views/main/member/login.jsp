<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="field" align="center">
	<h2 class="card-title text-center" style="color: #113366;">LOGIN PAGE</h2>
	<form name="loginForm" action="member/login" method="post">
	<%-- Message Area --%>
	<c:if test="${not empty errorMsg}">
		<div class="ui negative message">
			<i class="close icon"></i>
			<div class="header">${errorMsg}</div>
		</div>
	</c:if>
	<c:if test="${not empty successMessage}">
		<div class="ui success message" style="width: 350px!important;font-size: 0.8em !important;
				position:absolute; top: 4%; left: 50%; transform: translateY(-50%) translateX(-50%);
				-webkit-transform: translateY(-50%) translateX(-50%); z-index:999;">
			<i class="close icon"></i>
			<div class="header">${successMessage}</div>
		</div>
	</c:if>

		<table>
			<tr>
				<td>E-MAIL</td>
				<td>
					<div class="ui input">
						<input type="text" class="form-control" name="username" id="username" maxlength="50"
								placeholder="E-MAIL">
					</div>
				</td>
				<td rowspan="3">
					<button type="button" class="ui blue button" style=height:80px; id="loginBtn">ログイン</button>
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
		</table>
	</form>
</div>
<script>
	function submitForm() {
		if (checkIsNull('username','E-MAIL') && checkIsNull('password','パスワード') &&
			checkIsAlphaNum('password') && checkCharLength('password', '4', '20', 'パスワード')
		) {
			document.loginForm.submit();
		}
	}

	addEventListener("DOMContentLoaded", function () {
		document.getElementById("loginBtn").addEventListener("click", submitForm);
		document.querySelectorAll("main form input").forEach(function (input) {
			input.addEventListener("keydown", function (event) {
				if (event.key === "Enter") {
					submitForm();
				}
			});
		});
	});
</script>