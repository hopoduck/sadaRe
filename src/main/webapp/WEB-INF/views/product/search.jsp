<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe - 검색 결과</title>
    </head>
    <body>
        <h3>제품 보기</h3>
        <table>
            <tr>
                <th>번호</th>
                <td>${p.product_num}</td>
            </tr>
            <tr>
                <th>제품명</th>
                <td>${p.product_name}</td>
            </tr>
            <tr>
                <th>가격</th>
                <td>${p.product_price}</td>
            </tr>
            <tr>
                <th>카테고리</th>
                <td>${p.product_name}</td>
            </tr>
            <tr>
                <th>등록일</th>
                <td>${p.product_add_date}</td>
            </tr>
            <tr>
                <th>조회수</th>
                <td>${p.product_hit}</td>
            </tr>
            <tr>
                <th>이미지</th>
                <td>
                    <c:forEach var="file" items="${files}">
                        <img alt="${p.product_name}" src="${file}" width="200">
                    </c:forEach>
                </td>
            </tr>
        </table>
    </body>
</html>
