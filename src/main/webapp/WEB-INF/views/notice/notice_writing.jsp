<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ page trimDirectiveWhitespaces="true" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe: 사다리 - 공지사항 작성</title>
        <!-- JavaScript -->
        <script>
            // $(document).ready(function () {
            //     $("#writing").click(function () {
            //         $("#noticeForm").submit();
            //     });
            //     $("#reset").click(function () {
            //         // $("#noticeForm").attr("action", "/notice/notice_board");
            //         $("#noticeForm")[0].reset();
            //     });
            // });
        </script>
        <meta charset="UTF-8" />
        <c:import url="../head.jsp" />
    </head>
    <body>
        <c:import url="../header.jsp" />
        <section class="py-5">
            <div class="container">
                <div class="title py-3">
                    <h1>공지사항 작성</h1>
                </div>
                <div class="write-form col-md-12">
                    <form method="post" id="noticeForm" action="${pageContext.request.contextPath}/notice/notice_writing">
                        <div class="mb-3">
                            <label for="title" class="form-label">제목</label>
                            <input type="text" class="form-control w-100" id="title" placeholder="제목을 입력하세요." name="notice_title" />
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">내용</label>
                            <textarea
                                class="form-control w-100"
                                id="content"
                                rows="14"
                                placeholder="내용을 입력하세요."
                                name="notice_content"
                            ></textarea>
                        </div>
                        <button class="btn btn-danger" type="reset">초기화</button>
                        <button class="btn btn-primary" type="submit">작성</button>
                    </form>
                </div>
            </div>
        </section>
        <c:import url="../footer.jsp" />
    </body>
</html>
