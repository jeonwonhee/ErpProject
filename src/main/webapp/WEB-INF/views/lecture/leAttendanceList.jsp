<!-- === 강사 출결정정 페이지 (상태 오른쪽으로 이동 및 크기 확장) === -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KH EduERP | 강사 출결정정 처리</title>

        <link rel="stylesheet" href="styles\default.css">
        <link rel="stylesheet" href="styles\style.css">
        <link rel="stylesheet" href="styles\lecture.css">
    </head>

    <body class="lecture lecture-attendance-list">
        <div class="teacher-attendance-page kh-container">
            <!-- 사이드바 -->
            <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

            <main class="main">
                <header class="topbar">
                    <div class="path">강사 &gt; 출결정정 처리 <b>강사 페이지</b></div>
                        <div class="user-info">
                            <span class="alert">알림(2)</span>
                            <span class="user">김강사(강사)</span>
                        </div>
                </header>

                <section class="content">
                    <div class="card">
                        <h2>정정 요청 목록</h2>
                        <div class="lecture-request-list">

                            <c:forEach var="u" items="${list}">

                                <div class="card lecture-request-card" onclick="location.href='${pageContext.request.contextPath}/lectureAttendanceCorrection.co?number=${u.attendUpdateNo}'">

                                    <div class="lecture-request-main">
                                        <div class="lecture-request-info">

                                            <strong>${u.studentName}</strong>

                                            <div class="lecture-request-details">
                                                날짜: ${u.correctionApplicationDate}
                                                | 사유: ${u.attendUpdateContent}
                                                | 증빙: <c:if test="${u.hasFile eq 'Y'}">첨부</c:if>
                                                <c:if test="${u.hasFile eq 'N'}">없음</c:if>
                                            </div>
                                        </div>

                                        <span class="status-tag">
                                            <c:choose>
                                                <c:when test="${u.status eq 'REQUESTED'}">대기</c:when>
                                                <c:when test="${u.status eq 'APPROVED'}">승인</c:when>
                                                <c:when test="${u.status eq 'REJECTED'}">반려</c:when>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </section>
            </main>
        </div>
    </body>
</html>
