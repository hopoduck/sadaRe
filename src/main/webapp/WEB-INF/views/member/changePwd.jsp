<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe: 사다리 - 비밀번호 변경하기</title>
        <c:import url="../head.jsp"></c:import>
        <link rel="stylesheet" href="/static/css/member_msg.css" />
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            var chkp = false;
            function join() {
                $("#edit").attr("disabled", true);
                if (chkp) {
                    $("#edit").attr("disabled", false);
                }
            }

            function chkPwd() {
                if ($("#user_pwd").val() != $("#pwdCheck").val()) {
                    $("#pwd2Result").text("비밀번호가 일치하지 않습니다.");
                    chkp = false;
                } else {
                    $("#pwd2Result").empty();
                    chkp = true;
                }
            }
            $(document).ready(function () {
                // enter 금지
                $('input[type="text"]').keydown(function () {
                    if (event.keyCode === 13) {
                        event.preventDefault();
                    }
                });
                $("#user_pwd").on("propertychange change keyup paste input blur", function () {
                    chkp = false;
                    $("#pwd1Result").empty();
                    $("#pwd2Result").empty();
                    if ($("#user_pwd").val() == "") {
                        $("#pwd1Result").text("필수 정보입니다.");
                    } else if ($("#pwdCheck").val() != "") {
                        chkPwd();
                    }
                    join();
                });

                $("#pwdCheck").on("propertychange change keyup paste input blur", function () {
                    chkp = false;
                    $("#pwd2Result").empty();
                    if ($("#pwdCheck").val() == "") {
                        $("#pwd2Result").text("필수 정보입니다.");
                    } else {
                        chkPwd();
                    }
                    join();
                });
            });
        </script>
    </head>
    <body>
        <c:import url="../header.jsp"></c:import>
        <section class="py-5">
            <div class="container">
                <form action="/member/changePwd" method="post">
                    <div class="mb-3 col-md-3">
                        <label for="user_pwd" class="form-label">새로운 비밀번호</label>
                        <input type="password" class="form-control" id="user_pwd" name="user_pwd" />
                        <span id="pwd1Result" class="msg"></span>
                    </div>
                    <div class="mb-3 col-md-3">
                        <label for="user_pwd" class="form-label">비밀번호 확인</label>
                        <input type="password" class="form-control" id="pwdCheck" />
                        <span id="pwd2Result" class="msg"></span>
                    </div>
                    <button type="submit" id="edit" class="btn btn-primary btn" disabled="disabled">비밀번호 변경하기</button>
                    <!-- <input type="submit" id="edit" disabled="disabled" value="submit" /> -->
                    <input type="hidden" name="user_id" value="${user_id}" />
                </form>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
