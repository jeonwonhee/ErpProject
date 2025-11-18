<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KH EduERP | 반 관리</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
</head>

<body class="admin admin-class-manage">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<!-- 메인 -->
<main class="main">
    <c:set var="pageName" value="반 관리" scope="request"></c:set>
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
        <!-- 반 관리 -->
        <h2 class="section-title">반 리스트 <button class="btn-submit" onclick="location.href='${pageContext.request.contextPath}/adminClassEnrollForm.co'">+ 반 추가</button></h2>
        <div class="card">
            <table>
                <thead>
                <tr>
                    <th>반 이름</th>
                    <th>학생 수</th>
                    <th>일정 시작일</th>
                    <th>일정 종료일</th>
                </tr>
                </thead>
                <tbody>
                    <c:forEach var="classInfo" items="${classList}">
                        <tr onclick="location.href='${pageContext.request.contextPath}/adminClassUpdateForm.co?classNo=${classInfo.classNo}'">
                            <td>${classInfo.className}</td>
                            <td>${classInfo.memberCount}</td>
                            <td>${classInfo.startDate}</td>
                            <td>${classInfo.endDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </section>
</main>
</body>
</html>
