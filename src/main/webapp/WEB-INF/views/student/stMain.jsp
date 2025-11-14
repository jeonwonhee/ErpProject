<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>KH EduERP | 학생 대시보드</title>

    <link rel="stylesheet" href="/styles/default.css" />
    <link rel="stylesheet" href="/styles/style.css" />
    <link rel="stylesheet" href="/styles/student.css" />
</head>
<body class="student">
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<main class="main">
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
        <div class="left-section">

            <!-- 출석률 카드 -->
            <div class="card">
                <h2>이번달 출석률</h2>
                <div class="attendance-wrapper">
                    <div class="donut-wrapper">
                        <svg viewBox="0 0 220 220">
                            <circle class="bg" cx="110" cy="110" r="90" />

                            <!-- 출석 (보라색) -->
                            <circle class="attend" cx="110" cy="110" r="90"
                                    style="stroke-dasharray: ${attendanceData.attendRate * 5.65}, 565;" />

                            <!-- 지각 (노랑) -->
                            <circle class="late" cx="110" cy="110" r="90"
                                    style="stroke-dasharray: ${attendanceData.lateRate * 5.65}, 565;
                                            stroke-dashoffset: -${attendanceData.attendRate * 5.65};" />

                            <!-- 결석 (빨강) -->
                            <circle class="absent" cx="110" cy="110" r="90"
                                    style="stroke-dasharray: ${attendanceData.absentRate * 5.65}, 565;
                                            stroke-dashoffset: -${(attendanceData.attendRate + attendanceData.lateRate) * 5.65};" />
                        </svg>

                        <div class="chart-text">${attendanceData.rate}%</div>
                    </div>

                    <div class="attendance-details">
                        <div><strong>출석</strong> ${attendanceData.attendCount}회</div>
                        <div><strong>지각</strong> ${attendanceData.lateCount}회</div>
                        <div><strong>결석</strong> ${attendanceData.absentCount}회</div>

                        <div class="legend">
                            <span class="att">출석</span>
                            <span class="late">지각</span>
                            <span class="abs">결석</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 오늘 일정 -->
            <div class="card schedule">
                <h2>오늘 일정</h2>
                <ul>
                    <c:forEach var="s" items="${todaySchedule}">
                        <li>
                                ${s.title}
                            (<fmt:formatDate value="${s.startDate}" pattern="MM/dd" />~
                            <fmt:formatDate value="${s.endDate}" pattern="MM/dd" />)
                        </li>
                    </c:forEach>
                    <c:if test="${empty todaySchedule}">
                        <li>오늘 일정이 없습니다.</li>
                    </c:if>
                </ul>
            </div>
        </div>

        <!-- 상세 기록 -->
        <div class="card details-card">
            <h2>상세 기록</h2>

            <div class="week-nav">
                <button id="prevWeekBtn" onclick="changeWeek(-1)">◀ 이전주</button>
                <button id="nextWeekBtn" onclick="changeWeek(1)">다음주 ▶</button>
            </div>

            <table>
                <thead>
                <tr>
                    <th>날짜</th>
                    <th>출석</th>
                    <th>지각</th>
                    <th>결석</th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                    <c:when test="${not empty weeklyList}">
                        <c:forEach var="a" items="${weeklyList}">
                            <tr>
                                <td>
                                    <fmt:formatDate value="${a.attendDate}" pattern="yyyy.MM.dd"/>
                                </td>

                                <!-- 출석 -->
                                <td>
                                    <c:if test="${a.attendStatus eq 'ATTEND'}">
                                        <span class="attend-text">✔️ 출석</span>
                                    </c:if>
                                </td>

                                <!-- 지각 -->
                                <td>
                                    <c:if test="${a.attendStatus eq 'LATE'}">
                                        <span class="late-text">⚠️ 지각</span>
                                    </c:if>
                                </td>

                                <!-- 결석 -->
                                <td>
                                    <c:if test="${a.attendStatus eq 'ABSENT'}">
                                        <span class="absent-text">❌ 결석</span>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <tr>
                            <td colspan="4" style="text-align:center; color:#888;">출석 데이터가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>

            <script>
                function changeWeek(offset) {
                    const next = ${weekOffset} + offset;
                    location.href = '/stMain.co?weekOffset=' + next;
                }

                window.onload = function () {
                    const week = ${weekOffset};

                    const prevBtn = document.getElementById("prevWeekBtn");
                    const nextBtn = document.getElementById("nextWeekBtn");

                    // week = 0 : 이번주 → 다음주(미래) 금지
                    if (week >= 0) {
                        nextBtn.disabled = true;
                    }

                    // week = -4 이상 가면 너무 과거이므로 제한
                    if (week <= -4) {
                        prevBtn.disabled = true;
                    }
                }
            </script>
</body>
</html>