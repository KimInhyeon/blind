<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="jp">
  <head>
    <meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
   </head>
   
   <body>
   <!-- 금요일(6/18)에 업로드될 공통레이아웃의 포맷에 따라 변경을 실시할 것. -->

   <div class="inputSearchKeyword">    
   		<form>
			<div class="ui right action left icon input">
			  <i class="search icon"></i>
			  <input type="text" placeholder="Search"
				     name="searchKeyword" value=${pastSearchKeyword}> 
			</div>
   		</form>
   </div>
   <div class="main_contents">
	    <!-- 검색어가 기업이 아닌경우 출력되지 않는다. -->      
	    <div class="search_company_name">
  				<h1><strong>${boardTopicName}</strong>검색결과</h1>
   				<h3>기업</h3>
  		</div>
 

		<c:if test="${searchResultCompanyDataFlag eq '1'}"><!-- searchResultCompanyDataFlag의 값이 1이면 회사정보 있으며, 이에따라 출력실시. -->
	   		<div class="search_company"  style="height: auto; width: 100%; border:1px solid #5e615b; padding:20;" >
				<div class="search_company_intro"> <!-- 회사이름,별점 안내 및  리뷰,게시글,연봉 버튼 생성 -->
					<a href="" style="font-color:000000; text-decoration:none"><!-- 회사의 안내페이지 링크 주도록 설정. -->
						<img src="" width=40, height=40>	
							${searchResultCompany[0].companyName}
					</a>
					<i class="star icon"></i>
					<ul>
						<a href="">리뷰</a>
						<a href="">게시글</a>
						<a href="">연봉</a>
					</ul>	
				</div>			
			<div class="vote">
				<p>${searchResultCompany[0].companyName}은(는) 일해보고 싶은 회사인가요?</p>
				<div class="button_vote">
					<button class="ui icon button">
						<i class="thumbs up outline icon"></i>
					</button>
					<button class="ui icon button" >
						<i class="thumbs down outline icon"></i>
					</button>
				</div>

				<a href="" class="review" style="background-color:#03f8fc">
					<div>${companyReviews[0].allPoint}
						<span>리뷰전체 보기</span>
					</div> 
					<div>${companyReviews[0].jobGroupCode}</div>
					<div>${companyReviews[0].simpleComment}</div>
					<div>${companyReviews[0].disadvantages}</div>
		
				</a>
			</div>
   		</div>
		</c:if>


        
   
   <div class="search_topic">
   		<div class="drop down button">
	   		<select name="topics">
	   			<option value="전체">전체(${countPostAll})</option>
	   			<option value="토픽1">토픽1(${countPostofBoard1})</option>
	   			<option value="토픽2">토픽2(${countPostofBoard2})</option>   		
	   			<option value="토픽3">토픽3(${countPostofBoard3})</option>
	   			<option value="토픽4">토픽4(${countPostofBoard4})</option>  
	   		</select>
   		</div>
	</div>   		

	<div class="postOutList" >
 		<c:forEach items="${searchResultPosts}" var="posts"> <!-- 아이템이 2개이면 어떻게 할것인가?(댓글필요) -->
		   <div class="postOutEach" style="float: left; width:40%; margin:10px;" >
		   		<div>보드타입 맵핑필요</div>
		 		<div> <p>${posts.postTitle}</p> </div>			
				<div> <i class="eye icon"></i> 				(조회수출력)</div>
				<div> <i class="thumbs up outline icon"></i> (추천수클릭)</div>	   
		   		<div> <i class="comment outline icon"></i>   (댓글수출력)</div>
		   		<div> ${posts.postCreateDate} <i class="bookmark outline icon"></i></div>
		   </div>
 		</c:forEach>
   </div>
      
  </body>
</html>


