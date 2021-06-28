<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="jp">
  <head>
    <meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script
         src="https://code.jquery.com/jquery-3.1.1.min.js"
          integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8="
         crossorigin="anonymous"></script>
        <script src="../semantic/semantic.js"></script>
        <style>
            body{padding:2rem;}
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
        </style>
	
	
	<script>
	function bookmarkSet(postId){
		alert(postId); //postid를 컨트롤러에게 넘겨줘서 북마크 처리가능.
		var bookmarkId = "#bookmarkSet"+postId;
		$(bookmarkId).html("<a><i class='bookmark icon'></i></a>");
	}
	
	$(function(){
		//1개의 토픽을 선택시 해당 토픽만 출력하도록 하는 제이쿼리 함수.
		$("#viewPostsSelectedTopic").on('change', function(){	
			var checkTopicNum= $("#viewPostsSelectedTopic option:selected").val();
			alert("checkTopicNum:"+checkTopicNum);
	    	$.ajax({
				type:"POST",
			    url: "viewPostsSelectedTopic",
				data : { selectBoardId : $("#viewPostsSelectedTopic option:selected").val()//-1:전체 출력으로 실시. -1이외는 selecteTopicNumber에 따라 1개 토픽관련 포스트만 출력.
						 ,searchKeyword : $("input[name=searchKeyword]").val() 			 //검색창의 검색어
				 	   },
				dataType:"json",
				success: function(result){
					//alert("success");

					//포스트리스트의 화면재구성 시작
					//주요틀 재구성
					$(postList).html("");
					//반복문통해 각 포스트들 출력진행
					$.each(result, function (key, value) {	
						var hideUserNick =  value.userNickName.substring(0,1)+'****';
						var postCreateDate = value.postCreateDate.substring(5,7)+'.'+value.postCreateDate.substring(8,10);
						$(postList).append("<div class='column' style='float: left; width:45%; margin:10px; display:inline;'>"
	                							+"<div>"+value.boardTopicName+"</div>"
						                   		+"<div style='margin:10px; word-break:break-all;'> <h3>" +value.postTitle+ "</h3> </div>"
						                    	+"<div style='margin:10px;'> <p>"+value.postContents+"</p></div>" 
										 		+"<div style='margin:10px;'>"+ value.companyName 
									 				+"<div>" + hideUserNick + "</div>"
												+"</div>"
						                    	+"<div style='padding:10px; line-heigh:top;'>"
						                        	+"<i class='eye icon' style='margin:0px 5px 0px 5px;'></i>" + value.postCount
						                        	+"<i class='thumbs up outline icon' style='margin:0px 5px 0px 5px;'></i>" +value.recommendCount
						                        	+"<i class='comment outline icon' style='margin:0px 5px 0px 5px;'></i>"  +value.replyCount
						                    		+"<div style='float:right;'>"
							                    		+ postCreateDate
							              				+"<div id='bookmarkSet" +value.postId + " 'onclick='bookmarkSet(" +value.postId + ")' style='display:inline;margin:0px 5px 0px 5px;'>"
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
			alert("checkTopicNum:"+checkTopicNum);
			$.ajax({
				type:"POST",
			    url: "sortPosts",
				data : { sortPostOption : $("#sortPosts option:selected").val() //값 1:최신순 정렬, 값 2:추천순정렬
						 ,searchKeyword : $("input[name=searchKeyword]").val()  //검색창의 검색어
						 ,selectBoardId : $("#viewPostsSelectedTopic option:selected").val()//-1:전체 출력으로 실시. -1이외는 selecteTopicNumber에 따라 1개 토픽관련 포스트만 출력.
					   },
				dataType:"json",
				success: function(result){
					console.log(result);
					//값 정상 전달여부 확인위한 콘솔로그.
					$.each(result,function(key, value){
					var arr = value.postTitle;
					console.log(arr);
					});
					
					//포스트리스트의 화면재구성 시작
					//주요틀 재구성
					$(postList).html("");
					//반복문통해 각 포스트들 출력진행
					$.each(result, function (key, value) {	
						var hideUserNick =  value.userNickName.substring(0,1)+'****';
						var postCreateDate = value.postCreateDate.substring(5,7)+'.'+value.postCreateDate.substring(8,10);
						$(postList).append("<div class='column' style='float: left; width:45%; margin:10px; display:inline;'>"
	                							+"<div>"+value.boardTopicName+"</div>"
						                   		+"<div style='margin:10px; word-break:break-all;'> <h3>" +value.postTitle+ "</h3> </div>"
						                    	+"<div style='margin:10px;'> <p>"+value.postContents+"</p></div>" 
										 		+"<div style='margin:10px;'>"+ value.companyName 
									 				+"<div>" + hideUserNick + "</div>"
												+"</div>"
						                    	+"<div style='padding:10px; line-heigh:top;'>"
						                        	+"<i class='eye icon' style='margin:0px 5px 0px 5px;'></i>" + value.postCount
						                        	+"<i class='thumbs up outline icon' style='margin:0px 5px 0px 5px;'></i>" +value.recommendCount
						                        	+"<i class='comment outline icon' style='margin:0px 5px 0px 5px;'></i>"  +value.replyCount
						                    		+"<div style='float:right;'>"
							                    		+ postCreateDate
							              				+"<div id='bookmarkSet" +value.postId + " 'onclick='bookmarkSet(" +value.postId + ")' style='display:inline;margin:0px 5px 0px 5px;'>"
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
	</script>
	
   <title>検索結果 page</title>
   
   </head>
   
   <body>
   
   <!-- 검색창 -->
   <div class="inputSearchKeyword">    
   		<form>
        <div class="ui fluid massive left icon input">
				  <input type="text" placeholder="Search"
					     name="searchKeyword" value=${pastSearchKeyword}> 
	    		<i class="search icon"></i>
	  			<div class="results"></div>
			</div>
   		</form>
   </div>


	<!-- 검색결과출력페이지(전체) -->
   <div class="ui stacked segment"  style="border:1px solid #5e615b;">
		<h1><strong>${searchKeyword}</strong> 検索結果</h1> <!-- 검색키워드로 변경(지금은 기업명일때만 나온다. -->
	
	<!-- 검색결과1. 기업정보 / 검색어가 기업이 아닌경우 출력되지 않는다. -->      
		<c:if test="${searchResultCompanyDataFlag eq '1'}"><!-- searchResultCompanyDataFlag의 값이 1이면 회사정보 있으며, 이에따라 출력실시. -->
			<div class="ui stacked segment" style="border:1px solid #33333;">
	   			<h3>企業</h3>
		   		<div  class="ui stacked segment"  style="height: auto; width: 100%; border:1px solid #5e615b; padding:20;" >
					<!-- 검색결과1.1. 기업의 기본정보페이지(총평점 및 리뷰/게시글/연봉링크) -->
					<!-- 회사이름,별점 안내 및  리뷰,게시글,연봉 버튼 생성 -->
					<div style="position:absolute;">
						<div style="float:left; border:1px solid #5e615b;"> 
							<a href=""><img  src="${pageContext.request.contextPath}/resources/images/company/${searchResultCompany[0].companyId}.png" width=40px, height=40px style="margin:5px;" align="top"></a><!-- 회사의 안내페이지 링크 주도록 설정. -->
						</div>
						<div  style="border:1px solid #5e615b;">
							<a href="">${searchResultCompany[0].companyName}</a>
							<i class="star icon"></i>
							<ul style="line-height:1px;  display:block;" >
								<a href="">レビュー</a>　❘
								<a href="">企業ポスト</a>　❘
								<a href="">給料</a>
							</ul>	
						</div>
					</div>
	
					<!-- 검색결과1.2. 일하고 싶은 기업인지 추천/비추천버튼 -->
					<div class="ui stacked segment" style="margin:60px; border:1px solid #5e615b;">
						<div class="ui stacked segment" style="height: auto; width: 100%; border:1px solid #33333; margin:10px;" >
							${searchResultCompany[0].companyName}は働きたい企業ですか
							<button style="color: blue;" class="ui icon button">
								<i class="thumbs up outline icon"></i>
							</button>
							<button style="color: red;" class="ui icon button" >
								<i class="thumbs down outline icon"></i>
							</button>
						</div>
	 				
						<div style="background-color:#b1d4e3; margin:10px">
							<a href="">
								<div>${companyReviews[0].allPoint}</div> 				
								<div style="float:Right;">レビュー全部見る > </div>
								<div>${companyReviews[0].jobGroupName}</div>
								<div>${companyReviews[0].simpleComment}</div>
								<div>${companyReviews[0].disadvantages}</div>
							</a>
						</div>
					</div>
		 		</div>
			</div>
		<div class="ui divider"></div>
	  	</c:if>

	<!-- 검색결과2. 토픽(게시글) -->
		<div class="ui stacked segment" style="height: auto; width: 100%; border:1px solid #5e615b;" >
			<!-- 드롭버튼 - 토픽선택, 정렬설정 -->
			<!-- 드롭버튼(1)토픽선택 -->
			<div>
				<select id="viewPostsSelectedTopic" class="ui dropdown" style="border:1px solid #5e615b;">

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
				<select id="sortPosts" style="border:1px solid #5e615b; float:right;">
					<option value="1">最新順</option>
					<option value="2">推薦順</option>
				</select>
			</div>   		
		 <hr width = "100%" color = "#000000" size = "5"></hr>
			<!-- 게시글(포스트)들 출력 -->
			<div class="ui four column grid" id="postList">
				<c:forEach items="${searchResultPosts}" var="posts">
					<div class="column" style="float: left; width:45%; margin:10px; display:inline;">

						<div> ${posts.boardTopicName} </div>
					 	<div style="margin:10px; word-break:break-all;" > <h3>${posts.postTitle}</h3> </div>			
					 	<div style="margin:10px;"> ${posts.postContents}</div>
					 	<div style="margin:10px;"> ${posts.companyName} 
					 		- ${fn:substring(posts.userNickName,0,1)}
							<c:forEach begin="2" end='5'>*</c:forEach>
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


