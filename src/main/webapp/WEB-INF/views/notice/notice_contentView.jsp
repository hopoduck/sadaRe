<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe: 사다리 - ${n.notice_title}</title>
        <c:import url="../head.jsp" />
    </head>
    <body>
        <!-- navbar 영역 시작 -->
        <c:import url="../header.jsp" />
        <!-- navbar 영역 끝 -->
        <section class="py-5">
            <div class="container">
                <div class="py-3">
                    <h1>공지사항</h1>
                </div>
                <c:import url="/notice/Board"></c:import>
                <div class="col-md-12">
                    <form id="contentForm" action="${pageContext.request.contextPath}">
                        <input type="hidden" name="notice_num" value="${n.notice_num}" />
                        <div class="mb-3">
                            <h1>${n.notice_title}</h1>
                        </div>
                        <div class="mb-3">
                            <fmt:formatDate value="${n.notice_date}" pattern="YYYY년 MM월 dd일 hh:mm" />
                        </div>
                        <hr class="dropdown-divider" />
                        <div class="mb-3">
                            <div class="content fs-2" style="white-space: pre">${n.notice_content}</div>
                        </div>
                        <div class="mb-3">
                            <c:if test="${user_type==2}">
                                <button
                                    class="btn btn-danger del-btn"
                                    type="button"
                                    onclick="location.href=`${pageContext.request.contextPath}/notice/notice_delete?notice_num=${n.notice_num}`"
                                >
                                    삭제
                                </button>
                            </c:if>
                            <button class="btn btn-primary list-btn" type="button" onClick="history.back();">목록으로</button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <!-- footer 영역 시작 -->
        <c:import url="../footer.jsp" />
        <!-- footer 영역 끝 -->
    </body>
</html>
