<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	/*사용하는 기기의 스크린화면별 동적CSS*/
	/*@media screen and (max-width:1799px) {
		#mypage_wrap{ background-color: red; }	
	}
	
	@media screen and (max-width:1199px) {
		#mypage_wrap{ background-color: green; }
	}
	
	@media screen and (max-width:899px) {
			#mypage_wrap{ background-color: blue; }
	}
	
	@media screen and (max-width:599px) {
		#mypage_wrap{ background-color: black; }
	}*/
	
	
	/* 1. 마이페이지 전체 일괄적용css ---------------------------------------------------------------------- */
	/* 1.1. 마이페이지 전체를 감싸는 div */
	#mypage_wrap{ 				
		text-align:center;	 		/*자식 div에게 'display: inline-block;' 속성을 줘야 가운데 정렬이 적용된다.*/
		width:50%;
	}	

	/* 1.2. <a>태그의 설정. */
	a {
	  text-decoration-line: none;	/*<a>의 밑줄속성 삭제*/
	}
	
	/* 1.3.폰트 옵션 모음*/
	 .mypage_common_font{
	 	font-size: 1.2em;
	 }
	
	/* 2.헤더부분 css ------------------------------------------------------------------------------ */
	.mypage_header{
		font-size: 2.5em;
		margin:2%;
	}
	
	/* 3.메인(유저프로필, 버튼들) -----------------------------------------------------------------------*/

	/* 3.0. 메인 전체를 적용 */
	/*yes*/
	.mypage_main_wrap{
		text-align:center; 					/*내부에 배치되는 중앙정렬할 div에게 display: inline-block; 속성을 줘야 적용된다.*/
	}


	/* 3.1. 메인-유저프로필(닉네임,이메일,소속기업명 출력부분) */
	.mypage_main_textmargin{ /**/
		font-size: 1.0em;		
		margin-left: -15%;
		margin-top: 7%;
	}


	.mypage_buttontap_name{ /*각 버튼탭들의 정렬설정(좌측정렬)*/
		text-align:left;
		margin:3%;
	}


	.mypage_buttontap_wrap{ /*버튼탭 내에 배치되는 버튼명과 '>'아이콘을 묶어주는 영역*/
		text-align:left;
		margin:3%;
	}

	.mypage_button_style_wrap{ 		/*버튼 각각의 바탕배경색 및 간격설정. mypage_button_style_button_name과 mypage_button_style_button_icon을 감싸는 역할.*/
		background-color: #ffffff; 
		margin: 2%; 
		padding: 1.5%;			
		cursor: pointer;
	} 	
	
	.mypage_button_style_button_icon{ /*'>'아이콘의 정렬 및 폰트크기 설정.*/
		text-align: right;
		font-size: 1.5em;
	} 
	</style>

	<script>
	$(function(){
		//1.현재의 비밀번호를 입력. 본인이 맞는지를 확인.
		$("#inputCurrentPassword").on('keyup', function(){	
			var inputCurrentPassword= $("#inputCurrentPassword").val();
			//alert("inputNowPassword:"+inputNowPassword);
			
			$.ajax({
				type:"POST",
			    url: "checkCurrentPassword",
				data : { inputCurrentPassword },
				dataType:"json",
				success: function(result){
					//입력 텍스트 창 밑에 결과(일치여부) 출력.
					if(result ==1){
						$(check1_current_password).html(""); //초기화(기존내용 삭제)
						$(check1_current_password).append("パスワードが一致します。");
					}
					else if(result ==0){
						$(check1_current_password).html(""); //초기화(기존내용 삭제)
						$(check1_current_password).append("パスワードが一致しません。");
					}
				},
				error: function(){
					alert("エラー");
				}				
			});
		}); 	
		
		//2.신규로 사용할 비밀번호 조건부합여부 체크
		$("#inputNewPassword").on('keyup', function(){	
			var inputNewPassword= $("#inputNewPassword").val();
			//alert("inputNewPassword:"+inputNewPassword);

			if( inputNewPassword.search(/\s/) != -1 ){ //조건체크1. 공백불허
				$(check2_new_password).html("");
				$(check2_new_password).append("空白文字は使用できません。");		
			    return false;
			}
			
			else if(inputNewPassword.length<8){       //조건체크2. 8자 이상
				$(check2_new_password).html("");
				$(check2_new_password).append("8字以上してください。");				
			    return false;
			}
			
			else if(inputNewPassword.length>32){     //조건체크3. 32자 이하
				$(check2_new_password).html("");
				$(check2_new_password).append("32字以内にしてください。");				
			    return false;
			}
			
			else{									//위의 모든 조건들을 통과시 
				$(check2_new_password).html("");
				$(check2_new_password).append("使うのができるパスワードです。");			
			}
	
		}); 

	
	
		//3.신규 비밀번호 1번더 입력의 일치여부 확인
		$("#repeatNewPassword").on('keyup', function(){	
			var repeatNewPassword= $("#repeatNewPassword").val() ;
			//alert("repeatNewPassword:" + repeatNewPassword );

			var inputNewPassword= $("#inputNewPassword").val() ;
			//alert("inputNewPassword:" + inputNewPassword );

			
			if(repeatNewPassword == inputNewPassword){
				$(check3_repeat_new_password).html("");
				$(check3_repeat_new_password).append("新しいパスワードと一致します。");			
			}
			else{
				$(check3_repeat_new_password).html("");
				$(check3_repeat_new_password).append("新しいパスワードと一致しません。");			
			}
	
		}); 
	}); 	
	</script>
</head>


<body>
	<div id="mypage_wrap" >
		<div class="mypage_header">
			<div style="display: inline-block; position:absolute;">
				アカウントの情報変更
			</div>	
			<div class="mypage_button_style_button_icon">	
				<a><i class="sign out alternate icon"></i></a>
			</div>
		</div>
		
		<div id="mypage_main_wrap">
			<div style="text-align:left;">
				パスワード変更
			</div>
		
			<div style="background-color: #71736e; padding: 1%;">
				
				<!-- 1.현재의 비밀번호 입력 -->
				<div class="mypage_buttontap_name">												
					現在のパスワード
				</div>
					
				<div class="mypage_buttontap_wrap"> 												
					<div class="mypage_button_style_wrap" style="margin:-3%;"> 	
					
						<input type="password" placeholder="現在のパスワードを入力してください。"style="width:100%"
								id="inputCurrentPassword">
					</div>	
					<div class="mypage_button_style_wrap" style="margin:-3%;"
					   	 id="check1_current_password" > 	
					</div>
				</div>

				<!-- 2.새로 사용할 비밀번호 입력 -->
				<div class="mypage_buttontap_name">												
					新しいパスワード
				</div>
					
				<div class="mypage_buttontap_wrap"> 												
					<div class="mypage_button_style_wrap" style="margin:-3%;"> 	
						<input type="text" placeholder="8〜32字で英語、数字、特殊記号を使っているください。"style="width:100%"
						id="inputNewPassword">
					</div>	
					<div class="mypage_button_style_wrap" style="margin:-3%;"
					   	 id="check2_new_password" > 	
					</div>
				</div>

				<div class="mypage_buttontap_name">												
					新しいパスワード確認
				</div>
					
				<div class="mypage_buttontap_wrap"> 												
					<div class="mypage_button_style_wrap" style="margin:-3%;"> 	
						<input type="新しいパスワードをもう一同入力してください。" style="width:100%"
						id="repeatNewPassword">
					</div>	
					<div class="mypage_button_style_wrap" style="margin:-3%;"
					   	 id="check3_repeat_new_password" > 
					</div>
				</div>
						
			</div>
		</div>
	</div>
</body>
</html>