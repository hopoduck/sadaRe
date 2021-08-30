<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- 카테고리 관리 컨테이너-->
	<div class="admin_category_container">
	    <div class="admin_category_area">
	        <p> 카테고리를 추가 / 수정 / 삭제 합니다. </p>
	        <hr />
	    </div>
	
	    <div class="admin_all_category_area">
	    	<!-- 카테고리 대분류 폼 -->
		    <div class="admin_category1">
		        <table id="category1_print">
					<caption class="admin_category_caption">대분류</caption>	         
					<tr>
						<td>
							<input type="text" id="category1_name" class="category1" placeholder="대분류 추가"/>
						</td>
					</tr>
		
					<tr>
						<td>
							<input type="button" id="add_category1_btn" value="추가" />
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="category_type" value="1">
	        
	        <!-- 카테고리 중분류 폼 -->
			<div class="admin_category2">
				<table id="category2_print">
					<caption class="admin_category_caption">중분류</caption>
					<tr>
						<td>
							<input type="text" id="category2_name" name="category_name" class="category2" placeholder="중분류 추가"/>
						</td>
					</tr>
		
					<tr>
						<td>
							<input type="button" id="add_category2_btn" value="추가" />
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" id="category2_num" name="parent_category_num" value=""/>
			
			<!-- 카테고리 소분류 폼 -->
			<div class="admin_category3">
				<table id="category3_print">
					<caption class="admin_category_caption">소분류</caption>
					<tr>
						<td>
							<input type="text" id="category3_name" name="category_name" class="category3" placeholder="소분류 추가"/>
						</td>
					</tr>
		
					<tr>
						<td>
							<input type="button" id="add_category3_btn" class="add_category_btn" value="추가" />
						</td>
					</tr>
				</table>
			</div>
			<input type="hidden" id="category3_num" name="parent_category_num" value=""/>
			
			<!-- 선택된 카테고리 영역 -->
	        <div class="admin_select_category_area">
	            <table>
    	            <caption class="admin_category_caption">선택한 카테고리</caption>
	                <tr>
	                    <td>
	                        <input type="text" name="select_category" class="select_category" id="selected_category" value="" /> 
	                    </td>
	                </tr>
	
	                <tr>
	                    <td>
	                        <input type="button" name="edit_btn" class="edit_btn" id="edit_btn" value="수정하기" />
	                        <input type="button" name="del_btn" class="del_btn" id="del_btn" value="삭제하기" />
	                    </td>
	                </tr>
	            </table>
	        </div>
	    </div>
    </div>
</body>
</body>
</html>