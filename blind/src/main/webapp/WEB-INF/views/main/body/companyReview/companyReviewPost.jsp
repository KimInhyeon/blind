<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="jp">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
	span{
	  margin-left: 1%;
	  font-size: 1.3em;
	}
</style>

</head>


<body>
	<div style="margin:2%;"> <!-- 기업리뷰의 게시글 전체 감싸기 div -->	
		
		<!-- 1.기업리뷰의 게시글의 헤더(검색창&추천키워드)부분 -->
		<div style="width:50%;"> 
			<h2> ${company_name}のポスト</h2>		
			   <!-- 1.1.검색창 -->
			   <div class="inputSearchKeyword">    
			   		<form>
			        <div class="ui fluid massive left icon input">
							<input type="text" placeholder="Search" id="searchbox" name="searchKeyword" value="${pastSearchKeyword}"> 
				    		<i class="search link icon" id="searchicon" onclick="goSearch();"></i>
				  			<div class="results"></div>
						</div>
			   		</form>
			   </div>
			   
			   <!-- 1.2.추천 키워드 출력 -->
			   <div style="margin:2%;">
					<span style="font-weight: bold;">おすすめキーワード</span>
					<!-- 문의2. 추천키워드별 링크값 대입하는 방법 -->
					<!-- 문의3. 디렉토리를 활용하여 디렉토리의 내용을 for each로 출력하는 형태는 어떠한가 -->

					<!-- 상단의 css에 a태그 관련 설정. -->
					<span> <a href=""> ${company_name}の處遇 </a> </span> 		<!-- 처우 -->
					<span> <a href=""> ${company_name}の給料 </a> </span> 		<!-- 연봉 -->
					<span> <a href=""> ${company_name}のキャリア </a> </span> 	<!-- 경력 -->
					<span> <a href=""> ${company_name}の待遇 </a> </span> 		<!-- 대우(직장에서의 지위나 급료 등 근무자에 대한 처우(處遇).) -->
					<span> <a href=""> ${company_name}の雰圍氣 </a> </span> 			<!-- 분위기 -->
					<span> <a href=""> ${company_name}の面接 </a> </span> 			<!-- 면접 -->
					<span> <a href=""> ${company_name}の開發</a> </span>			<!-- 개발 -->
			   </div>
		</div>
		
		
		<!-- 2.포스터출력 -->
		<!-- 구현(1)컨트롤러에서 기업명으로 검색을 한 결과를 가져와서 출력하도록 실시.
			 구현(2)모든 토픽들을 검색하며, 현재는 제목에 검색어가 있는 경우만 실실.
			 구현(3)검색결과 출력할 글이 20개 이하면 페이징 않고 전체 출력.(패이징 컨트롤러도 출력얺음)
			      20개 초과시 페이징실시 & 하단에 페이지컨트롤러 배치.
		 -->

		<div>
		
		</div>

	</div>
</body>
</html>