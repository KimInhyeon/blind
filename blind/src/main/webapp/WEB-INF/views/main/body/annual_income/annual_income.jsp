<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<div>
		<div> <h3>${companyProfile[0].companyName}</h3>の給料情報 </div>
		<div> <strong>${companyProfile[0].companyName}の給料情報を職群別に確認してみてください。</strong> </div>


		<!-- 직군별 연봉정보 출력 탭 -->
		<div>
			<!-- selectBox : 직군들 출력 및 택1가능.-->
			<select id="selectGroupList" style="width:50%;height:25px;">
				<option value="-1">職群全体</option> <!-- 전체는 무조건 사용되므로 무조건 적용. -->
				<c:forEach items="${jobGroupList}" var="menuData">
					<option value="${menuData.jobGroupCode}"> ${menuData.jobGroupName} </option>
				</c:forEach>
			</select>	
			
			<div>
				<!--  그라데이션 bar 바로 밑의 연봉 -->
				<div>						
					<div style="float:left; margin:10px;"> 最小値給料  ${ annualIncomeData[0].minAnnualIncome } </div>
					<div style="float:left; margin:10px;"> 中央値給料  ${ annualIncomeData[0].avgAnnualIncome } </div>
					<div style="float:left; margin:10px;"> 最大値給料  ${ annualIncomeData[0].maxAnnualIncome } </div>
				</div>			
				<!-- 연봉정보 표 -->
				<div>					
					<table class="ui celled table">
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
							    <td> ${ annualIncomeData[0].avgAnnualIncome } </td>
							    <td> ${ annualIncomeData[0].minAnnualIncome } ~ ${ annualIncomeData[0].maxAnnualIncome } </td>
							</tr>
						 </tbody>
					</table>
				</div>	
			</div>
		</div>   		
	</div>	
</body>
</html>