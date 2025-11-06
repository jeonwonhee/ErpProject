<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
        <meta charset="UTF-8">
        <title>KH EduERP | 강의 만족도 상세</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <link rel="stylesheet" href="styles\default.css">
        <link rel="stylesheet" href="styles\style.css">
        <link rel="stylesheet" href="styles\lecture.css">
    </head>

    <body class="lecture lecture-graph">
        <!-- 사이드바 -->
        <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

        <main class="main">
            <header class="topbar">
                <div class="path">강사 > 만족도 결과 > JAVA/SPRING > 강사명 <b>강사 페이지</b></div>
                <div class="user-info">
                    <div class="kh-user-info">
                        <span class="alert">알림(2)</span>
                        <span class="user">김강사(강사)</span>
                    </div>
                </div>
            </header>

            <section class="content">
                <div class="card">
                    <h2>강의별 만족도 (5점 만점 기준)</h2>
                    <small>JAVA/SPRING - 강사명</small>

                    <div class="chart-container">
                        <div class="chart-box">
                            <canvas id="lectureChart"></canvas>
                            <p>강의 평점: 4.2</p>
                        </div>
                        <div class="chart-box">
                            <canvas id="teacherChart"></canvas>
                            <p>강사 평점: 4.3</p>
                        </div>
                    </div>

                    <div class="feedback-section">
                        <h3>학생 의견</h3>
                        <div class="feedback-list">
                            <div class="card feedback-card">
                                <p class="student-name">익명 학생</p>
                                <p class="feedback-text">강의 내용이 명확하고 실습이 많아서 좋았습니다.</p>
                            </div>
                            <div class="card feedback-card">
                                <p class="student-name">익명 학생</p>
                                <p class="feedback-text">설명이 친절하지만 예시를 더 추가해주시면 좋겠어요.</p>
                            </div>
                            <div class="card feedback-card">
                                <p class="student-name">익명 학생</p>
                                <p class="feedback-text">프로젝트 피드백이 빠르고 구체적이었어요.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <script>
            const ctx1 = document.getElementById('lectureChart');
            const ctx2 = document.getElementById('teacherChart');

            new Chart(ctx1, {
                type: 'bar',
                data: {
                    labels: ['강의 만족도'],
                    datasets: [{
                    label: '평점',
                    data: [4.2],
                    backgroundColor: '#6b5bff',
                    borderRadius: 8
                    }]
                },
                options: { scales: { y: { beginAtZero: true, max: 5 } } }
            });

            new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: ['강사 만족도'],
                    datasets: [{
                    label: '평점',
                    data: [4.3],
                    backgroundColor: '#35c5b3',
                    borderRadius: 8
                    }]
                },
                options: { scales: { y: { beginAtZero: true, max: 5 } } }
            });
        </script>
    </body>
</html>
