<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>sadaRe: 사다리</title>
        <c:import url="./head.jsp"></c:import>
        <link href="${pageContext.request.contextPath}/static/css/index.css" rel="stylesheet" />
    </head>
    <body>
        <c:import url="./header.jsp"></c:import>
        <!-- Section-->
        <section class="py-5">
            <!-- Header-->
            <header class="bg-dark py-5">
                <div class="text-center text-white">
                    <h1>sadaRe: 사다리</h1>
                    <p class="text-white-50">중고제품을 저렴한 가격에 구매 / 판매하세요!</p>
                </div>
            </header>
            <div class="container">
                <c:if test="${empty list}">
                    <div class="py-5">
                        <h1>등록된 제품이 없습니다..</h1>
                        <h1>가장 먼저 제품을 등록해보세요!!!</h1>
                        <h3>
                            <a href="${pageContext.request.contextPath}/product/add">제품 등록하기</a>
                        </h3>
                    </div>
                </c:if>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <!-- 한 제품목록의 시작 -->
                    <c:forEach var="item" items="${list}">
                        <div class="col mb-5">
                            <div class="card h-100">
                                <!-- Product image-->
                                <div class="product-img">
                                    <a href="${pageContext.request.contextPath}/product/view?product_num=${item.product_num}">
                                        <img class="card-img-top" src="${pageContext.request.contextPath}${item.path1}" alt="${item.product_name}" />
                                    </a>
                                </div>
                                <!-- Product details-->
                                <div class="card-body p-4">
                                    <div class="text-center">
                                        <!-- Product name-->
                                        <h5 class="fw-bolder">${item.product_name}</h5>
                                        <!-- Product price-->
                                        <fmt:formatNumber value="${item.product_price}" pattern="#,###원" />
                                    </div>
                                </div>
                                <!-- Product actions-->
                                <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                    <div class="text-center">
                                        <a
                                            class="btn btn-outline-dark mt-auto"
                                            href="${pageContext.request.contextPath}/product/view?product_num=${item.product_num}"
                                            >상품페이지로 이동</a
                                        >
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <!-- 한 제품목록의 끝 -->
                </div>
            </div>
        </section>
        <c:import url="./footer.jsp"></c:import>
    </body>
</html>
