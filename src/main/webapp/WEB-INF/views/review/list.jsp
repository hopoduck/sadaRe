<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sadare - 리뷰 목록</title>
</head>
<body>
	<c:choose>
		<c:when test="${not empty rList}">
			<c:forEach var="r" items="${rList}">
				${r.writer_id}님 : ${r.review_content}
			</c:forEach>
		</c:when>
		<c:otherwise>
			<h2>등록된 리뷰가 없습니다!</h2>
		</c:otherwise>
	</c:choose>
</body>
</html>
