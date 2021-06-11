<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="jp">
  <head>
    <meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
   </head>
   
   <body>
	<form name="searchText" method="post" action="search">
    <input name="keyword" value="${map.keyword}">
    <input type="submit" value="조회">
</form>

   <div class="main_contents">
	    <!-- 검색어가 기업이 아닌경우 출력되지 않는다. -->      
	    <div class="search_company_name">
  				<h1><strong>(기업명)</strong>검색결과</h1>
   				<h3>기업</h3>
  		</div>
   		<div class="search_company"  style="height: auto; width: 100%; border:1px solid #5e615b; padding:20;" >
 
	
		<div class="search_company">
			<div class="search_company_intro"> <!-- 회사이름,별점 안내 및  리뷰,게시글,연봉 버튼 생성 -->
				<a href=""><!-- 회사의 안내페이지 링크 주도록 설정. -->
					<img src="" width=40, height=40>	
						(기업명)
					<img src="">	
						이미지-별점
					별점
				</a>
				<ul>
					<a href="">리뷰</a>
					<a href="">게시글</a>
					<a href="">연봉</a>
				</ul>	
			</div>			

			<div class="vote">
				<p>(회사명)은(는) 일해보고 싶은 회사인가요?</p>
				<div class="button_vote">
				<button>good</button>
				<button>bad</button>
			</div>
				
			<div class="review" style="background-color:#03f8fc">
				해당 기업에 대한 리뷰내역을 추가.
			</div>
		</div>
   </div>
        
   
   <div class="search_topic">
	   <!-- 모든 토픽들에서 검색어와 관련되면 출력한다.. -->   
   </div><!-- <div class="search_topic_post"> -->
   
  </body>
</html>