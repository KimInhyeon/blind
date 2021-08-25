<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
    <title></title>
    <script>
	    function searchCompany() {
            $('#selectList').html("");
            var searchKeyword = $('#searchKeyword').val();
            var resultHtml = "";
            var result = "";
            if (searchKeyword == "") {
                $('#selectList').html("");
              } else {
                  var check = $(".filterUL li:contains('"+searchKeyword+"')");//".filterUL li:contains('"+searchKeyword+"')"배열값이다.
                  for(var i =0 ; i<check.length;i++){
                      var companyArr=check[i].outerText.split('★');
                      resultHtml = resultHtml +
                      '<div style="display:flex;" onclick="companyNameClick(\''+companyArr+'\');" ><img class="ui avatar image" src="${pageContext.request.contextPath}/resources/images/company/'+companyArr[1]+'.png"><div class="content"><div class="header">'+companyArr[0]+'</div></div></div>';
                 }
                 result = $(".filterUL li:contains('"+searchKeyword+"')").show();
                 $('#selectList').append(resultHtml);
              }
	    };

    function companyNameClick(companyInfo){
    	var companyArr = companyInfo.split(',');
    	$('#selectList').html("");
    	$('#searchKeyword').val(companyArr[0]);
    	location.href='${pageContext.request.contextPath}/companyIntroduction?companyId=' + companyArr[1];
	 }; 
    </script>
    <style>
        .companysearchbox{
            padding:60px;
            align:center;
        }
        .companysearchbox p{
            font-size:17px;
        }
	    #searchbox{border-radius:50px; font-size:23px;}
	    #searchKeyword{border-radius:50px; border-color:black;}
        #searchKeyword::placeholder{font-size:15px; padding-left:15px;}
        #box{width:65%; padding:30px 0;}
        .companyapplymain a{
            color:black;
        }
        #apply{text-decoration:underline;}
        #companybackground{
            background-color:#ebf7fa;
            height:270px;
            margin-top:30px;
        }
        #imagetextback{
            background: url(${pageContext.request.contextPath}/resources/images/companymainjp.png) 0 0 no-repeat;
            height: 320px;
            top:-45px;
            background-position: 480px 0px;
            background-size: 618px 320px;
            position:relative;
        }
        #searchicon{padding-left:70px;}
        .bestcompanyname{font-size:15px; font-weight:700; color:black;}
        .div_star{padding-top:6px;}
        .div_tab{padding-top:8px;}
        .div_tab a{font-size:13px; padding-left:11px;}
        .div_tab a:first-child{padding-left:0px;}
        #bestcompanygrid .column:last-child{margin-bottom:100px;}

    /* 기업등록신청(BLIND_0013_企業登録申請) 모달창 css */
    #request_company_regist_modal { /*기업등록 신청 모달창의 크기등을 설정.*/
        display: none;
        width: 40%;
        height : auto;
        padding: 20px 20px;
        background-color: #ffffff;
        border-radius: 3px;
    }

    #request_company_regist_modal div{ /*request_company_regist_modal 내의 모든 div 옵션*/
        list-style:none;
        margin-bottom:15px;
    }
    </style>
</head>

<body>
	<div class="ui container">
        <div class="companysearchbox" align="center" >
    <h1 >現職者たちの会社レビュー。</h1>
    <p>実際の職員たちが評価する年俸と福祉はどうなのか確認してみてください。</p>
    
    <form name="searchForm" action="/blind/companyReviewMain" method="post" onsubmit="return false;">

    <div class="ui fluid big left icon input" id="box">
        <input class="prompt" type="text" id="searchKeyword" name="searchKeyword" onkeyup = "searchCompany()" placeholder="会社の名前を入力してください。" ></input>
        <i class="search icon" id="searchicon"></i>
        <div class="ui middle aligned selection list" id="selectList" style="margin-top: 65px;font-size: 0.8em;background-color:#999999;position:absolute;margin-left: 60px;"></div>
    </div>
    
    <div class="companyapplymain" align="center">
        お探しの会社がありませんか。
        <a href="#">
            <span id="apply" onclick="requestCompanyRegistModalStart()"
                  style="cursor:pointer">
                知りたい会社を直接申し込んでください。
            </span>
        </a>
        </div>
    </div>

    <ul class="filterUL" style="display: none;">
		<c:forEach items="${companyList}" var="company2">
			<li>${company2.companyName}★${company2.companyId }</li>
		</c:forEach>
	</ul>
   </form>
</div>

	<%-- <c:forEach items="${companyDto}" var="company">
	${company.companyName}
</c:forEach>  --%>
	<div class="ui fluid container" id="companybackground" >
        <div class="ui container" id="imagetextback">
            <h2 style="text-align:left; padding-top:130px;">私の会社をレビューする</h2>
    
            <p style="text-align:left;">会員様のレビューは、求職者が会社を 検討するのに役立ちます。</p>
        <button class="ui blue button" onclick="location.href='companyReviewWrite'" style="float:left; margin-top:10px; padding:15px 30px;">レビュー作成</button>
        </div>
    </div>

<div class="ui container" style="padding-top:75px;">
    <h3 align="left" style="font-size:20px;">ベスト会社</h3>
    <div class="ui three column grid" style="padding-top:30px;" id="bestcompanygrid">

	<c:forEach items="${companyJoinPopular}" var="company3" varStatus="count">      
            <div class="column"><!--회사-->
                <div class="ui segment">
                    <div style="display:inline-block;">
                    <img class="ui tiny left floated image" src="${pageContext.request.contextPath}/resources/images/company/${company3.companyId}.png">
                        <div style="display:inline-block;">
                        <a class="bestcompanyname" href="${pageContext.request.contextPath}/companyIntroduction?companyId=${company3.companyId}" style="display:inline-block;">${company3.companyName}</a>
                            <div class="div_star"> 
                                <div class="ui star rating" data-rating="${company3.allPoint}" data-max-rating="5"></div>${company3.realAllPoint}
                            </div>
                            <div class="div_tab">
                                <a class="" href="${pageContext.request.contextPath}/companyShowReview?companyId=${company3.companyId}">レビュー</a>
                                <a class="" href="#">掲示板</a>
                                <a class="" href="/blind/companyShowReview?companyId=${company3.companyId}">年収</a>
                                <a class="" href="#">採用</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </c:forEach>
    </div>
</div>

    <!--기업등록신청 모달창-->
    <div id="request_company_regist_modal" data-backdrop="static" data-keyboard="false">
        <div align='center' >
            <div> <!-- 모달창의 헤더(제목 및 닫기버튼)배치 -->
                <h1 style="display:inline; ;" >企業の登録申請</h1>
                <div style="float:right;" id="modal_close_btn">X</div>
            </div>

            <div align='left' style="margin-top:5%;width:80%;">  <!-- 작성을 위한 안내멘트 기입. -->
                <h2>知りたい企業の企業名と、企業のメールを入力してください！</h2>
            </div>

            <div align='center'>
                <div style="margin-top:5%;width:80%;">
                    <p align='left'>企業名</p>
                    <div class="ui input" style="width:100%;">
                        <input type="text" placeholder="企業名を入力してください。"
                               id="request_compnay_name">
                    </div>

                    <p align='left'>企業のメール</p>
                    <div class="ui input" style="width:100%;">
                        <input type="text" placeholder="企業のメールを入力してください。"
                               id="request_compnay_email">

                    </div>


                    <button class="ui primary button" id="send_request_company_regist"
                            style="width:30%; height:auto; text-align:center; margin-top: 20px;">
                        申し込む
                    </button>

                    <div align='left'
                         style="margin-top: 4%;">
                        <h3>お申し込みいただいた企業は、担当者の検証手続きに従って登録が進行されます。</h3>
                        <!-- 신청하신 기업은 담당자의 확인절차에 따라 등록이 진행됩니다. -->
                    </div>
                </div>

            </div>

        </div>
    </div>


    <script>
        $("#searchKeyword").focus(function(){
        $(this).css("border-color", "black");
        $(this).css("border-width", "1px");
        });
        $("#searchKeyword").blur(function(){
        $(this).css("border-color", "");
        $(this).css("border-width", "");
        });
        $('.ui.rating')
        .rating('disable');

        function test(){
            var aa = $("#stars").children('.selected').length;
            alert(aa);
        }


        // 기업등록신청(BLIND_0013_企業登録申請) 모달창을 위한 ajax 기능.

        //1.기업등록신청 모달(request_company_regist_modal)-팝업실시.
        function requestCompanyRegistModalStart(){
            $('#request_company_regist_modal').modal({ closable: false }); //모달밖을 클릭해도 닫히지 않도록 설정.
            $('#request_company_regist_modal').modal('show');
        };


        $(function(){
            $("#send_request_company_regist").on("click", function(){
                var requestCompnayName = $('#request_compnay_name').val();
                var requestCompnayEmail =$('#request_compnay_email').val();

                //alert("request_compnay_name :" + request_compnay_name);
                //alert("request_compnay_email :" + request_compnay_email);

                //입력검정-기업메일(기업입력메일이 공란시 ''으로 입력하여 정상처리되도록 실시)
                if((typeof requestCompnayEmail == "undefined" || requestCompnayEmail == "" || requestCompnayEmail == null)){
                    //유저가 기업메일을 입력하지 않아도 작동하도록 하고 있음.(기업입력메일이 공란시 ''으로 입력하여 정상처리되도록 실시)
                    requestCompnayEmail = '';
                    //alert("requestCompnayEmail :"+requestCompnayEmail); //체크용
                }

                if(typeof requestCompnayName == "undefined" || requestCompnayName == "" || requestCompnayName == null ){
                    //유저가 회사명 또는 회사메일을 기입않을시 참으로 간주하여 경고문 출력 및 기업등록신청 스톱처리.
                    alert("企業名を入力してください。"); //선택된 신고사항이 없기에 선택을 요청
                    false;
                }
                else{
                    $.ajax({
                        type : "POST",
                        url  : "/blind/sendRequestCompanyRegist",
                        data : { requestCompnayName
                            , requestCompnayEmail
                        },
                        dataType: "json",
                        success: function(result){
                            if(result ==1){
                                alert("申込みが完了しました。");
                                $('#request_company_regist_modal').modal('hide');
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
        });
  </script>

</body>
</html>