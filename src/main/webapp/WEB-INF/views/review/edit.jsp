<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadare - 리뷰 상세 보기</title>
        <script>
            if ("${sessionScope.id}" === "") {
                alert("로그인이 필요한 페이지입니다.");
                location.href = `${
                    pageContext.request.contextPath
                }/member/loginForm?refer=${"${location.href}"}`;
            }
        </script>
    </head>
    <body>
        <form
            action="${pageContext.request.contextPath}/review/edit?review_num=${r.review_num}"
            method="POST"
            enctype="multipart/form-data"
        >
            <table>
                <tr>
                    <td>리뷰 번호</td>
                    <td>${r.review_num}</td>
                    <input
                        type="hidden"
                        name="review_num"
                        value="${r.review_num}"
                    />
                </tr>
                <tr>
                    <td>작성자</td>
                    <td>${r.writer_id}</td>
                    <input
                        type="hidden"
                        name="writer_id"
                        value="${r.writer_id}"
                    />
                </tr>
                <tr>
                    <td>작성일</td>
                    <td>${r.review_date}</td>
                    <input
                        type="hidden"
                        name="review_date"
                        value="${r.review_date}"
                    />
                </tr>
                <tr>
                    <td>이미지</td>
                    <td>
                        <input
                            type="file"
                            name="file"
                            id="file"
                            accept="image/*"
                        />
                    </td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td>
                        <textarea
                            name="review_content"
                            id="review_content"
                            cols="30"
                            rows="10"
                        >
${r.review_content}</textarea
                        >
                    </td>
                </tr>
                <tr>
                    <td>제품이름</td>
                    <td>변경예정</td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button type="submit">수정</button>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
