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

	/* 1. 마이페이지 전체 일괄적용css ---------------------------------------------------------------------- */
	/* 1.1. 마이페이지 전체를 감싸는 div */
	#mypage_wrap{ 				
		text-align:center;	 		/*자식 div에게 'display: inline-block;' 속성을 줘야 가운데 정렬이 적용된다.*/
		width:50%;
	}	

	/* 1.2. <a>태그의 설정. */
    a { text-decoration: none; color: black; }
    a:visited { text-decoration: none;color: black;  }
    a:hover { text-decoration: none; color: black; }
    a:focus { text-decoration: none; color: black; }
    a:hover, a:active { text-decoration: none; color: black; }
	
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
		text-align:center; 	/*내부에 배치되는 중앙정렬할 div에게 display: inline-block; 속성을 줘야 적용된다.*/
	}


	/* 3.1. 메인-유저프로필(닉네임,이메일,소속기업명 출력부분) */
	.mypage_main_textmargin{ /**/
		font-size: 1.0em;		
		margin-left: -15%;
		margin-top: 7%;
	}


	.mypage_passwordtap_name{ /*각 버튼탭들의 정렬설정(좌측정렬)*/
		text-align:left;
		margin:3%;
	}


	.mypage_passwordtap_wrap{ /*버튼탭 내에 배치되는 버튼명과 '>'아이콘을 묶어주는 영역*/
		text-align:left;
		margin:3%;
	}

	.mypage_password_style_wrap{ 		/*버튼 각각의 바탕배경색 및 간격설정. mypage_button_style_button_name과 mypage_button_style_button_icon을 감싸는 역할.*/
		background-color: #ffffff; 
		margin: 2%; 
		padding: 1.5%;			
		cursor: pointer;
	} 	
 	 
	.mypage_button_style_button_icon{ /*'>'아이콘의 정렬 및 폰트크기 설정.*/
		display:inline-block;
		float : right;
		font-size: 1.5em;
	} 
	</style>

	<script>
	$(function(){
	
		//각 입력들의 조건부합 여부 체크
		var checkFlag1_inputCurrentPassword = 0;
	    var checkFlag2_inputNewPassword = 0;
	    var checkFlag3_repeatNewPassword = 0;
	    
	    var inputCurrentPassword;
	    var inputNewPassword;
	   
	      //1.현재의 비밀번호를 입력. 본인이 맞는지를 확인.
		$("#inputCurrentPassword").on('keyup', function(){	
			inputCurrentPassword= $("#inputCurrentPassword").val();
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
						$(check1_current_password).append("<span style='color: blue;'>パスワードが一致します。</span>");
						checkFlag1_inputCurrentPassword=1;
					}
					else if(result ==0){
						$(check1_current_password).html(""); //초기화(기존내용 삭제)
						$(check1_current_password).append("<span style='color: red;'>パスワードが一致しません。</span>");
						checkFlag1_inputCurrentPassword=0;
					}
				},
				error: function(){
					alert("エラー");
				}				
			});
		}); 	
		
		//2.신규로 사용할 비밀번호 조건부합여부 체크
		$("#inputNewPassword").on('keyup', function(){	
			inputNewPassword= $("#inputNewPassword").val();
			//alert("inputNewPassword:"+inputNewPassword);
			
			if( inputNewPassword.search(/\s/) != -1 ){ //조건체크1. 공백불허
				$(check2_new_password).html("");
				$(check2_new_password).append("<span style='color: red;'>空白文字は使用できません。</span>");		
				checkFlag2_inputNewPassword=0;	
			    return false;
			}
			
			else if(inputNewPassword.length<8){       //조건체크2. 8자 이상
				$(check2_new_password).html("");
				$(check2_new_password).append("<span style='color: red;'>8字以上してください。</span>");				
				checkFlag2_inputNewPassword=0;
				return false;
			}
			
			else if(inputNewPassword.length>32){     //조건체크3. 32자 이하
				$(check2_new_password).html("");
				$(check2_new_password).append("<span style='color: red;'>32字以内にしてください。</span>");				
				checkFlag2_inputNewPassword=0;
				return false;
			}
			
			else if(inputNewPassword.length>32){     //조건체크4. 기존비밀번호와 일치여부(기존비밀번호와 같을경우 불가처리)
				$(check2_new_password).html("");
				$(check2_new_password).append("<span style='color: red;'>既存のパスワードと同じです。</span>");				
				checkFlag2_inputNewPassword=0;
				return false;
			}
			
			else{									//위의 모든 조건들을 통과시 
				$(check2_new_password).html("");
				$(check2_new_password).append("<span style='color: blue;'>使うのができるパスワードです。</span>");			
				checkFlag2_inputNewPassword=1;
			}
		}); 
	
		//3.신규 비밀번호 1번더 입력의 일치여부 확인
		$("#repeatNewPassword").on('keyup', function(){	
			var repeatNewPassword= $("#repeatNewPassword").val() ;
			//var inputNewPassword= $("#inputNewPassword").val() ;

			//alert("repeatNewPassword:" + repeatNewPassword );
			//alert("inputNewPassword:" + inputNewPassword );

			if(checkFlag1_inputCurrentPassword==1 && checkFlag2_inputNewPassword==1  ){//먼저 기존비밀번호의 확인 및 신규비밀번호의 생선조건 부합여부를 통과하였는지 체크.
				
				if(repeatNewPassword == inputNewPassword){
					checkFlag3_repeatNewPassword = 1;
					$(check3_repeat_new_password).html("");
					$(check3_repeat_new_password).append("<span style='color: blue;'>新しいパスワードと一致します。</span>");			
				}
				else{
					checkFlag3_repeatNewPassword = 0;
					$(check3_repeat_new_password).html("");
					$(check3_repeat_new_password).append("<span style='color: red;'>新しいパスワードと一致しません。新しいパスワードを入力してください。</span>");			
					return false;
				}
			
			}
			else{	//기존비밀번호의 확인을 안 받았거나(check1), 신규비밀번호의 생선조건 부합여부(check2)를 통과않을 시 불허처리.
				checkFlag3_repeatNewPassword = 0;
				$(check3_repeat_new_password).html("");
				$(check3_repeat_new_password).append("<span style='color: red;'>既存のパスワードや新規パスワードを確認してください。</span>");			
				return false;
			}
		}); 
		
		//4.비밀번호 갱신 실시
		$("#updateToNewPassword").on('click', function(){	

			//기존의 비밀번호, 신규비밀번호, 신규비밀번호1회 재입력 까지 3가지 사항을 모두 완료한 경우에만 신규비밀번호로 업데이트 하도록 실시.
			if(checkFlag1_inputCurrentPassword==1 && checkFlag2_inputNewPassword==1  && checkFlag3_repeatNewPassword==1 ){
				//alert("비밀번호변경실시");
	
				$.ajax({
					type:"POST",
				    url: "updateToNewPassword",
					data : { inputCurrentPassword,
	 						  inputNewPassword},
					dataType:"json",
					success: function(result){
						alert("パスワードの変更が完了しました。");
					},
					error: function(){
						alert("エラー");
					}				
				});
				
				
			}
			else{
				alert("パスワードの変更ができません。入力内容を確認してください。");			
				return false;
			}

		}); 
		
		
		//5. 로그아웃 실시
		$("#logout").on('click', function(){	
			$.ajax({
				type:"POST",
			    url: "logout",
				success: function(result){
					alert("ログアウトを完了しました。");
					location.replace(result.url);  //로그인 페이지로 이동하도록실시.
				},
				error: function(){
					alert("エラー");
				}				
			});
		}); 	
		
	}); 	
	</script>
</head>


<body>
	<div id="mypage_wrap" >
		<div class="mypage_header">
			<div style="display: inline-block; position: absolute; left: 0; font-size: 1.5em;">
				<a href="/blind/member/mypage"><i class="angle left icon"></i></a>
			</div>
			
			<div style="display: inline-block; position: relative; ">
				アカウントの情報変更
			</div>	
			<div class="mypage_button_style_button_icon">	
				<i class="sign out alternate icon"></i>	<!-- logout Button -->
			</div>
		</div>
		
		<div id="mypage_main_wrap">
			<div style="text-align:left;">
				パスワード変更
			</div>
		
			<div style="background-color: #71736e; padding: 1%;">
				
				<!-- 1.현재의 비밀번호 입력 -->
				<div class="mypage_passwordtap_name">												
					現在のパスワード
				</div>
					
				<div class="mypage_passwordtap_wrap"> 												
					<div class="mypage_password_style_wrap" style="margin:-3%;"> 	
					
						<input type="password" placeholder="現在のパスワードを入力してください。"style="width:100%"
								id="inputCurrentPassword">
					</div>	
					<div class="mypage_password_style_wrap" style="margin:-3%;"
					   	 id="check1_current_password" > 	
					</div>
				</div>

				<!-- 2.새로 사용할 비밀번호 입력 -->
				<div class="mypage_passwordtap_name">												
					新しいパスワード
				</div>
					
				<div class="mypage_passwordtap_wrap"> 												
					<div class="mypage_password_style_wrap" style="margin:-3%;"> 	
						<input type="password" placeholder="8〜32字で英語、数字、特殊記号を使っているください。" 
							   style="width:100%" id="inputNewPassword">
					</div>	
					<div class="mypage_password_style_wrap" style="margin:-3%;" 
					   	 id="check2_new_password" class="check_result_view"> 	
					</div>
				</div>

				<div class="mypage_passwordtap_name">												
					新しいパスワード確認
				</div>
					
				<div class="mypage_passwordtap_wrap"> 												
					<div class="mypage_password_style_wrap" style="margin:-3%;"> 	
						<input type="password" 
							   placeholder="新しいパスワードをもう一同入力してください。" style="width:100%"
							   id="repeatNewPassword">
					</div>	
					<div class="mypage_password_style_wrap" style="margin:-3%;"
					   	 id="check3_repeat_new_password" > 
					</div>
				</div>
						
			</div>
		</div>
		<button class="ui primary button" style="margin:3%;" 
			   id="updateToNewPassword" value="パスワードを更新します。">
		 	パスワードを更新します。
		</button>
</body>
</html>