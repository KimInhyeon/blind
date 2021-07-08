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
		<table class="ui celled table" style="width:100%;margin:20px;">
			<thead>
				<tr>
			    	<th>分類</th>
				    <th>情報1</th>
				    <th>情報2</th>
				    <th>文のタイトル</th>
				    <th>作成者のニックネーム</th>
				    <th>申告する ボタン</th>
		  		</tr>
			</thead>
			<tbody>
		    	<tr>	   
				    <td data-label="alert_type"> post	</td>
					<td data-label="code_data"> post_id : ${postId} </td>
			    	<td data-label="code_data"> user_id : ${userId} </td>
			      	<td data-label="title">
				      	<div id="post_title">
							<h3>this is post title.</h3>
						</div>
					</td>
		        	<td data-label="post_nickname">
		     			<div id="post_nickname">
							<p>p****</p>
						</div>
					</td>
				    <td data-label="alert_button">
				    	<button class="alert_modal_start" onclick="alertModalStart(this.value)" value="0006">申告する（ポスト）</button>
				    </td>
		    	</tr>
		   		<tr>	   
			    	<td data-label="alert_type"> 企業レビュー </td>
					<td data-label="code_data"> company_review_id : ${companyReviewId} </td>
		    		<td data-label="code_data"> user_id : ${userId} </td>
		      		<td data-label="title">
			      		<div id="company_review_title">
							<h3>this is company review title.</h3>
						</div>
					</td>
		        	<td data-label="company_review_nickname">
		     			<div id="company_review_nickname">
							<p>c****</p>
						</div>
			  		</td>
					<td data-label="alert_button">
			     		<button class="alert_modal_start" onclick="alertModalStart(this.value)" value="0008">申告する(企業レビュー)</button>
			      	</td>
		    	</tr>	    
			    <tr>	   
				    <td data-label="alert_type"> コメント </td>
					<td data-label="code_data"> reply_id : ${replyId} </td>
			    	<td data-label="code_data"> user_id : ${userId} </td>
			      	<td data-label="title">
				      	<div id="reply_title"> 
							<h3>this is reply title.</h3>
						</div>
					</td>
			        <td data-label="writer_nickname">
			     		<div id="reply_nickname">
							<p>r****</p>
						</div>
			  </td>
		      <td data-label="alert_button">
		     		<button class="alert_modal_start" onclick="alertModalStart(this.value)" value="0012">申告する(コメント)</button>
		      </td>
		    </tr>
		  </tbody>
		</table>
		
	<!--신고 모달창-->
	<div id="alert_modal" data-backdrop="static" data-keyboard="false">
		<div class="warp_alert_modal">
			<div class="inf_title">
				<h2 style="display:inline;">申告する</h2>
      		    <div style="float:right;" id="modal_close_btn">X</div> 
				
				<div align='left'>
					<span>作成者</span> 
					<span id="nickName"><!-- 신고할 포스트의 닉네임이 입력됩니다. --></span>
				</div>
				
				<div align='left'>
					<span style="display: inline;">タイトル</span>
					<span id="alertTitle"><!-- 신고할 포스트의 제목이 입력됩니다. --></span>
				</div> 
			</div> 
			
			<div class="ui inverted divider"></div>

			<div id="alert_reason_list">
				<!-- 유형에 해당하는 신고목록 출력합니다. -->
			</div>		
			
			<div id="alert_reason_textarea">
				<!-- textarea를 로드 -->
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
	//1.신고모달창을 팝업실시.
   	function alertModalStart(alertType){
  		document.getElementById("currentAlertType").value = alertType;
  		$.ajax({
    	         type : "POST",
    	         url  : "/blind/loadAlertReasonList",
    	         data : { alertType },
    	         dataType: "json",
    	         success: function(result){
     	            //1.신고할 포스트의 제목과 작성자 닉네임을 로드 및 모달창에 삽입.
    	            var selectedAlertType =$('#currentAlertType').val(); 

     	            if(selectedAlertType=="0006")
     	            {
     	            	document.getElementById("alertTitle").innerHTML=$('#post_title').text();
     	                document.getElementById("nickName").innerHTML=$('#post_nickname').text();        
     	            }
     	            else if(selectedAlertType=="0008")
	                {
     	            	document.getElementById("alertTitle").innerHTML=$('#company_review_title').text();
     	                document.getElementById("nickName").innerHTML=$('#company_review_nickname').text();             
	                }        
     	            else if(selectedAlertType=="0012")
     	            {
     	            	document.getElementById("alertTitle").innerHTML=$('#reply_title').text();
     	                document.getElementById("nickName").innerHTML=$('#reply_nickname').text();             	                      
     	            }
     	            
    				//2.신고할 사항들의 리스트
    				$(alert_reason_list).html(""); 		//신고목록(라디오버튼)을 출력할 부분 초기화
    				$(alert_reason_textarea).html("");  //기타입력시 부분 초기화.
    				
    				//신고목록(라디오버튼)배치
    				$.each(result, function (key, value) {	
    					$(alert_reason_list).append("<div align='left'><input type='radio' onclick='textOnOff();' name='alert_post_reason' id=" + value.reportReasonCode + " value=" + value.reportReasonCode + ">"+ value.reportReasonContents+"</div>");
 					});
    				
    				//textarea 배치
    				 $(alert_reason_textarea).append("<textarea id='report_reason_content' style='width:100%; height:150px; resize: none;' disabled> </textarea>");

    				$('#alert_modal').modal({ closable: false }); //모달밖을 클릭해도 닫히지 않도록 설정.
    				$('#alert_modal').modal('show');
    	         },
    	         error: function(){
 		            alert("システムのエラーです。管理者にお問い合わせください。");
    	         }            
    		});
    	};

    	//2.신고를 하는 코드
 		$(function(){ 		
        	$("#send_alert").on("click", function(){
            	var reportReasonCode = $('input[name="alert_post_reason"]:checked').val();            		
            	var alertType =$('#currentAlertType').val();            		
    		
          		if(typeof reportReasonCode == "undefined" || reportReasonCode == "" || reportReasonCode == null){ 
            		alert("申告する理由を選んでください。"); //선택된 신고사항이 없기에 선택을 요청
            	}else{
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
            		         success: function(result){
            		        	 alert("result : "+result);
            		        	if(result ==1){
                		 			alert("申告の受付を完了しました。");       		        		
            		        	}
            		        	else if (result ==0){
                		            alert("システムのエラーです。管理者にお問い合わせください。");
                		    	}
            		         },
            		         error: function(){
            		            alert("システムのエラーです。管理者にお問い合わせください。");
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
	   		if(reportReasonCode ==20){
	   			 //その外 선택시 textarea 활성화
			 	 $(alert_reason_textarea).html(""); //초기화
				 $(alert_reason_textarea).append("<textarea id='report_reason_content' style='width:100%; height:150px; resize: none;'> </textarea>");
			}else{
				//その外가 아닌 다른 라디오버튼을 클릭시 textarea 비활성화
			 	 $(alert_reason_textarea).html(""); //초기화		
				 $(alert_reason_textarea).append("<textarea id='report_reason_content' style='width:100%; height:150px; resize: none;' disabled> </textarea>");
			}
				
		}
	</script>
</html>