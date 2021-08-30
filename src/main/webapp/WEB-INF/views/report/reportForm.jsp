<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe: 사다리 - 신고작성</title>
        <c:import url="../head.jsp"></c:import>
        <script>
            $(document).ready(function () {
                $("#s").click(function (e) {
                    e.preventDefault();
                    //제출할건지 물어보고 확인버튼 클릭시 관리자계정 신고리스트 페이지로 값 보내기
                    var returnValue = confirm("신고리포트를 제출할까요?");
                    if (returnValue == true) {
                        $("#report-form").submit();
                        alert("신고 접수가 완료되었습니다");
                    } else {
                        alert("취소되었습니다");
                    }
                });
            });
        </script>
    </head>
    <body>
        <c:import url="../header.jsp"></c:import>
        <!-- Section-->
        <section class="py-5">
            <div class="container">
                <div class="py-3">
                    <h1>신고 작성</h1>
                </div>
                <form action="/report/add" method="post" id="report-form">
                    <div class="col-md-12">
                        <div class="mb-3">
                            <h3>신고 제품 : ${p.product_name}</h3>
                        </div>
                        <div class="mb-3">
                            <label for="title" class="form-label">제목</label>
                            <input type="email" class="form-control w-100" name="report_title" id="title" placeholder="제목" required />
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">신고사유</label>
                            <textarea
                                class="form-control w-100"
                                id="content"
                                rows="12"
                                name="report_content"
                                placeholder="신고사유를 작성해주세요."
                                required
                            ></textarea>
                        </div>
                        <div class="mb-3">
                            <button class="btn btn-danger" type="reset">초기화</button>
                            <button class="btn btn-success" type="submit" id="s">신고</button>
                        </div>
                    </div>
                    <input type="hidden" id="product_num" name="product_num" value="${p.product_num}" />
                </form>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
