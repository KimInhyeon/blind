<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html lang="jp">
<head>
	<!-- Remember to include jQuery :) -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
	
	<!-- jQuery Modal -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

	<meta charset="UTF-8">
	<title></title>
<style>
	.ui.grid > .row {
		padding-bottom: 0;
	}

	.ui.table thead th {
		padding: 0;
	}

	.ui.table td {
		padding: .78571429em .2em .78571429em .2em;
	}

	.ui.compact.selection.dropdown {
		font-weight: 700;
		padding: 0;
	}

	.ui.modal > .actions {
		text-align: center;
	}
	
	.modal_alert_post{
		float: left;
	}
	
	.inf_post > * { 
		  margin-top: 15px; 
	}

	input[type="radio"] {  
	  margin-top: 20px; 
	}
	
	        #modal.modal-overlay {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(1.5px);
            -webkit-backdrop-filter: blur(1.5px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        #modal .modal-window {
            background: rgba( 69, 139, 197, 0.70 );
            box-shadow: 0 8px 32px 0 rgba( 31, 38, 135, 0.37 );
            backdrop-filter: blur( 13.5px );
            -webkit-backdrop-filter: blur( 13.5px );
            border-radius: 10px;
            border: 1px solid rgba( 255, 255, 255, 0.18 );
            width: 400px;
            height: 500px;
            position: relative;
            top: -100px;
            padding: 10px;
        }
        #modal .title {
            padding-left: 10px;
            display: inline;
            text-shadow: 1px 1px 2px gray;
            color: white;
            
        }
        #modal .title h2 {
            display: inline;
        }
        #modal .close-area {
            display: inline;
            float: right;
            padding-right: 10px;
            cursor: pointer;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
        
        #modal .content {
            margin-top: 20px;
            padding: 0px 10px;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
</style>	
	
<script>
$(function(){ 
	$("#alert_post").on("click", function(){
		var alert_post =$("#alert_post").val();
	    $.ajax({
	         type : "POST",
	         url  : "/blind/loadAlertReasonList",
	         dataType: "json",
	         success: function(result){
	          	//모달창에 데이터들을 입력하기 위한 코드
	     
	            //1.신고할 포스트의 제목과 작성자 닉네임을 로드 및 삽입.
				//  포스트의 글과 닉네임을 해당페이지에서 바로 modal에게로 전달하기 위한 코드.
				var postTitle = $('#sample_post_title').text(); 
				var nickName =  $('#sample_nickname_writer').text();		
				document.getElementById("postTitle").innerHTML=postTitle;
				document.getElementById("nickName").innerHTML=nickName;

				//2.신고할 사항들의 리스트
				$(alert_list_post).html(""); //초기화
				
				//추가시작
				$(alert_list_post).append("<ul>");
				$.each(result, function (key, value) {	
					$(alert_list_post).append("<li style='list-style:none;margin-right: 100px;'><input type='radio' name='alert_post_reason'  value=" + value.reportReasonCode + ">"+ value.reportReasonContents+"</li>");
				});
				$(alert_list_post).append("</ul>");
				$(alert_list_post).append("<textarea id='alert_write' style='width:100%; height:150px; resize: none;'></textarea>");
			
				//신고모달창 팝업
				$(".warp_alert_post").modal('show');
	         },
	         error: function(){
	            alert("에러");
	         }            
		});
	});
	   
	//신고 모달창의 '신고하기'버튼 라디오신고버튼 클릭여부확인
	$("#send_alert").on("click", function(){
		var selectAlertReason = $('input[name="alert_post_reason"]:checked').val();
		alert("선택라디오값 : "+selectAlertReason);
		if(typeof selectAlertReason == "undefined" || selectAlertReason == "" || selectAlertReason == null){ 
			alert("申告する理由を選んでください。"); //선택된 신고사항이 없기에 선택을 요청
		}else{
			alert("申告完了。");//
		}
	}); 	   
});




		

//--------------------------------------------------------------------------------------------------------]
/*
$(function(){ 
	$("#alert_post").on("click", function(){
		var alertType=$("#alert_post").val();
		var obj = 0;
		alert("alertType :"+alertType);
    	$.ajax({
			type : "POST",
		    url  : "/blind/loadAlertReasonList",
			data : alertType,
			dataType:"Json",
			success: function(result){

				alert("리턴성공 result:"+result);
				
				//포스트의 글과 닉네임을 해당페이지에서 바로 modal에게로 전달하기 위한 코드.
				var postTitle = $('#sample_post_title').text(); 
				var nickName =  $('#sample_nickname_writer').text();		
				document.getElementById("postTitle").innerHTML=postTitle;
				document.getElementById("nickName").innerHTML=nickName;
				
				$(".warp_alert_post").modal('show');
			},
			error: function(){
				alert("에러");
			}				
		});
	});
});
*/

//라디오 버튼- 활성/비활성 버튼 여부에 따라 텍스트 입력가능여부 설정
$(document).ready(function(){
    // 라디오버튼 클릭시 이벤트 발생
    $("input:radio[name=radio]").click(function(){
 
        if($("input[name=radio]:checked").val() == "1"){
            $("input:text[name=text]").attr("disabled",false);
            // radio 버튼의 value 값이 1이라면 활성화
 
        }else if($("input[name=radio]:checked").val() == "0"){
              $("input:text[name=text]").attr("disabled",true);
            // radio 버튼의 value 값이 0이라면 비활성화
        }
    });
});

//라디오 버튼 클릭시 값 출력
$(document).ready(function () {
    $('#radioButton').click(function () {
      // getter
      var radioVal = $('input[name="radioTxt"]:checked').val();
      alert(radioVal);
    });

    $('#radioButton2').click(function () {
      // setter
      // 선택한 부분을 세팅할 수 있다.
      $('input[name="radioTxt"]').val(['Banana']);
    });
  });

//라디오버튼 미선택시 경고팝업 체크
$(document).ready(function () {
    $('#testNoSelect').click(function () {
      // getter
      var radioVal = $('input[name="radio_test_alert"]:checked').val(); //radioTxt
      alert("radioVal : " +radioVal);
    });

    $('#radioCheckedClear').click(function () {
      // setter
      // 선택한 부분을 세팅할 수 있다.
      $('input[name="radioTxt"]').val(['Banana']);
    });
  });
</script>
	
</head>

<body>
	<!-- 게시글 가안입니다. 신고시 제목과 닉네임 전송을 묘사하기 위한 샘플 목적으로 만들어졌습니다. -->
	<div class="sample_post" style="margin:20px;">
		<div id="sample_post_title">
			<h3>this is sample_post_title.</h3>
		</div>
		<div id="sample_nickname_writer">
			<p>o****</p>
		</div>
		<div id="sample_post_contents">
			<p>sample_post_contents.</p>
		</div>
	</div>

	 
	<button id="alert_post" value="1">신고하기(포스트버전)</button>



<!-- [JQuery]라디오버튼 선택시 텍스트박스 활성화/비활성화  -->
<div style="width:200px;">
  <input type="radio" name="radio" id="r1" value="1" checked><label for="r1">활성화</label>
  <input type="radio" name="radio" id="r2" value="0"><label for="r2">비활성화</label>
</div>
<div style="width:200px;">
  <input type="text" name="text">
</div>

<!-- 라디오 버튼 값 출력 -->
    <ul>
      <li>
        <input type="radio" name="radioTxt" value="Apple" checked>Apple
      </li>
      <li>
        <input type="radio" name="radioTxt" value="Grape">Grape
      </li>
      <li>
        <input type="radio" name="radioTxt" value="Banana">Banana
      </li>
    </ul>
    <button type="button" name="button" id="radioButton">get radio Value</button>
    <button type="button" name="button" id="radioButton2">set radio Value</button>


<!-- 라디오 버튼 선택않을시 경고창 띄우기 -->
    <ul>
      <li>
        <input type="radio" name="radio_test_alert" value="alert_1">alert_1
      </li>
      <li>
        <input type="radio" name="radio_test_alert" value="alert_2">alert_2
      </li>
      <li>
        <input type="radio" name="radio_test_alert" value="alert_3">alert_3
      </li>
    </ul>
    <button type="button" name="radio_test" id="testNoSelect">라디오버튼테스트(선택X시 경고팝업)</button>
    <button type="button" name="radio_test" id="radioCheckedClear">라디오버튼 선택초기화</button>


</body>

</html>

	<!-- post 신고에 대한 모달창 -->
	<div class="modal">
		<div class="warp_alert_post">
			<div class="inf_post_title">
				<h1 style="display:inline;">신고하기(1.포스트버전)</h1>
				<div style="float:right;">
					<h1><a href="#" rel="modal:close"> X </a></h1>  
				</div>
			</div> 
			<div>
				<strong>作成者</strong>
				<div id="postTitle"><!-- 신고할 포스트의 제목이 jquery를 통해 입력됩니다. --></div>
			</div> 
			<div>
				<strong>タイトル</strong> 
				<div id="nickName"><!-- 신고할 포스트의 닉네임이 jquery를 통해 입력됩니다. --></div>
			</div>
		 	
			<div class="ui inverted divider"></div>

			<div id="alert_list_post">
				<!-- 제이쿼리(alert_post)를 통해 로드한 신고리스트들을 출력합니다. -->
			</div>		
			
			<button class="ui primary button" id="send_alert"
					style="width:100%; height:50px; text-align:center; margin-top: 10px;">
					신고하기
			</button>
			
		</div>	 
	</div>
