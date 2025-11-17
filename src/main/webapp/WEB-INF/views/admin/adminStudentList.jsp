<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>KH EduERP | 학생목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
</head>

<body class="admin admin-student-list">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<!-- 메인 -->
<main class="main">
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content student-list">
        <div class="card">
            <h2>학생목록</h2>

            <table class="student-table">
                <thead>
                <tr>
                    <th>이름</th>
                    <th>과정</th>
                    <th>연락처</th>
                    <th>출석률</th>
                    <th>상태</th>
                </tr>
                </thead>
                <tbody>

                <!-- 학생이 하나도 없을 때 -->
                <c:if test="${empty studentList}">
                    <tr>
                        <td colspan="5" style="text-align:center; color:#666;">
                            등록된 학생이 없습니다.
                        </td>
                    </tr>
                </c:if>

                <!-- DB에서 가져온 학생 목록 -->
                <c:forEach var="stu" items="${studentList}">
                    <tr>
                        <td>${stu.memberName}</td>
                        <td>${stu.className}</td>
                        <td>${stu.phone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${stu.attendRate ne null}">
                                    ${stu.attendRate}%
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${stu.status == 'Y'}">재학</c:when>
                                <c:when test="${stu.status == 'N'}">수료</c:when>
                                <c:otherwise>${stu.status}</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
            <div class="pagination">

                <c:forEach var="i" begin="${pi.startPage}" end="${pi.endPage}">
                    <c:choose>
                        <c:when test="${i == pi.currentPage}">
                            <button class="page-btn" disabled>
                                    ${i}
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button class="page-btn"
                                    onclick="location.href='${pageContext.request.contextPath}/adminStudentList.co?currentPage=${i}'">
                                    ${i}
                            </button>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

            </div>
        </div>
    </section>
</main>
</body>
</html>
