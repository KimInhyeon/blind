<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="jp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KSINFOSYS BLIND</title>
<script>
	function submitForm() {
		var submitFlg = true;
		submitFlg = checkIsNull('username','E-MAIL');
		
		if(submitFlg) {
			submitFlg = checkIsNull('password','パスワード');
		}
		
		if(submitFlg) {
			submitFlg = checkIsAlphaNum('password');	
		}
		
		if(submitFlg) {
			submitFlg = checkCharLength('password', '4', '20', 'パスワード');
		}
		
		if (submitFlg) {
			document.loginForm.submit();
		} else {
			return false;
		}
	}
	
	function loginWithEnter() {
		// ENTERキーの場合
		if (window.event.keyCode == 13) {
			document.getElementById('loginBtn').click();
		}
	}	
</script>
</head>
<body>
<div class="field" align="center">    
<h2 class="card-title text-center" style="color: #113366;">LOGIN PAGE</h2>    
<form name="loginForm" action="/blind/login" method="post" onsubmit="return false;">
<!--  Message Area -->
<c:if test="${not empty errorMsg}">
	    <div class="ui negative message">
	        <i class="close icon"></i>
            <div class="header">${errorMsg}</div>
        </div>
</c:if>
<c:if test="${not empty successMessage}">
	    <div class="ui success message" style="width: 350px!important;font-size: 0.8em !important; position:absolute; 
	    top: 4%; left: 50%; transform: translateY(-50%) translateX(-50%); -webkit- transform: translateY(-50%) translateX(-50%); z-index:999;">
	        <i class="close icon"></i>
            <div class="header">${successMessage}</div>
        </div>
</c:if>

<table>
    <tr>
        <td>E-MAIL</td>
        <td>
            <div class="ui input">
                <input type="text" class="form-control" name="username" id="username" maxlength="50" placeholder="E-MAIL" onkeydown="loginWithEnter()">
            </div>
        </td>
        <td rowspan="3">
            <button class="ui blue button" style=height:80px; id="loginBtn" onclick="submitForm()" type="button">ログイン</button>
        </td>
    </tr>
    <tr>
        <td>パスワード</td>
        <td>
            <div class="ui input">
                <input type="password" class="form-control" name="password"  id="password" maxlength="20" placeholder="パスワード" onkeydown="loginWithEnter()">
            </div>
        </td>
    </tr>
</table>
</form>
</div>
</body>
</html>