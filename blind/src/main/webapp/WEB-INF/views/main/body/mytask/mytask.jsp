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
           .protasktit{padding-top:15px;}
           .protasktit2{margin-top:100px;}
           .subtit{padding:0 20px; font-size: 140%; font-weight: 700;}
           .protaskcontent{margin-top:20px; font-weight:400; color:gray; font-size:100%; padding:5px 0;}
           .protaskcontent i{float:left; padding:12px 40px 12px 30px;}
           .topictit{padding-top:5px; font-weight:700; color:black; font-size:17px;}
           .protasknoti{padding: 15px 0px 10px 0px; float:left; margin-left:82px;}
           .procheck{float:right;}
           .protaskdate{padding: 15px 30px 10px 0; float:right;}
           .item a{color:black;}
</style>
<script>
    function goCRUpdate(){
        var reviewForm = document.reviewForm;
        reviewForm.submit();
    }

    function goCRDelete(){
        var reviewForm = document.reviewFormDelete;
        reviewForm.submit();
    }
</script>
</head>
<body>
    <div class="ui container">
        <h3 class="tit">進行中のタスク</h3>
        <hr class="titline">
        <div class="protasktit">
            <c:forEach var="crCount" items="${companyreviewList}" begin="0" end="0">
        <span class="subtit">企業レビュ</span><span>進行中のタスクが　${crCount.companyReviewCount}件　あります。</span>
            </c:forEach>
        </div>
        <c:forEach var="crList" items="${companyreviewList}">
        <div class="protaskcontent">
            <i class="large black building outline icon"></i>
            <div class="topictit">${crList.companyName}</div>
            <div class="protasknoti" >「${crList.companyName}」のレビューを登録しました。<br style="clear:both;"></div>
            <div class="protaskdate" >${crList.reviewCreateDate}<br style="clear:both;"></div>
                <c:choose>
            <c:when test="${crList.verifyFlag eq 0 && crList.completeFlag eq 0}">
            <a><div class= "ui label procheck" style="padding:7px 30px; margin-right:50px; border-radius:50px;">
                <span>待機中</span>
                <br style="clear:both;"> </div></a>
                    </c:when>
                    <c:when test="${crList.verifyFlag eq 1 && crList.completeFlag eq 1}">
                <a><div class= "ui label procheck" style="padding:7px 24px; margin-right:50px; border-radius:50px;">
                        <span style="color:#00ff00;">承認完了</span>
                    <br style="clear:both;"> </div></a>
                    </c:when>
                    <c:when test="${crList.verifyFlag eq 0 && crList.completeFlag eq 2}">
                    <a href="#" id="companion"><div class= "ui label procheck" style="padding:7px 36px; margin-right:50px; margin-left:40px; border-radius:50px;">
                        <span style="color:#ff2222">却下</span>
                        <br style="clear:both;"> </div></a>
                        <div class="ui icon top right pointing dropdown" style="float:right;">
                            <i class="ellipsis horizontal icon" style="padding:0px 20px 20px 0px;"></i>
                            <div class="menu">
                                <div class="item"><a href="javascript:goCRUpdate()" >修正</a></div>
                                <div class="item"><a href="javascript:goCRDelete()" >削除</a></div>
                            </div>
                            <form class="ui form" id="reviewForm" name="reviewForm" method="post" action="companyReviewUpdate">
                                <input type="hidden" name="comrevchange" value="${crList.companyReviewId}"/>
                            </form>
                            <form class="ui form" name="reviewFormDelete" method="post" action="companyReviewDelete">
                                <input type="hidden" name="comrevchange" value="${crList.companyReviewId}"/>
                            </form>
                        </div>
                    </c:when>
                </c:choose>


        <div class="ui fitted divider" style="margin-top:50px; "><!--fit 되는 얇은 선--></div>
        </div>
        </c:forEach>
                <c:forEach var="rpCount" items="${reportList}" begin="0" end="0">
    <div class="protasktit2">
    <span class="subtit">通報</span><span>進行中のタスクが　${rpCount.reportCount}件　あります。</span>
    </div>
                </c:forEach>
    <c:forEach var="rpList" items="${reportList}">
    <c:choose>
    <c:when test="${rpList.reportType eq 1}">
    <div class="protaskcontent">
        <i class="large red bullhorn icon"></i>
        <div class="topictit">${rpList.postTitle}</div>
        <div class="protasknoti" >${rpList.boardTopicName}トピックの「${rpList.companyName}・${rpList.userNickName}」様のポストを通報しました。<br style="clear:both;"></div>
        <div class="protaskdate" >${rpList.createDate}<br style="clear:both;"></div>
        <c:choose>
        <c:when test="${rpList.verifyFlag eq 0 && rpList.completeFlag eq 0}">
        <a><div class= "ui label procheck" style="padding:7px 30px; margin-right:50px; border-radius:50px;">
            <span>待機中</span>
            </c:when>
            <c:when test="${rpList.verifyFlag eq 1 && rpList.completeFlag eq 1}">
            <a><div class= "ui label procheck" style="padding:7px 24px; margin-right:50px; border-radius:50px;">
                <span style="color:#00ff00;">承認完了</span>
                </c:when>
                <c:when test="${rpList.verifyFlag eq 0 && rpList.completeFlag eq 2}">
                <a href="#"><div class= "ui label procheck" style="padding:7px 36px; margin-right:50px; border-radius:50px;">
                    <span style="color:#ff2222">却下</span>
                    </c:when>
                    </c:choose>
                    <br style="clear:both;"> </div></a>
    <div class="ui fitted divider" style="margin-top:50px; "><!--fit 되는 얇은 선--></div>
    </div>
    </c:when>
            <c:when test="${rpList.reportType eq 2}">
            <div class="protaskcontent">
                <i class="large red bullhorn icon"></i>
                <div class="topictit">${rpList.postTitle}</div>
                <div class="protasknoti" >「${rpList.jobGroupName}・${rpList.userNickName}」様の企業レビューを通報しました。<br style="clear:both;"></div>
                <div class="protaskdate" >${rpList.createDate}<br style="clear:both;"></div>
                <c:choose>
                <c:when test="${rpList.verifyFlag eq 0 && rpList.completeFlag eq 0}">
                <div class= "ui label procheck" style="padding:7px 30px; margin-right:50px; border-radius:50px;">
                    <span>待機中</span>
                    </c:when>
                    <c:when test="${rpList.verifyFlag eq 1 && rpList.completeFlag eq 1}">
                    <div class= "ui label procheck" style="padding:7px 24px; margin-right:50px; border-radius:50px;">
                        <span style="color:#00ff00;">承認完了</span>
                        </c:when>
                        <c:when test="${rpList.verifyFlag eq 0 && rpList.completeFlag eq 2}">
                        <div class= "ui label procheck" style="padding:7px 36px; margin-right:50px; border-radius:50px;">
                            <span style="color:#ff2222">却下</span>
                            </c:when>
                            </c:choose>
                            <br style="clear:both;"> </div>
                        <div class="ui fitted divider" style="margin-top:50px; "><!--fit 되는 얇은 선--></div>
                    </div>
                    </c:when>
    </c:choose>
    </c:forEach>
    </div>

                <div class="ui modal">
                    <i class="close icon"></i>
                    <div class="header">
                        <p>반려이유</p>
                    </div>
                    <div class="content">
                        <div class="image">
                            An image can appear on left or an icon
                        </div>
                        <div class="description">
                            A description can appear on the right
                        </div>
                    </div>
                    <div class="actions">
                        <div class="ui button">Cancel</div>
                        <div class="ui button">OK</div>
                    </div>
                </div>

                <script>
                    $(function(){
                        $('#companion').click(function(){
                            $('.ui.modal').modal({
                                closable  : false
                            })
                                    .modal('setting', "transition", "fade")
                                    .modal('show');
                        });
                    });

                    $('.ui.dropdown')
                            .dropdown()
                    ;
                </script>
    </body>

</html>