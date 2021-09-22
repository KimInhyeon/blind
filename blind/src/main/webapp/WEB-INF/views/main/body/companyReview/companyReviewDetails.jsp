<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="jp">
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
        /*모든 div들은 공통적으로 아래의 간격으로 거리를 띄우도록 설정.*/
        div{
            margin: 1.2%;
        }

        /*드래그를 방지하는 CSS*/
        div.stop-dragging
        {
            -ms-user-select: none;
            -moz-user-select: -moz-none;
            -khtml-user-select: none;
            -webkit-user-select: none;
            user-select: none;
        }
        .star-ratings {
            color: #aaa9a9;
            position: relative;
            unicode-bidi: bidi-override;
            width: max-content;
            -webkit-text-fill-color: transparent; /* Will override color (regardless of order) */
            -webkit-text-stroke-width: 1.3px;
            -webkit-text-stroke-color: #2b2a29;
        }

        .star-ratings-fill {
            color: #fff58c;
            padding: 0;
            position: absolute;
            z-index: 1;
            display: flex;
            top: 0;
            left: 0;
            overflow: hidden;
            -webkit-text-fill-color: gold;
        }

        .star-ratings-base {
            z-index: 0;
            padding: 0;
        }
    </style>

	<script>
		//役立ちます(도움이 되었습니다/기업리뷰추천수)를 카운트 및 출력하는 기능.
		function helpfulSet(nowCompanyId, companyReviewId) {
			var helpfulId = "#helpfulSet"+companyReviewId;
			$.ajax({
				type: "POST",
				url: "/blind/helpfulSet",
				data: { nowCompanyId
						,companyReviewId },
				dataType: "json",
				success: function (result) {
					if (result == 1) { //1:DB 추가완료
						alert('「役立ちます」登録完了。');
						//$(bookmarkId).html("<a><i class='bookmark icon'></i></a>");
					}
					else if (result == 0) {
						alert('「役立ちます」解除完了。 ');
						//$(bookmarkId).html("<a><i class='bookmark outline icon'></i></a>");
					}
				},
				error: function () {
					alert("システムエラーです。");
				}
			});
		}
	</script>

</head>
<body>
<div class="ui fluid container" id="reviewHeader" style="padding:80px 0; background-color:black">

</div>
<div class="ui container">
	<div style="padding-top:20px;">
		<button style="margin-top:30px;"class="blue ui right floated button"  onclick="location.href='${pageContext.request.contextPath}/companyReviewWrite?companyId=${companyIntroduction.companyId}';"  >
			この会社をレビューする
		</button>
		<img class="ui left floated image" src="${pageContext.request.contextPath}/resources/images/company/${companyIntroduction.companyId}.png" width="90px" height="90px" ></img>
		<div style="margin-top:10px;" >
			<h2>${companyIntroduction.companyName }</h2>
			<p style="line-height:0.rem;">★${companyIntroduction.realAllPoint } (${reviewCount }個のレビュー)</p>
		</div>
	</div>
</div>
<div class="ui container">
	<div class="ui top attached tabular menu" style="font-size:1.2rem;">
		<div class="item" onclick="location.href='${pageContext.request.contextPath}/companyIntroduction?companyId=${companyProfile[0].companyId}'" style="display:flex; justify-content:center; width:15%; cursor:pointer;">紹介</div>
		<div class="active item" onclick="location.href='${pageContext.request.contextPath}/companyShowReview?companyId=${companyProfile[0].companyId}'" style="display:flex; justify-content:center; width:15%; cursor:pointer;">レビュー</div>
		<div class="item" style="display:flex; justify-content:center; width:15%; cursor:pointer;">掲示板</div>
		<div class="item" onclick="location.href='${pageContext.request.contextPath}/annualIncome/annualIncome?selectCompanyId=${companyProfile[0].companyId}'" style="display:flex; justify-content:center; width:15%; cursor:pointer;">年棒</div>
		<div class="item" style="display:flex; justify-content:center; width:15%; cursor:pointer;">ニュース</div>
	</div>

    <!-- 기업리뷰 페이지 전체를 wrap 하는 div-->
    <div style="margin: 3%;">
        <!-- 1.기업리뷰 1개 출력부분.-->
        <div style="padding: 2%;">
            <!-- 1.1.기업리뷰1개-헤더부분. 별점/제목(한줄평)/작성자정보(닉네임,업종,작성일)/신고버튼 배치.-->
			<!-- 추가옵션 버튼(신고하기 등) -->
			<div style="float: right;">
				<div class="ui button" style="background: white; margin:0px;" data-position="bottom center">
					<i class="ellipsis horizontal icon" style="font-size: 1.2em;"></i></div>
				<div class="ui flowing popup top left transition hidden">
					<div class="column" data-position="bottom left">
						<button class="alert_modal_start"
								onclick="alertModalStart(
									'0008'
									,0
									,'${companyReviewLists[0].companyReviewId}'
									,0
									,'${companyReviewLists[0].userNickname}'
									,'${companyReviewLists[0].simpleComment}'
								)">
							<!-- 신고유형. 0008은 기업리뷰 신고(currentAlertType) -->
							<!-- 신고할 기업리뷰의 id(currentCompanyReviewId) -->
							<!-- replyId. 여기서는 기업리뷰 신고인 관계로 없음 의미로 0을 입력. -->
							<!-- 신고할 기업리뷰의 id(currentCompanyReviewId) -->
							<!-- nickName(신고할 포스트의 닉네임) -->
							<!-- 신고할 포스트의 제목(simpleComment) -->
							申告する(企業レビュー)
						</button>
					</div>
				</div>
			</div>
            <div style="padding: 0.5%;">
                <div style="padding: 1%;display: flex;">
                    <!-- 헤더파트1.별점 정보& 신고버튼 배치-->
                    <div style="font-size: 1.6em; ">
                        ${companyReviewLists[0].allPoint}
                    </div>
                    <div class="div_star" style="display: inline-block;">
                        <div class="ui star rating"
                             data-rating="${companyReviewLists[0].allPoint}"
                             data-max-rating="5">
                        </div>
                    </div>

                    <!-- 별점(별이미지로 표현) 다음으로 각 항목 볼수 있도록 하는 드롭다운.-->
                    <div>
                        <div class="div_star">
                            <div class="ui button" style="background: white; margin:0px;"
                                 data-position="bottom center"><i class="angle down icon"></i></div>
                            <div class="ui flowing popup top left transition hidden">
                                <div class="column" data-position="bottom left">
                                    <div class="div_star">
                                        <div class="ui star rating" data-rating=${companyReviewLists[0].careerPoint}
                                             data-max-rating="5"　style="margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">キャリア向上</span>
                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating"
                                             data-rating=${companyReviewLists[0].workLifeBalancePoint}
                                             data-max-rating="5"　style="margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">ワークライフバランス</span>
                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating"
                                             data-rating=${companyReviewLists[0].companyCulturePoint}
                                             data-max-rating="5"　style="float:left; margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">社内文化</span>
                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating" data-rating=${companyReviewLists[0].payPoint}
                                             data-max-rating="5"　style="float:left; margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">給料と福祉</span>
                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating" data-rating=${companyReviewLists[0].headPoint}
                                             data-max-rating="5"　style="float:left; margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">経営陣</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </div>

            <!-- 1.2.기업리뷰1개-본문내용. -->
            <!-- <div style="background-color: #573A08; padding: 0.5%;"> -->
            <div style="padding: 0.5%;">
				<!-- 기업리뷰1개-본문-1.한줄평&작성자 정보 (구)헤더파트2.한줄평&작성자 정보-->
				<div style="padding: 0.5%;">
					<!-- 기업리뷰의 제목(한줄평)-->
					<span style="font-size: 2em;font-weight: bold;"> ${companyReviewLists[0].simpleComment} </span>

					<!-- 기업리뷰 작성자의 정보를 출력 -->
					<div  style="padding-top:1.2%;">
						<span style="padding-right: 1.3%; "> </span>  <!-- 리뷰 작성자의 현직원/전직원 여부 -->
						<span style="padding-right: 1.3%; "> ${companyReviewLists[0].userNickname} </span>  <!-- 리뷰 작성자의 닉네임-->
						<span style="padding-right: 1.3%; "> </span>  <!-- 리뷰 작성자의 직군 .-->
						<span style="padding-right: 1.3%; "> ${companyReviewLists[0].recCreateDate} </span> <!-- 리뷰 작성일 -->

					</div>
				</div>
				<!-- 기업리뷰1개-본문-2.기업 장점 출력-->
				<div  style="padding-top:1.2%;">
                    <span style="font-size: 1.5em;font-weight: bold;">長所</span>
                    <div style="font-size: 1.3em;"> ${companyReviewLists[0].advantages}</div>
                </div>
				<!-- 기업리뷰1개-본문-2.기업 단점 출력-->
				<div  style="padding-top:1.2%;">
                    <span style="font-size: 1.2em;font-weight: bold;">短所</span>
					<div style="font-size: 1.3em;">${companyReviewLists[0].disadvantages}</div>
                </div>
            </div>

            <!-- 1.3.기업리뷰1개-푸터역할. 추천(도움이됩니다)버튼, 공유(트윗/페북/URL복사)기능-->
            <!-- <div style="background-color: plum; padding-bottom : 10%;">-->
            <div style="padding-bottom : 10%;">
                <div style="float:left;">
					<div class="ui primary button"
						 id="helpfulSet${companyReviewLists[0].companyReviewId}"
						 onclick="helpfulSet( ${nowCompanyId}
						 					  ,${companyReviewLists[0].companyReviewId})">
						<i class="thumbs up icon"></i>
						役立ちます(${companyReviewLists[0].countHelpful})
					</div>
				<!-- 페이스북,트위터등 공유링크  -->                    
                </div>
                 <div style="float:right;"><!-- 우측배치 -->
                    <i class="twitter icon" style="font-size: 2.5em;"></i>
                    <i class="facebook icon" style="font-size: 2.5em;"></i>
                    <i class="external alternate icon" style="font-size: 2.5em;"></i>
                </div>
            </div>


        </div>  <!--1.1개의 기업리뷰(샘플역할) div영역 종료 -->

        <!-- 2.리뷰페이지로 리턴하는 버튼 -->
        <div style="background-color: #3d698e;
               		cursor: pointer;
		            margin-top: 2.0%;
		            margin-bottom: 2.0%;
                    padding: 1.2%; ">           <!-- 클릭영역 넓히기 위해 패딩적용.-->
            <i class="arrow left icon"></i>
            「${companyName}」のレビューをすべて見る
            
        </div>

        <!-- 3.이외기업리뷰글들 리스트형으로 출력.-->
        <div>
			<div style="padding : 2%; border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;"></div>
	
	        <c:forEach items="${companyReviewLists}" var="reviews" varStatus="status">	
			<!-- 1.1.기업리뷰1개-헤더부분. 별점/제목(한줄평)/작성자정보(닉네임,업종,작성일)/신고버튼 배치.-->
			<div style="padding: 0.5%;">
	       		<div style="padding: 1%;display: flex;">
	        	<!-- 헤더파트1.별점 정보& 신고버튼 배치-->
	            <div style="font-size: 1.6em; ">${companyReviewLists[0].allPoint}</div>
	    	    <div class="div_star" style="display: inline-block;">
	        		<div class="ui star rating"data-rating="${companyReviewLists[0].allPoint}"data-max-rating="5"></div>
	           	</div>
				
				<!-- 별점(별이미지로 표현) 다음으로 각 항목 볼수 있도록 하는 드롭다운.-->
	            <div>
					<div class="div_star">
		            		<div class="ui button" style="background: white; margin:0px;"
		              	         data-position="bottom center"><i class="angle down icon"></i>
		                    </div>
		                   	<div class="ui flowing popup top left transition hidden">
		   	            		<div class="column" data-position="bottom left">
		                             <div class="div_star">
		                           	    <div class="ui star rating" 
		                           	    	 data-rating=${companyReviewLists[0].careerPoint} data-max-rating="5" style="margin-right:10px;">
		                                </div>
		                                <span style="margin-right:10px;">キャリア向上</span>
		                             </div>
			                         
			                         <div class="div_star">
			                            <div class="ui star rating"
			                                 data-rating=${companyReviewLists[0].workLifeBalancePoint} data-max-rating="5"　style="margin-right:10px;">
			                            </div>
			                            <span style="margin-right:10px;">ワークライフバランス</span>
			                      	</div>
			                    
			                        <div class="div_star">
			                             <div class="ui star rating"
			                                  data-rating=${companyReviewLists[0].companyCulturePoint} data-max-rating="5"　style="float:left; margin-right:10px;">
			                             </div>
		                          	 	 <span style="margin-right:10px;">社内文化</span>
		                            </div>
		                            
			                        <div class="div_star">
			                        	<div class="ui star rating" 
			                        		 data-rating=${companyReviewLists[0].payPoint} data-max-rating="5"　style="float:left; margin-right:10px;">
			                            </div>
			                            <span style="margin-right:10px;">給料と福祉</span>
			                        </div>
			                        
			                        <div class="div_star">
			                       		<div class="ui star rating" 
			                       			 data-rating=${companyReviewLists[0].headPoint} data-max-rating="5"　style="float:left; margin-right:10px;">
			                            </div>
			                 	        <span style="margin-right:10px;">経営陣</span>
			                        </div>
		   	            		</div>
		                   	</div>
						</div>
	            	</div>
				
					<!-- 헤더파트2.한줄평&작성자 정보 / '(구)헤더파트2.한줄평&작성자 정보'가 업데이트되면 변경예정. -->
		            <div style="padding: 1.5%;">
		            	<span style="font-size: 1.3em;"> ${companyReviewLists[0].simpleComment} </span>
		           	    <!-- 리뷰작성자 근무기업, 닉네임, 작성일자 등등...  -->
		                <!-- 리뷰작성자 근무기업은 미기재/리뷰작성자의 근무기업이름 갖고오도록 sql 갱신할 것.-->
		                <div>${companyReviewLists[0].userNickname}</div>
		                <div>${companyReviewLists[0].recCreateDate}</div>
		            </div>
				</div>
				
		      		<!-- 1.2.기업리뷰1개-본문내용. -->
		      		<div style="background-color : #555555; padding-top: 5%; padding-bottom: 5%;"><!--원래 부모역할(위로 먼저나옴. 리뷰작성을 독려하는 멘트 및 버튼 배치)-->
                 		<div style="position: relative;"> <!-- new 부모-->
                     	 	<!--자식역할(기업리뷰내용. 블러등으로 내용 못보게 처리.) -->
	                     	<div class='stop-dragging',
	                        	  style="position: absolute; -webkit-filter: blur(3px);padding: 0.5%;">  <!-- -webkit-filter : css 블러(글씨흐림)효과 -->
	                     	<!-- 블러가 적용되는 구간(시작) -->
	                 		   	<div>
	                    			<span style="font-size: 1.2em;">長所</span>
	                    			<div>${companyReviewLists[0].advantages}</div>
	                			</div>
		                		<div>
		                    		<span style="font-size: 1.2em;">短所</span>
				                    <div>${companyReviewLists[0].disadvantages}</div>
				                </div>
	               		      	<!-- 블러가 적용되는 구간(종료) -->
	                     	</div>
	
		                    <div style="position: relative;">
	     	                   <div style="text-align: center;">
	            	                <i class="lock icon" style="color: #ffffff; font-size: 5em;"></i>
	        	                </div>
	                	        <div style="text-align: center; color: #ffffff; font-weight:bold ; font-size: 1.5em;">
	                    	        企業のレビューを書いたら、すべてのレビューを読むことができます！
	                        	</div>
	                        	<div style="text-align: center;">
	                            	<button class="ui primary button" style="margin-top: 3%; padding: 2%;">
	                                	企業のレビューを書く
	                           		</button>
	                        	</div>
	                    	</div>
                		</div>
		            </div>


		            <!-- 1.3.기업리뷰1개-푸터역할. 추천(도움이됩니다)버튼, 공유(트윗/페북/URL복사)기능-->

   	       		</div>
			</div>    	        
			<div style="padding : 2%; border-color: #d4d4d5; border-width: thin !important; border-bottom-style: inset;"></div>
			</c:forEach>
		</div>       
        
        
        <div  style="background-color: gray;">
            <!-- jstl의 foreach문을 통하여 계속 출력하도록 설정예정. -->

            <!--
            <p>블러효과&드래그방지 적용</p>
            <div class='stop-dragging'
                 style="-webkit-filter: blur(3px);      /*-webkit-filter : css 블러(글씨흐림)효과 */
                         background-color: #c86f11;">
                블러효과 테스트
            </div>
            -->
            
			<!-- 예제2-블러 및 드래그방지까지적용. 주석을 쓸 수 없어 id에 주석사항을 기재.id내용 참고바람.-->
			<!-- 
            <div id="부모역할">
                 <div id="새 부모역할" style="position: relative;"> 
                     <div id="자식역할(기업리뷰내용. 블러등으로 내용 못보게 처리.)"
                     	 class='stop-dragging',
                          style="position: absolute;
                         -webkit-filter: blur(3px);">     
                     	[!]기업리뷰내용(밑에 깔리고 블러로 가려질 글)
                     </div>

                    <div style="position: relative;">
                        <div style="text-align: center;">
                            <i class="lock icon"></i>
                        </div>
                        <div style="text-align: center;">
                            企業のレビューを書いたら、すべてのレビューを読むことができます！
                        </div>
                        <div style="text-align: center;">
                            <button class="ui primary button">
                                企業のレビューを書く
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            -->
        </div>
    </div>

	<!--신고하기(send_alert)를 할 때 전송할 값을 줄 수 있도록 임시로 값을 저장. -->
	<input type="hidden" value="" id="currentAlertType" />
	<input type="hidden" value="" id="currentPostId" />
	<input type="hidden" value="" id="currentCompanyReviewId" />
	<input type="hidden" value="" id="currentReplyId" />

</body>

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

<script>
    $('.button')
        .popup({
            inline: true,
            hoverable: true
        });
    $('.ui.rating')
        .rating('disable');

	//1.신고모달창을 팝업실시.
	function alertModalStart(alertType, postId, companyReviewId, replyId, targetUserNickname, targetTitle){
    	//신고하기 전에 hidden에 미리 정보를 저장. send_alert 함수를 실행때 사용할 수 있도록 저장.
    	document.getElementById("currentAlertType").value = alertType;
		document.getElementById("currentPostId").value = postId;
		document.getElementById("currentCompanyReviewId").value = companyReviewId;
		document.getElementById("currentReplyId").value = replyId;

		//DB에서 신고유형(포스트/기업리뷰/댓글)에 따라 신고할 목록을 로드.
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
					//document.getElementById("alertTitle").innerHTML=$('#post_title').text();
					//document.getElementById("nickName").innerHTML=$('#post_nickname').text();
				}
				else if(selectedAlertType=="0008")
				{
					document.getElementById("alertTitle").innerHTML=targetUserNickname;
					document.getElementById("nickName").innerHTML=targetTitle;
				}
				else if(selectedAlertType=="0012")
				{
					//document.getElementById("alertTitle").innerHTML=$('#reply_title').text();
					//document.getElementById("nickName").innerHTML=$('#reply_nickname').text();
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
			//신고정보들을 집계.
			//2.1.신고사유 및 유형
			var alertType = $('#currentAlertType').val();
			var reportReasonCode = $('input[name="alert_post_reason"]:checked').val(); //유저가 라디오 버튼에서 선택한 신고사유.

			//2.2.신고대상ID(0이 입력된 경우는 없음과 같음.)
			var postId = $('#currentPostId').val();
			var companyReviewId = $('#currentCompanyReviewId').val();
			var replyId = $('#currentReplyId').val();

			alert("send_alertType : "+alertType );
			alert("send_postId : "+postId );
			alert("send_currentCompanyReviewId : "+companyReviewId );
			alert("send_replyId : "+replyId );

			if(typeof reportReasonCode == "undefined" || reportReasonCode == "" || reportReasonCode == null){
				alert("申告する理由を選んでください。"); //선택된 신고사항이 없기에 선택을 요청
			}else{
				$.ajax({
					type : "POST",
					url  : "/blind/sendAlert",
					data : { postId
							,companyReviewId
							,replyId
							,reportReasonCode
							,alertType
							,report_reason_content : $("#report_reason_content").val()
					},
					dataType: "json",
					success: function(result){
						if(result ==1){
							alert("申告の受付を完了しました。");
							$('#alert_modal').modal('hide');
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
	//신고하기 관련 AJAX 끝.

</script>

</html>