<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <title>KH EduERP | 강사목록</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">

    </head>

    <body class="admin admin-lecture-list">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <c:set var="pageName" value="직원 관리" scope="request"></c:set>
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content lecture-list">
                <div class="card">
                    <h2>강사목록</h2>
                    <div class="inquiry-write">
                        <button type="button" class="btn-write create-btn" onclick="location.href='${pageContext.request.contextPath}/adminRegister.co'">강사/관리자 생성</button>
                    </div>
                    <table class="lecture-table">
                        <thead>
                            <tr>
                                <th>이름</th>
                                <th>담당 과정</th>
                                <th>연락처</th>
                                <th>출근율</th>
                                <th>상태</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="emp" items="${empList}">
                                <tr>
                                    <td>${emp.memberName}</td>
                                    <td>${emp.lectureName}</td>
                                    <td>${emp.phone}</td>
                                    <td>${emp.commuteRate}</td>
                                    <td>${emp.status}</td>
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
                                            onclick="location.href='${pageContext.request.contextPath}/adminLectureList.co?currentPage=${i}'">
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
