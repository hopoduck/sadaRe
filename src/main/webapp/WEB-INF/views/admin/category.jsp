<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
    <head>
        <title>sadaRe: 사다리 - 카테고리 관리</title>
        <c:import url="../head.jsp"></c:import>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/admin_category.css" />
        <script>
            // 카테고리 버튼 생성
            function makeBtn(data, category_type = 1) {
                let html = `
                <div class="btn-group" role="group" id="c${"${category_type}"}-item-${"${data.category_num}"}">
                    <input type="radio" class="btn-check" name="c${"${category_type}"}" id="c${"${category_type}"}-${"${data.category_num}"}" value="${"${data.category_num}"}" autocomplete="off">
                    <label 
                        class="btn btn-outline-primary list-group-item w-75"
                        for="c${"${category_type}"}-${"${data.category_num}"}"
                        itemid="${"${data.category_num}"}"
                        itemtype="c${"${category_type}"}"
                        >
                            ${"${data.category_name}"}
                        </label>
                    <button type="button" class="btn btn-outline-danger w-25" name="remove" itemid="${"${data.category_num}"}" >삭제</button>
                </div>
                `;
                return html;
            }
            // 카테고리 목록 생성
            function makeBtnList(array, category_type = 1) {
                let html = `<div></div>`;
                for (let i = 0; i < array.length; i++) {
                    const element = array[i];
                    html += makeBtn(element, category_type);
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
                        let html = makeBtnList(arr, category_type);
                        $("#c" + category_type + "-list").html(html);
                    },
                });
            }
            // 카테고리 추가
            function addCategory(e) {
                const form = $(e.target);
                const data = {};
                // 데이터 입력
                if (form[0].category_name.value !== "") {
                    data["category_name"] = form[0].category_name.value;
                    form[0].category_name.value = "";
                } else {
                    alert("분류 이름을 입력하세요!");
                    form[0].category_name.focus();
                    return false;
                }
                data["category_type"] = form[0].category_type.value;
                if (form[0].parent_category_num === undefined) {
                } else if (form[0].parent_category_num !== undefined && form[0].parent_category_num.value !== "") {
                    data["parent_category_num"] = form[0].parent_category_num.value;
                } else {
                    alert("먼저 상위 분류를 선택하세요!");
                    return false;
                }
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/category/add",
                    data: data,
                    success: function (response) {
                        const array = $.parseJSON(response);
                        let html = makeBtnList(array, data["category_type"]);
                        $("#" + form.attr("itemref")).html(html);
                    },
                });
            }
            // 카테고리 삭제
            function removeCategory(e) {
                const btn = $(e.target);
                const data = btn.parent().attr("id").split("-");
                const category_type = data[0].split("c")[1];
                const category_num = data[2];
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/category/delete",
                    data: { category_type, category_num },
                    success: function (response) {
                        const arr = $.parseJSON(response);
                        let html = makeBtnList(arr, category_type);
                        $("#c" + category_type + "-list").html(html);
                    },
                });
            }
            // 카테고리 버튼 클릭 시 (하위 카테고리를 추가하기 위한 상위 카테고리 선택 시)
            function categoryBtnClickHandler(e) {
                const data = $(e.target).attr("id").split("-");
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
                // 카테고리를 추가할 때
                $("form").submit(function (e) {
                    e.preventDefault();
                    addCategory(e);
                });
                // 카테고리 선택 버튼
                $(document).on("change", "input[type='radio']", function (e) {
                    categoryBtnClickHandler(e);
                });
                // 카테고리 삭제 버튼
                $(document).on("click", "button[name='remove']", function (e) {
                    removeCategory(e);
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
                    <h1>카테고리 관리</h1>
                </div>
                <div class="grid my-3">
                    <div class="c1 py-3 px-3 border">
                        <div class="title">
                            <h1>대분류</h1>
                        </div>
                        <div>
                            <form class="list-group btn-group-vertical btn-group" role="group" id="c1-list"></form>
                        </div>
                        <div class="add-form w-100 my-3">
                            <form action="${pageContext.request.contextPath}/category/add" method="POST" itemref="c1-list" class="input-group">
                                <input
                                    type="text"
                                    class="form-control w-75"
                                    placeholder="대분류 추가"
                                    aria-label="대분류 추가"
                                    aria-describedby="c1-btn"
                                    name="category_name"
                                />
                                <input type="hidden" name="category_type" value="1" />
                                <button class="btn btn-outline-secondary w-25" type="submit" id="c1-btn">등록</button>
                            </form>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center align-items-center fs-1"><i class="fas fa-arrow-right"></i></div>
                    <div class="c2 py-3 px-3 border">
                        <div class="title">
                            <h1>중분류</h1>
                        </div>
                        <div class="list-group btn-group-vertical btn-group" role="group" id="c2-list"></div>
                        <div class="add-form w-100 my-3">
                            <form action="${pageContext.request.contextPath}/category/add" method="POST" itemref="c2-list" class="input-group">
                                <input
                                    type="text"
                                    class="form-control w-75"
                                    placeholder="중분류 추가"
                                    aria-label="중분류 추가"
                                    aria-describedby="c2-btn"
                                    name="category_name"
                                />
                                <input type="hidden" name="category_type" value="2" />
                                <input type="hidden" name="parent_category_num" value="" id="c2-parent" />
                                <button class="btn btn-outline-secondary w-25" type="submit" id="c2-btn">등록</button>
                            </form>
                        </div>
                    </div>
                    <div class="d-flex justify-content-center align-items-center fs-1"><i class="fas fa-arrow-right"></i></div>
                    <div class="c3 py-3 px-3 border">
                        <div class="title">
                            <h1>소분류</h1>
                        </div>
                        <div class="list-group btn-group-vertical btn-group" role="group" id="c3-list"></div>
                        <div class="add-form w-100 my-3">
                            <form action="${pageContext.request.contextPath}/category/add" method="POST" itemref="c3-list" class="input-group">
                                <input
                                    type="text"
                                    class="form-control w-75"
                                    placeholder="소분류 추가"
                                    aria-label="소분류 추가"
                                    aria-describedby="c3-btn"
                                    name="category_name"
                                />
                                <input type="hidden" name="category_type" value="3" />
                                <input type="hidden" name="parent_category_num" value="" id="c3-parent" />
                                <button class="btn btn-outline-secondary w-25" type="submit" id="c3-btn">등록</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
