<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<title></title>
<script>
	function searchCompany() {
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
        	  '<div style="display:flex;" onclick="companyNameClick(\''+companyArr+'\');" ><img class="ui avatar image" src="${pageContext.request.contextPath}/resources/images/company/'+companyArr[1]+'.png"><div class="content"><div class="header">'+companyArr[0]+'</div></div></div>';
              
              
          }
          result = $(".filterUL li:contains('"+searchKeyword+"')").show();
          $('#selectList').append(resultHtml);
          
          }  
	};

    function companyNameClick(companyInfo){
    	var companyArr = companyInfo.split(',');
    	
    	$('#selectList').html("");
    	$('#searchKeyword').val(companyArr[0]);
    	
    	location.href='${pageContext.request.contextPath}/companyIntroduction?companyId=' + companyArr[1];
	 }; 
</script>
<style>
.companysearchbox{
		padding:60px;
		align:center;		
	}
    .companysearchbox p{
        font-size:17px;
    }
	#searchbox{border-radius:50px; font-size:23px;}
	#searchKeyword{border-radius:50px; border-color:black;}
    #searchKeyword::placeholder{font-size:15px; padding-left:15px;}
	#box{width:65%; padding:30px 0;}
    .companyapplymain a{
        color:black;
    }
	#apply{text-decoration:underline;}
	#companybackground{
	 background-color:#ebf7fa;
	 height:270px;
     margin-top:30px;
	}
    #imagetextback{
    height: 320px;
    top:-45px;
    background-position: 480px 0px;
    background-size: 618px 320px;
    position:relative;

    }
	#searchicon{padding-left:70px;}
    .bestcompanyname{font-size:15px; font-weight:700; color:black;}
    .div_star{padding-top:6px;}
    .div_tab{padding-top:8px;}
    .div_tab a{font-size:13px; padding-left:11px;}
    .div_tab a:first-child{padding-left:0px;}
    #bestcompanygrid .column:last-child{margin-bottom:100px;}
</style>

</head>




<body>
	<div class="ui container">
        <div class="companysearchbox" align="center" >
    <h1 >現職者たちの会社レビュー。</h1>
    <p>実際の職員たちが評価する年俸と福祉はどうなのか確認してみてください。</p>
    
    <form name="searchForm" action="/blind/companyReviewMain" method="post" onsubmit="return false;">

    <div class="ui fluid big left icon input" id="box">
    <input class="prompt" type="text" id="searchKeyword" name="searchKeyword" onkeyup = "searchCompany()" placeholder="会社の名前を入力してください。" ></input>
    <i class="search icon" id="searchicon"></i>
    <div class="ui middle aligned selection list" id="selectList" style="margin-top: 65px;font-size: 0.8em;background-color:#999999;position:absolute;margin-left: 60px;"></div>
    </div>
    
    <div class="companyapplymain" align="center">
        お探しの会社がありませんか。<a href="#"> <span id=apply>知りたい会社を直接申し込んでください。</span></a>
        </div>
    </div>

    <ul class="filterUL" style="display: none;">
		<c:forEach items="${companyList}" var="company2">
			<li>${company2.companyName}★${company2.companyId }</li>
		</c:forEach>
	</ul>
   </form>
</div>

	<%-- <c:forEach items="${companyDto}" var="company">
	${company.companyName}
</c:forEach>  --%>
	<div class="ui fluid container" id="companybackground" >
    <div class="ui container" id="imagetextback">
    <h2 style="text-align:left; padding-top:130px;">私の会社をレビューする</h2>
    
    <p style="text-align:left;">会員様のレビューは、求職者が会社を
    検討するのに役立ちます。</p>
    <button class="ui blue button" onclick="location.href='companyReviewWrite'" style="float:left; margin-top:10px; padding:15px 30px;">レビュー作成</button> 
</div>
    </div>

<div class="ui container" style="padding-top:75px;">
    <h3 align="left" style="font-size:20px;">ベスト会社</h3>
    <div class="ui three column grid" style="padding-top:30px;" id="bestcompanygrid">

	<c:forEach items="${companyJoinPopular}" var="company3" varStatus="count">      
            <div class="column"><!--회사-->
                <div class="ui segment">
                    <div style="display:inline-block;">
                    <img class="ui tiny left floated image" src="${pageContext.request.contextPath}/resources/images/company/${company3.companyId}.png">
                        <div style="display:inline-block;">
                        <a class="bestcompanyname" href="${pageContext.request.contextPath}/companyIntroduction?companyId=${company3.companyId}" style="display:inline-block;">${company3.companyName}</a>
                            <div class="div_star"> 
                                <div class="ui star rating" data-rating="${company3.allPoint}" data-max-rating="5"></div>${company3.realAllPoint}
                            </div>
                            <div class="div_tab">
                                <a class="" href="${pageContext.request.contextPath}/companyShowReview?companyId=${company3.companyId}">レビュー</a>
                                <a class="" href="#">掲示板</a>
                                <a class="" href="/blind/companyShowReview?companyId=${company3.companyId}">年収</a>
                                <a class="" href="#">採用</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </c:forEach>
    </div>
    </div>
    
    <script>
        $("#searchKeyword").focus(function(){
      $(this).css("border-color", "black");
      $(this).css("border-width", "1px");
  });
      $("#searchKeyword").blur(function(){
      $(this).css("border-color", "");
      $(this).css("border-width", "");
  });
        $('.ui.rating')
        .rating('disable');

        function test(){
            var aa = $("#stars").children('.selected').length;
            alert(aa);
        }
  </script>


</body>
</html>