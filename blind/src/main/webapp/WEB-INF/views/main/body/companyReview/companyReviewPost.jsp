<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
	
	a{
	  margin:0.5%;
	}
</style>

</head>


<body>
	<div style="margin:2%; width:100%;"> <!-- 기업리뷰의 게시글 전체 감싸기 div -->	
		
		<!-- 1.기업리뷰의 게시글의 헤더(검색창&추천키워드)부분 -->
		<div style="margin-top: 5%; margin-bottom: 5%;"> 
			<h2 style="margin-bottom: 3%;"> ${company_name}のポスト</h2>		
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
		<div style="margin-top: 5%;"> 
			<h3> ${company_name}のベストポスト</h2>		
			
			<!-- 게시글(포스트)들 출력 -->
			<!-- https://semantic-ui.com/collections/grid.html -->
			<div id="postList" style="background-color:#ffffff; padding : 2%;">
				<div class="ui divider"  style="border-color: #d4d4d5;"></div>
				<c:forEach items="${company_posts}" var="posts" varStatus="status">			
					<div style="padding : 2%; border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;border-right-style: inset;">
						<a href="topicDetail?postId=${posts.postId}">
							<span style="font-size: 150%;">${posts.postTitle}</span>
						</a>
						
						<div>
							<div>
								<a href="topicDetail?postId=${posts.postId}"><p>${posts.postContents}</p></a>	
								<a href="companyIntroduction?companyId=${posts.companyId}">
									<p> ${posts.companyName} - ${fn:substring(posts.userNickName,0,1)} ****</p> <!-- 작성자의 근무사, 닉네임(*처리) -->
								</a>
							</div>

						</div>

			 			<div style="padding:10px; line-heigh:top;">
						 	<div style="display:flex;"> <!-- 조회수, 좋아요 갯수, 댓글 수 출력  -->
								<a href="/blind/topicDetail?postId=${posts.postId }"><i class="eye icon" style="margin:0px 5px 0px 5px;"></i>${posts.postCount}</a>
							 	<a href="/blind/topicDetail?postId=${posts.postId }"><i class="thumbs up outline icon" style="margin:0px 5px 0px 5px;"></i> ${posts.recommendCount}</a>
								<a href="/blind/topicDetail?postId=${posts.postId }"><i class="comment outline icon"  style="margin:0px 5px 0px 5px;"></i>  ${posts.replyCount}</a>
							</div>	 
								
							<div style="float:Right;"> <!-- 작성일,북마크 출력 -->
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
	
	<!-- 페이징 버튼 배치. 정렬옵션을 주어 배치를 맞춰야 한다. -->
	<div id="pagination" style="text-align: center; margin-bottom: 5%;">
		<div class="active item">1</div>
	</div>
	
	
<script>
	// ページナビゲーター
	const endPage = ${navi.endPage};
	if (endPage > 1) {
		const pathname = location.pathname;
		const getParameterHtml = function (page) {
			if (page > 1) {
				let parameterHtml = "?page=" + page
				return parameterHtml
			} else if (parameterIsExist) {
				return "?" + parameter;
			}
			return "";
		};
		
		let page = ${navi.startPage};
		if (page === 1) {
			html = "<div class=\"ui pagination menu\" style=\"visibility: hidden\;\">" +
					"<div class=\"item\">前へ</div></div>";
		} else {
			html = "<div class=\"ui pagination menu\"><a class=\"item\" href=\"" + pathname +
					getParameterHtml(page - ${navi.pagination}) + "\">前へ</a></div>";
		}
		html += "<div class=\"ui pagination menu\">";
		
		while (page <= endPage) {
			if (page === ${navi.currentPage}) {
				html += "<div class=\"active item\">" + page + "</div>";
			} else {
				html += "<a class=\"item\" href=\"" + pathname + getParameterHtml(page) + "\">" + page + "</a>";
			}
			++page;
		}
		html += "</div>";
		if (endPage === ${navi.totalPage}) {
			html += "<div class=\"ui pagination menu\" style=\"visibility: hidden\;\">"
		} else {
			html += "<div class=\"ui pagination menu\"><a class=\"item\" href=\"" + pathname + "?page=" + page;
		}
		document.getElementById("pagination").innerHTML = html;
	}
</script>
</body>

</html>