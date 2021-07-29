<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
</style>
<script>

//본래의 서비스를 이용하려는데 정회원이 아닌관계로 본 인증페이지로 이동한 유저들에게 안내를 위해 사용하는 팝업창.
$(document).ready(function() { 
	if(${explain_flag} == 1){	//인증으로 넘기는 컨트롤러에서 플래그값을 넘긴다.
		alert("企業のメールを通じた認証が必要です。"); 		
	}
});
</script>

</head>


<body>
인증페이지
	
</body>
</html>


