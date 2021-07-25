<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title></title>
<style>
	.tabtable tr td{
	 border:none;
	 padding-top:10px;
	}
    

</style>
</head>
<body>
<div class="ui fluid container" id="reviewHeader" style="padding:80px 0; background-color:black">

</div>
<div class="ui container">
	<div style="padding-top:20px;">
	 <button style="margin-top:30px;"class="blue ui right floated button"  onclick="location.href='${pageContext.request.contextPath}/companyReviewWrite?companyId=${companyIntroduction.companyId}';"  >
	  この会社をレビューする
	 </button>
	
	 <img class="ui left floated image" src="${pageContext.request.contextPath}/resources/images/company/${companyIntroduction.companyId}.png" width="90px" height="90px" ></img>
	 <div style="margin-top:10px;" >
	 <h2>${companyIntroduction.companyName }</h2>
	 <p style="line-height:0.rem;">★${companyIntroduction.realAllPoint } (${reviewCount }個のレビュー)</p>
	 </div>
	
	
	</div>


</div>




	
<div class="ui container">	
	
	
	
	
	
<div class="ui top attached tabular menu" style="font-size:1.2rem;">
  <div class="active item" onclick="location.href='companyIntroduction?companyId=${companyIntroduction.companyId}'" style="display:flex; justify-content:center; width:15%; cursor:pointer;">紹介</div>
  <div class="item" onclick="location.href='companyShowReview?companyId=${companyIntroduction.companyId}'" style="display:flex; justify-content:center; width:15%; cursor:pointer;">レビュー</div>
  <div class="item" style="display: flex; justify-content:center; width:15%; cursor:pointer;">掲示板</div>
  <div class="item" onclick="location.href='annualIncome/annualIncome?selectCompanyId=${companyIntroduction.companyId}'" style="display: flex; justify-content:center; width:15%; cursor:pointer;">年棒</div>
  <div class="item" style="display: flex; justify-content:center; width:15%; cursor:pointer;">ニュース</div>
  
  
</div>
<div class="ui bottom attached active tab segment">
  <div	style="width:100%; border:1px;">
  		<table class="tabtable" border="1" style="width:100%; margin:0 auto; padding:30px"><!--마진은되도록 쓰지말자  -->
  		
	    <tr><td>${companyIntroduction.companyName }  会社紹介</td></tr>
		<tr><td > ホムページ</td><td style="width:300px;">${companyIntroduction.companyHomepage }</td><td>業界</td><td>${companyIntroduction.businessTypeName }</td></tr>
		
		<tr><td >本社</td><td>${companyIntroduction.companyAddress}</td><td>設立</td><td><fmt:formatDate value="${companyIntroduction.foundingDate}" pattern="yyyy" /></td></tr>
		<tr><td >職員数</td><td>${companyIntroduction.workersCount }</td></tr>
		<tr><td >${companyIntroduction.companyExplain }</td></tr>
		
	    </table>
  
  </div>
</div>		
	
	
	
</div>	

</body>

</html>