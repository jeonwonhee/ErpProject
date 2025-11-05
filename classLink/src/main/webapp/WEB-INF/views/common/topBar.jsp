<%--
  Created by IntelliJ IDEA.
  User: awake
  Date: 25. 11. 3.
  Time: 오후 5:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>topBar</title>
</head>
<body>
<header class="topbar">
    <div class="path">강사 › 공지사항 <b>강사 페이지</b></div>
    <div class="user-info" onclick="location.href='${pageContext.request.contextPath}/studentMyPage.co'">알림(<span>2</span>) 김강사(강사)</div>
</header>
</body>
</html>
