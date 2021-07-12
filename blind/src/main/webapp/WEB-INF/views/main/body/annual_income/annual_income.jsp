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
<h1>annual_income</h1>
	<div>
		<div> ${companyProfile[0].companyName}の給料情報 </div>
		<div> ${companyProfile[0].companyName}の給料情報を職群別に確認してみてください。 </div>


		<!-- 드롭버튼(1)토픽선택 -->
			<div>
				<tt id="viewPostsSelectedTopic" class="ui dropdown" style="width:200px;height:50px;">

				<!-- 모든 토픽들의 포스트들을 총합 -->
				<c:set var="sumOfboardCounts" value="0" />
					<c:forEach items="${boardNameAndIdAndCount}" var="countOfboard">
						sumOfboardCounts=sumOfboardCounts+countOfboard
						<c:set var="sumOfboardCounts" value="${sumOfboardCounts + countOfboard.postCount}" />
					</c:forEach>

				<!-- 모든 토픽들과 포스트들의 이름, 갯수들을 출력.-->
				<option value="-1">トピック全体( ${sumOfboardCounts} )</option> <!-- 전체는 무조건 사용되므로 무조건 적용. -->
					<c:forEach items="${boardNameAndIdAndCount}" var="menuData">
					    <option value="${menuData.boardId}"> ${menuData.boardTopicName} ( ${menuData.postCount} )</option>
					</c:forEach>
				</select>
				
				<!-- 드롭버튼(2)정렬설정 --> 		
				<select id="sortPosts" style="float:right; width:100px;height:50px;">
					<option value="1">最新順</option>
					<option value="2">推薦順</option>
				</select>
			</div>   		
		 <hr width = "100%" color = "#000000" size = "5"></hr>
			<!-- 게시글(포스트)들 출력 -->
				<div class="ui internally celled grid" id="postList" >
					<c:forEach items="${searchResultPosts}" var="posts" >
							<div class="eight wide column" style="border-color: #d4d4d5; border-width: thin !important; border-style: inset;">
								<a href=""><span>${posts.boardTopicName }</span></a>	
								<a href=""><span style="font-size: 130%; font-weight: 700;">${posts.postTitle}</span></a>
									<div class="ui grid">
										<div class="thirteen wide column">
											<a href=""><p>${posts.postContents}</p></a>
											<a href=""><p> ${posts.companyName} 
	  												 	   - ${fn:substring(posts.userNickName,0,1)} ****</p></a>
										</div>
										<div class="three wide column">
											<img class="ui tiny right floated image" src="bookmarkimage.png">
										</div>
									</div>

						 	<div style="padding:10px; line-heigh:top;">
						 		 <i class="eye icon" style="margin:0px 5px 0px 5px;"></i>${posts.postCount} <!-- margin: top, right, bottom, left;  -->
								 <i class="thumbs up outline icon" style="margin:0px 5px 0px 5px;"></i> ${posts.recommendCount}
								 <i class="comment outline icon"  style="margin:0px 5px 0px 5px;"></i>  ${posts.replyCount}
						  		<div style="float:Right;">
							 		${fn:substring(posts.postCreateDate,5,7)}.${fn:substring(posts.postCreateDate,8,10)} <!-- 년-월-일 출력 방식 : ${fn:substring(posts.postCreateDate,0,10)} -->
							   		<div id="bookmarkSet${posts.postId}" onclick="bookmarkSet(${posts.postId})" style="display: inline; margin:0px 5px 0px 5px;">
							   			<a style="color:#000000; margin:0px;"><i class="bookmark outline icon"></i></a>
							   		</div>
							  	</div>
					   		</div>
					   </div>
					
					</c:forEach>
			 	 </div>
			</div>


	</div>

</body>
</html>