<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function() {
	//찜 목록 페이지에서 상품 선택 삭제
 	$(".delete").click(function(){
 		var item = $(".delete").attr("itemid");
 		$.ajax({
 			type: "post" ,
 			url: "${pageContext.request.contextPath}/wish/delete",
        	data: { wish_num: item },
        	success: function(response){
        		alert("삭제되었습니다");
        		location.href=location.href;
        	},
 		});
		
	}); 
	
	//찜 목록 페이지에서 상품 전체 삭제
	$("#deleteAll").click(function(){
		var confirm_val = confirm("정말 삭제하시겠습니까?");
		if(confirm_val){
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
<h3>찜 목록 페이지</h3>
<form id="w" action="${pageContext.request.contextPath }/wish/wishList" method="post">
<c:if test="${empty list }">
찜 목록이 비어있습니다.
</c:if>
<c:if test="${not empty list }">
<table class="table">
                            <thead class="thead-light">
                                <tr>
                                    <th>제품번호</th>
                                    <th>제품이름</th>
                                    <th>제품가격</th>
                                    <th>등록일</th>
                                    <th>작성자</th>
                                    <th>조회수</th>
                                    <th>판매결과</th>
                                </tr>
                            </thead>
                            <c:forEach var="wish" items="${list}">
                                <tr>
                                    <td>${wish.p.product_num}</td>
                                    <td>
                                        <a
                                            href="${pageContext.request.contextPath}/product/view?product_num=${wish.p.product_num}"
                                            >${wish.p.product_name}</a
                                        >
                                    </td>
                                    <td>
                                    	₩ <fmt:formatNumber pattern="#,###" value="${product.product_price}"></fmt:formatNumber>
                                    </td>
                                    <td>${wish.p.product_add_date}</td>
                                    <td>${wish.p.user_id}</td>
                                    <td>${wish.p.product_hit}</td>
                                    <!-- 판매 상태에 대한 값을 보기 좋게 변경함 -->
                                    <td>
                                        <c:choose>
                                            <c:when
                                                test="${wish.p.product_result == 0}"
                                            >
                                                판매중
                                            </c:when>
                                            <c:otherwise>
                                                판매완료
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                  	<input type="button" value="삭제" class="delete" itemid="${wish.wish_num }">                
                                  	</td>
                                </tr>                                                         
                            </c:forEach>
                        </table><br>
                         		<tr>
                                	<td><input type="button" value="전체삭제" id="deleteAll"></td>
                                </tr>
</c:if>
</form>
</body>
</html>