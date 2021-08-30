<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe: 사다리 - 비밀번호 확인</title>
        <c:import url="../head.jsp"></c:import>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function () {
                // enter 금지
                $('input[type="text"]').keydown(function () {
                    if (event.keyCode === 13) {
                        event.preventDefault();
                    }
                });
                $("#submit").click(function () {
                    $.ajax({
                        url: "/member/pwdChk",
                        type: "post",
                        data: { pwd: $("#user_pwd").val() },
                        success: function (data) {
                            if (data.res == "ok") {
                                $("#form").submit();
                            } else {
                                alert("패스워드를 확인해주세요!");
                                document.getElementById("user_pwd").value = "";
                            }
                        },
                    });
                });
                $("#form").submit(function (e) {
                    e.preventDefault();
                    $.ajax({
                        url: "/member/pwdChk",
                        type: "post",
                        data: { pwd: $("#user_pwd").val() },
                        success: function (data) {
                            if (data.res == "ok") {
                                /* $("#form").submit(); */
                                location.href = "/member/editForm";
                            } else {
                                alert("패스워드를 확인해주세요!");
                                document.getElementById("user_pwd").value = "";
                                document.getElementById("user_pwd").focus();
                            }
                        },
                    });
                });
            });
        </script>
    </head>

    <body>
        <c:import url="../header.jsp"></c:import>
        <section class="py-5">
            <div class="container">
                <div class="py-3">
                    <h1>비밀번호 확인</h1>
                </div>
                <form id="form">
                    <div class="col-md-6 input-group" style="width: 40%">
                        <input type="password" name="user_pwd" id="user_pwd" class="form-control" placeholder="비밀번호를 입력하세요." />
                        <button class="btn btn-outline-secondary" type="submit">확인</button>
                    </div>
                </form>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
