<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe - 리뷰 작성</title>
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
        <h3>리뷰 등록</h3>
        <form
            action="${pageContext.request.contextPath}/review/add"
            method="POST"
            enctype="multipart/form-data"
        >
            <table>
                <tr>
                    <th>제목</th>
                    <td>
                        <input
                            type="text"
                            name="review_title"
                            id="review_title"
                        />
                    </td>
                </tr>
                <tr>
                    <th>리뷰 내용</th>
                    <td>
                        <textarea
                            name="review_content"
                            id="review_content"
                            cols="30"
                            rows="10"
                        ></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
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
                    <td colspan="2">
                        <button>글 작성</button>
                    </td>
                </tr>
            </table>
            <input
                type="hidden"
                name="writer_id"
                value="${sessionScope.user_id}"
            />
            <input
                type="hidden"
                name="product_num"
                value="${product.product_num}12"
            />
        </form>
    </body>
</html>
