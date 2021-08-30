<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<c:set var="alram_size">
    <c:import url="${pageContext.request.contextPath}/alram/getsize" />
</c:set>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container px-4 px-lg-5">
        <!-- Logo -->
        <a class="navbar-brand" href="/">sadaRe</a>
        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent"
            aria-expanded="false"
            aria-label="Toggle navigation"
        >
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                <c:choose>
                    <%-- 비 로그인 상태 --%>
                    <c:when test="${empty sessionScope.user_id}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/member/joinForm">회원가입</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/member/loginForm">로그인</a>
                        </li>
                    </c:when>
                    <%-- 로그인 상태 --%>
                    <c:otherwise>
                        <c:choose>
                            <%-- 관리자 로그인 시 --%>
                            <c:when test="${sessionScope.user_type == 2}">
                                <li class="nav-item dropdown">
                                    <a
                                        class="nav-link dropdown-toggle"
                                        id="navbarDropdown"
                                        href="#"
                                        role="button"
                                        data-bs-toggle="dropdown"
                                        aria-expanded="false"
                                        >관리자 메뉴</a
                                    >
                                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/member/main">내 정보</a>
                                        </li>
                                        <li><hr class="dropdown-divider" /></li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/member/list">회원관리</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/product/list">제품관리</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/report/reportList">신고 목록 확인</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/notice/notice_board">공지사항</a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/category">카테고리 관리</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
                                </li>
                            </c:when>
                            <%-- 일반 로그인 시 --%>
                            <c:otherwise>
                                <li class="nav-item dropdown">
                                    <a
                                        class="nav-link dropdown-toggle"
                                        id="navbarDropdown"
                                        href="#"
                                        role="button"
                                        data-bs-toggle="dropdown"
                                        aria-expanded="false"
                                    >
                                        내 메뉴
                                        <c:if test="${alram_size >= 1}">
                                            <span
                                                class="
                                                    position-absolute
                                                    top-25
                                                    start-0
                                                    translate-middle
                                                    p-1
                                                    bg-danger
                                                    border border-light
                                                    rounded-circle
                                                "
                                            >
                                                <span class="visually-hidden">새 알람</span>
                                            </span>
                                        </c:if>
                                    </a>
                                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/member/main"
                                                >내 정보<c:if test="${alram_size >= 1}">
                                                    <span class="badge bg-danger">${alram_size}</span>
                                                </c:if>
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider" /></li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/product/add">제품 추가하기</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/member/logout">로그아웃</a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/product/list">제품목록</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/notice/notice_board">공지사항</a>
                </li>
                <%-- 유저평점
                <c:if test="${sessionScope.user_id != null}">
                    <li class="nav-item d-flex align-items-center px-2">
                        <i class="fas fa-star text-warning"></i>
                        <span>
                            <c:import url="${pageContext.request.contextPath}/api/member/getScore" var="score" />
                            <c:if test="${score == '-1.0'}">평점이 없습니다.</c:if>
                        </span>
                    </li>
                </c:if>
                --%> <%--
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"
                        >카테고리로 찾기</a
                    >
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <!-- value값은 카테고리 목록에서 받아오는 값으로 수정해야 함! 또한 c:forEach문 사용하여 목록 출력하도록 할 것 -->
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/product/search?q=c1&value=0">의류</a>
                        </li>
                        <li>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/product/search?q=c1&value=0">가전제품</a>
                        </li>
                        <!-- 아래 요소는 dropdown-item을 나눌 수 있도록 구분선을 표현해 줌(필수는 아님!) -->
                        <!-- <li><hr class="dropdown-divider" /></li> -->
                    </ul>
                </li>
                --%>
            </ul>
            <form class="d-flex" style="margin-bottom: 0px">
                <button class="btn btn-outline-dark" type="button" onclick="location.href='${pageContext.request.contextPath}/wish/wishList'">
                    <i class="bi-cart-fill me-1"></i>
                    찜 목록
                    <!-- 아래 0값은 찜 목록에 있는 목록의 개수를 불러와야 함!! -->
                    <span class="badge bg-dark text-white ms-1 rounded-pill">
                        <c:import url="${pageContext.request.contextPath}/wish/count"></c:import>
                    </span>
                </button>
            </form>
        </div>
    </div>
</nav>
