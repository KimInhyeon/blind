<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="jp">
    <head>
        <meta charset="UTF-8" />
        <title>Alert Modal jsStyle</title>

        <style>
            #alert_modal {
                display: none;
                width: 400px;
                height : auto;
                padding: 20px 20px;
                background-color: #ffffff;
                border-radius: 3px;
            }

            #alert_modal .modal_close_btn {
                position: absolute;
                top: 10px;
                right: 10px;
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
		    	<th>분류(전송시 구분값)</th>
			    <th>정보1</th>
			    <th>정보2</th>
			    <th>글 제목</th>
			    <th>작성자 닉네임</th>
			    <th>신고모달버튼</th>
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
		     		<button id="alert_start_post" value="0006">신고하기(포스트버전)</button>
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
		     		<button id="alert_start_review" value="0008">申告する(企業レビュー)</button>
		      </td>
		    </tr>	    
		    <!-- 3.댓글 신고 예제 -->
		    <tr>	   
			    <td data-label="alert_type"> コメント(0012)	</td>
				<td data-label="code_data"> company_review_id : ${companyReviewId} </td>
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
		     		<button id="alert_start_review" value="0008">申告する(企業レビュー)</button>
		      </td>
		    </tr>
		  </tbody>
		</table>
		
	<!-- 신고에 대한 모달창(신고모달은 공통으로 활용) -->
	<div id="alert_modal">
		<div class="warp_alert_modal">
			<div class="inf_post_title">
				<h2 style="display:inline;">申告する(ポスト)</h2>
				<div style="float:right;"> <a href="#" rel="modal:close"> X </a> </div>
			</div> 
			<div>
				<strong style="display: inline;">作成者</strong>
				<div id="alertTitle"><!-- 신고할 포스트의 제목이 jquery를 통해 입력됩니다. --></div>
			</div> 
			<div>
				<strong>タイトル</strong> 
				<div id="nickName"><!-- 신고할 포스트의 닉네임이 jquery를 통해 입력됩니다. --></div>
			</div>
		 	
			<div class="ui inverted divider"></div>

			<div id="alert_reason_list">
				<!-- 제이쿼리(alert_post)를 통해 로드한 신고리스트들을 출력합니다. -->
			</div>		
			
			<button class="ui primary button" id="send_alert"
					style="width:100%; height:50px; text-align:center; margin-top: 20px;">
					신고하기
			</button>
			
		</div>	 
	</div>	


	</body>
	    
	<script>

	
	//신고하기-신고모달창 팝업실시(포스트/기업리뷰/댓글 공통활용)
  	//컨트롤러의 loadAlertReasonList 를 통해 신고이유 리스트들을 로드. 
		$(function(){ 		
           	$("#alert_start_post").on("click", function(){
          		var alertType ="0006";
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
            				$(alert_reason_list).html(""); //초기화
            				
            				//신고할 리스트들을 추가시작
            				$.each(result, function (key, value) {	
            					$(alert_reason_list).append("<div  align='left'><input type='radio' name='alert_post_reason'  value=" + value.reportReasonCode + ">"+ value.reportReasonContents+"</div>");
         					});
            				$(alert_reason_list).append("<textarea id='report_reason_content' style='width:100%; height:150px; resize: none;'> </textarea>");
            				//라디오버튼 변경시마다 코드값을 못받아서 disable의 해제가 불가. $(alert_reason_list).append("<textarea id='report_reason_content' style='width:100%; height:150px; resize: none;' disabled> </textarea>");
            				//신고모달창 팝업
            				$('#alert_modal').modal({ closable: false });
            				$('#alert_modal').modal('show');
            	         },
            	         error: function(){
            	            alert("에러");
            	         }            
            		});

            	});
            	
            	//1.2.신고 모달창의 '신고하기'버튼 클릭시 신고이유 선택여부 확인.
            	$("#send_alert").on("click", function(){
            		var reportReasonCode = $('input[name="alert_post_reason"]:checked').val();
            		var alertType =0006; //맨처음 화면에서 alert_post 값이 넘어오지 않아서 전송버튼 클릭시로 변경.
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
                				$('#alert_modal').modal('hide');
            		         },
            		         error: function(){
            		            alert("신고에러");
            		         }            
            			});
            			
            		}
            	});
            	
            	
            	//맞는 코드인데 작동을 못하고 있음.
            	$("input[name='alert_post_reason']:radio").change(function () {
                    //라디오 버튼 값을 가져온다.
                    alert('qqqqq');
            		var reportReasonCode = $('input[name="alert_post_reason"]:checked').val();
                    console(reportReasonCode);          
                    alert(reportReasonCode);            
            	});

            	
            });
	</script>
</html>