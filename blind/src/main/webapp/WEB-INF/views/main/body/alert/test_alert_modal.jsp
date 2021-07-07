<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="jp">
    <head>
        <meta charset="UTF-8" />
        <title>Alert Modal</title>

        <style>
            #alert_modal {
                display: none;
                width: 400px;
                height : auto;
                padding: 20px 20px;
                background-color: #ffffff;
                border-radius: 3px;
            }
            
             #alert_modal div{
	            list-style:none;
	            margin-bottom:15px;
            }

        </style>
    </head>

    <body>
		<!-- 게시글 가안입니다. 신고시 제목과 닉네임 전송을 묘사하기 위한 샘플 목적으로 만들어졌습니다. -->
		<table class="ui celled table" style="width:100%;margin:20px;">
		  <thead>
		    <tr>
		    	<th>分類(区分値)</th>
			    <th>情報1</th>
			    <th>情報2</th>
			    <th>文のタイトル</th>
			    <th>作成者のニックネーム</th>
			    <th>申告する ボタン</th>
		  	</tr>
		  </thead>
		  <tbody>
		  <!-- 1.포스트 신고 예제 -->
		    <tr>	   
			    <td data-label="alert_type"> post(0006)	</td>
				<td data-label="code_data"> post_id : ${postId} </td>
		    	<td data-label="code_data"> user_id(신고자 유저id) : ${userId} </td>
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
		     		<button class="alert_modal_start" onclick="alertModalStart(this.value)" value="0006">申告する（ポスト）</button>
		     		
		      </td>
		    </tr>
		  <!-- 2.기업리뷰 신고 예제 -->
		    <tr>	   
			    <td data-label="alert_type"> 企業レビュー(0008)	</td>
				<td data-label="code_data"> company_review_id : ${companyReviewId} </td>
		    	<td data-label="code_data"> user_id(신고자 유저id) : ${userId} </td>
		      	<td data-label="title">
			      	<div id="sample_company_review_title"> <!-- 신고 모달화면에 띄우기 용 -->
						<h3>this is sample_company_review_title.</h3>
					</div>
				</td>
		        <td data-label="writer_nick_name">
		     		<div id="sample_nickname_writer">
						<p>o****</p>
					</div>
			  </td>
		      <td data-label="alert_button">
		     		<button class="alert_modal_start" onclick="alertModalStart(this.value)" value="0008">申告する(企業レビュー)</button>
		      </td>
		    </tr>	    
		    <!-- 3.댓글 신고 예제 -->
		    <tr>	   
			    <td data-label="alert_type"> コメント(0012)	</td>
				<td data-label="code_data"> reply_id : ${replyId} </td>
		    	<td data-label="code_data"> user_id(신고자 유저id) : ${userId} </td>
		      	<td data-label="title">
			      	<div id="sample_company_review_title"> <!-- 신고 모달화면에 띄우기 용 -->
						<h3>this is sample_reply_title.</h3>
					</div>
				</td>
		        <td data-label="writer_nick_name">
		     		<div id="sample_nickname_writer">
						<p>o****</p>
					</div>
			  </td>
		      <td data-label="alert_button">
		     		<button class="alert_modal_start" onclick="alertModalStart(this.value)" value="0012">申告する(コメント)</button>
		      </td>
		    </tr>
		  </tbody>
		</table>
		
	<!-- 신고에 대한 모달창(신고모달은 공통으로 활용) -->
	<div id="alert_modal" data-backdrop="static" data-keyboard="false">
		<div class="warp_alert_modal">
			<div class="inf_post_title">
				<h2 style="display:inline;">申告する</h2>
      		    <div style="float:right;" id="modal_close_btn">X</div> <!--  -->
			</div> 
			
			<div align='left'>
				<span>作成者</span> 
				<span id="nickName"><!-- 신고할 포스트의 닉네임이 jquery를 통해 입력됩니다. --></span>
			</div>
			<div align='left'>
				<span style="display: inline;">タイトル</span>
				<span id="alertTitle"><!-- 신고할 포스트의 제목이 jquery를 통해 입력됩니다. --></span>
			</div> 
		 	
			<div class="ui inverted divider"></div>

			<div id="alert_reason_list">
				<!-- 제이쿼리(alert_post)를 통해 로드한 신고리스트들을 출력합니다. -->
			</div>		
			
			<div id="alert_reason_textarea">
				<!-- 제이쿼리(alert_post)를 . -->
			</div>		
			
			<button class="ui primary button" id="send_alert"
					style="width:100%; height:50px; text-align:center; margin-top: 20px;">
					申告する
			</button>
		</div>	 
	</div>	

	<input type="hidden" value="" id="currentAlertType"> <!-- 신고종류(포스트/기업리뷰/댓글)를 구분하는 값을 임시저장. -->

	</body>
	    
	<script>
	//1.신고모달창 팝업실시(포스트/기업리뷰/댓글 공통활용)
   	function alertModalStart(alertType){
  		//alert("alert_modal_start_post - alertType : "+alertType); //신고구분값 확인용
  		document.getElementById("currentAlertType").value = alertType;
  		$.ajax({
    	         type : "POST",
    	         url  : "/blind/loadAlertReasonList",
    	         data : { alertType },
    	         dataType: "json",
    	         success: function(result){
    	          	//모달창에 데이터들을 입력하기 위한 코드
    	     
    	            //1.신고할 포스트의 제목과 작성자 닉네임을 로드 및 삽입.
    				//  포스트의 글과 닉네임을 해당페이지에서 바로 modal에게로 전달하기 위한 코드.
    				var alertTitle = $('#sample_post_title').text(); 
    				var nickName =  $('#sample_nickname_writer').text();		

    				document.getElementById("alertTitle").innerHTML=alertTitle;
    				document.getElementById("nickName").innerHTML=nickName;

    				//2.신고할 사항들의 리스트
    				$(alert_reason_list).html(""); //신고목록(라디오버튼)을 출력할 부분 초기화
    				$(alert_reason_textarea).html(""); //기타입력시 부분 초기화.
    				
    				//신고할 리스트들을 추가시작
    				$.each(result, function (key, value) {	
    					$(alert_reason_list).append("<div align='left'><input type='radio' onclick='textOnOff();' name='alert_post_reason' id=" + value.reportReasonCode + " value=" + value.reportReasonCode + ">"+ value.reportReasonContents+"</div>");
 					});
    				 $(alert_reason_textarea).append("<textarea id='report_reason_content' style='width:100%; height:150px; resize: none;' disabled> </textarea>");

    				 //신고모달창 팝업
    				$('#alert_modal').modal({ closable: false }); //모달밖을 클릭해도 닫히지 않도록 설정.
    				$('#alert_modal').modal('show');
    	         },
    	         error: function(){
    	            alert("もダルのエラーです。");
    	         }            
    		});
    	};

    	//2.신고하기 모션(포스트/기업리뷰/댓글 공통활용)
 		$(function(){ 		
        	$("#send_alert").on("click", function(){
            	var reportReasonCode = $('input[name="alert_post_reason"]:checked').val();            		
            	var alertType =$('#currentAlertType').val();            		
    		
          		if(typeof reportReasonCode == "undefined" || reportReasonCode == "" || reportReasonCode == null){ 
            		alert("申告する理由を選んでください。"); //선택된 신고사항이 없기에 선택을 요청
            	}else{
            		alert("受付中です。少々お待ちください。");
            		    $.ajax({
            		         type : "POST",
            		         url  : "/blind/sendAlert",
            		         data : { postId : ${postId}
            		    			 ,companyReviewId : ${ companyReviewId }
            		    			 ,replyId : ${replyId}
            						 ,userId : ${userId}
            						 ,reportReasonCode
            						 ,alertType
            						 ,report_reason_content : $("#report_reason_content").val()
            		         },
            		         dataType: "json",
            		         success: function(){
            		 			alert("申告の受付を完了しました。");
                				$('#alert_modal').modal('hide');
            		         },
            		         error: function(){
            		            alert("エラーが発生しました。");
            		         }            
            			});
            		}
            	});
     
                $("#modal_close_btn").on("click", function(){ //신고되면 모달창을 닫도록 함.
                    $('#alert_modal').modal('hide');
                });
            	
		});
		
 		//report_reason_content(textarea)의 입력 활성화/비활성화 설정
		function textOnOff(){ 
	        var reportReasonCode = $('input[name="alert_post_reason"]:checked').val();        
	        //alert(reportReasonCode);    //선택한 값 확인용
	   		if(reportReasonCode ==20){
	   			//その外인 경우에는 textarea 활성화
			 	 $(alert_reason_textarea).html(""); //초기화
				 $(alert_reason_textarea).append("<textarea id='report_reason_content' style='width:100%; height:150px; resize: none;'> </textarea>");
			}else{
				//その外가 아닌 라디오버튼들이 클릭시 textarea 비활성화
			 	 $(alert_reason_textarea).html(""); //초기화		
				 $(alert_reason_textarea).append("<textarea id='report_reason_content' style='width:100%; height:150px; resize: none;' disabled> </textarea>");
			}
				
		}
	</script>
</html>