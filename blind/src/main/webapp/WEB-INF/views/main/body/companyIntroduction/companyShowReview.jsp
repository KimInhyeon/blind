<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title></title>


	<script>
		$(document).ready(function() {
			$('#sample')
					.popup({
						on: 'click'
					});
			$("#sample").children().on('click', function(){
				var abc = $('#sample div').slice(1);

				console.log(abc);
			});

		});
		function countUp(companyReviewId){

			$.ajax({
				type:"POST",
				url: "helpCountUp",
				data : { companyId : "${companyIntroduction.companyId}"
					,companyReviewId : companyReviewId
				},
				dataType:"json",
				success: function(result){

				},
				error: function(){
					alert("에러");
				}
			});
		};
	</script>



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
		<div class="item" onclick="location.href='companyIntroduction?companyId=${companyIntroduction.companyId}'" style="width:15%;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;紹介</div>
		<div class="active item" onclick="location.href='companyShowReview?companyId=${companyIntroduction.companyId}'" style="width:15%; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;レビュー</div>
		<div class="item" style="width:15%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;掲示板</div>
		<div class="item" style="width:15%;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年棒</div>
		<div class="item" style="width:15%;" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ニュース</div>
	</div>
	<div class="ui bottom attached active tab segment">
		<div	style="width:100%; border:1px;">
			<table class="tabtable" border="1" style="width:100%; margin:15px auto; padding:30px"><!--마진은되도록 쓰지말자  -->

				<tr><td>${companyIntroduction.companyName }レビュー</td></tr>
				<tr>
					<td>${companyAverageDto.allPoint}</td>
					<td>
						<c:if test="${companyAverageDto.allPoint == 5.0}">
							<label class="star">★</label>
							<label class="star">★</label>
							<label class="star">★</label>
							<label class="star">★</label>
							<label class="star">★</label>

						</c:if>
						<c:if test="${companyAverageDto.allPoint == 4.0}">
							<label class="star">★</label>

							<label class="star">★</label>

							<label class="star">★</label>

							<label class="star">★</label>

						</c:if>
						<c:if test="${companyAverageDto.allPoint == 3.0}">

							<label class="star">★</label>

							<label class="star">★</label>

							<label class="star">★</label>

						</c:if>
						<c:if test="${companyAverageDto.allPoint == 2.0}">



							<label class="star">★</label>

							<label class="star">★</label>

						</c:if>
						<c:if test="${companyAverageDto.allPoint == 1.0}">

							<label class="star">★</label>

						</c:if>
					</td>

					<td>(${reviewCount }個のレビュー)</td><td>項目別平均点数</td> <td></td></tr>
				<tr><td></td><td></td><td></td><td>${companyAverageDto.careerPoint}★キャリア向上</td>


					<td>

					</td>

				</tr>


				<tr><td ></td><td></td><td></td><td>${companyAverageDto.workLifeBalancePoint}★ワークライフバランス</td></tr>
				<tr><td ></td><td></td><td></td><td>${companyAverageDto.payPoint}★給料と福祉</td></tr>
				　　　　 <tr><td ></td><td></td><td></td><td>${companyAverageDto.companyCulturePoint}★社内文化</td></tr>
				<tr><td ></td><td></td><td></td><td>${companyAverageDto.headPoint}★経営陣</td></tr>
				　　　　　</table>

		</div>

		<div	style="width:100%; border:1px;">
			<table class="tabtable" border="1" style="width:100%; margin:15px auto; padding:30px"><!--마진은되도록 쓰지말자  -->

				<tr><td>${oneCompanyReview.allPoint }</td><td><h4>"${oneCompanyReview.simpleComment }"</h4></td><td></td><td>
					<div id="sample"  data-position="bottom left"
						 data-content="신고"><i class="ellipsis horizontal icon"></i></div>
				</td></tr>
				<tr><td >
					<div>

						<c:if test="${oneCompanyReview.allPoint == 5.0}">
							<label class="star">★</label>
							<label class="star">★</label>
							<label class="star">★</label>
							<label class="star">★</label>
							<label class="star">★</label>

						</c:if>
						<c:if test="${oneCompanyReview.allPoint == 4.0}">
							<label class="star">★</label>

							<label class="star">★</label>

							<label class="star">★</label>

							<label class="star">★</label>

						</c:if>
						<c:if test="${oneCompanyReview.allPoint == 3.0}">

							<label class="star">★</label>

							<label class="star">★</label>

							<label class="star">★</label>

						</c:if>
						<c:if test="${oneCompanyReview.allPoint == 2.0}">



							<label class="star">★</label>

							<label class="star">★</label>

						</c:if>
						<c:if test="${oneCompanyReview.allPoint == 1.0}">

							<label class="star">★</label>

						</c:if>



						<div class="ui button">
							<i class="add icon"></i>
						</div>


						<div class="ui popup">
							<div class="header">User Rating</div>
							<div class="ui star rating" data-rating="3"></div>
						</div>


					</div>



				</td><td><h5>장점</h5></td><td><fmt:formatDate value="${oneCompanyReview.recCreateDate}" pattern="yyyy-mm-dd" /></td><td></td>


					<td></td>
				</tr>

				<tr><td ></td><td>${oneCompanyReview.advantages }</td><td></td></tr>
				<tr><td ></td><td><h5>단점</h5></td></tr>
				<tr><td ></td><td>${oneCompanyReview.disadvantages }</td></tr>
				<tr><td><button onclick="countUp(${oneCompanyReview.companyReviewId});">도움이 돼요</button></tr>
			</table>

		</div>

		<c:forEach var="companyShowList" items="${companyShowList}" varStatus="status">
		<div id="showCompanyList">
			<div	style="width:100%; border:1px;" >
				<table class="tabtable" border="1" style="width:100%; margin:15px auto; padding:30px"><!--마진은되도록 쓰지말자  -->
					<tr><td></td></tr>
					<tr><td > ${companyShowList.allPoint}</td><td style="width:300px;">장점</td><td><fmt:formatDate value="${companyShowList.recCreateDate}" pattern="yyyy-mm-dd" /></td><td></td></tr>

					<tr><td >

						<c:if test="${companyShowList.allPoint == 5.0}">
							<label class="star">★</label>
							<label class="star">★</label>
							<label class="star">★</label>
							<label class="star">★</label>
							<label class="star">★</label>

						</c:if>
						<c:if test="${companyShowList.allPoint == 4.0}">
							<label class="star">★</label>

							<label class="star">★</label>

							<label class="star">★</label>

							<label class="star">★</label>

						</c:if>
						<c:if test="${companyShowList.allPoint == 3.0}">

							<label class="star">★</label>

							<label class="star">★</label>

							<label class="star">★</label>

						</c:if>
						<c:if test="${companyShowList.allPoint == 2.0}">



							<label class="star">★</label>

							<label class="star">★</label>

						</c:if>
						<c:if test="${companyShowList.allPoint == 1.0}">

							<label class="star">★</label>

						</c:if>




					</td><td>${companyShowList.advantages }</td><td></td><td></td></tr>
					<tr><td ></td><td>단점</td></tr>
					<tr><td ></td><td>${companyShowList.disadvantages }</td></tr>
					<tr><td><button onclick="countUp(${companyShowList.companyReviewId});">도움이 돼요(${companyShowList.helpfulCount })</button></tr>
				</table>

			</div>
		</div>

		</c:forEach>

	</div>






</div>

</body>

</html>