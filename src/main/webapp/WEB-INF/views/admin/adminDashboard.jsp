<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- JSTL 포맷팅 태그 선언 추가 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>KH EduERP | 관리자 대시보드</title>

    <!-- 공통 CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">

    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="admin">

<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

<!-- 메인 영역 -->
<main class="main">

    <!-- 상단바 -->
    <c:set var="pageName" value="대시보드" scope="request"></c:set>
    <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <!-- 콘텐츠 영역 -->
    <section class="content">

        <!-- 🔹 통계 카드 -->
        <div class="stats-row">
            <div class="stat-box">
                <h4>전체 학생수</h4>
                <p>${totalStudents}</p>
            </div>
            <div class="stat-box">
                <h4>전체 강사수</h4>
                <p>${totalLectures}</p>
            </div>
            <div class="stat-box">
                <h4>학생 평균 출석률</h4>
                <p><fmt:formatNumber value="${studentAvgRate}" type="number" maxFractionDigits="1" />%</p> <!-- ✅ 반올림 적용 -->
            </div>
            <div class="stat-box">
                <h4>강사 평균 출석률</h4>
                <p><fmt:formatNumber value="${lectureAvgRate}" type="number" maxFractionDigits="1" />%</p> <!-- ✅ 반올림 적용 -->
            </div>
            <div class="stat-box">
                <h4>금일 결석자</h4>
                <p>${todayAbsents}</p>
            </div>
        </div>

        <!-- 🔹 차트 + 알림 -->
        <div class="bottom-section">

            <!-- 요일별 출석률 그래프 -->
            <div class="card" style="flex:1;">
                <h3>요일별 출석률</h3>
                <canvas id="weeklyChart"></canvas>
            </div>

            <!-- 알림 -->
            <div class="card" style="max-width:300px;">
                <h3>알림</h3>
                <ul class="alert-list">
                    <li>상담 신청 대기 ${pendingCounsel}건</li>
                    <li>휴가 신청 대기 ${pendingVacation}건</li>
                    <li>기자재 렌탈 신청 대기 ${pendingDeviceRent}건</li>
                </ul>
            </div>
        </div>

    </section>
</main>

<!-- 🔹 Chart.js Script -->
<script>
    // Controller에서 보내준 JSON (문자열 그대로 들어오므로 parse 처리)
    const weeklyData = JSON.parse('${weeklyJson}');

    const labels = weeklyData.map(item => item.WEEKDAY);
    const rates = weeklyData.map(item => item.RATE * 100);

    new Chart(document.getElementById('weeklyChart'), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '출석률 (%)',
                data: rates,
                borderWidth: 3,
                fill: false,
                tension: 0.3
            }]
        },
        options: {
            layout: {
                padding: { top: 10 }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    max: 110
                }
            }
        }
    });
</script>

</body>
</html>