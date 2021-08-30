<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadare - 리뷰 상세 보기</title>
    </head>
    <body>
        <table>
            <tr>
                <td>리뷰 번호</td>
                <td>${r.review_num}</td>
            </tr>
            <tr>
                <td>작성자</td>
                <td>${r.writer_id}</td>
            </tr>
            <tr>
                <td>작성일</td>
                <td>${r.review_date}</td>
            </tr>
            <tr>
                <td>이미지</td>
                <td><img src="${pageContext.request.contextPath}${r.review_path}" alt="${r.review_content}" width="400"/></td>
            </tr>
            <tr>
                <td>내용</td>
                <td>
                    <pre>${r.review_content}</pre>
                </td>
            </tr>
            <tr>
                <td>제품이름</td>
                <td>변경예정</td>
            </tr>
            <c:if test="${sessionScope.id == r.writer_id}">
                <tr>
                    <td colspan="2">
                        <a href="${pageContext.request.contextPath}/review/edit?review_num=${r.review_num}">수정하기</a> <br>
                        <a href="${pageContext.request.contextPath}/review/delete?review_num=${r.review_num}">삭제하기</a>
                    </td>
                </tr>
            </c:if>
        </table>
    </body>
</html>
