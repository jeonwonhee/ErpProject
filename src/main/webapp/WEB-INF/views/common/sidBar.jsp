<%--
  Created by IntelliJ IDEA.
  User: awake
  Date: 25. 11. 3.
  Time: 오후 5:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="/styles/style.css">
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
            <li><a href="${pageContext.request.contextPath}/stMain.co">대시보드</a></li>
            <li><a href="${pageContext.request.contextPath}/stLectureDate.co">일정조회</a></li>
            <li><a href="${pageContext.request.contextPath}/stAtt.co">출석정정신청</a></li>
            <li><a href="${pageContext.request.contextPath}/stSatisfication.co">강의만족도조사</a></li>
            <li><a href="${pageContext.request.contextPath}/stConsult.co">상담신청</a></li>
            <li><a href="${pageContext.request.contextPath}/stScore.co">성적조회</a></li>
            <li><a href="${pageContext.request.contextPath}/stQuestion.co">문의</a></li>
            <li><a href="${pageContext.request.contextPath}/notice.co">공지사항</a></li>
            <li><a href="${pageContext.request.contextPath}/stFacility.co">기자재신청</a></li>
           강사
            <li><a href="${pageContext.request.contextPath}/leDashboard.co">대시보드</a></li>
            <li><a href="${pageContext.request.contextPath}/leGrade.co">성적관리</a></li>
            <li><a href="${pageContext.request.contextPath}/leAttendance.co">출결관리</a></li>
            <li><a href="${pageContext.request.contextPath}/leCalender.co">일정관리</a></li>
            <li><a href="${pageContext.request.contextPath}/leConsult.co">상담관리</a></li>
            <li><a href="${pageContext.request.contextPath}/leAttendanceList.co">출결정정 처리</a></li>
            <li><a href="${pageContext.request.contextPath}/leFeedback.co">만족도 결과</a></li>
            <li><a href="${pageContext.request.contextPath}/notice.co">공지사항</a></li>
            <li><a href="${pageContext.request.contextPath}/questionManage.co">문의</a></li>
            관리자
            <li><a href="${pageContext.request.contextPath}/adminDashboard.co">대시보드</a></li>
            <li><a href="${pageContext.request.contextPath}/adminStudentList.co">학생관리</a></li>
            <li><a href="${pageContext.request.contextPath}/adminLectureList.co">직원관리</a></li>
            <li><a href="${pageContext.request.contextPath}/adminCalenderManage.co">일정관리</a></li>
            <li><a href="${pageContext.request.contextPath}/adminAttendDashboard.co">출결현황</a></li>
            <li><a href="${pageContext.request.contextPath}/notice.co">공지사항</a></li>
            <li><a href="${pageContext.request.contextPath}/questionManage.co">문의</a></li>
            <li><a href="${pageContext.request.contextPath}/adminFacility.co">기자재관리</a></li>
        </ul>
    </div>
    <footer>© 2025 KH</footer>
</aside>
</body>
</html>
