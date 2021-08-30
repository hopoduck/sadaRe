<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>sadaRe: 사다리 - 로그인</title>
        <c:import url="../head.jsp"></c:import>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/member_loginForm.css" />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/member_msg.css" />
        <script>
            const re = document.location.href.split("?")[0];
            const re2 = document.location.href.split(re)[1];
            $(document).ready(function () {
                if (re !== undefined) {
                    // refer값이 있으면
                    document.getElementById("ref").value = re2;
                }
                $("#login").click(function () {
                    if ($("#user_id").val() == "") {
                        document.getElementById("msg").innerHTML = "아이디를 입력해주세요.";
                    } else if ($("#user_pwd").val() == "") {
                        document.getElementById("msg").innerHTML = "패스워드를 입력해주세요.<br>";
                    } else {
                        id = $("#user_id").val();
                        pwd = $("#user_pwd").val();
                        $.ajax({
                            url: "/member/loginChk",
                            type: "post",
                            data: { id, pwd },
                            success: function (data) {
                                if (data.res == "fail") {
                                    document.getElementById("msg").innerHTML = "가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.<br>";
                                } else {
                                    $("form").submit();
                                    /* location.href="/member/joinForm"; */
                                }
                            },
                        });
                    }
                });
            });
        </script>
    </head>
    <body>
        <c:import url="../header.jsp"></c:import>
        <section class="py-5">
            <div class="container">
                <div class="py-3">
                    <h1>로그인</h1>
                </div>
                <form action="${pageContext.request.contextPath}/member/login" method="post">
                    <div class="col-md-5 my-2">
                        <input type="text" class="my-3 py-2 form-control" name="user_id" id="user_id" placeholder="ID" />
                        <input type="password" class="my-3 py-2 form-control" name="user_pwd" id="user_pwd" placeholder="PASSWORD" />
                        <span id="msg" class="my-3 py-2 msg"> </span>
                        <button type="button" id="login" class="btn btn-success py-2">로그인하기</button>
                    </div>
                    <input type="hidden" name="refer" id="ref" />
                </form>
                <a href="${pageContext.request.contextPath}/member/joinForm">회원가입</a>
                <a href="${pageContext.request.contextPath}/member/findPwd">비밀번호 찾기</a>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
