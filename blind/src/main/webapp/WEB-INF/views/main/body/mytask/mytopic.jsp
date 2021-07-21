<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KSINFOSYS BLIND</title>
<style>
           .tit{padding: 30px 0 8px 0; font-size: 150%; font-weight: 700;}
           .titline{border: 0; height:2px; background: #dfe1e4;}
           .mytopiccontent{font-weight:400; color:gray; font-size:100%; padding:5px 0;}
           .mytopiccontent i{float:left; padding:7px 40px 50px 30px;}
           .topictit{padding-top:5px; font-weight:700; color:black; font-size:17px;}
           .mytopicnoti{padding: 15px 0 10px 10px; float:left;}
           .mytopicdate{padding: 15px 30px 10px 0; float:right;}
        </style>
    </head>
    <body>
    <div class="ui container">
        <h3 class="tit">私のトピック</h3>
        <hr class="titline">
        <c:forEach var="mytopic" items="${mytopicList }">  
    	<c:choose>
    	<c:when test="${mytopic.mytopicType eq 1 }">
        <div class="mytopiccontent">
            <i class="large red clipboard list icon"></i>
            <div class="topictit">${mytopic.postTitle }</div>
            <div class="mytopicnoti" >会員様が「${mytopic.boardTopicname }トピックグループ」にポストを登録しました。<br style="clear:both;"></div>
        <div class="mytopicdate">${mytopic.createDate }<br style="clear:both;"></div>
        <div class="ui fitted divider" style="margin-top:50px;"><!--fit 되는 얇은 선--></div>
        </div>
		</c:when>
		
		<c:when test="${mytopic.mytopicType eq 2 }">
        <div class="mytopiccontent">
            <i class="large black comment alternate icon"></i>
            <div class="topictit">${mytopic.postTitle }</div>
            <div class="mytopicnoti" >会員様のポストに「${mytopic.companyName}・${mytopic.userNickName}」様がコメントを作成しました。<br style="clear:both;"></div>
        <div class="mytopicdate">${mytopic.createDate }<br style="clear:both;"></div>
        <div class="ui fitted divider" style="margin-top:50px;"><!--fit 되는 얇은 선--></div>
        </div>
        </c:when>
        <c:when test="${mytopic.mytopicType eq 3 }">
        <div class="mytopiccontent">
            <i class="red heart icon"></i>
            <div class="topictit">${mytopic.postTitle }</div>
            <div class="mytopicnoti" >会員様のポストに「${mytopic.companyName}・${mytopic.userNickName}」様がいいね！しました。<br style="clear:both;"></div>
        <div class="mytopicdate">${mytopic.createDate }<br style="clear:both;"></div>
        <div class="ui fitted divider" style="margin-top:50px;"><!--fit 되는 얇은 선--></div>
        </div>
        </c:when>
        <c:when test="${mytopic.mytopicType eq 4 }">
        <div class="mytopiccontent">
            <i class="large red bullhorn icon"></i>
            <div class="topictit">${mytopic.postTitle }</div>
            <div class="mytopicnoti" >会員様のポストが「${mytopic.companyName}・${mytopic.userNickName}」様により、通報されました。<br style="clear:both;">
                ${mytopic.postReportNickName }様は今まで総 ${mytopic.reportedCount } 回通報されました。<br>
                3回以上になった場合、ご利用を制限することがあります。</div>
        <div class="mytopicdate" style="padding: 55px 30px 10px 0;">${mytopic.createDate }<br style="clear:both;"></div>
        <div class="ui fitted divider" style="margin-top:90px;"><!--fit 되는 얇은 선--></div>
        </div>
        </c:when>
		</c:choose>
		</c:forEach>
    </div>
    </body>
</html>