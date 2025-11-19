<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 강사 대시보드</title>
        <link rel="stylesheet" href="styles/default.css">
        <link rel="stylesheet" href="styles/style.css">
        <link rel="stylesheet" href="styles/lecture.css">
    </head>
    <body class="lecture lecture-dashboard">

        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <main class="main">
            <c:set var="pageName" value="대시보드" scope="request"></c:set>
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="dashboard-grid">

                <!-- 출석률 그래프 -->
                <div class="card">
                    <h3>출석률</h3>
                    <div class="chart-area">
                        <canvas id="attendanceChart"></canvas>
                    </div>
                </div>

                <!-- 반별 평균 성적 그래프 -->
                <div class="card">
                    <h3>반별 평균 성적</h3>
                    <div class="chart-area">
                        <canvas id="avgScoreChart"></canvas>
                    </div>
                </div>

                <!-- 최근 신청 리스트 -->
                <div class="card">
                    <h3>최근 신청 리스트</h3>
                    <table>
                        <thead>
                        <tr><th>이름</th><th>신청일</th><th>사유</th></tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty recentApplicationList}">
                                <c:forEach items="${recentApplicationList}" var="ap">
                                    <tr>
                                        <td>${ap.studentName}</td>
                                        <td>${ap.applyDate}</td>
                                        <td>${ap.reason}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="3" style="color:#777;">데이터가 없습니다</td></tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>

                <!-- 출석 현황 (여기서는 '출석률' 대신 '평균 점수'로 보는게 맞음) -->
                <div class="card">
                    <h3>반별 평균 성적/인원</h3>
                    <table>
                        <thead>
                        <tr><th>반</th><th>인원</th><th>평균 점수</th></tr>
                        </thead>
                        <tbody>
                        <c:choose>
                            <c:when test="${not empty classAvgScores}">
                                <c:forEach items="${classAvgScores}" var="row">
                                    <tr>
                                        <td>${row.className}</td>
                                        <td>${row.studentCount}</td>
                                        <td>${row.avgGrade}</td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr><td colspan="3" style="color:#777;">데이터가 없습니다</td></tr>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>

            </section>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <script>
            const attendanceRate = ${attendanceRate != null ? attendanceRate : 0};

            const classLabels = [
                <c:forEach var="row" items="${classAvgScores}">
                '${row.className}',
                </c:forEach>
            ];

            const classAvgScores = [
                <c:forEach var="row" items="${classAvgScores}">
                ${row.avgGrade},
                </c:forEach>
            ];

            new Chart(document.getElementById("attendanceChart"), {
                type: 'doughnut',
                data: {
                    labels: ['출석', '기타'],
                    datasets: [{
                        data: [attendanceRate, 100 - attendanceRate],
                        backgroundColor: ['#6B46C1', '#E2E8F0']
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false }
            });

            new Chart(document.getElementById("avgScoreChart"), {
                type: 'bar',
                data: {
                    labels: classLabels,
                    datasets: [{
                        label: '평균 점수',
                        data: classAvgScores,
                        backgroundColor: '#9F7AEA'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: { y: { beginAtZero: true, max: 100 } }
                }
            });
        </script>

    </body>
</html>