<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
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
			document.registForm.submit();
		} else {
			return false;
		}
	}
	
	function regWithEnter() {
		// ENTERキーの場合
		if (window.event.keyCode == 13) {
			document.getElementById('regBtn').click();
		}
	}	
</script>
</head>
<body>
<div class="field" align="center">    
<h2 class="card-title text-center" style="color: #113366;">Sign In PAGE</h2>    
<form name="registForm" action="/blind/registMember" method="post" onsubmit="return false;">
<table>
    <tr>
        <td>E-MAIL</td>
        <td>
            <div class="ui input">
                <input type="email" class="form-control" name="username" id="username" maxlength="50" placeholder="E-MAIL" onkeydown="regWithEnter()">
            </div>
        </td>
        <td rowspan="3">
            <button class="ui blue button" style=height:80px; id="regBtn" onclick="submitForm()" type="button">登録</button>
        </td>
    </tr>
    <tr>
        <td>パスワード</td>
        <td>
            <div class="ui input">
                <input type="password" class="form-control" name="password"  id="password" maxlength="20" placeholder="パスワード" onkeydown="regWithEnter()">
            </div>
        </td>
    </tr>
    <tr>
        <td>ニックネーム</td>
        <td>
            <div class="ui input">
                <input type="text" class="form-control" name="nickName"  id="nickName" maxlength="20" placeholder="ニックネーム" onkeydown="regWithEnter()">
            </div>
        </td>
    </tr>
</table>
<label>一般会員</label><input type="radio" name="role" id="role" value="NM" />
<label>正会員</label><input type="radio" name="role" id="role" value="RM" />
<label>管理者</label><input type="radio" name="role" id="role" value="SV" />
</form>
</div>
</body>
</html>