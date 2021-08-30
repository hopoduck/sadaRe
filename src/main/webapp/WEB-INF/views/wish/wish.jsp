<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
    <head>
        <title>sadaRe: 사다리</title>
        <c:import url="../head.jsp"></c:import>
        <link rel="stylesheet" href="/static/css/product_list.css" />
        <script>
            if ("${sessionScope.user_id}" === "") {
                alert("로그인이 필요한 페이지입니다.");
                location.href = `${pageContext.request.contextPath}/member/loginForm?refer=${"${location.href}"}`;
            }
            $(document).ready(function () {
                //찜 목록 페이지에서 상품 선택 삭제
                $(".delete").click(function () {
                    var item = $(".delete").attr("itemid");
                    $.ajax({
                        type: "post",
                        url: "${pageContext.request.contextPath}/wish/delete",
                        data: { wish_num: item },
                        success: function (response) {
                            alert("삭제되었습니다");
                            location.href = location.href;
                        },
                    });
                });
                //찜 목록 페이지에서 상품 전체 삭제
                $("#deleteAll").click(function () {
                    var confirm_val = confirm("정말 삭제하시겠습니까?");
                    if (confirm_val) {
                        location.href = "/wish/wishDelAll";
                    } else {
                        //no
                        alert("전체삭제 취소");
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
                    <h1>찜 목록</h1>
                </div>
                <c:import url="../product/importList.jsp"></c:import>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
