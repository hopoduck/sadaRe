<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>reportValue</title>
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>
            $(document).ready(function () {
                $("#ok").click(function () {
                    location.href = "${pageContext.request.contextPath}/report/reportList";
                });
            });
        </script>
    </head>
    <body>
        <h3>접수된 신고 내용</h3>
        <form action="${pageContext.request.contextPath }/report/value" method="post">
            제목 : <input type="text" name="report_title" value="${r.report_title }" readonly /> <br /><br />
            내용 : <textarea name="report_content" rows="15" cols="50" readonly>${r.report_content }</textarea>
        </form>
        <br />
        <input type="button" id="ok" value="확인" />
    </body>
</html>
