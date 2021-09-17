<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title></title>


    <script>

        function getReviewListByPage(page) {
            const searchParams = new URLSearchParams(location.search);
            if (page > 1) {
                searchParams.set("page", page);
            } else {
                searchParams.delete("page");
            }
            location.search = searchParams.toString();
        }


        function countUp(companyReviewId) {

            $.ajax({
                type: "POST",
                url: "helpCountUp",
                data: {
                    companyId: "${companyIntroduction.companyId}"
                    , companyReviewId: companyReviewId
                },
                dataType: "json",
                success: function (result) {
                    console.log(result);
                    var helpfulCount = "#helpfulCount" + result.companyReviewId;
                    $(helpfulCount).html("");
                    var recommendFlag = "#recommendFlag" + result.companyReviewId;
                    var recommendFlag2 = $(recommendFlag).val();
                    if (recommendFlag2 == 1) {
                        $(helpfulCount).append("<div style='color:black;'>도움이 돼요(" + result.helpfulCount + ")</div>");
                        $(recommendFlag).val(0);
                    } else {
                        $(helpfulCount).append("<div style='color: red;'>도움이 돼요(" + result.helpfulCount + ")</div>");
                        $(recommendFlag).val(1);
                    }
                },
                error: function () {
                    alert("에러");
                }
            });
        };







        function copyToClipboard(val) {
            const t = document.createElement("textarea");
            document.body.appendChild(t);
            t.value = val;
            t.select();
            document.execCommand('copy');
            document.body.removeChild(t);
        };
            function copy() {
            copyToClipboard('localhost:8282/blind/companyShowReview?companyId='+${companyIntroduction.companyId});

        };



    </script>


    <style>
        .tabtable tr td {
            border: none;
            padding-top: 10px;
        }


    </style>


</head>
<body>
<div class="ui fluid container" id="reviewHeader" style="padding:80px 0; background-color:black">

</div>


<div class="ui container">
    <div style="padding-top:20px;">
        <button style="margin-top:30px;" class="blue ui right floated button"
                onclick="location.href='${pageContext.request.contextPath}/companyReviewWrite?companyId=${companyIntroduction.companyId}';">
            この会社をレビューする
        </button>

        <img class="ui left floated image"
             src="${pageContext.request.contextPath}/resources/images/company/${companyIntroduction.companyId}.png"
             width="90px" height="90px"></img>
        <div style="margin-top:10px;">
            <h2>${companyIntroduction.companyName }</h2>
            <p style="line-height:0.rem;">★${companyIntroduction.realAllPoint } (${reviewCount }個のレビュー)</p>
        </div>


    </div>


</div>


<div class="ui container">


    <div class="ui top attached tabular menu" style="font-size:1.2rem;">
        <div class="item" onclick="location.href='companyIntroduction?companyId=${companyIntroduction.companyId}'"
             style="width:15%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;紹介
        </div>
        <div class="active item" onclick="location.href='companyShowReview?companyId=${companyIntroduction.companyId}'"
             style="width:15%; ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;レビュー
        </div>
        <div class="item" style="width:15%;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;掲示板
        </div>
        <div class="item" style="width:15%;">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年棒
        </div>
        <div class="item" style="width:15%;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ニュース</div>
    </div>
    <div class="ui bottom attached active tab segment">
        <div style="width:100%; border:1px;">
            <table class="tabtable" border="1" style="width:100%; margin:15px auto; padding:30px"><!--마진은되도록 쓰지말자  -->

                <tr>
                    <td>${companyIntroduction.companyName }レビュー</td>
                </tr>
                <tr>
                    <td>${companyAverageDto.allPoint}</td>
                    <td>
                        <div class="div_star">
                            <div class="ui star rating" data-rating="${companyAverageDto.allPoint}"
                                 data-max-rating="5"></div>

                        </div>
                    </td>

                    <td>(${reviewCount }個のレビュー)</td>
                    <td>項目別平均点数</td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>${companyAverageDto.careerPoint}
                        <div class="ui star rating" data-rating="1"
                             data-max-rating="1"　style="margin-right:10px;">
                        </div>


                        キャリア向上</td>


                    <td>

                    </td>

                </tr>


                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>${companyAverageDto.workLifeBalancePoint}
                        <div class="ui star rating" data-rating="1"
                                data-max-rating="1"　style="margin-right:10px;">
                        </div>


                        ワークライフバランス</td>
                </tr>

                　　　　
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>${companyAverageDto.companyCulturePoint}
                        <div class="ui star rating" data-rating="1"
                             data-max-rating="1"　style="margin-right:10px;">
                        </div>


                        社内文化</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>${companyAverageDto.payPoint}
                        <div class="ui star rating" data-rating="1"
                             data-max-rating="1"　style="margin-right:10px;">
                        </div>

                        給料と福祉</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td>${companyAverageDto.headPoint}
                        <div class="ui star rating" data-rating="1"
                             data-max-rating="1"　style="margin-right:10px;">
                        </div>


                        経営陣</td>
                </tr>
                　　　　　
            </table>

        </div>




        <c:if test="${!empty oneCompanyReview}">
        <div style="width:100%; border:1px;">
            <table class="tabtable" border="1" style="width:100%; margin:15px auto; padding:30px"><!--마진은되도록 쓰지말자  -->

                <tr>
                    <td style="width:20%;">${oneCompanyReview.allPoint }</td>
                    <td style="width:65%;"><h4>"${oneCompanyReview.simpleComment }"</h4></td>
                    <td>${oneCompanyReview.recCreateDate}</td>

                    <td style="width:5%;">
                        <%--<div id="sample"  data-position="bottom left"
                             data-content="신고"><i class="ellipsis horizontal icon"></i></div>--%>
                        <div class="ui button" style="background: white; margin:0px;" data-position="bottom center"><i
                                class="ellipsis horizontal icon"></i></div>
                        <div class="ui flowing popup top left transition hidden">
                            <div class="ui column divided center aligned grid">
                                <div class="column" data-position="bottom left">
                                    <div class="ui button" style="background: white;">신고</div>
                                </div>

                            </div>
                        </div>


                    </td>
                </tr>
                <tr>
                    <td>


                        <div class="div_star">
                            <div class="ui star rating" data-rating="${oneCompanyReview.allPoint}"
                                 data-max-rating="5"></div>
                            <div class="ui button" style="background: white; margin:0px;"
                                 data-position="bottom center"><i class="angle down icon"></i></div>
                            <div class="ui flowing popup top left transition hidden">

                                <div class="column" data-position="bottom left">

                                    <div class="div_star">
                                        <div class="ui star rating" data-rating="${oneCompanyReview.careerPoint}"
                                             data-max-rating="5"　style="margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">キャリア向上</span>

                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating"
                                             data-rating="${oneCompanyReview.workLifeBalancePoint}"
                                             data-max-rating="5"　style="margin-right:10px;">
                                        </div>

                                        <span style="margin-right:10px;">ワークライフバランス</span>

                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating"
                                             data-rating="${oneCompanyReview.companyCulturePoint}"
                                             data-max-rating="5"　style="float:left; margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">社内文化</span>

                                    </div>
                                    <div class="div_star">
                                        <div class="ui star rating" data-rating="${oneCompanyReview.payPoint}"
                                             data-max-rating="5"　style="float:left; margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">給料と福祉</span>
                                    </div>


                                    <div class="div_star">
                                        <div class="ui star rating" data-rating="${oneCompanyReview.headPoint}"
                                             data-max-rating="5"　style="float:left; margin-right:10px;">
                                        </div>
                                        <span style="margin-right:10px;">経営陣</span>
                                    </div>
                                </div>


                            </div>
                        </div>

                    </td>
                    <td><h5>장점</h5></td>

                    <td></td>


                    <td></td>
                </tr>

                <tr>
                    <td></td>
                    <td>${oneCompanyReview.advantages }</td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td><h5>단점</h5></td>
                </tr>
                <tr>
                    <td></td>
                    <td>${oneCompanyReview.disadvantages }</td>
                </tr>
                <tr>
                    <td>
                        <c:if test="${oneCompanyReview.recommendFlag == 1}">
                <tr>
                    <td>
                        <button onclick="countUp(${oneCompanyReview.companyReviewId});">
                            <div id="helpfulCount${oneCompanyReview.companyReviewId}" style="display:flex;color:red">도움이
                                돼요(${oneCompanyReview.helpfulCount })
                            </div>
                        </button>
                </tr>

                </c:if>
                <c:if test="${oneCompanyReview.recommendFlag == 0}">
                    <tr>
                        <td>
                            <button onclick="countUp(${oneCompanyReview.companyReviewId});">
                                <div id="helpfulCount${oneCompanyReview.companyReviewId}" style="display:flex;">도움이
                                    돼요(${oneCompanyReview.helpfulCount })
                                </div>
                            </button>
                        </td>
                        <td>
                            <button onclick="copy()">COPY</button>

                        </td>
                    </tr>
                </c:if>

                <input type="hidden" id="recommendFlag${oneCompanyReview.companyReviewId}"
                       value="${oneCompanyReview.recommendFlag}"></input>
                </tr>
            </table>

        </div>
        </c:if>

        <c:forEach var="companyShowList" items="${companyShowList}" varStatus="status">
            <div id="showCompanyList">
                <div style="width:100%; border:1px;">
                    <table class="tabtable" border="1" style="width:100%; margin:15px auto; padding:30px">
                        <!--마진은되도록 쓰지말자  -->

                        <tr>
                            <td style="width:20%;" > ${companyShowList.allPoint}</td>
                            <td style="width:65%;" ><h4>"${companyShowList.simpleComment }"</h4></td>

                            <td>${companyShowList.recCreateDate}</td>
                            <td style="width:5%;" >

                                <div class="ui button" style="background: white; margin:0px;"
                                     data-position="bottom center"><i class="ellipsis horizontal icon"></i></div>
                                <div class="ui flowing popup top left transition hidden">

                                    <div class="column" data-position="bottom left">

                                        <div class="ui button" style="background: white ;">신고</div>

                                    </div>


                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td>


                                <div class="div_star">
                                    <div class="ui star rating" data-rating="${companyShowList.allPoint}"
                                         data-max-rating="5"></div>
                                    <div class="ui button" style="background: white; margin:0px;"
                                         data-position="bottom center"><i class="angle down icon"></i></div>
                                    <div class="ui flowing popup top left transition hidden">

                                        <div class="column" data-position="bottom left">

                                            <div class="div_star">
                                                <div class="ui star rating" data-rating="${companyShowList.careerPoint}"
                                                    data-max-rating="5"　style="margin-right:10px;">
                                                </div>
                                                <span style="margin-right:10px;">キャリア向上</span>

                                            </div>
                                            <div class="div_star">
                                                <div class="ui star rating"
                                                     data-rating="${companyShowList.workLifeBalancePoint}"
                                                     data-max-rating="5"　style="margin-right:10px;">
                                                </div>

                                                    <span style="margin-right:10px;">ワークライフバランス</span>

                                            </div>
                                            <div class="div_star">
                                                <div class="ui star rating"
                                                     data-rating="${companyShowList.companyCulturePoint}"
                                                     data-max-rating="5"　style="float:left; margin-right:10px;">
                                                </div>
                                                <span style="margin-right:10px;">社内文化</span>

                                            </div>
                                            <div class="div_star">
                                                <div class="ui star rating" data-rating="${companyShowList.payPoint}"
                                                     data-max-rating="5"　style="float:left; margin-right:10px;">
                                                </div>
                                                <span style="margin-right:10px;">給料と福祉</span>
                                            </div>
                                            <div class="div_star">
                                                <div class="ui star rating" data-rating="${companyShowList.headPoint}"
                                                     data-max-rating="5"　style="float:left; margin-right:10px;">
                                                </div>
                                                <span style="margin-right:10px;">経営陣</span>
                                            </div>
                                        </div>


                                    </div>

                                </div>
                                <td><h5>장점</h5></td>



                            </td>


                        </tr>
                        <tr>
                            <td></td>
                            <td>${companyShowList.advantages }</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><h5>단점</h5></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>${companyShowList.disadvantages }</td>
                        </tr>
                        <c:if test="${companyShowList.recommendFlag == 1}">
                            <tr>
                                <td>
                                    <button onclick="countUp(${companyShowList.companyReviewId});">
                                        <div id="helpfulCount${companyShowList.companyReviewId}"
                                             style="display:flex;color:red">도움이 돼요(${companyShowList.helpfulCount })
                                        </div>
                                    </button>
                            </tr>

                        </c:if>
                        <c:if test="${companyShowList.recommendFlag == 0}">
                            <tr>
                                <td>
                                    <button onclick="countUp(${companyShowList.companyReviewId});">
                                        <div id="helpfulCount${companyShowList.companyReviewId}" style="display:flex;">
                                            도움이 돼요(${companyShowList.helpfulCount })
                                        </div>
                                    </button>
                                </td>
                                <td>
                                    <button onclick="copy()">COPY</button>

                                </td>
                            </tr>
                        </c:if>
                        <input type="hidden" id="recommendFlag${companyShowList.companyReviewId}"
                               value="${companyShowList.recommendFlag}"></input>

                    </table>

                </div>
            </div>

        </c:forEach>

    </div>


    <div class="ui grid">
        <div class="center aligned column">
            <c:choose>
                <c:when test="${navi.startPage gt navi.pagination}">
                    <div class="ui pagination menu">
                        <a class="item"
                           href="javascript:getReviewListByPage(${navi.startPage - navi.pagination});">前へ</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="ui pagination menu" style="visibility: hidden;"><a class="item">前へ</a></div>
                </c:otherwise>
            </c:choose>
            <div class="ui pagination menu">
                <c:forEach var="page" begin="${navi.startPage}" end="${navi.endPage}">
                    <c:choose>
                        <c:when test="${page eq navi.currentPage}">
                            <div class="active item">${page}</div>
                        </c:when>
                        <c:otherwise>
                            <a class="item" href="javascript:getReviewListByPage(${page});">${page}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
            <c:choose>
                <c:when test="${navi.totalPage gt navi.endPage}">
                    <div class="ui pagination menu">
                        <a class="item" href="javascript:getReviewListByPage(${navi.endPage + 1})">次へ</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="ui pagination menu" style="visibility: hidden;"><a class="item">次へ</a></div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>

</div>


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

</body>

</html>