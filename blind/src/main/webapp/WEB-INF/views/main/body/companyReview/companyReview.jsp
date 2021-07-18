<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title></title>
<script>
	function searchCompany(){
		$('#selectList').html("");
		var searchKeyword = $('#searchKeyword').val();
		var resultHtml = "";
		var result = "";
        if (searchKeyword == "") {
            $('#selectList').html("");	
          } else {
          var check = $(".filterUL li:contains('"+searchKeyword+"')");//".filterUL li:contains('"+searchKeyword+"')"배열값이다.    
          for(var i =0 ; i<check.length;i++){
        	  var companyArr=check[i].outerText.split('★');
        	  resultHtml = resultHtml + 
        	  '<div style="display:flex;" onclick="companyNameClick(\''+companyArr[0]+'\');" ><img class="ui avatar image" src="${pageContext.request.contextPath}/resources/images/'+companyArr[1]+'.png"><div class="content"><div class="header">'+companyArr[0]+'</div></div></div>';
              
              
          }
          result = $(".filterUL li:contains('"+searchKeyword+"')").show();
          $('#selectList').append(resultHtml);
          
          }       
	};
	
    function companyNameClick(companyInfo){
    	$('#selectList').html("");
    	$('#searchKeyword').val(companyInfo);
	 }; 
	 
</script>
<style>
	.star{
	-webkit-text-fill-color: gold;
	-webkit-text-stroke-width: 1.0px;
	}
	.box{
		padding:60px;
		align:center;		
	}
	#searchbox{border-radius:50px; font-size:23px;}
	#searchKeyword{border-radius:20px;}
	#box{width:750px;}
	#apply{text-decoration:underline;}
	#background{
	 background-color:#ebf7fa;
	 height:200px;
	}
	#searchicon{padding-left:70px;}
</style>

</head>




<body>
<div class="box" align="center" >
<h1 >現職者たちの会社レビュー。</h1>
<div class="ui container">
<p >実際の職員たちが評価する年俸と福祉はどうなのか確認してみてください。</p>

</div>
<div class="box" style ="margin-right:24px;	margin-left:24px;">
<form name="searchForm" action="/blind/companyReviewMain" method="post" onsubmit="return false;">


<div class="ui fluid massive left icon input" id="box">
<input type="text" id="searchKeyword" name="searchKeyword" onkeyup = "searchCompany()" ></input>
<i class="search icon" id="searchicon"></i>
<div class="ui middle aligned selection list" id="selectList" style="margin-top: 65px;font-size: 0.8em;background-color:#999999;position:absolute;margin-left: 60px;"></div>
</div>
  
</div>

<%-- <c:forEach items="${companyDto}" var="company">
	${company.companyName}
</c:forEach>  --%>

<ul class="filterUL" style="display:none;">
<c:forEach items="${companyList}" var="company2">
	<li>${company2.companyName}★${company2.companyId }</li>
</c:forEach>
</ul>
</form>


<div class="box" align="center">
お探しの会社はありませんか <span id=apply>知りたい会社を直接申し込んでください</span>
</div>
<div class="box" id="background" >
<h2 style="text-align:left;">私の会社をレビューする</h2>

<p style="text-align:left;">会員様のレビューは、求職者が会社を
検討するのに役立ちます</p>
<button class="ui primary button" onclick="location.href='companyReviewWrite'" style="float:left;">レビュー作成</button> 

</div>


<div class="box">
<h3 align="left">ベスト会社</h3>


<table border="0" align="left" style="width: -webkit-fill-available;" id="popularCompany">

<tr>
<c:forEach items="${companyJoinPopular}" var="company3" varStatus="count">
  
   
      
      <td>
      <table border="1">
      <tr>
         <td rowspan="3" style="border:none;"><img src="${pageContext.request.contextPath}/resources/images/company/${company3.companyId}.png" width="90px" height="90px" ></td>
         <td style="border:none;">${company3.companyName}</td>
      </tr>
      <tr>
         <td style="border:none;">
        
			<c:if test="${company3.allPoint == 5}">
				<label class="star">★</label>
				<label class="star">★</label>
				<label class="star">★</label>
				<label class="star">★</label>
				<label class="star">★</label>(${company3.realAllPoint })
			
			</c:if>
			<c:if test="${company3.allPoint == 4}">
				<label class="star">★</label>

				<label class="star">★</label>
			
				<label class="star">★</label>
			
				<label class="star">★</label>(${company3.realAllPoint })
			
			</c:if>
			<c:if test="${company3.allPoint == 3}">

				<label class="star">★</label>
			
				<label class="star">★</label>
			
				<label class="star">★</label>(${company3.realAllPoint })
			
			</c:if>
			<c:if test="${company3.allPoint == 2}">

			
			
				<label class="star">★</label>
			
				<label class="star">★</label>(${company3.realAllPoint })
			
			</c:if>
			<c:if test="${company3.allPoint == 1}">
			
				<label class="star">★</label>(${company3.realAllPoint })
			
			</c:if>					
			
		</div>
         	
         	
          </td>
      </tr>
      <tr >
         <td style="border:none;"><a href=>掲示板</a>　<a href=>年収</a>　<a href=>レビュー</a>　<a href=>採用</a></td>
      </tr>
      </table>	 
	 </td>
<c:if test="${count.count%3 == 0}">

</tr>
<tr>
</c:if>	 
	 
  
</c:forEach>
</tr>

</table>

</div>


</div>
</body>
</html>