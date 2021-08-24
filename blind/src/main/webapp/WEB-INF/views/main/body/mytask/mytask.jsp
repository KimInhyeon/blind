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
           .protasknoti{padding: 15px 0px 10px 75px; float:left;}
           .procheck{float:right;}
           .protaskdate{padding: 15px 30px 10px 0; float:right;}
</style>
</head>
<body>
    <div class="ui container">
        <h3 class="tit">進行中のタスク</h3>
        <hr class="titline">
        <div class="protasktit">
        <span class="subtit">企業レビュ</span><span>進行中のタスクが　1件　あります。</span>
        </div>
        <div class="protaskcontent">
            <i class="large black building outline icon"></i>
            <div class="topictit">トヨタ自動車</div>
            <div class="protasknoti" >「トヨタ自動車」のレビューを登録しました。<br style="clear:both;"></div>
            <div class="protaskdate" >2021.06.15<br style="clear:both;"></div>
            <div class= "ui label procheck" style="padding:7px 30px; margin-right:50px; border-radius:50px;"> <span>待機中</span><br style="clear:both;"> </div>
        <div class="ui fitted divider" style="margin-top:50px; "><!--fit 되는 얇은 선--></div>
        </div>
    <div class="protasktit2">
    <span class="subtit">通報</span><span>進行中のタスクが　1件　あります。</span>
    </div>
    <div class="protaskcontent">
        <i class="large red bullhorn icon"></i>
        <div class="topictit">化粧品オススメリスト</div>
        <div class="protasknoti" >OOOトピックの「資生堂・J******」様のポストを通報しました。<br style="clear:both;"></div>
        <div class="protaskdate" >2021.06.15<br style="clear:both;"></div>
        <div class= "ui label procheck" style="padding:7px 24px; margin-right:50px; border-radius:50px;"> <span style="color:#00ff00;">承認完了</span><br style="clear:both;"> </div>
    <div class="ui fitted divider" style="margin-top:50px; "><!--fit 되는 얇은 선--></div>
    </div>
    <div class="protaskcontent">
        <i class="large red bullhorn icon"></i>
        <div class="topictit">トヨタの真実</div>
        <div class="protasknoti" >OOOトピックの「トヨタ自動車・K******」様のポストを通報しました。<br style="clear:both;"></div>
        <div class="protaskdate" >2021.06.15<br style="clear:both;"></div>
        <div class= "ui label procheck" style="padding:7px 30px; margin-right:50px; border-radius:50px;"> <span>待機中</span><br style="clear:both;"> </div>
    <div class="ui fitted divider" style="margin-top:50px; "><!--fit 되는 얇은 선--></div>
    </div>
    </div>
    </body>
</html>