<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe: 사다리 - 제품목록</title>
        <script>
            if ("${sessionScope.user_id}" === "") {
                alert("로그인이 필요한 페이지입니다.");
                location.href = `${pageContext.request.contextPath}/member/loginForm?refer=${"${location.href}"}`;
            }
        </script>
        <c:import url="../head.jsp"></c:import>
        <link rel="stylesheet" href="/static/css/product_list.css" />
    </head>
    <body>
        <c:import url="../header.jsp"></c:import>
        <section class="py-5">
            <div class="container">
                <div class="py-3">
                    <h1>내가 등록한 제품 목록</h1>
                </div>
                <div class="py-2">
                    <button type="button" class="btn btn-outline-primary" onclick="location.href=`${pageContext.request.contextPath}/product/add`">
                        제품 추가하기
                    </button>
                </div>
                <c:import url="./importList.jsp"></c:import>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
