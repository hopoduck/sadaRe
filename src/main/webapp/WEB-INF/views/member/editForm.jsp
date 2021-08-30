<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe: 사다리 - 내 정보 수정</title>
        <c:import url="../head.jsp"></c:import>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <link rel="stylesheet" href="/static/css/member_joinForm.css" />
        <script>
            $(document).ready(function () {
                // enter 금지
                $('input[type="text"]').keydown(function () {
                    if (event.keyCode === 13) {
                        event.preventDefault();
                    }
                });

                document.getElementById("edit").disabled = false;
                var chkp = true;
                var chkemail = true;

                function join() {
                    $("#edit").attr("disabled", true);
                    if (chkp) {
                        if (chkemail) {
                            $("#edit").attr("disabled", false);
                        }
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

                $("#user_pwd").on("propertychange change keyup paste input blur", function () {
                    chkp = false;
                    $("#pwd1Result").empty();
                    $("#pwd2Result").empty();
                    if ($("#user_pwd").val() == "") {
                        $("#pwd1Result").text("필수 정보입니다.");
                    } else if ($("#pwdCheck").val() != "") {
                        chkPwd();
                    }
                });

                $("#pwdCheck").on("propertychange change keyup paste input blur", function () {
                    chkp = false;
                    $("#pwd2Result").empty();
                    if ($("#pwdCheck").val() == "") {
                        $("#pwd2Result").text("필수 정보입니다.");
                    } else {
                        chkPwd();
                    }
                });

                $("#user_email1, #user_email2, user_email").on("propertychange change keyup paste input blur", function () {
                    chkemail = false;
                    if ($("#user_email1").val() == "") {
                        $("#emailResult").text("필수 정보입니다.");
                    } else {
                        $("#emailResult").empty();
                        chkemail = true;
                    }
                });
                $("#email_list").change(function () {
                    if ($(this).val() != "") {
                        document.getElementById("user_email2").readOnly = true;
                    } else {
                        document.getElementById("user_email2").readOnly = false;
                    }
                    document.getElementById("user_email2").value = document.getElementById("email_list").value;
                    document.getElementById("user_email2").focus();
                });

                $("input, select").on("propertychange change keyup paste input blur", function () {
                    document.getElementById("user_email").value =
                        document.getElementById("user_email1").value + "@" + document.getElementById("user_email2").value;
                    join();
                });

                $("#memberOut").click(function () {
                    alert("탈퇴처리되었습니다.\n이용해주셔서 감사합니다.");
                    location.href = `${pageContext.request.contextPath}/member/out`;
                });

                var email = "${m.user_email}";
                document.getElementById("user_email1").value = email.slice(0, email.indexOf("@"));
                document.getElementById("user_email2").value = email.slice(email.indexOf("@") + 1);
            });
        </script>
    </head>
    <body>
        <c:import url="../header.jsp"></c:import>
        <section class="py-5">
            <div class="container col-md-9">
                <div class="py-3">
                    <h1>회원 정보 수정</h1>
                </div>
                <form action="/member/edit" id="form" method="post">
                    <!-- 아이디 -->
                    <div class="mb-3">
                        <label for="user_id" class="form-label">아이디</label>
                        <input type="text" class="form-control" name="user_id" id="user_id" value="${m.user_id }" placeholder="아이디" readonly />
                        <span id="idResult"></span>
                    </div>

                    <!-- 비밀번호 -->
                    <div class="mb-3">
                        <label for="user_pwd" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" name="user_pwd" id="user_pwd" value="${m.user_pwd }" placeholder="비밀번호" />
                        <span id="pwd1Result" class="message"></span>
                    </div>
                    <!-- 비밀번호 확인 -->
                    <div class="mb-3">
                        <label for="pwdCheck" class="form-label">비밀번호 확인</label>
                        <input type="password" class="form-control" id="pwdCheck" value="${m.user_pwd }" placeholder="비밀번호 확인" />
                        <span id="pwd2Result" class="message"></span>
                    </div>
                    <!-- 이름 -->
                    <div class="mb-3">
                        <label for="user_name" class="form-label">이름</label>
                        <input type="text" class="form-control" name="user_name" id="user_name" value="${m.user_name }" placeholder="이름" readonly />
                        <span id="nameResult" class="message"></span>
                    </div>
                    <!-- 닉네임 -->
                    <div class="mb-3">
                        <label for="user_nickname" class="form-label">닉네임</label>
                        <input
                            type="text"
                            class="form-control"
                            name="user_nickname"
                            id="user_nickname"
                            value="${m.user_nickname }"
                            placeholder="닉네임"
                        />
                    </div>
                    <!-- 이메일 -->
                    <div class="input-group mb-3">
                        <label for="user_email1" id="email_label" class="form-label">이메일</label>
                        <input type="text" name="user_email1" id="user_email1" class="form-control" placeholder="이메일" aria-label="이메일" />
                        <span class="input-group-text">@</span>
                        <input type="text" id="user_email2" class="form-control" />
                        <!-- 이메일선택 -->
                        <button
                            class="btn btn-outline-secondary dropdown-toggle"
                            id="email_list"
                            type="button"
                            data-bs-toggle="dropdown"
                            aria-expanded="false"
                        ></button>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" onclick="changeEmail('')" value="">직접입력</a></li>
                            <li><a class="dropdown-item" onclick="changeEmail('naver.com')" value="naver.com">네이버</a></li>
                            <li><a class="dropdown-item" onclick="changeEmail('hanmail.net')" value="hanmail.com">다음</a></li>
                            <li><a class="dropdown-item" onclick="changeEmail('google.com')" value="google.com">구글</a></li>
                        </ul>
                    </div>
                    <input type="hidden" id="user_email" name="user_email" readonly />
                    <span id="emailResult" class="message"></span>

                    <!-- 전화번호 -->
                    <div class="mb-3">
                        <label for="user_tel" class="form-label">전화번호</label>
                        <input type="text" class="form-control" name="user_tel" id="user_tel" value="${m.user_tel }" placeholder="전화번호" />
                    </div>
                    <!-- 우편번호 검색 -->
                    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                    <script src="/static/js/postcode.js"></script>
                    <div class="mb-3 postcode">
                        <label for="postcode" id="addr" class="form-label">주소</label>
                        <input
                            type="text"
                            name="user_postcode"
                            id="user_postcode"
                            style="width: 100px"
                            class="form-control"
                            value="${m.user_postcode }"
                            placeholder="우편번호"
                            readonly
                        />
                        <button type="button" id="postcode" class="btn btn-secondary btn" onclick="sample6_execDaumPostcode()">주소찾기</button>
                    </div>
                    <!-- 주소1 -->
                    <div class="mb-3">
                        <input
                            type="text"
                            name="user_addr1"
                            id="user_addr1"
                            class="form-control"
                            value="${m.user_addr1 }"
                            placeholder="주소"
                            readonly
                        />
                    </div>
                    <!-- 주소2 -->
                    <div class="mb-3">
                        <input type="text" name="user_addr2" id="user_addr2" class="form-control" value="${m.user_addr2 }" placeholder="상세주소" />
                    </div>
                    <!-- 생일 -->
                    <div class="mb-3">
                        <label for="user_birth" class="form-label">생일</label>
                        <input id="user_birth" name="user_birth" type="text" class="form-control" value="${m.user_birth }" readonly />
                        <!-- <input id="user_birth" name="user_birth" type="date" min="1900-01-01" max="2000-01-01" class="form-control" value="1900-01-01" /> -->
                    </div>
                    <!-- 타입 -->
                    회원등급 :
                    <input type="hidden" name="user_type" id="user_type" value="${m.user_type }" />
                    <c:if test="${m.user_type ==1}"> 일반회원 </c:if>
                    <c:if test="${m.user_type ==2}"> 관리자 </c:if>
                    <br /><br />
                    <!-- <label><input type="radio" name="user_type" id="user_type" value="1" checked />일반회원</label>
                    <label><input type="radio" name="user_type" id="user_type" value="2" />관리자</label><br /> -->
                    <!-- 가입버튼 -->
                    <button type="submit" id="edit" class="btn btn-primary btn" disabled="disabled">수정하기</button>
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop">탈퇴하기</button>
                    <!-- =================================구분선=============================== -->
                    <!-- Modal -->
                    <div
                        class="modal fade"
                        id="staticBackdrop"
                        data-bs-backdrop="static"
                        data-bs-keyboard="false"
                        tabindex="-1"
                        aria-labelledby="staticBackdropLabel"
                        aria-hidden="true"
                    >
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="staticBackdropLabel">탈퇴</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    탈퇴는 철회할 수 없으며 자신이 작성한 글/댓글은 모두 삭제처리됩니다. <br />
                                    정말로 탈퇴하시겠습니까?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                    <button type="button" class="btn btn-danger" id="memberOut">탈퇴하기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
