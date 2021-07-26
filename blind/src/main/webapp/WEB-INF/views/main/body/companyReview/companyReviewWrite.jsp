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
					  resultHtml = resultHtml + '<div class="item" style="display:flex;" onclick="companyNameClick(\''+value.companyId+'★'+value.companyName+'\')"><img class="ui avatar image" src="${pageContext.request.contextPath}/resources/images/company/'+value.companyId+'.png"><div class="content"><div class="header">'+value.companyName+'</div></div></div>'					  
				});
					 $('#selectList').append(resultHtml);
 
				}else{

					 $('#companyImg').html("");
						resultHtml = resultHtml + '<img src="${pageContext.request.contextPath}/resources/images/company/0.png" width="90" height="90""></img>';
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
		
		var imgPath = "${pageContext.request.contextPath}/resources/images/company/" +companyArr[0]+ ".png";
	    $("#companyReviewImg").attr("src", imgPath);
		 
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

	    $("div[id='ratingCareerPoint']").click(function () {
	    	var careerPoint = $("#ratingCareerPoint").children(".active").length;
	    	document.getElementById("hdnCareerPoint").value = careerPoint;        
	    });
	    $("div[id='ratingWorkLifeBalancePoint']").click(function () {
	    	var workLifeBalancePoint = $("#ratingWorkLifeBalancePoint").children(".active").length;
	    	document.getElementById("hdnWorkLifeBalancePoint").value = workLifeBalancePoint;        
	    });
	    $("div[id='ratingPayPoint']").click(function () {
	    	var payPoint = $("#ratingPayPoint").children(".active").length;
	    	document.getElementById("hdnPayPoint").value = payPoint;        
	    });
	    $("div[id='ratingCompanyCulturePoint']").click(function () {
	    	var companyCulturePoint = $("#ratingCompanyCulturePoint").children(".active").length;
	    	document.getElementById("hdnCompanyCulturePoint").value = companyCulturePoint;        
	    });
	    $("div[id='ratingHeadPoint']").click(function () {
	    	var headPoint = $("#ratingHeadPoint").children(".active").length;
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


	.box1{
	padding: 10px 15px 10px 16px;	
	width: 200px;
	}
 	
 	#title1{
	padding: 20px 0 10px 0;
	margin-bottom: 28px;
	}
	.div_star{
        padding-bottom:20px;
    }
    .field0{
        font-size:15px; font-weight: 700; padding-top:5px;
    }
    .field{
        font-size:15px;
    }
	.ui.menu{
		margin:0;	
	}

		
</style>



<body>


<div class="ui fluid container" style="background-color: #f6f7fa;">
    <div class="ui container" style="padding:50px 0px;">
        <div class="ui segment" >
        <div style="padding:40px;">
        <form class="ui form" id="reviewForm" name= "reviewForm" method="post" action="companyReviewWrite" onsubmit="return check();">
        <div>
            <h2 id="title1" style="padding-bottom:30px;">企業レビューを作成</h2>
            <img id="companyReviewImg" class="ui tiny left floated image" src ="${pageContext.request.contextPath}/resources/images/company/0.png" alt="" width="90" height="90" ></img>
            <h4>会社名</h4>
            <div class="ui fluid input">
            <input type="text" class="box1" placeholder="会社名前で検索してください" id="companyName" name="companyName"><div id="selectList" style="position:absolute; background-color:#999999;"></div></input>

        </div>

<h4 class="ui dividing header" style="padding-top:30px;"></h4>

<h3 style="font-size:22px; padding:10px 0;">会社評価</h3>
		<div style="padding-left:40px;">
        <div class="field0" style="float:left; width:120px;"><label>キャリア向上</label></div>
        <div class="div_star"> 
            <div class="ui massive star rating" id="ratingCareerPoint" data-rating="0" data-max-rating="5"></div>
        </div>
        
        <div class="field0"  style="float:left; width:120px;"><label>ワークバランス</label></div>
        <div class="div_star"> 
            <div class="ui massive star rating" id="ratingWorkLifeBalancePoint" data-rating="0" data-max-rating="5"></div>
        </div>
        
        <div class="field0" style="float:left; width:120px;"><label>給料と福祉</label></div>
        <div class="div_star"> 
            <div class="ui massive star rating" id="ratingPayPoint" data-rating="0" data-max-rating="5"></div>
        </div>
        
        <div class="field0" style="float:left; width:120px;"><label>社内文化</label></div>
        <div class="div_star"> 
            <div class="ui massive star rating" id="ratingCompanyCulturePoint" data-rating="0" data-max-rating="5"></div>
        </div>
        
        <div class="field0" style="float:left; width:120px;"><label>経営陣</label></div>
        <div class="div_star"> 
            <div class="ui massive star rating" id="ratingHeadPoint" data-rating="0" data-max-rating="5"></div>
        </div>
         </div>
        
       
        
        
 <h4 class="ui dividing header" style="margin-top:50px;"></h4>
 


 
 <h3 style="padding:15px 0; font-size:20px;">レビューを作成する</h3>
         <div class="field"><label>簡単なコメント</label>
         <input type="text" class="box1" placeholder="例:ワークバランスをよく守る部署" maxlength="60" id="oneWriteReview" name="oneWriteReview" ></input></div>
         <div class="field"><label>長所</label>
         <textarea cols="10" rows="5" placeholder="この会社に働きながら一番良かったのは何でしょうか" id="strongPoint" name="strongPoint" style="resize:none;"></textarea></div>
         <div class="field"><label>短所</label>
         <textarea cols="10" rows="5" placeholder="この会社に働きながら一番大変だったのは何でしょうか" id="weakPoint" name="weakPoint" style="resize:none;"></textarea></div>
         <div class="field"><label>転職理由</label>
         <textarea cols="10" rows="5" placeholder="この会社止めるきっかけは 何でしょうか?" id="resignReason" name="resignReason" style="resize:none;"></textarea></div>
        <h4 class="ui dividing header" style="margin-top:50px;"></h4>
        <h3 style="font-size:20px; padding:10px 0;">作成者の情報</h3>
            
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
         
         <h4 class="ui dividing header" style="margin-top:50px;"></h4>
         
         
        <input type="hidden" id="hdnStartDate" name="hdnStartDate" value="-1"></input>	
        <input type="hidden" id="hdnFinishDate" name="hdnFinishDate" value="-1"></input>
        <input type="hidden" id="hdnCareerPoint" name="hdnCareerPoint" value="-1"></input>
        <input type="hidden" id="hdnWorkLifeBalancePoint" name="hdnWorkLifeBalancePoint"  value="-1"></input>
        <input type="hidden" id="hdnPayPoint" name="hdnPayPoint" value="-1"></input>
        <input type="hidden" id="hdnCompanyCulturePoint" name="hdnCompanyCulturePoint" value="-1"></input>
        <input type="hidden" id="hdnHeadPoint" name="hdnHeadPoint" value="-1"></input>
        <input type="hidden" id="hdnCompanyFlag" name ="hdnCompanyFlag" value="-1"></input>
        <input type="hidden" id="hdnCompanyId" name ="hdnCompanyId" value="-1"></input>
          <button class="ui primary button" type="submit" placeholder="submit" style="padding:15px 80px; margin-top:30px;">提出</button>
         </form>
        </div>
        </div>
    </div>
</div>
<script>
    $('.ui.rating')
        .rating();
</script>
</body>
</html>