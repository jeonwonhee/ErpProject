<%--
  Created by IntelliJ IDEA.
  User: awake
  Date: 25. 11. 3.
  Time: 오후 5:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<aside class="sidebar" style="overflow-x: scroll;">
    <div>
        <div class="logo"><span>KH EduERP</span></div>
        <ul class="menu">
            학생
            <li>대시보드</li>
            <li>일정조회</li>
            <li>출결정정신청</li>
            <li>강의만족도조사</li>
            <li>상담신청</li>
            <li>성적조회</li>
            <li>문의</li>
            <li><a href="${pageContext.request.contextPath}/notice.co">공지사항</a></li>
           강사
            <li>대시보드</li>
            <li>학생관리</li>
            <li>휴가승인</li>
            <li>출결 정정 관리</li>
            <li>상담관리</li>
            <li>만족도 결과</li>
            <li><a href="${pageContext.request.contextPath}/notice.co">공지사항</a></li>
            <li>문의</li>
            관리자
            <li class="active">대시보드</li>
            <li>학생관리</li>
            <li>직원관리</li>
            <li>출결현황</li>
            <li><a href="${pageContext.request.contextPath}/notice.co">공지사항</a></li>
            <li>문의</li>
        </ul>
    </div>
    <footer>© 2025 KH</footer>
</aside>
</body>
</html>
