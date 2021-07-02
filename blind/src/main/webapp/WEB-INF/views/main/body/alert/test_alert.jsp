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
	//1.신고하기(포스트)
	//1.1. 신고모달창 팝업실시
	$("#alert_post").on("click", function(){
		var alert_post =$("#alert_post").val();
	    $.ajax({
	         type : "POST",
	         url  : "/blind/loadAlertReasonList",
	         dataType: "json",
	         success: function(result){
	             console.log("12345");
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
				$(alert_list_post).append("<textarea id='report_reason_content' style='width:100%; height:150px; resize: none;' disabled> </textarea>");
				
				//신고모달창 팝업
				$(".warp_alert_post").modal('show');
	         },
	         error: function(){
	            alert("에러");
	         }            
		});
	});

	
	//1.2.신고 모달창의 '신고하기'버튼 클릭시 신고이유 선택여부 확인.
	$("#send_alert").on("click", function(){
		var reportReasonCode = $('input[name="alert_post_reason"]:checked').val();
		var alertType =1; //맨처음 화면에서 alert_post 값이 넘어오지 않아서 전송버튼 클릭시로 변경.
		if(typeof reportReasonCode == "undefined" || reportReasonCode == "" || reportReasonCode == null){ 
			alert("申告する理由を選んでください。"); //선택된 신고사항이 없기에 선택을 요청
		}else{
			alert("신고시작。");
		    $.ajax({
		         type : "POST",
		         url  : "/blind/sendAlert",
		         data : { postId : ${postId}
						 ,userId : ${userId}
						 ,reportReasonCode
						 ,alertType
						 ,report_reason_content : $("#report_reason_content").val()
		         },
		         dataType: "json",
		         success: function(){
		            console.log("신고완료");
		 			alert("신고완료。");
		         },
		         error: function(){
		            alert("신고에러");
		         }            
			});
			
		}
	});
	
	$("input[name='alert_post_reason']").change (function () {
        //라디오 버튼 값을 가져온다.
        console.log("aaaaa");
   		var selectAlertReason = $('input[name="alert_post_reason"]:checked').val();
                        
        alert(selectAlertReason);            
	});
	
});
</script>
	
</head>

<body>
	<!-- 게시글 가안입니다. 신고시 제목과 닉네임 전송을 묘사하기 위한 샘플 목적으로 만들어졌습니다. -->
	<table class="ui celled table" style="width:100%;margin:20px;">
	  <thead>
	    <tr>
	    	<th>분류(전송시 구분값)</th>
		    <th>정보1</th>
		    <th>정보2</th>
		    <th>글 제목</th>
		    <th>작성자 닉네임</th>
		    <th>신고모달버튼</th>
	  	</tr>
	  </thead>
	  <tbody>
	    <tr>	   
		    <td data-label="alert_type">
				post(1)
		    </td>

			<td data-label="code_data">
				post_id : ${postId}
		    </td>
		    
	    	<td data-label="code_data">
				user_id : ${userId}
		    </td>
	    
	    
	      	<td data-label="title">
		      	<div id="sample_post_title">
					<h3>this is sample_post_title.</h3>
				</div>
			</td>

	      <td data-label="writer_nick_name">
	     		<div id="sample_nickname_writer">
					<p>o****</p>
				</div>
		  </td>
			
	      <td data-label="alert_button">
	     		<button id="alert_post" value="1">신고하기(포스트버전)</button>
	      </td>
	    </tr>
	    
	  </tbody>
	</table>

	
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
				<strong style="display: inline;">作成者</strong>
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
