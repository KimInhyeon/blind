<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ja">
<head>
	<!-- Remember to include jQuery :) -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
	<script src="../semantic/semantic.js"></script>
	
	<!-- jQuery Modal -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

	<meta charset="UTF-8">
	<title>企業管理</title>
</head>
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
</style>
<body>
	<!-- 모달작성 참고 웹사이트 https://jquerymodal.com/ -->
	<!-- Link to open the modal -->
	<p><a href="#ex1" rel="modal:open">신고하기(포스트버전)</a></p>
	
	<!-- Modal HTML embedded directly into document -->
	<div id="ex1" class="modal">
		<div class="modal_alert_post">
			<div>
				<h1 style="display:inline;">신고하기(1.포스트버전)</h1>
				<div style="float:right;"> <h1><a href="#" rel="modal:close">Close</a></h1>  </div>
			</div> 
			<div class="inf_post">
				<div class="inf_post_writer"><strong>작성자</strong>a****</div> 
				<div class="inf_post_title"><strong>제목</strong> </div>
			</div>
		 	
		 	<div class="ui inverted divider"></div>
		 
			<div class="alert_list_post">
			  	<ul style="list-style:none;">
					<li><input type="radio" name="alert_post_reason"  value="1"> 토픽에 맞지 않는 글</li>
					<li><input type="radio" name="alert_post_reason"  value="2"> 욕설 / 비하발언</li>
					<li><input type="radio" name="alert_post_reason"  value="3"> 특정인 비방	</li>	
					<li><input type="radio" name="alert_post_reason"  value="4"> 개인 사생활 침해</li>	
					<li><input type="radio" name="alert_post_reason"  value="5"> 19+ 만남 / 쪽지유도</li>	
					<li><input type="radio" name="alert_post_reason"  value="6"> 음란성</li>				 
					<li><input type="radio" name="alert_post_reason"  value="7"> 회사 기밀</li>	
					<li><input type="radio" name="alert_post_reason"  value="8"> 게시글 / 댓글 도배</li>	
					<li><input type="radio" name="alert_post_reason"  value="9"> 시즈널 이벤트, 추천인 코드 등 </li>				 
					<li><input type="radio" name="alert_post_reason"  value="10"> 홍보성 컨텐츠</li>	 
					<li><input type="radio" name="alert_post_reason"  value="11"> 퇴사자 신고</li>	 
					<li><input type="radio" name="alert_post_reason"  value="12"> 닉네임 신고</li>	 
					<li><input type="radio" name="alert_post_reason"  value="13"> 부적절한 회사 / 채널 태그</li>	 
					<li><input type="radio" name="alert_post_reason"  value="14"> 기타 </li>	 
				</ul>
				<textarea id="alert_write" style="width:400px; height:150px; resize: none;"></textarea>
			</div>		
				<button class="ui primary button" style="width:400px; height:50px; text-align:center;">신고하기</button>
		</div>	 		  	
	</div>

	<div id="ex2" class="modal">
		<div class="modal_alert_post">
			<h1>신고하기(2.기업리뷰버전)</h1> 
			<div class="inf_post">
				<div class="inf_post_writer"><strong>작성자</strong>a****</div> 
				<div class="inf_post_title"><strong>제목</strong> </div>
			</div>
		
			<div class="alert_list_post">
			  	<ul style="list-style:none;"><!-- 한국경우 1번(토픽에 맞지 않는 글) 제외하면 동일함. -->
					<li><input type="radio" name="alert_post_reason"  value="1">${alertListOfPost}</li><!-- 욕설 / 비하발언 -->
					<li><input type="radio" name="alert_post_reason"  value="2"> </li><!-- 특정인 비방 -->
					<li><input type="radio" name="alert_post_reason"  value="3"> </li><!-- 개인 사생활 침해 -->	
					<li><input type="radio" name="alert_post_reason"  value="4"> 19+ 만남 / 쪽지유도</li>	<!--  -->
					<li><input type="radio" name="alert_post_reason"  value="5"> 음란성</li>	<!--  -->
					<li><input type="radio" name="alert_post_reason"  value="6"> 회사 기밀</li>		<!--  -->		 
					<li><input type="radio" name="alert_post_reason"  value="7"> 게시글 / 댓글 도배</li>	<!--  -->
					<li><input type="radio" name="alert_post_reason"  value="8"> 시즈널 이벤트, 추천인 코드 등</li>	<!--  -->
					<li><input type="radio" name="alert_post_reason"  value="9"> 홍보성 컨텐츠</li>				 <!--  -->
					<li><input type="radio" name="alert_post_reason"  value="10"> 퇴사자 신고</li>	 <!--  -->
					<li><input type="radio" name="alert_post_reason"  value="11"> 닉네임 신고</li>	 <!--  -->
					<li><input type="radio" name="alert_post_reason"  value="12"> 부적절한 회사 / 채널 태그</li><!--  -->	 
					<li><input type="radio" name="alert_post_reason"  value="13"> </li>	 <!-- 기타 -->
				</ul><!-- textarea는 기타버튼 클릭시에만 작동하도록 수정. -->
				<textarea id="alert_write" style="width:400px; height:150px; resize: none;"></textarea>
			</div>		
				<button class="ui primary button" style="width:400px; height:50px; text-align:center;">신고하기</button>
		</div>	 		  	
	</div>

	<div id="ex2" class="modal">
		<div class="modal_alert_post">
			<h1>신고하기(3.댓글버전)</h1> 
			<div class="inf_post">
				<div class="inf_post_writer"><strong>작성자</strong>a****</div> 
				<div class="inf_post_title"><strong>제목</strong> </div>
			</div>
		
			<div class="alert_list_post">
			  	<ul style="list-style:none;">
					<li><input type="radio" name="alert_post_reason"  value="1"> 토픽에 맞지 않는 글</li>
					<li><input type="radio" name="alert_post_reason"  value="2"> 욕설 / 비하발언</li>
					<li><input type="radio" name="alert_post_reason"  value="3"> 특정인 비방	</li>	
					<li><input type="radio" name="alert_post_reason"  value="4"> 개인 사생활 침해</li>	
					<li><input type="radio" name="alert_post_reason"  value="5"> 19+ 만남 / 쪽지유도</li>	
					<li><input type="radio" name="alert_post_reason"  value="6"> 음란성</li>				 
					<li><input type="radio" name="alert_post_reason"  value="7"> 회사 기밀</li>	
					<li><input type="radio" name="alert_post_reason"  value="8"> 게시글 / 댓글 도배</li>	
					<li><input type="radio" name="alert_post_reason"  value="9"> 시즈널 이벤트, 추천인 코드 등 </li>				 
					<li><input type="radio" name="alert_post_reason"  value="10"> 홍보성 컨텐츠</li>	 
					<li><input type="radio" name="alert_post_reason"  value="11"> 퇴사자 신고</li>	 
					<li><input type="radio" name="alert_post_reason"  value="12"> 닉네임 신고</li>	 
					<li><input type="radio" name="alert_post_reason"  value="13"> 부적절한 회사 / 채널 태그</li>	 
					<li><input type="radio" name="alert_post_reason"  value="14"> 기타 </li>	 
				</ul>
				<textarea id="alert_write" style="width:400px; height:150px; resize: none;"></textarea>
			</div>		
				<button class="ui primary button" style="width:400px; height:50px; text-align:center;">신고하기</button>
		</div>	 		  	
	</div>

	
</body>
<script>
	function confirm() {
		if (window.confirm('更新しますか？')) {
			console.log('test');
		}
	}

	function openModal() {
		$().modal('show');
	}

	$(function () {
		$('#checkAll').change(function () {
			if ($(this).is(':checked')) {
				$('input[name=companyID]').not(':checked').click();
			} else {
				$('input[name=companyID]').click();
			}
		});

		$('input[name=companyID]').change(function () {
			const $checkbox = $(this);
			if ($checkbox.is(':checked')) {
				$checkbox.closest('tr').addClass('warning');
			} else {
				$checkbox.closest('tr').removeClass('warning');
			}
		});
	});
</script>
</html>