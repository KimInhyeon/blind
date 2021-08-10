<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KSINFOSYS BLIND</title>
    <script>
        $(function(){
            $("i[name=bmi]").click(function(){
                if($(this).hasClass("red") === true){
                    $(this).removeClass("red").addClass("outline");
                }else{
                    $(this).addClass("red").removeClass("outline");
                }
                var postId = $(this).attr('id');
                        $.ajax({
                            type : "POST",
                            url : "/blind/addBookmark",
                            data : { postId : postId },
                            dataType:"json",
                            success : function(result){
                            }
                        });
            });
        });
    </script>
<style>
            .tit{padding: 30px 0 8px 0; font-size: 150%; font-weight: 700;}
            .bookmarkcontent a{color:black; display:block; padding-bottom:8px;}
            .bookmarkcontent a span{font-size:80%;}
            .bookmarkcontent p{padding-top:12px; font-size:90%;}
            #icn1 a{color:gray;}
            #icn1 a i:hover{color:gray;}
            #icn2 a{color:gray;}
            #icn2 a i:hover{color:gray;}

</style>
</head>
 <body>
    <div class="ui container">
        <h3 class="tit">ブックマーク</h3>
<%--        <div class="ui fitted divider" style="border-width:medium;"><!--fit 되는 얇은 선--></div>--%>
        <div class="bookmarkcontent">
        <div class="ui internally celled grid">
        <c:forEach var="bookmark" items="${bookmarkList}" varStatus="status">
            <script>
                $(document).ready(function(){

                });

            </script>
                <c:choose>
                <c:when test="${status.count % 2 == 1}">
                <div class="row">
                    <div class="eight wide column">
                        <a href="searchBoardName?searchKeyword=${bookmark.boardId}"><span>${bookmark.boardTopicname}</span></a>
                        <a href="${pageContext.request.contextPath}/topicDetail?postId=${bookmark.postId}"><span style="font-size:130%; font-weight:700;">${bookmark.postTitle}</span></a>
                        <div class="ui grid">
                            <div class="thirteen wide column">
                                <div style="height:65px;">
                                    <a href="${pageContext.request.contextPath}/topicDetail?postId=${bookmark.postId}"><p>${bookmark.postContents}</p></a>
                                </div>
                            </div>
                            <c:if test="${bookmark.postFileUrl ne null}">
                            <div class="three wide column">
                                <a href="${pageContext.request.contextPath}/topicDetail?postId=${bookmark.postId}"><img class="ui tiny right floated image" src="${bookmark.postFileUrl}"></a>
                            </div>
                            </c:if>
                        </div>
                        <a href=""><span>${bookmark.companyName}・${bookmark.userNickName}</span></a>
                        <div class="ui left floated horizontal list" id="icn1">
                            <a class="item" href="http://naver.com"><i class="eye icon"></i><span style="padding:0 5px;">${bookmark.postCount}</span></a>
                            <a class="item" href="http://naver.com"><i class="thumbs up outline icon"></i><span style="padding-left:5px;">${bookmark.recommendCount}</span></a>
                            <a class="item" href="#"><i class="comment outline icon"></i><span style="padding:0 5px;">${bookmark.replyCount}</span></a>
                        </div>
                        <div class="ui right floated horizontal list" >
                            <a class="item" href=""><span style="padding-left:5px; color:gray;">${bookmark.createDate}</span></a>
                            <a class="item" ><i class="bookmark icon red" name="bmi" id="${bookmark.postId}"></i><span style="padding:0 5px;"></span></a>
                        </div>
                    </div>
                    <c:if test="${status.last eq true}">
                    <div class="eight wide column">
                    </div>
                    </c:if>
                </c:when>
                <c:when test="${status.count % 2 == 0}">
                    <div class="eight wide column">
                        <a href="searchBoardName?searchKeyword=${bookmark.boardId}"><span>${bookmark.boardTopicname} </span></a>
                        <a href="${pageContext.request.contextPath}/topicDetail?postId=${bookmark.postId}"><span style="font-size:130%; font-weight:700;">${bookmark.postTitle}</span></a>
                        <div class="ui grid">
                            <div class="thirteen wide column">
                                <div style="height:65px;">
                                    <a href="${pageContext.request.contextPath}/topicDetail?postId=${bookmark.postId}"><p>${bookmark.postContents}</p></a>
                                </div>
                            </div>
                            <c:if test="${bookmark.postFileUrl ne null}">
                                <div class="three wide column">
                                    <a href="${pageContext.request.contextPath}/topicDetail?postId=${bookmark.postId}">
                                        <img class="ui tiny right floated image" src="${bookmark.postFileUrl}"></a>
                                </div>
                            </c:if>
                        </div>
                        <a href=""><span>${bookmark.companyName}・${bookmark.userNickName}</span></a>
                        <div class="ui left floated horizontal list" id="icn2">
                            <a class="item" href="http://naver.com"><i class="eye icon"></i><span style="padding:0 5px;">${bookmark.postCount}</span></a>
                            <a class="item" href="http://naver.com"><i class="thumbs up outline icon"></i><span style="padding-left:5px;">${bookmark.recommendCount}</span></a>
                            <a class="item" href="#"><i class="comment outline icon"></i><span style="padding:0 5px;">${bookmark.replyCount}</span></a>
                        </div>
                        <div class="ui right floated horizontal list" >
                            <a class="item" href=""><span style="padding-left:5px; color:gray;">${bookmark.createDate}</span></a>
                            <a class="item" ><i class="bookmark icon red" name="bmi" id="${bookmark.postId}"></i><span style="padding:0 5px;"></span></a>
                        </div>
                    </div>
                </div>
                </c:when>
                </c:choose>

        </c:forEach>
        </div>
        </div>
          <div class="ui fitted divider" style="border-width:medium;"><!--하선--></div>
    </div>
 </body>
</html>