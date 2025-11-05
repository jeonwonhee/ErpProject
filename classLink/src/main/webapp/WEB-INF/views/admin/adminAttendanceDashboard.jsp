<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>KH EduERP | 출결현황</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/default.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
        <!-- Chart.js 외부 라이브러리 로드 -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>

    <body class="admin admin-attendance">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <!-- 메인 -->
        <main class="main">
            <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

            <section class="content attendance-container">
                <!-- 필터 -->
                <div class="filter-bar">
                    <h2>출결 통계</h2>
                    <select id="period-filter">
                        <option>이번 주</option>
                        <option>이번 달</option>
                        <option>전체</option>
                    </select>
                </div>

                <!-- 그래프 영역 -->
                <div class="chart-grid">
                    <div class="chart-card">
                        <h3>요일별 출석률 <span class="summary">평균 92%</span></h3>
                        <canvas id="dayChart"></canvas>
                    </div>

                    <div class="chart-card">
                        <h3>출석 비율</h3>
                        <canvas id="pieChart"></canvas>
                    </div>

                    <div class="chart-card wide">
                        <h3>월별 출석률 <span class="summary">평균 89%</span></h3>
                        <canvas id="monthChart"></canvas>
                    </div>
                </div>
            </section>
        </main>

        <script>
            // 요일별 출석률 (막대그래프)
            new Chart(document.getElementById("dayChart"), {
                type: 'bar',
                data: {
                    labels: ["월", "화", "수", "목", "금"],
                    datasets: [{
                    label: "출석률 (%)",
                    data: [90, 92, 85, 95, 94],
                    backgroundColor: "#4B5DFF",
                    borderRadius: 6,
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                    y: { beginAtZero: true, max: 100 }
                    },
                    plugins: { legend: { display: false } }
                }
            });

            // 출석 비율 (도넛차트)
            new Chart(document.getElementById("pieChart"), {
                type: 'doughnut',
                data: {
                    labels: ["출석", "지각", "결석"],
                    datasets: [{
                    data: [80, 10, 10],
                    backgroundColor: ["#4B5DFF", "#FFD43B", "#FF6B6B"]
                    }]
                },
                options: {
                    plugins: {
                        legend: { position: "bottom" }
                    }
                }
            });

            // 월별 출석률
            new Chart(document.getElementById("monthChart"), {
                type: 'line',
                data: {
                    labels: ["1월","2월","3월","4월","5월","6월","7월"],
                    datasets: [{
                    label: "출석률 (%)",
                    data: [88, 90, 85, 92, 89, 94, 95],
                    borderColor: "#4B5DFF",
                    fill: true,
                    backgroundColor: "rgba(75,93,255,0.1)",
                    tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                    y: { beginAtZero: true, max: 100 }
                    },
                    plugins: { legend: { display: false } }
                }
            });
        </script>
    </body>
</html>
