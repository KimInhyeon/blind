<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="jp">
  <head>
    <meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!--북마크 변경-자바스크립트-사용않기로 결정(사유:화면새로고침등을 실시해야 함.)
	<script type= "text/javascript">
		function innerHTMLTest(){
			alert("bookmarkSet을 누르셨습니다.");
			var bookmarkSet = document.getElementById("bookmarkSet");
			bookmarkSet.innerHTML =	"<a><i class=" + 'bookmark icon' +"></i></a>";			
		}
	</script>
	 -->
	 
	<!-- 제이쿼리 통해 북마크 변경안
	<script>
		function bookmarkChanege(){
		    var bookmarkOnOffSet = $('#bookmarkSet').serialize();
		    $.ajax({
		        url: "/search/bookmarkChanege",
		        data: book,
		        type:"POST",
		        cache: false
		    }).done(function (fragment) {
		         $("#list").replaceWith(fragment);
		    });
		    
		}	
	</script>
 -->
	 
	<title>検索結果 page</title>
   </head>
   
   <body>
   
   <!-- 검색창 -->
   <div class="inputSearchKeyword">    
   		<form>
	   		<div class="ui transparent left icon input">
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
			<div class="ui stacked segment">
	   			<h3>企業</h3>
		   		<div  class="ui stacked segment"  style="height: auto; width: 100%; border:1px solid #5e615b; padding:20;" >
					<!-- 검색결과1.1. 기업의 기본정보페이지(총평점 및 리뷰/게시글/연봉링크) -->
					<!-- 회사이름,별점 안내 및  리뷰,게시글,연봉 버튼 생성 -->
					<div style="position:absolute;">
						<div style="float:left; border:1px solid #5e615b;"> 
							<a href=""><img src="" width=40px, height=40px style="margin:5px;" align="top"></a><!-- 회사의 안내페이지 링크 주도록 설정. -->
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
								<div>${jobGroupNameOfCompanyReviewer[0]}</div>
								<div>${companyReviews[0].simpleComment}</div>
								<div>${companyReviews[0].disadvantages}</div>
							</a>
						</div>
					</div>
		 		</div>
			</div>
	  	</c:if>

	<!-- 검색결과2. 토픽(게시글) -->
		<div class="ui stacked segment" style="height: auto; width: 100%; border:1px solid #5e615b;" >
			<!-- 드롭버튼 2개(토픽선택, 정렬설정) -->
			<div>
				<select class="ui dropdown" style="border:1px solid #5e615b;">
		   		<option value="">トピック全体(${countPostAll})</option> <!-- 전체는 무조건 사용되므로 무조건 적용. -->
				<c:forEach items="${boardTopicName}" var="menuTopicName">
			   		<option value="test"> ${menuTopicName.boardTopicName} 	</option>
			   	</c:forEach>
				</select>
				
				<select class="ui dropdown" style="border:1px solid #5e615b; float:right;">
					<option value="">最新順</option>
					<option value="">最新順</option>
					<option value="">推薦順</option>
				</select>
			</div>   		
		 <hr width = "100%" color = "#000000" size = "5"></hr>
			<!-- 게시글(포스트)들 출력 -->
			<div class="ui four column grid">
			<c:set var="i" value="0" />
				<c:forEach items="${searchResultPosts}" var="posts"> <!-- 아이템이 2개이면 어떻게 할것인가?(댓글필요) -->
					<div class="column" style="float: left; width:40%; margin:10px; display:inline; border:1px solid #5e615b; ">
						<div> ${boardTopicName[i].boardTopicName} </div>
					 	<div style="margin:4px;"> <h3>${posts.postTitle}</h3> </div>			
					 	<div style="margin:4px;"> <p>${posts.postContents}</p></div>
					 	<div style="margin:4px;"> ${writerCompany[i]} - ${writerDataOfPosts[i].userNickName}  </div>
					 	<div style="margin:4px;">
					 		 <i class="eye icon"></i>${viewCountOfPosts[i].postCount}
							 <i class="thumbs up outline icon"></i> ${recommendCountOfPosts[i]}
							 <i class="comment outline icon"></i>  ${replyCountOfPosts[i]}
						</div>
				   		<div> 
					  		<div style="float:left;">
					  		${fn:substring(posts.postCreateDate,5,10)}
					  		</div>
					   		<div id="bookmarkSet" >
					   			<a><i class="bookmark outline icon"></i></a>
					   		</div>
				   		</div>
				   </div>
		 		   <c:set var="i" value="${i+1}" />
		 		</c:forEach>
			</div>
		</div>
   </div>

</body>
<!-- 
					<div style="position:absolute;">
						<div style="float:left; border:1px solid #5e615b;"> 
							<a href=""><img src="" width=20px, height=20px style="margin:10px;" align="top"></a>
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
 -->

</html>


