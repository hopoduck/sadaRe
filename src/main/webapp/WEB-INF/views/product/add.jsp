<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
    <head>
        <title>sadaRe: 사다리 - 제품 추가</title>
        <c:import url="../head.jsp"></c:import>

        <script>
            if ("${sessionScope.user_id}" === "") {
                alert("로그인이 필요한 페이지입니다.");
                location.href = `${pageContext.request.contextPath}/member/loginForm?refer=${"${location.href}"}`;
            }
            // 카테고리 버튼 생성
            function makeOption(data, category_type = 1) {
                let html = `
                    <option id="c${"${category_type}"}-${"${data.category_num}"}" value="${"${data.category_num}"}">${"${data.category_name}"}</option>
                `;
                return html;
            }
            // 카테고리 목록 생성
            function makeOptionList(array, category_type = 1) {
                let html = `<option value="">선택하세요!</option>`;
                for (let i = 0; i < array.length; i++) {
                    const element = array[i];
                    html += makeOption(element, category_type);
                }
                return html;
            }
            // 카테고리 데이터 가져오기
            function getCategoryList(category_type, parent_category_num = -1) {
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/category/getCategory",
                    data: { category_type, parent_category_num },
                    success: function (response) {
                        const arr = $.parseJSON(response);
                        let html = makeOptionList(arr, category_type);
                        $("#c" + category_type + "-list").html(html);
                    },
                });
            }
            function removeCategoryList(category_type) {
                if (category_type <= 2) {
                    $("#c" + (category_type + 1) + "-list").html("");
                }
                if (category_type <= 1) {
                    $("#c" + (category_type + 2) + "-list").html("");
                }
            }
            // 카테고리 버튼 클릭 시 (하위 카테고리를 추가하기 위한 상위 카테고리 선택 시)
            function categorySelectChangeHandler(e) {
                const selectedOption = $("#" + $(e.target).attr("id") + " option:selected");
                const data = selectedOption.attr("id").split("-");
                const category_type = parseInt(data[0].substr(1));
                if (category_type != 3) {
                    const category_num = data[1];
                    getCategoryList(category_type + 1, category_num);
                    $("#c" + (category_type + 1) + "-parent").val(category_num);
                }
            }
            $(document).ready(function () {
                // 기본 대분류 카테고리 목록 가져옴
                getCategoryList(1);
                // 카테고리 선택 버튼
                $(document).on("change", "select", function (e) {
                    const category_type = parseInt(
                        $("#" + $(e.target).attr("id") + " option:selected")
                            .attr("id")
                            .split("-")[0]
                            .substr(1)
                    );
                    categorySelectChangeHandler(e);
                    removeCategoryList(category_type);
                });
            });
        </script>
        <link href="${pageContext.request.contextPath}/static/css/product_add.css" rel="stylesheet" />
    </head>
    <body>
        <c:import url="../header.jsp"></c:import>
        <!-- Section-->
        <section class="py-5">
            <div class="container">
                <div class="py-3">
                    <h1>제품 등록</h1>
                </div>
                <form
                    action="${pageContext.request.contextPath}/product/add"
                    method="POST"
                    enctype="multipart/form-data"
                    class="row g-3"
                    id="product-form"
                >
                    <div class="col-md-12">
                        <label for="product-name" class="form-label">제품 이름</label>
                        <input type="text" class="form-control" id="product-name" name="product_name" required />
                    </div>
                    <div class="col-md-12">
                        <label for="product-price" class="form-label">제품 가격</label>
                        <input type="number" class="form-control" id="product-price" min="0" max="20000000" name="product_price" required />
                    </div>
                    <div class="col-md-12">
                        <label for="product-info" class="form-label">제품 정보</label>
                        <textarea class="form-control" id="product-info" rows="10" style="resize: none" name="product_info" required></textarea>
                    </div>
                    <div class="col-md-12 row g-3">
                        <label for="c1" class="form-label">카테고리</label>
                        <div class="form-floating col-md-4">
                            <select class="form-select" id="c1-list" name="category1_num" required></select>
                            <label for="c1">대분류</label>
                        </div>
                        <div class="form-floating col-md-4">
                            <select class="form-select" id="c2-list" name="category2_num" required>
                                <option value="">대분류를 선택하세요!</option>
                            </select>
                            <label for="c2">중분류</label>
                        </div>
                        <div class="form-floating col-md-4">
                            <select class="form-select" id="c3-list" name="category3_num" required>
                                <option value="">중분류를 선택하세요!</option>
                            </select>
                            <label for="c3">소분류</label>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <label for="file1" class="form-label">첨부파일</label>
                        <input class="form-control" type="file" name="file1" id="file1" accept="image/*" />
                        <input class="form-control" type="file" name="file2" id="file2" accept="image/*" />
                        <input class="form-control" type="file" name="file3" id="file3" accept="image/*" />
                    </div>
                    <div class="col-md-12">
                        <button type="submit" class="btn btn-success">등록하기</button>
                    </div>
                    <input type="hidden" name="user_id" value="${sessionScope.user_id}" required />
                </form>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
