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
		
	#income_table{  /*연봉차트 밑의 연봉 테이블*/
	    width:489px; 
	    margin-top:2%;
		clear: both;	
	}
	
	#annual_income_graph_wrap {
	    position:relative;
	    width:500px;
	    height:60px;
	}
	
	#annual_income_graph_bar {
	    width:500px;
	    text-align : center;
	}
	
	#annual_income_graph_min {
	    width:70px;			/* 텍스트 구간설정 */
	    position:absolute;
	    left:2%;			/* 텍스트 배치위치 조정*/
	}
	
	#annual_income_graph_median {
	    width:70px;			/* 텍스트 구간설정 */
	    position:absolute;
	    left:47%;			/* 텍스트 배치위치 조정*/
	}
	
	#annual_income_graph_max {
	    width:70px;			/* 텍스트 구간설정 */
	    position:absolute;
	    left:88%;			/* 텍스트 배치위치 조정*/
	    text-align:right;	/*오른쪽 들여쓰기적용*/    
	}
</style>
<script>	
$(function(){
	//1개의 직군을 선택하면 선택한 직군에 따라 연봉값들을 리턴.
	$("#selectGroupList").on('change', function(){	
		var companyId = ${companyProfile[0].companyId};
		alert("companyId : "+companyId);
		var jobGroupCode= $("#selectGroupList option:selected").val();
		alert("jobGroupCode:"+jobGroupCode);
		
    	$.ajax({
			type:"POST",
		    url: "viewAnnualIncomeBySelectedJobGroupCode",
			data : { companyId      //기업id(기업구분용)
					 ,jobGroupCode 	//-1:전체직군. -1이외는 선택된 직군코드에 대한 직군연봉만 출력.
			 	   },
			dataType:"json",
			success: function(result){

				//1.그래프 밑의 연봉정보(annual_income_graph_undertext) 업데이트
				$(annual_income_graph_undertext).html("");//초기화
				//리턴받은 해당 직군의 값으로 재구성
				//css style을 각 div마다 직접기입.(초기의 css가 적용되지 않음)
				$(annual_income_graph_undertext).append("<div id='annual_income_graph_min' style='width:70px; position:absolute; left:2%;'>"
													+"最小" 
													+"<div>" + result[0].minAnnualIncome + "万円</div>" 
						    					+"</div>"
						    					+"<div id='annual_income_graph_median' style='width:70px; position:absolute; left:47%;'>"
													+"中央"  
													+"<div>" + result[0].avgAnnualIncome + "万円</div>"
						    					+"</div>"
						    					+"<div id='annual_income_graph_max' style='width:70px; position:absolute; left:84%; text-align:right; '>"
													+"最大"  
													+"<div>" + result[0].maxAnnualIncome +"万円</div>"
							    				+"</div>");
			
			
				//2.연벙표(annual_income_table)내의 연봉데이터 업데이트
				$(annual_income_table).html(""); //초기화
				//리턴받은 해당 직군의 값으로 재구성
				$(annual_income_table).append("<table class='ui celled table'  id='income_table'>"
										+"<thead>"
											+"<tr>"								
												+"<th>報償</th>"
												+"<th>中央値給料</th>"
												+"<th>範囲</th>"
											+"</tr>"
										+"</thead>"
										+"<tbody>" 											
						    				+"<tr>"
												+"<td> 給料 </td>"
									    		+"<td>" + result[0].avgAnnualIncome +" 万円" + "</td>"
									   	 		+"<td>" + result[0].minAnnualIncome +" 万円" + " ~ " + result[0].maxAnnualIncome + " 万円" + "</td>"
									   	 	+"</tr>"
								 		+"</tbody>"
									+"</table>");		 
			},
		    error:function(request,status,error){
	   	    	alert("システムエラーです。管理者にお問い合わせください。");
		    	
		    	//에러내용출력 코드.
	   	    	//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		    	
			}				
		});
	}); 	
}); 	
</script>	
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
  <div class="item" onclick="location.href='${pageContext.request.contextPath}/companyIntroduction?companyId=${companyProfile[0].companyId}'" style="display:flex; justify-content:center; width:15%; cursor:pointer;">紹介</div>
  <div class="item" onclick="location.href='${pageContext.request.contextPath}/companyShowReview?companyId=${companyProfile[0].companyId}'" style="display:flex; justify-content:center; width:15%; cursor:pointer;">レビュー</div>
  <div class="item" style="display:flex; justify-content:center; width:15%; cursor:pointer;">掲示板</div>
  <div class="active item" onclick="location.href='${pageContext.request.contextPath}/annualIncome/annualIncome?selectCompanyId=${companyProfile[0].companyId}'" style="display:flex; justify-content:center; width:15%; cursor:pointer;">年棒</div>
  <div class="item" style="display:flex; justify-content:center; width:15%; cursor:pointer;">ニュース</div>
  
  
</div>
<div class="ui bottom attached active tab segment">
	<div style="margin:3%;"> <!-- 전체적 공통 여백 적용 -->
		<div style="margin-top:1.3%;">
			<div> 
				<span style = " font-size:1.5em; ">
					${companyProfile[0].companyName}
				</span>
				の給料情報
			</div>
			
			<div style="margin-top:1.3%;">
				<span style = " font-size:1.2em; ">		
					${companyProfile[0].companyName}の給料情報を職群別に確認してみてください。
				</span>
			</div>
		</div>
		
		<!-- 직군별 연봉정보 출력 탭 -->
		<div style="margin-top:2%; float:left; display:contents;">
			<!-- 직군들 출력 및 택1가능. -->
			<div style="padding: 20px;">
			<select class="ui dropdown" id="selectGroupList" style="width:489px; margin-left:2%;">
				<option value="-1">職群全体</option> <!-- 전체는 무조건 사용되므로 무조건 적용. -->
				
				<!-- 아래의 c:forEach 반복문에서 DB에서 로드한 직군들을 출력. -->
				<!-- 입력연봉값이 1개라도 없는 경우에는 비활성화처리하여 클릭되지 않도록 -->
				<c:forEach items="${jobGroupList}" var="menuData">
				<c:choose>
					<c:when test="${menuData.disableFlag eq '1' }">
						<option value="${menuData.jobGroupCode}"> ${menuData.jobGroupName} </option>
					</c:when>
					<c:otherwise>
						<option value="${menuData.jobGroupCode}" disabled> ${menuData.jobGroupName} &lt; Coming Soon &gt;</option>
					</c:otherwise>
				</c:choose>
				</c:forEach>
			</select>
			<!-- 연봉정보가 나오는 영역 -->
			<div style="margin:2%;"> 
				<!--  그라데이션 bar 및 연봉정보 -->
				<div id="annual_income_graph_wrap">
						<div id="annual_income_graph_bar">
							<img src="${pageContext.request.contextPath}/resources/images/annual_income_image.png"
							style="margin-left: auto; margin-right: auto;"/>
						</div>
	    				<div id="annual_income_graph_undertext">	
		    				<div id="annual_income_graph_min">
								最小  
								<div>${ annualIncomeData[0].minAnnualIncome }万円</div> 
		    				</div>
		    				<div id="annual_income_graph_median">
								中央  
								<div>${ annualIncomeData[0].avgAnnualIncome }万円</div>
		    				</div>
		    				<div id="annual_income_graph_max" style="margin-left:-20px;">
								最大  
								<div>${ annualIncomeData[0].maxAnnualIncome }万円</div>
		    				</div>    
	    				</div>
				</div>			
					<!-- 연봉정보 표 -->
					<div id="annual_income_table">					
						<table class="ui celled table" id="income_table">
							<thead>
			    				<tr>
			    					<th>報償	</th>
						    		<th>中央値給料</th>
							    	<th>範囲</th>
							  	</tr>
							 </thead>
							 <tbody>
				    			<tr>
									<td> 給料 </td>
								    <td> ${ annualIncomeData[0].avgAnnualIncome } 万円 </td>
								    <td> ${ annualIncomeData[0].minAnnualIncome } 万円 ~ ${ annualIncomeData[0].maxAnnualIncome } 万円</td>
								</tr>
							 </tbody>
						</table>
					</div>
				</div>
			</div>
		</div>   		
	</div>
</div>	
</div>	
</body>
</html>