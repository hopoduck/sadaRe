<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"
%> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe - 제품 보기</title>
        <c:import url="../head.jsp"></c:import>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/product_view.css" />
        <script>
            replyList = {};
            function toggleReply(reply_num) {
                $(`#form-${"${reply_num}"}`).slideToggle();
            }
            function editReply(reply_num) {
                const reply = $(`#reply-${"${reply_num}"}`);
                if (replyList[reply_num] === undefined) {
                    replyList[reply_num] = reply.text();
                    let html = `
                        <form action="${pageContext.request.contextPath}/reply/edit" method="post">
                            <div class="input-group edit-reply">
                                <textarea name="reply_content" class="form-control" rows="4" aria-describedby="reply" required>${"${reply.text()}"}</textarea>
                                <button class="btn btn-outline-secondary reply-btn" type="submit">댓글 수정</button>
                            </div>
                            <input type="hidden" name="reply_num" value="${"${reply_num}"}" />
                        </form>`;
                    reply.css("white-space", "normal");
                    reply.html(html);
                } else {
                    reply.text(replyList[reply_num]);
                    reply.css("white-space", "pre");
                    replyList[reply_num] = undefined;
                }
            }
            function deleteReply(reply_num) {
                $.ajax({
                    type: "post",
                    url: "${pageContext.request.contextPath}/reply/delete",
                    data: { reply_num },
                    success: function (response) {
                        alert("댓글이 삭제되었습니다.");
                        location.href = location.href.split("#")[0];
                    },
                });
            }
            // 찜 목록 및 거래기능 추가시 로그인사용자만 가능하게끔 구현
            function loginCheck() {
                if ("${sessionScope.user_id}" === "" || "${sessionScope.user_id}" === "null") {
                    return false;
                } else {
                    return true;
                }
            }
            // 이미지 리스트 생성
            $(document).ready(function () {
                // 로그인 되어있을 때 찜버튼 변경
                if (loginCheck()) {
                    $.ajax({
                        type: "post",
                        url: "${pageContext.request.contextPath}/wish/check",
                        data: { product_num: "${p.product_num}" },
                        success: function (response) {
                            // 로그인이 되어있고, 해당 상품을 찜 해놓았으면 체크박스 값 변경해줌
                            if (loginCheck() === true && response === true) {
                                $("#wish").prop("checked", true);
                            }
                        },
                    });
                }
                // 찜 버튼 클릭시 로그인여부를 확인하고, 찜 목록에 추가/삭제기능
                $("#wish").change(function (e) {
                    if (loginCheck() === true) {
                        if ($(this).prop("checked") === true) {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath}/wish/add",
                                data: { product_num: "${p.product_num}" },
                                success: function (response) {
                                    alert("찜목록에 추가되었습니다.");
                                },
                            });
                        } else {
                            $.ajax({
                                type: "post",
                                url: "${pageContext.request.contextPath}/wish/delete",
                                data: { product_num: "${p.product_num}" },
                                success: function (response) {
                                    alert("찜목록에서 삭제되었습니다.");
                                },
                            });
                        }
                    } else {
                        const goLogin = confirm("로그인이 필요한 기능입니다. 로그인하시겠습니까?");
                        if (goLogin) {
                            $("#wish").prop("checked", false);
                            location.href = `${pageContext.request.contextPath}/member/loginForm?refer=${"${location.href}"}`;
                        } else {
                            // 로그인하지 않았으므로 체크박스를 다시 해제시킴
                            $("#wish").prop("checked", false);
                        }
                    }
                });
                // 댓글 입력
                $(".add-reply-form").submit(function (e) {
                    e.preventDefault();
                    if ("${sessionScope.user_id}" === "") {
                        const goLogin = confirm("로그인이 필요한 기능입니다. 로그인하시겠습니까?");
                        if (goLogin) {
                            location.href = `${pageContext.request.contextPath}/member/loginForm?refer=${"${location.href}"}`;
                        } else {
                            $(this)[0].reset();
                        }
                    } else {
                        $(this)[0].submit();
                    }
                });
                $('[data-toggle="popover"]').popover({ html: true });
                $("button[name='reply-user_id']").click(function (e) {
                    e.preventDefault();
                    console.log(e);
                });
                // 신고하기 버튼
                $(document).on("click", "a[id='reportbtn']", function (e) {
                    e.preventDefault();
                    if ("${sessionScope.user_id}" === "") {
                        const goLogin = confirm("로그인이 필요한 기능입니다. 로그인하시겠습니까?");
                        if (goLogin) {
                            location.href = `${pageContext.request.contextPath}/member/loginForm?refer=${"${location.href}"}`;
                        }
                    } else {
                        $("#rb").modal("toggle");
                    }
                });
                // 신고 제출 버튼
                $(document).on("click", "button[id='report']", function () {
                    document.getElementById("report_form").submit();
                });
            });
        </script>
    </head>
    <body>
        <c:import url="../header.jsp"></c:import>
        <section class="py-5">
            <div class="container border px-5 py-4">
                <h2>${p.product_name}</h2>
                <div class="product_image">
                    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-indicators">
                            <button
                                type="button"
                                data-bs-target="#carouselExampleIndicators"
                                data-bs-slide-to="0"
                                class="active"
                                aria-current="true"
                                aria-label="Slide 1"
                            ></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                        </div>
                        <div class="carousel-inner">
                            <c:if test="${not empty p.path1}">
                                <div class="carousel-item active">
                                    <a href="${p.path1}" target="blank">
                                        <img src="${p.path1}" alt="${p.product_name}" id="img1" class="d-block w-100 product-img" itemid="0" />
                                    </a>
                                </div>
                            </c:if>
                            <c:if test="${not empty p.path2}">
                                <div class="carousel-item">
                                    <a href="${p.path2}" target="blank">
                                        <img src="${p.path2}" alt="${p.product_name}" id="img2" class="d-block w-100 product-img" itemid="1" />
                                    </a>
                                </div>
                            </c:if>
                            <c:if test="${not empty p.path3}">
                                <div class="carousel-item">
                                    <a href="${p.path3}" target="blank">
                                        <img src="${p.path3}" alt="${p.product_name}" id="img3" class="d-block w-100 product-img" itemid="2" />
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
                <div class="my-4">
                    <div class="product-info">
                        <div class="user">
                            <span class="user-id">
                                <a
                                    href="${pageContext.request.contextPath}/product/search?q=user_id&value=${p.user_id}"
                                    title="판매자의 다른 상품보기"
                                    >${p.member.user_nickname}</a
                                >
                            </span>
                            (${p.user_id},
                            <c:choose>
                                <c:when test="${p.member.user_scorecount != 0}">
                                    <i class="fas fa-star"></i>
                                    <fmt:formatNumber value="${p.member.user_score/p.member.user_scorecount}" pattern="#.##점" />,
                                    ${p.member.user_scorecount}명
                                </c:when>
                                <c:otherwise>평점 정보가 없습니다.</c:otherwise>
                            </c:choose>
                            )
                        </div>
                        <div class="dropdown-divider my-3"></div>
                        <div class="product-price">
                            <fmt:formatNumber value="${p.product_price}" pattern="#,###원" />
                        </div>
                        <div class="category">
                            <nav style="--bs-breadcrumb-divider: '>'" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item active">
                                        <a
                                            href="${pageContext.request.contextPath}/product/search?q=c1&value=${p.category1_num}"
                                            title="해당 대분류로 검색"
                                            >${p.c1.category_name}</a
                                        >
                                    </li>
                                    <li class="breadcrumb-item active">
                                        <a
                                            href="${pageContext.request.contextPath}/product/search?q=c2&value=${p.category2_num}"
                                            title="해당 중분류로 검색"
                                            >${p.c2.category_name}</a
                                        >
                                    </li>
                                    <li class="breadcrumb-item active">
                                        <a
                                            href="${pageContext.request.contextPath}/product/search?q=c3&value=${p.category3_num}"
                                            title="해당 소분류로 검색"
                                            >${p.c3.category_name}</a
                                        >
                                    </li>
                                </ol>
                                <div class="add_date">${p.stringDate}</div>
                            </nav>
                        </div>
                        <div class="content py-2">${p.product_info}</div>
                        <div class="product-data my-2">
                            조회수 ${p.product_hit} | 관심
                            <c:import url="${pageContext.request.contextPath}/wish/countProduct?product_num=${p.product_num}" /> | 댓글
                            ${p.replys.size()} |
                            <a id="reportbtn" style="cursor: pointer">신고하기</a>
                        </div>
                        <c:choose>
                            <%-- 판매자 --%>
                            <c:when test="${sessionScope.user_id == p.user_id}">
                                <c:choose>
                                    <c:when test="${p.product_result != 2}">
                                        <div class="user-panel">
                                            <button
                                                type="button"
                                                class="btn btn-danger"
                                                onclick="location.href=`${pageContext.request.contextPath}/product/delete?product_num=${p.product_num}`"
                                            >
                                                제품 삭제
                                            </button>
                                            <c:choose>
                                                <c:when test="${p.product_result == 1}">
                                                    <button
                                                        type="button"
                                                        class="btn btn-warning"
                                                        onclick="location.href=`${pageContext.request.contextPath}/product/ordercancel?product_num=${p.product_num}`"
                                                    >
                                                        거래 예약 취소
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <button
                                                        type="button"
                                                        class="btn btn-warning"
                                                        onclick="location.href=`${pageContext.request.contextPath}/product/order?product_num=${p.product_num}`"
                                                    >
                                                        거래 예약 중
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <h4 class="result my-4">거래 완료된 제품입니다.</h4>
                                        <button
                                            type="button"
                                            class="btn btn-danger"
                                            onclick="location.href=`${pageContext.request.contextPath}/product/delete?product_num=${p.product_num}`"
                                        >
                                            제품 삭제
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <%-- 구매자 --%>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${p.product_result != 2}">
                                        <label class="like">
                                            <input type="checkbox" id="wish" />
                                            <div class="hearth"></div>
                                        </label>
                                        <!-- 신고하기 -->
                                        <div class="modal fade" id="rb" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="exampleModalLabel">신고하기</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form id="report_form" method="post" action="${pageContext.request.contextPath}/report/add">
                                                            <div class="mb-3">
                                                                <label for="recipient-name" class="col-form-label">신고 사유</label>
                                                                <input type="text" class="form-control  w-100" id="recipient-name" name="report_title">
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="message-text" class="col-form-label">세부 내용을 적어주세요</label>
                                                                <textarea class="form-control w-100" id="message-text" name="report_content"></textarea>
                                                            </div>
                                                            <input type="hidden" id="product_num" name="product_num" value="${p.product_num}" />
                                                        </form>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                                                        <button type="button" class="btn btn-primary" id="report">신고</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /신고하기 -->
                                    </c:when>
                                    <c:otherwise>
                                        <h4 class="result my-4">거래 완료된 제품입니다.</h4>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                <div class="dropdown-divider my-3"></div>
                <div class="replys" id="reply-add-form">
                    <!-- 댓글 등록 폼 -->
                    <form action="${pageContext.request.contextPath}/reply/add" method="post" class="add-reply-form">
                        <div class="input-group add-reply">
                            <textarea name="reply_content" class="form-control" rows="4" aria-describedby="reply" required></textarea>
                            <button class="btn btn-outline-secondary reply-btn" type="submit">댓글 등록</button>
                        </div>
                        <input type="hidden" name="user_id" value="${sessionScope.user_id}" />
                        <input type="hidden" name="product_num" value="${p.product_num}" />
                        <input type="hidden" name="parent_reply_num" value="-1" />
                    </form>
                    <!-- 댓글 목록 -->
                    <ul class="list-group replys">
                        <c:forEach var="reply" items="${p.replys}">
                            <c:set var="status" value="${reply.reply_content==null?'deleted':p.user_id==reply.user_id?'seller':'other'}" />
                            <c:set var="className" value="${reply.reply_content==null?'deleted':p.user_id==reply.user_id?'primary':'info'}" />
                            <%-- 한개의 댓글 내용 --%>
                            <c:choose>
                                <%-- 댓글이 정상상태인 경우 --%>
                                <c:when test="${status!='deleted'}">
                                    <li class="list-group-item list-group-item-${className} ${status}">
                                        <div class="reply-content" id="reply-${reply.reply_num}">${reply.reply_content}</div>
                                        <div class="reply-writer">
                                            <c:if test="${p.user_id==sessionScope.user_id && p.product_result != 2}">
                                                <a
                                                    name="reply-user_id"
                                                    data-toggle="popover"
                                                    title="<a href='${pageContext.request.contextPath}/product/soldout?product_num=${p.product_num}&user_id=${reply.user_id}'>거래완료상대</a>"
                                                >
                                            </c:if>
                                            ${reply.member.user_nickname} (${reply.user_id})
                                            <c:if test="${p.user_id==sessionScope.user_id && p.product_result != 2}">
                                                </a>
                                            </c:if>
                                        </div>
                                        <div class="reply-menu mt-3">
                                            <c:if test="${sessionScope.user_id!=null}">
                                                <a onclick="toggleReply(`${reply.reply_num}`)" title="댓글"><i class="fas fa-reply"></i> 댓글</a>
                                            </c:if>
                                            <c:if test="${reply.user_id==sessionScope.user_id}">
                                                <span> | </span>
                                                <a onclick="editReply(`${reply.reply_num}`)" title="수정"><i class="fas fa-edit"></i> 수정</a>
                                                <span> | </span>
                                                <a onclick="deleteReply(`${reply.reply_num}`)" title="삭제"><i class="fas fa-trash"></i> 삭제</a>
                                            </c:if>
                                        </div>
                                    </li>
                                    <%-- 댓글 내용 끝 & 댓글의 댓글 추가 폼 --%>
                                    <form
                                        action="${pageContext.request.contextPath}/reply/add"
                                        method="post"
                                        class="add-child-reply-form"
                                        id="form-${reply.reply_num}"
                                        style="display: none"
                                    >
                                        <div class="input-group">
                                            <textarea name="reply_content" class="form-control" rows="4" aria-describedby="reply" required></textarea>
                                            <button class="btn btn-outline-secondary child-reply-btn" type="submit">댓글 등록</button>
                                        </div>
                                        <input type="hidden" name="user_id" value="${sessionScope.user_id}" />
                                        <input type="hidden" name="product_num" value="${p.product_num}" />
                                        <input type="hidden" name="parent_reply_num" value="${reply.reply_num}" />
                                    </form>
                                    <%-- 댓글의 댓글 폼 끝 --%>
                                </c:when>
                                <%-- 댓글이 삭제된 상태인 경우 --%>
                                <c:otherwise>
                                    <li class="list-group-item list-group-item-${className} ${status}">
                                        <div class="reply-content">삭제된 댓글 입니다.</div>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                            <%-- 하위 댓글이 있는 경우 --%>
                            <c:if test="${not empty reply.child_reply}">
                                <c:forEach var="c_reply" items="${reply.child_reply}">
                                    <c:set
                                        var="child_status"
                                        value="${c_reply.reply_content==null?'deleted':p.user_id==c_reply.user_id?'seller':'other'}"
                                    />
                                    <c:set
                                        var="child_className"
                                        value="${c_reply.reply_content==null?'deleted':p.user_id==c_reply.user_id?'primary':'info'}"
                                    />
                                    <c:choose>
                                        <c:when test="${child_status!='deleted'}">
                                            <li class="list-group-item list-group-item-${child_className} ${child_status} child-reply">
                                                <div id="reply-${c_reply.reply_num}" class="child reply-content">${c_reply.reply_content}</div>
                                                <div class="child reply-writer">
                                                    <c:if test="${p.user_id==sessionScope.user_id && p.product_result != 2}">
                                                        <a
                                                            name="reply-user_id"
                                                            data-toggle="popover"
                                                            title="<a href='${pageContext.request.contextPath}/product/soldout?product_num=${p.product_num}&user_id=${reply.user_id}'>거래완료상대</a>"
                                                        >
                                                    </c:if>
                                                    ${c_reply.member.user_nickname} (${c_reply.user_id})
                                                    <c:if test="${p.user_id==sessionScope.user_id && p.product_result != 2}">
                                                        </a>
                                                    </c:if>
                                                </div>
                                                <%-- 댓글 쓴 사람 == 로그인 한 사람 --%>
                                                <c:if test="${c_reply.user_id==sessionScope.user_id}">
                                                    <div class="child reply-menu mt-3">
                                                        <a onclick="editReply(`${c_reply.reply_num}`)" title="수정"
                                                            ><i class="fas fa-edit"></i> 수정</a
                                                        >
                                                        <span> | </span>
                                                        <a onclick="deleteReply(`${c_reply.reply_num}`)" title="삭제"
                                                            ><i class="fas fa-trash"></i> 삭제</a
                                                        >
                                                    </div>
                                                </c:if>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="list-group-item list-group-item-${child_className} ${child_status} child-reply">
                                                <div class="child reply-content">삭제된 댓글 입니다.</div>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
