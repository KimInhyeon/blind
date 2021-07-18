<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="jp">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	$(function(){
	$("#companyName").on('keyup', function(){	
		 $('#hdnCompanyFlag').val("-1");
		var companyName= $("#companyName").val();
		
    	$.ajax({
			type:"POST",
		    url: "/blind/searchCompanyByCompanyName",
			data : { companyName : companyName
 	 	    },
			dataType:"json",
			success: function(result){
			
			 var resultHtml="";


			 $('#selectList').html("");
			
			 if(companyName != ""){
				 
				 $.each(result, function (key, value) {	
					  console.log(key);
					  console.log(value.companyName);
					  resultHtml = resultHtml + '<div class="item" style="display:flex;" onclick="companyNameClick(\''+value.companyId+'★'+value.companyName+'\')"><img class="ui avatar image" src="${pageContext.request.contextPath}/resources/images/company/'+value.companyId+'.png"><div class="content"><div class="header">'+value.companyName+'</div></div></div>'					  
				});
					 $('#selectList').append(resultHtml);
					 
					 
					 
					 
					 
				}else{
					
					
					 $('#companyImg').html("");
						resultHtml = resultHtml + '<img src="${pageContext.request.contextPath}/resources/images/logo1.png" width="90" height="90""></img>';
						$('#companyImg').append(resultHtml);
					
				}
			 },
			error: function(){
				alert("에러");
				
			}				
		});
	});

});
	function companyNameClick(companyInfo){
		
		var companyArr = companyInfo.split('★');//리턴형이 어레이 배열형
		
		var resultHtml1 = "";
	    $('#companyImg').html("");
		resultHtml1 = resultHtml1 + '<img  src="${pageContext.request.contextPath}/resources/images/company/'+companyArr[0]+'.png" width="90" height="90""></img>';
		 
		$('#companyImg').append(resultHtml1);
		$('#companyName').val(companyArr[1]); 		 
		$('#selectList').html("");		 
		$('#hdnCompanyFlag').val(1);
		$('#hdnCompanyId').val(companyArr[0]);
	};

	function selectStartDate(){
		var startDate=$("#startDate option:selected").val();
		document.getElementById("hdnStartDate").value = startDate;
	}
	function selectFinishDate(){
		var finishDate=$("#finishDate option:selected").val();
		document.getElementById("hdnFinishDate").value = finishDate;
	}

	$(document).ready(function () {

	    $("input[name='rating2']").click(function () {
	    	var careerPoint = $("input[name=rating2]:checked").val();
	    	document.getElementById("hdnCareerPoint").value = careerPoint;        
	    });
	    $("input[name='rating3']").click(function () {
	    	var workLifeBalancePoint = $("input[name=rating3]:checked").val();
	    	document.getElementById("hdnWorkLifeBalancePoint").value = workLifeBalancePoint;        
	    });
	    $("input[name='rating4']").click(function () {
	    	var payPoint = $("input[name=rating4]:checked").val();
	    	document.getElementById("hdnPayPoint").value = payPoint;        
	    });
	    $("input[name='rating5']").click(function () {
	    	var companyCulturePoint = $("input[name=rating5]:checked").val();
	    	document.getElementById("hdnCompanyCulturePoint").value = companyCulturePoint;        
	    });
	    $("input[name='rating6']").click(function () {
	    	var headPoint = $("input[name=rating6]:checked").val();
	    	document.getElementById("hdnHeadPoint").value = headPoint;        
	    }); 
	});
	
	function check(){
		var oneWriteReview=document.getElementById("oneWriteReview").value;
		var strongPoint=document.getElementById("strongPoint").value;
		var weakPoint=document.getElementById("weakPoint").value;
		var resignReason=document.getElementById("resignReason").value;
		var workArea = document.getElementById("workArea").value;
		
		 var companyFlag = $('#hdnCompanyFlag').val();
		 if(companyFlag == -1 || companyFlag ==""){
			 alert("会社名を入力してください");
			 return false;
		 }
		
 		if($("#hdnCareerPoint").val() == -1){
			alert("キャリア向上の点数を入力してください");
			return false;
		}
		if($("#hdnWorkLifeBalancePoint").val() == -1){
			alert("ワークライフバランスの点数を入力してください");
			return false;
		}
		if($("#hdnPayPoint").val() == -1){
			
			alert("給料と福祉の点数を入力してください");
			return false;
		}
		if($("#hdnCompanyCulturePoint").val() == -1){
			
			alert("社内文化の点数を入力してください");
			return false;
			
		}
		if($("#hdnHeadPoint").val() == -1){
			alert("経営陣の点数を入力してください");
			return false;
		} 
		if(oneWriteReview.length == '' || oneWriteReview.length == 0 || $.trim($("#oneWriteReview").val())==''){
			alert("簡単なコメントを入力してください");
			return false;
		}
		if(strongPoint.length == '' || strongPoint.length == 0||$.trim($("#strongPoint").val())==''){
			alert("長所を入力してください");
			return false;
		}
		if(weakPoint.length ==''|| weakPoint.length ==0||$.trim($("#weakPoint").val())==''){
			alert("短所を入力してください");
			return false;
		}
		if(resignReason.length == '' || resignReason.length ==0||$.trim($("#resignReason").val())==''){
			alert("転職理由を入力してください");
			return false;
			
		}
		
		if($("#hdnStartDate").val() == -1){
			alert("勤務開始日をチェックしてください");
			return false;	
		}
		if($("#hdnFinishDate").val() == -1){
			alert("終業日をチェックしてください");
			return false;	
		}
		if(workArea.length == '' || workArea.length ==0||$.trim($("#workArea").val())==''){
			alert("勤務先を入力してください");
			return false;
		}

		
		return true;
		
	}

</script>
</head>


<style>
	.star-rating{
	display: flex;
	flex-direction:row-reverse;
	font-size:2.25rem;
	line-height:2.5rem;
	justify-content:space-around;
	padding: 0 0.2em;
	text-align: center;
	width: 5em;	
	}

	/*기존 라디오 버튼 사라짐*/
	.star-rating input{
	display: none;
	}
	.star-rating label{
	-webkit-text-fill-color: transparent;
	-webkit-text-stroke-width:2.3px;
	-webkit-text-stroke-color:#2b2a29;
	cursor: pointer;
	
	}
	
	/*클릭시 변경*/
	.star-rating :checked ~ label{
	-webkit-text-fill-color: yellow;
	}
	
	/*호버시 변경*/
	.star-rating label:hover,
	.star-rating label:hover ~ label{
	-webkit-text-fill-color: yellow;
	}
	
	.box1{
	padding: 10px 15px 10px 16px;	
	width: 200px;
	}
 	
 	#title1{
	padding: 38px 40px 0px ;
	margin-bottom: 28px;
	}
	 
	.container{
	margin-right:24px;
	margin-left:24px;
	}
	

		
</style>



<body>
<div class="container">

<form class="ui form" id="reviewForm" name= "reviewForm" method="post" action="companyReviewWrite" onsubmit="return check();">



<div>
	<h2 id="title1">企業レビュー作成</h2>
	<div style = "display:inline-flex;">
	<span id="companyImg"><img src ="${pageContext.request.contextPath}/resources/images/logo1.png" alt="" width="90" height="90"></img></span>

	<div style = "margin-left:20px;">
	
	<h4>会社名</h4>
	<input type="text" class="box1" placeholder="会社名前で検索してください" id="companyName" name="companyName"><div id="selectList" style="position:absolute; background-color:#999999;"></div></input>
	
	</div>
	
	</div>

</div>

<h4 class="ui dividing header"></h4>

<h3>会社評価</h3>
<div class="field"  style="float:left; width:120px;"><label>キャリア向上</label></div>
<div class="star-rating " id="careerPoint">
<input type="radio" id="5-stars2" name="rating2" value="5" v-model="ratings2"/>
<label for="5-stars2" class="star2 pr-4">★</label>
<input type="radio" id="4-stars2" name="rating2" value="4" v-model="ratings2"/>
<label for="4-stars2" class="star2">★</label>
<input type="radio" id="3-stars2" name="rating2" value="3" v-model="ratings2"/>
<label for="3-stars2" class="star2">★</label>
<input type="radio" id="2-stars2" name="rating2" value="2" v-model="ratings2"/>
<label for="2-stars2" class="star2">★</label>
<input type="radio" id="1-stars2" name="rating2" value="1" v-model="ratings2"/>
<label for="1-stars2" class="star2">★</label>
</div>

<div class="field"  style="float:left; width:120px;"><label>ワークバランス</label></div>
<div class="star-rating space-x-4 mx-auto" id="workLifeBalancePoint">
<input type="radio" id="5-stars3" name="rating3" value="5" v-model="ratings3"/>
<label for="5-stars3" class="star pr-4">★</label>
<input type="radio" id="4-stars3" name="rating3" value="4" v-model="ratings3"/>
<label for="4-stars3" class="star">★</label>
<input type="radio" id="3-stars3" name="rating3" value="3" v-model="ratings3"/>
<label for="3-stars3" class="star">★</label>
<input type="radio" id="2-stars3" name="rating3" value="2" v-model="ratings3"/>
<label for="2-stars3" class="star">★</label>
<input type="radio" id="1-stars3" name="rating3" value="2" v-model="ratings3"/>
<label for="1-stars3" class="star">★</label>
</div>

<div class="field" style="float:left; width:120px;"><label>給料と福祉</label></div>
<div class="star-rating space-x-4 mx-auto" id="payPoint">
<input type="radio" id="5-stars4" name="rating4" value="5" v-model="ratings4"/>
<label for="5-stars4" class="star pr-4">★</label>
<input type="radio" id="4-stars4" name="rating4" value="4" v-model="ratings4"/>
<label for="4-stars4" class="star">★</label>
<input type="radio" id="3-stars4" name="rating4" value="3" v-model="ratings4"/>
<label for="3-stars4" class="star">★</label>
<input type="radio" id="2-stars4" name="rating4" value="2" v-model="ratings4"/>
<label for="2-stars4" class="star">★</label>
<input type="radio" id="1-stars4" name="rating4" value="2" v-model="ratings4"/>
<label for="1-stars4" class="star">★</label>
</div>

<div class="field" style="float:left; width:120px;"><label>社内文化</label></div>
<div class="star-rating space-x-4 mx-auto" id="companyCulturePoint">
<input type="radio" id="5-stars5" name="rating5" value="5" v-model="ratings5"/>
<label for="5-stars5" class="star pr-4">★</label>
<input type="radio" id="4-stars5" name="rating5" value="4" v-model="ratings5"/>
<label for="4-stars5" class="star">★</label>
<input type="radio" id="3-stars5" name="rating5" value="3" v-model="ratings5"/>
<label for="3-stars5" class="star">★</label>
<input type="radio" id="2-stars5" name="rating5" value="2" v-model="ratings5"/>
<label for="2-stars5" class="star">★</label>
<input type="radio" id="1-stars5" name="rating5" value="2" v-model="ratings5"/>
<label for="1-stars5" class="star">★</label>
</div>

<div class="field" style="float:left; width:120px;"><label>経営陣</label></div>
<div class="star-rating space-x-4 mx-auto" id="headPoint">
<input type="radio" id="5-stars6" name="rating6" value="5" v-model="ratings6"/>
<label for="5-stars6" class="star pr-4">★</label>
<input type="radio" id="4-stars6" name="rating6" value="4" v-model="ratings6"/>
<label for="4-stars6" class="star">★</label>
<input type="radio" id="3-stars6" name="rating6" value="3" v-model="ratings6"/>
<label for="3-stars6" class="star">★</label>
<input type="radio" id="2-stars6" name="rating6" value="2" v-model="ratings6"/>
<label for="2-stars6" class="star">★</label>
<input type="radio" id="1-stars6" name="rating6" value="2" v-model="ratings6"/>
<label for="1-stars6" class="star">★</label>
</div> 
 

 <h4 class="ui dividing header"></h4>
 
 <h3>レビュー作成する</h3>
 <div class="field"><label>簡単なコメント</label>
 <input type="text" class="box1" placeholder="例:ワークバランスをよく守る部署" maxlength="60" id="oneWriteReview" name="oneWriteReview" ></input></div>
 <div class="field"><label>長点</label>
 <textarea cols="10" rows="4" placeholder="この会社に働きながら一番良かったのは何でしょうか" id="strongPoint" name="strongPoint"></textarea></div>
 <div class="field"><label>短所</label>
 <textarea cols="10" rows="4" placeholder="この会社に働きながら一番大変だったのは何でしょうか" id="weakPoint" name="weakPoint"></textarea></div>
 <div class="field"><label>転職理由</label>
 <textarea cols="10" rows="4" placeholder="この会社止めるきっかけは 何でしょうか?" id="resignReason" name="resignReason"></textarea></div>
<h4 class="ui dividing header"></h4>
<h3>作成社の情報</h3>
	
  <div class="field">
    <label>認証状態</label>
    
      <div class="field">
        <input type="text" readonly placeholder="前社員">
      </div>
 
  </div>

  <div class="two fields">
    <div class="field">
      <label>勤務開始日</label>
    <select id= "startDate" class="ui fluid dropdown"  onchange="selectStartDate();">  
    <option>選んでください</option>
    <option value="2021">2021</option>
    <option value="2020">2020</option>
    <option value="2019">2019</option>
    <option value="2018">2018</option>
    <option value="2017">2017</option>
    <option value="2016">2016</option>
    <option value="2015">2015</option>
    <option value="2014">2014</option>
    <option value="2013">2013</option>
    <option value="2012">2012</option>
    <option value="2011">2011</option>
    <option value="2010">2010</option>
    <option value="2009">2009</option>
    <option value="2008">2008</option>
    <option value="2007">2007</option>
    <option value="2006">2006</option>
    <option value="2005">2005</option>
    <option value="2004">2004</option>
    <option value="2003">2003</option>
    <option value="2002">2002</option>
    <option value="2001">2001</option>
    <option value="2000">2000</option>
    <option value="1999">1999</option>
    <option value="1998">1998</option>
    <option value="1997">1997</option>
    <option value="1996">1996</option>
    <option value="1995">1995</option>
    <option value="1994">1994</option>
  </select>
  	 
    </div>
    <div class="field">
    <label>勤務終業日</label>
      
       <select id="finishDate" class="ui fluid dropdown" onchange="selectFinishDate();">
        <option>選んでください</option>
        <option value="2021">2021</option>
        <option value="2020">2020</option>
        </select>
          
    </div>
  </div>
 <div class="field">
     <label>勤務先</label>
    
      <div class="field">
        <input type="text" name="workArea" id = "workArea" placeholder="例: 東京">
      </div>
 </div>
 
 <h4 class="ui dividing header"></h4>
 
 
<input type="hidden" id="hdnStartDate" name="hdnStartDate" value="-1"></input>	
<input type="hidden" id="hdnFinishDate" name="hdnFinishDate" value="-1"></input>
<input type="hidden" id="hdnCareerPoint" name="hdnCareerPoint" value="-1"></input>
<input type="hidden" id="hdnWorkLifeBalancePoint" name="hdnWorkLifeBalancePoint"  value="-1"></input>
<input type="hidden" id="hdnPayPoint" name="hdnPayPoint" value="-1"></input>
<input type="hidden" id="hdnCompanyCulturePoint" name="hdnCompanyCulturePoint" value="-1"></input>
<input type="hidden" id="hdnHeadPoint" name="hdnHeadPoint" value="-1"></input>
<input type="hidden" id="hdnCompanyFlag" name ="hdnCompanyFlag" value="-1"></input>
<input type="hidden" id="hdnCompanyId" name ="hdnCompanyId" value="-1"></input>
  <input class="ui primary button" type="submit" placeholder="submit" ></input>
 </form>

</div>
</body>
</html>