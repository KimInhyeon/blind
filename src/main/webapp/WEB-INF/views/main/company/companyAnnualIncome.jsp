<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.tabtable tr td {
		border: none;
		padding-top: 10px;
	}

	#income_table { <%--연봉차트 밑의 연봉 테이블--%>
		width: 489px;
		margin-top: 2%;
		clear: both;
	}

	#annual_income_graph_wrap {
		position: relative;
		width: 500px;
		height: 60px;
	}

	#annual_income_graph_bar {
		width: 500px;
		text-align: center;
	}

	#annual_income_graph_min {
		width: 70px; <%-- 텍스트 구간설정 --%>
		position: absolute;
		left: 2%; <%-- 텍스트 배치위치 조정--%>
	}

	#annual_income_graph_median {
		width: 70px; <%-- 텍스트 구간설정 --%>
		position: absolute;
		left: 47%; <%-- 텍스트 배치위치 조정--%>
	}

	#annual_income_graph_max {
		width: 70px; <%-- 텍스트 구간설정 --%>
		position: absolute;
		left: 88%; <%-- 텍스트 배치위치 조정--%>
		text-align: right; <%--오른쪽 들여쓰기적용--%>
	}
</style>

<%@ include file="/WEB-INF/views/main/company/companyMenu.jsp" %>
<div class="ui container">
	<div class="ui bottom attached active tab segment">
		<div style="margin: 3%;"> <%-- 전체적 공통 여백 적용 --%>
			<div style="margin-top: 1.3%;">
				<div>
					<span style=" font-size: 1.5em;">${companyMenu.companyName}</span>の給料情報
				</div>

				<div style="margin-top: 1.3%;">
					<span style="font-size: 1.2em;">${companyMenu.companyName}の給料情報を職群別に確認してみてください。</span>
				</div>
			</div>

			<%-- 직군별 연봉정보 출력 탭 --%>
			<div style="margin-top: 2%; float: left; display: contents;">
				<%-- 직군들 출력 및 택1가능. --%>
				<div style="padding: 20px;">
					<select class="ui dropdown" id="selectGroupList" style="width: 489px; margin-left: 2%;">
						<option value="00">職群全体</option>
					<c:forEach var="job" items="${jobGroupList}">
						<option value="${job.jobGroupCode}"<c:if test="${not job.exist}"> disabled</c:if>>
							${job.jobGroupName}<c:if test="${not job.exist}"> &lt; Coming Soon &gt;</c:if>
						</option>
					</c:forEach>
					</select>
					<%-- 연봉정보가 나오는 영역 --%>
					<div style="margin: 2%;">
						<%-- 그라데이션 bar 및 연봉정보 --%>
						<div id="annual_income_graph_wrap">
							<div id="annual_income_graph_bar">
								<img src="resources/images/annual_income_image.png"
										style="margin-left: auto; margin-right: auto;">
							</div>
							<div id="annual_income_graph_undertext">
								<div id="annual_income_graph_min">
									最小
									<div>${annualIncome.minAnnualIncome}万円</div>
								</div>
								<div id="annual_income_graph_median">
									中央
									<div>${annualIncome.avgAnnualIncome}万円</div>
								</div>
								<div id="annual_income_graph_max" style="margin-left: -20px;">
									最大
									<div>${annualIncome.maxAnnualIncome}万円</div>
								</div>
							</div>
						</div>
						<%-- 연봉정보 표 --%>
						<div id="annual_income_table">
							<table class="ui celled table" id="income_table">
								<thead>
								<tr>
									<th>報償</th>
									<th>中央値給料</th>
									<th>範囲</th>
								</tr>
								</thead>
								<tbody>
								<tr>
									<td>給料</td>
									<td>${annualIncome.avgAnnualIncome}万円</td>
									<td>${annualIncome.minAnnualIncome} 万円 ~ ${annualIncome.maxAnnualIncome} 万円</td>
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

<script>
	addEventListener("DOMContentLoaded", function () {
		document.getElementById("selectGroupList").addEventListener("change", function () {
			fetch("company/annualIncome/${companyMenu.companyId}/" + this.value, {
				method: "GET"
			}).then(function (response) {
				if (response.ok) {
					return response.json();
				}
				throw response.status;
			}).then(function (annualIncome) {
				document.getElementById("annual_income_graph_min").innerHTML =
					"最小<div>" + annualIncome.minAnnualIncome + "万円</div>";
				document.getElementById("annual_income_graph_median").innerHTML =
					"中央<div>" + annualIncome.avgAnnualIncome + "万円</div>";
				document.getElementById("annual_income_graph_max").innerHTML =
					"最大<div>" + annualIncome.maxAnnualIncome + "万円</div>";
				document.querySelector("#income_table > tbody > tr").innerHTML =
					"<td>給料</td><td>" + annualIncome.avgAnnualIncome + "万円</td><td>" +
					annualIncome.minAnnualIncome + " 万円 ~ " + annualIncome.maxAnnualIncome + " 万円</td>";
			}).catch(function (error) {
				console.log(error);
				alert("システムエラーです。管理者にお問い合わせください。");
			});
		});
	});
</script>