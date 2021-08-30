<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
[
	<c:forEach var="i" items="${category_list }" varStatus="status">
		<c:if test="${not status.first }">
			,
		</c:if>
		{"num":${i.category_num }, "name":"${i.category_name }"}
	</c:forEach>
]
