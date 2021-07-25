<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
   .tit{padding: 6px 0 8px; font-size: 150%; font-weight: 700;}
   #direc{padding:15px; width:100%; background-color:#f2f2f3;}
   #direc a{color:black; padding:5px;}
   .dir_category{padding-bottom:20px;}
   #dir_searchtext{padding: 12px 0;}
   #dir_searchtext::placeholder{font-size:17px;}
   .dirkey{padding:40px 0px;}
   .dirkey li a{font-weight:500; color:black; font-size:15px;}
   .dirkey ul li{line-height:220%;}
   .dirpaging{text-align:center; padding-top:20px;}
   
   .company_review_sample > * {
   		padding:5px;
   }
   
   html, body {
	   position: relative;
	   height: 100%;
	}
	
	body {
	   font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
	   font-size: 14px;
	   color: #000;
	   margin: 0;
	   padding: 0;
	}

		.tit {
	   padding: 6px 0 8px;
	   font-size: 150%;
	   font-weight: 700;
	}
	
	.bookmarkcontent a {
	   color: black;
	   display: block;
	   padding-bottom: 8px;
	}
	
	.bookmarkcontent a span {
	   font-size: 80%;
	}
	
	.bookmarkcontent p {
	   padding-top: 12px;
	   font-size: 90%;
	}
	
    #searchbox{border-radius:50px; font-size:23px;}
    #searchbox::placeholder{font-size:18px;}
    .maintit{padding: 6px 0; font-size: 20px; font-weight: 700; float:left;}
    .titline{border: 0; height:2px; background: #dfe1e4;}
    #searchicon{padding-left:70px;}
    .maintopicbest{padding-top:8px;}
    .maintit span{padding-left:5px;}
    .topicbesttit{padding-top:50px;}
    #topicbestlabel{background:white; border:solid 1px #dfe1e4; margin-bottom:10px;}
    .seemore a {color:gray;}
    .topicbest span{color:gray;}
    .topicbest i{color:gray;}
</style>
	
	
	<script>
	function bookmarkSet(postId){
		var bookmarkId = "#bookmarkSet"+postId;
		$(bookmarkId).html("<a><i class='bookmark icon'></i></a>");
	}
	
	$(function(){
		//기업추천여부(기업에 일하고 싶은가 여부) - 좋아요 버튼 클릭시
		$(".company_recommend_button").on('click', function(){		
			
			var companyName = '${searchResultCompany[0].companyName}';  //기업명 저장. append할 때 로드하여 기업명 출력시 사용.
			$.ajax({
				type:"POST",
			    url: "companyRecommendVote",
				data : { companyId : ${searchResultCompany[0].companyId}
						,companyVoteValue : $(this).val()//기업추천여부. 1:기업추천 0:기업비추천
				 	   },
				dataType:"json",
				success: function(result){ //투표결과(기업선호도)를 출력하도록 변경.
					
					//초기화(기업선호도 투표를 위한 추천/비추천 버튼등을 삭제)
					$(company_vote_and_recommend_percent).html("");
					
					$(company_vote_and_recommend_percent).append( companyName +"は働きたい企業ですか"
																 +"<button style='color: blue;' class='ui icon button company_recommend_button'>"
																 +"<i class='thumbs up outline icon'></i>" + result[0].voteCountOfGood+'%'
																 +"</button>"
																 +"<button style='color: red;' class='ui icon button company_recommend_button'>"
																 +"<i class='thumbs down outline icon'></i>" + result[0].voteCountOfBad+'%'
																 +"</button>"
					);	                
				},
				error: function(){
					alert("에러");
				}				
			});
		}); 
		
		//1개의 토픽을 선택시 해당 토픽만 출력하도록 하는 제이쿼리 함수.
		$("#viewPostsSelectedTopic").on('change', function(){	
			var checkTopicNum= $("#viewPostsSelectedTopic option:selected").val();
			
	    	$.ajax({
				type:"POST",
			    url: "viewPostsSelectedTopic",
				data : { selectBoardId : $("#viewPostsSelectedTopic option:selected").val()//-1:전체 출력으로 실시. -1이외는 selecteTopicNumber에 따라 1개 토픽관련 포스트만 출력.
						 ,searchKeyword : $("input[name=searchKeyword]").val() 			 //검색창의 검색어
				 	   },
				dataType:"json",
				success: function(result){

					//포스트리스트의 화면재구성 시작
					//주요틀 재구성
					$(postList).html("");
					//반복문통해 각 포스트들 출력진행
					$.each(result, function (key, value) {	
						var hideUserNick =  value.userNickName.substring(0,1)+'****';
						var postCreateDate = value.postCreateDate.substring(5,7)+'.'+value.postCreateDate.substring(8,10);
						var boarderHtml = "<div class='eight wide column' style='border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;border-right-style: inset;'>";
						
						if (key%2==1) {
							boarderHtml = "<div class='eight wide column' style='border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;'>";
						}
						
						$(postList).append(boarderHtml
	                								+"<a href=''><span>"+ value.boardTopicName +"</span></a>"	
	                								+"<a href=''><span style='font-size: 130%; font-weight: 700;'>" +value.postTitle + "</span></a>"
	                								+"<div class='ui grid'>"
			                							+"<div class='thirteen wide column'>"
			                								+"<a href=''><p>"+ value.postContents + "</p></a>"
			                								+"<a href=''><p>"+ value.companyName + "-" + hideUserNick +"</p></a>"
			                							+"</div>"
			    										+"<div class='three wide column'>"
			    											+"<img class='ui tiny right floated image' src='bookmarkimage.png'>"
			    										+"</div>"
		    										+"</div>"
	    									 		+"<div style='padding:10px; line-heigh:top;'>"
	    								 		 		+"<i class='eye icon' style='margin:0px 5px 0px 5px;'></i>"+ value.postCount
	    								 		 		+"<i class='thumbs up outline icon' style='margin:0px 5px 0px 5px;'></i>" + value.recommendCount
	    								 		 		+"<i class='comment outline icon' style='margin:0px 5px 0px 5px;'></i>" + value.replyCount
	    								 			 	+"<div style='float:Right;'>"+postCreateDate
		    										   		+"<div id='bookmarkSet"+ value.postId + "' onclick='bookmarkSet"+value.postId +"' style='display: inline; margin:0px 5px 0px 5px;'>"
		    										   			+"<a style='color:#000000; margin:0px;'><i class='bookmark outline icon'></i></a>"
		    									   			+"</div>"
	    									  			+"</div>"
	    							   				+"</div>");
						}); //$.each(result, function (key, value) 반복출력 종료.
		                //마지막 부분 출력
	                	$(postList).append("</div>");	
				},
				error: function(){
					alert("에러");
				}				
			});
		}); 
	
		$("#sortPosts").on('change', function(){
			var checkTopicNum= $("#viewPostsSelectedTopic option:selected").val();
			
			$.ajax({
				type:"POST",
			    url: "sortPosts",
				data : { sortPostOption : $("#sortPosts option:selected").val() //값 1:최신순 정렬, 값 2:추천순정렬
						 ,searchKeyword : $("input[name=searchKeyword]").val()  //검색창의 검색어
						 ,selectBoardId : $("#viewPostsSelectedTopic option:selected").val()//-1:전체 출력으로 실시. -1이외는 selecteTopicNumber에 따라 1개 토픽관련 포스트만 출력.
					   },
				dataType:"json",
				success: function(result){
					

					//포스트리스트의 화면재구성 시작
					//주요틀 재구성
					$(postList).html("");
					//반복문통해 각 포스트들 출력진행
					$.each(result, function (key, value) {	
						var hideUserNick =  value.userNickName.substring(0,1)+'****';
						var postCreateDate = value.postCreateDate.substring(5,7)+'.'+value.postCreateDate.substring(8,10);
						var boarderHtml = "<div class='eight wide column' style='border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;border-right-style: inset;'>";
						
						if (key%2==1) {
							boarderHtml = "<div class='eight wide column' style='border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;'>";
						}
						
						$(postList).append(boarderHtml
	                								+"<a href=''><span>"+ value.boardTopicName +"</span></a>"	
	                								+"<a href=''><span style='font-size: 130%; font-weight: 700;'>" +value.postTitle + "</span></a>"
	                								+"<div class='ui grid'>"
			                							+"<div class='thirteen wide column'>"
			                								+"<a href=''><p>"+ value.postContents + "</p></a>"
			                								+"<a href=''><p>"+ value.companyName + "-" + hideUserNick +"</p></a>"
			                							+"</div>"
			    										+"<div class='three wide column'>"
			    											+"<img class='ui tiny right floated image' src='bookmarkimage.png'>"
			    										+"</div>"
		    										+"</div>"
	    									 		+"<div style='padding:10px; line-heigh:top;'>"
	    								 		 		+"<i class='eye icon' style='margin:0px 5px 0px 5px;'></i>"+ value.postCount
	    								 		 		+"<i class='thumbs up outline icon' style='margin:0px 5px 0px 5px;'></i>" + value.recommendCount
	    								 		 		+"<i class='comment outline icon' style='margin:0px 5px 0px 5px;'></i>" + value.replyCount
	    								 			 	+"<div style='float:Right;'>"+postCreateDate
		    										   		+"<div id='bookmarkSet"+ value.postId + "' onclick='bookmarkSet"+value.postId +"' style='display: inline; margin:0px 5px 0px 5px;'>"
		    										   			+"<a style='color:#000000; margin:0px;'><i class='bookmark outline icon'></i></a>"
		    									   			+"</div>"
	    									  			+"</div>"
		                						+"</div>");
						}); //$.each(result, function (key, value) 반복출력 종료.
		                //마지막 부분 출력
	                	$(postList).append("</div>");	
				},
				error: function(result){
					alert("에러"+result);
				}				
			});
		}); 
	});
		
	function goSearch(){
		var searchKeyword = $("#searchbox").val();
		
		if (searchKeyword === "" || searchKeyword === null || searchKeyword === undefined) {
			return false;
		}
		
		location.href='${pageContext.request.contextPath}/search?searchKeyword=' + searchKeyword;
	}
	</script>
	
   <title>検索結果 page</title>
   
   </head>
   
   <body>
   		 <div class="ui container">
			<div class="bookmarkcontent">
   <!-- 검색창 -->
   <div class="inputSearchKeyword">    
   		<form>
        <div class="ui fluid massive left icon input">
				<input type="text" placeholder="Search" id="searchbox" name="searchKeyword" value=${pastSearchKeyword}> 
	    		<i class="search link icon" id="searchicon" onclick="goSearch();"></i>
	  			<div class="results"></div>
			</div>
   		</form>
   </div>


	<!-- 검색결과출력페이지(전체) -->
		<h1><strong>${searchKeyword}</strong> 検索結果</h1> <!-- 검색키워드로 변경(지금은 기업명일때만 나온다. -->
	
	<!-- 검색결과1. 기업정보 / 검색어가 기업이 아닌경우 출력되지 않는다. -->      
		<c:if test="${searchResultCompanyDataFlag eq '1'}"><!-- searchResultCompanyDataFlag의 값이 1이면 회사정보 있으며, 이에따라 출력실시. -->
			<div class="ui stacked segment" >
	   			<h3>企業</h3>
		   		<div class="ui stacked segment"  style="height: auto; width: 100%;  padding:20;" >
					<!-- 검색결과1.1. 기업의 기본정보페이지(총평점 및 리뷰/게시글/연봉링크) -->
					<!-- 회사이름,별점 안내 및  리뷰,게시글,연봉 버튼 생성 -->
					<div class="company_profile_part" > <!-- onclick 통해 div영역 클릭시 페이지 이동(''내에 이동할 URL 기입) -->
						<div class="logo_and_companyName" style="float:left;display: inline;"> 
							<div style="display: flex;">
								<img src="${pageContext.request.contextPath}/resources/images/company/${searchResultCompany[0].companyId}.png" 
											width=40px, height=40px style="margin:5px;" align="top">
									<div>
										${searchResultCompany[0].companyName} 
										<i class="star icon"></i>
										<div style="display: flex;">
											<a href="${pageContext.request.contextPath}/companyShowReview?companyId=${searchResultCompany[0].companyId}"><span>レビュー</span></a>
											<a href=""><span>企業ポスト</span></a>
											<a href=""><span>給料</span></a>
										</div>
									</div>
								</div>
						</div>
					</div>
	
					<!-- 검색결과1.2. 일하고 싶은 기업인지 추천/비추천버튼 출력. 투표완료시 투표결과(기업선호도)를 출력하는 페이지로 변경. -->
					<div class="ui stacked segment" style="margin:60px;">
						<div class="ui stacked segment" style="height: auto; width: 100%;margin:10px;" id="company_vote_and_recommend_percent" >
							${searchResultCompany[0].companyName}は働きたい企業ですか
							<button style="color: blue;" class="ui icon button company_recommend_button" value="1">
								<i class="thumbs up outline icon"></i>
							</button>
							<button style="color: red;" class="ui icon button company_recommend_button" value="0">
								<i class="thumbs down outline icon"></i>
							</button>
						</div>
	 				
						<div class="company_review_sample" style="background-color:#b1d4e3; margin:10px;">
							<c:choose> 
								<c:when test="${empty companyReviews}">
									<div>この企業のレビューはありません。</div>
									<div>一番に作成しませんか。</div>
									<div style="float:Right;"><button class="mini ui blue button" onclick="javascript:{location.href='/blind/companyReviewWrite'}">この企業のレビューを作成する</button></div>　
								</c:when>
								<c:otherwise>
									<a href="">
										<div>${companyReviews[0].allPoint}</div> 				
										<div style="float:Right;">レビュー全部見る > </div>
										<div>${companyReviews[0].jobGroupName}</div>
										<div>${companyReviews[0].simpleComment}</div>
										<div>${companyReviews[0].disadvantages}</div>
									</a>						
								</c:otherwise>
							</c:choose>						
						</div>
					</div>
		 		</div>
			</div>
		<div class="ui divider"></div>
	  	</c:if>

	<!-- 검색결과2. 토픽(게시글) -->
		<!-- 드롭버튼 - 토픽선택, 정렬설정 -->
		<!-- 드롭버튼(1)토픽선택 -->
			<div>
				<select id="viewPostsSelectedTopic" class="ui dropdown" style="width:200px;height:50px;">

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
				<div class="ui internally grid" id="postList" style="box-shadow: none; margin: 0; width: 100%;">
					<c:forEach items="${searchResultPosts}" var="posts" varStatus="status">
						<c:if test="${status.index%2==0}">
							<div class="eight wide column" style="border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;border-right-style: inset;">
						</c:if>	
						<c:if test="${status.index%2==1}">
							<div class="eight wide column" style="border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;">
						</c:if>
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


