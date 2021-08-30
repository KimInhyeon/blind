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
</head>
<body>
    <!-- 기업리뷰 페이지 전체를 wrap 하는 div-->
    <div style="margin: 3%; background-color:darkred;">

        <!-- 1.기업리뷰 1개 출력부분.-->
        <div style="background-color: #0d71bb;
                    padding: 2%;">

            <!-- 1.1.기업리뷰1개-헤더부분. 별점/제목(한줄평)/작성자정보(닉네임,업종,작성일)/신고버튼 배치.-->
            <div style="background-color:#2e3032; padding: 0.5%;">
                <div style="background-color:#0ea432;
                            padding: 1%;
                            display: flex;">
                    <!-- 헤더파트1.별점 정보& 신고버튼 배치-->
                    <div style="font-size: 1.6em; ">
                        2.5
                    </div>
                    <div class="div_star" style="display: inline-block;">
                        <div class="ui star rating"
                             data-rating="2"
                             data-max-rating="5">
                        </div>
                    </div>

                    <div>
                        <!-- 별점(별이미지로 표현) 다음으로 각 항목 볼수 있도록 하는 드롭다운.-->
                        <div class="div_star">
                            <div class="ui button" style="background: white; margin:0px;"
                                 data-position="bottom center"><i class="angle down icon"></i></div>
                            <div class="ui flowing popup top left transition hidden">
                                <div class="column" data-position="bottom left">
                                    <div class="div_star">
                                        <div class="ui star rating" data-rating="2"
                                             data-max-rating="5"　style="margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">キャリア向上</span>
                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating"
                                             data-rating="3"
                                             data-max-rating="5"　style="margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">ワークライフバランス</span>
                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating"
                                             data-rating="4"
                                             data-max-rating="5"　style="float:left; margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">社内文化</span>
                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating" data-rating="5"
                                             data-max-rating="5"　style="float:left; margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">給料と福祉</span>
                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating" data-rating="1"
                                             data-max-rating="5"　style="float:left; margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">経営陣</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                    <!-- 신고버튼 -->
                    <div class="ui icon button" data-content="Add users to your feed">
                        <i class="add icon"></i>
                    </div>

                </div>

                <!-- 헤더파트2.한줄평&작성자 정보-->
                <!-- <div style=" dispaly:block; background-color: #9f3a38"> -->
                <div style=" dispaly:block; >
                    <span style="font-size: 1.3em;"> testComment1 </span>
                    <div>(✿╹◡╹) キンちゃん_testMan </div> <!-- 작성자 근무기업, 닉네임, 작성 등등...  -->
                </div>


            </div>

            <!-- 1.2.기업리뷰1개-본문내용. -->
            <!-- <div style="background-color: #573A08; padding: 0.5%;"> -->
            <div style="padding: 0.5%;">
                <!-- 1.2.기업리뷰1개-본문내용. 장점 내용 배치.-->
                <div>
                    <span style="font-size: 1.2em;">장점</span>
                    <div>
                        장점 내용을 출력합니다.
                    </div>
                </div>
                <!-- 1.2.기업리뷰1개-본문내용. 단점 내용 배치.-->
                <div>
                    <span style="font-size: 1.2em;">단점</span>
                    <div>
                        단점 내용을 출력합니다.
                    </div>
                </div>
            </div>

            <!-- 1.3.기업리뷰1개-푸터역할. 추천(도움이됩니다)버튼, 공유(트윗/페북/URL복사)기능-->
            <div style="background-color: plum;
                        padding-bottom : 10%;">

                <div style="float:left;">
                    <i class="thumbs up icon"></i> <!-- <i class="thumbs up outline icon"></i> -->
                    도움이 됩니다
                </div>
                 <div style="float:right;"><!-- 우측배치 -->
                    <i class="twitter icon"></i>
                    <i class="facebook icon"></i>
                    <i class="external alternate icon"></i>
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
            (기업명)
            리뷰 모두 보기
        </div>

        <!-- 3.이외기업리뷰글들 리스트형으로 출력.-->
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

            <p>div겹치기(CSS position기능 적용)</p>
            <div><!--원래 부모역할(위로 먼저나옴. 리뷰작성을 독려하는 멘트 및 버튼 배치)-->

                 <div style="position: relative;"> <!-- new 부모-->

                     <!--자식역할(기업리뷰내용. 블러등으로 내용 못보게 처리.) -->
                     <div class='stop-dragging',
                          style="position: absolute;
                          -webkit-filter: blur(3px);      /*-webkit-filter : css 블러(글씨흐림)효과 */
                          background-color: #c86f11;">
                         기업리뷰내용(밑에 깔리고 블러로 가려질 글)
                     </div>

                    <div style="position: relative;">
                        <div style="text-align: center;">
                            <i class="lock icon"></i>
                        </div>
                        <div style="text-align: center;">
                            기업리뷰를 작성하시면 모든 리뷰들을 보실수 있습니다!
                        </div>
                        <div style="text-align: center;">
                            <button class="ui primary button">
                                리뷰 작성하러 가기
                            </button>
                        </div>

                    </div>

                </div>
            </div>
        </div>

    </div>

</body>
<script>
    $('.button')
        .popup({
            inline: true,
            hoverable: true
        })
    ;
    $('.ui.rating')
        .rating('disable');


</script>
</html>