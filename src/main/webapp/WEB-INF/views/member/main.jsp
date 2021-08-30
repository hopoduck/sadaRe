<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>sadaRe: 사다리 - 메인페이지</title>
        <%-- --%>
        <c:import url="../head.jsp" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/star.css" />
    </head>
    <body>
        <c:import url="../header.jsp" />
        <section class="py-5">
            <div class="container">
                <span>
                    <span class="fs-1"> ${m.user_nickname} </span>
                    <span class="fs-5"> ${sessionScope.user_id } </span>
                </span>
                <table class="my-3 w-50">
                    <tr>
                        <td>
                            <h5>내 거래 점수</h5>
                        </td>
                    </tr>
                    <tr>
                        <td class="">
                            <c:set var="count" value="${m.user_scorecount }" />
                            <c:choose>
                                <c:when test="${count==0}">
                                    <c:set var="x" value="평점 없음"></c:set>
                                    <i class="fas fa-star" style="font-size: 20px; color: #5f5f5f">${x}</i>
                                </c:when>
                                <c:otherwise>
                                    <fmt:formatNumber var="val" value="${m.user_score/count}" pattern="#.##"></fmt:formatNumber>
                                    <c:set var="x" value="${val}"></c:set>
                                    <div class="progress" style="width: 336px; height: 25px">
                                        <div class="progress-bar bg-info" role="progressbar" style="width: ${m.user_score/count*20}%">
                                            <i class="fas fa-star" style="font-size: 20px; color: #ffe607">${x}</i>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>
                            <a style="width: 100px; height: 75px" href="/product/mylist" class="btn btn-outline-dark px-3 py-2 rounded-3"
                                ><i class="fs-1 fas fa-gifts w-100"></i>판매 내역</a
                            >
                        </td>
                        <td>
                            <a style="width: 100px; height: 75px" href="/wish/wishList" class="btn btn-outline-dark mx-3 px-3 py-2 rounded-3"
                                ><i class="fs-1 fas fa-shopping-bag w-100"></i>찜 목록</a
                            >
                        </td>
                        <td>
                            <a style="width: 100px; height: 75px" href="/product/add" class="btn btn-outline-dark px-3 py-2 rounded-3"
                                ><i class="fs-1 fas fa-plus-square w-100"></i>상품 등록</a
                            >
                        </td>
                    </tr>
                </table>

                <!-- <table border="1"> -->
                <c:import url="${pageContext.request.contextPath }/alram/mylist"></c:import>
                <!-- </table> -->
                <div class="btn-group btn-group-sm" role="group">
                    <a class="btn btn-outline-secondary" href="/member/passwordChk">내 정보 수정</a>
                    <a class="btn btn-outline-secondary" href="/member/logout">로그아웃</a>
                </div>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
