<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css">
	
	<style>
	#income_table{
	    width:489px;
	    margin-top:2%;
		clear: both;	
	}
	
	#container {
	    position:relative;
	    width:489px;
	    height:110px;
		background:#555566; 
	}
	#container div {
	    width:200px;
	}
	#left {
	    position:absolute;
	    left:0%;
	    bottom:0px;
	}
	#center {
	    position:absolute;
	    left:45%;
	    bottom:0px;
	}
	#right {
	    position:absolute;
	    left:90%;
	    bottom:0px;
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

					//1.그래프 밑의 연봉정보(annual_income_graph) 업데이트
					$(annual_income_graph).html("");//초기화
					//리턴받은 해당 직군의 값으로 재구성
					$(annual_income_graph).append("<div id='left'>"
														+"最小" 
														+"<div>" + result[0].minAnnualIncome + "万円</div>" 
							    					+"</div>"
							    					+"<div id='center'>"
														+"中央"  
														+"<div>" + result[0].avgAnnualIncome + "万円</div>"
							    					+"</div>"
							    					+"<div id='right'>"
														+"最大"  
														+"<div>" + result[0].maxAnnualIncome +"万円</div>"
								    				+"</div>");
				
				
					//2.연벙표(annual_income_table)내의 연봉데이터 업데이트
					$(annual_income_table).html(""); //초기화
					//리턴받은 해당 직군의 값으로 재구성
					$(annual_income_table).append("<table class='ui celled table'  id='income_table'>"
											+"<thead>"
												+"<tr>"								
													+"<th>type</th>"
													+"<th>中央値給料</th>"
													+"<th>範囲</th>"
												+"</tr>"
											+"</thead>"
											+"<tbody>" 											
							    				+"<tr>"
													+"<td> 契約給料 </td>"
										    		+"<td>" + result[0].avgAnnualIncome + "</td>"
										   	 		+"<td>" + result[0].minAnnualIncome + "~" + result[0].maxAnnualIncome + "</td>"
										   	 	+"</tr>"
									 		+"</tbody>"
										+"</table>");		 
				},
			    error:function(request,status,error){
			    	//에러를 파악하기 위한 코드 기입.
		   	    	alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					//출처: https://shonm.tistory.com/454 [정윤재의 정리노트]
				}				
			});
		}); 	
	}); 	
	</script>	

</head>

<body>
	<div style="margin:3%;"> <!-- 전체적 공통 여백 적용 -->
		<div style="margin-top:1.3%;"> <!-- 시작부분과  -->
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
		<div style="margin-top:2%; float:left;">
			<!-- 직군들 출력 및 택1가능. -->
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
				<div>
					<div id="container">
						<img src="${pageContext.request.contextPath}/resources/images/annual_income_image.jpg"/>
	    				<div id="annual_income_graph">	
		    				<div id="left">
								最小  
								<div>${ annualIncomeData[0].minAnnualIncome }万円</div> 
		    				</div>
		    				<div id="center">
								中央  
								<div>${ annualIncomeData[0].avgAnnualIncome }万円</div>
		    				</div>
		    				<div id="right">
								最大  
								<div>${ annualIncomeData[0].maxAnnualIncome }万円</div>
		    				</div>    
	    				</div>
					</div>
				</div>			
					<!-- 연봉정보 표 -->
					<div id="annual_income_table">					
						<table class="ui celled table" id="income_table">
							<thead>
			    				<tr>
			    					<th>type</th>
						    		<th>中央値給料</th>
							    	<th>範囲</th>
							  	</tr>
							 </thead>
							 <tbody>
				    			<tr>
									<td> 契約給料 </td>
								    <td> ${ annualIncomeData[0].avgAnnualIncome } 万円 </td>
								    <td> ${ annualIncomeData[0].minAnnualIncome } 万円 ~ ${ annualIncomeData[0].maxAnnualIncome } 万円</td>
								</tr>
							 </tbody>
						</table>
					</div>
			</div>
		</div>   		
	</div>	
</body>
</html>