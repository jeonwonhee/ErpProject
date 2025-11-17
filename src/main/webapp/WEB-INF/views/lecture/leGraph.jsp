<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                    <small>${lectureData.className} - ${lectureData.lectureName}</small>

                    <!-- 제출률 표시 -->
                        <p style="margin-top: 5px;">
                            <strong>제출률 :</strong>
                            ${lectureData.submittedCount} / ${lectureData.totalCount} (${submitRate}%)
                        </p>

                    <div class="chart-container">
                        <div class="chart-box">
                            <canvas id="lectureChart"></canvas>
                            <p>강의 평점: ${lectureData.avgClassRating}</p>
                        </div>
                        <div class="chart-box">
                            <canvas id="teacherChart"></canvas>
                            <p>강사 평점: ${lectureData.avgLectureRating}</p>
                        </div>
                    </div>

                    <!-- 학생 의견 -->
                    <div class="feedback-section">
                        <h3>학생 의견</h3>

                        <div id="commentArea" class="feedback-list"></div>

                        <!-- 페이징 영역 -->
                        <div id="pageArea" class="pagination" style="margin-top:15px;"></div>
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
                    labels: ['수업 만족도'],
                    datasets: [{
                    label: '평점',
                    data: [${lectureData.avgClassRating}],
                    backgroundColor: '#6b5bff',
                    borderRadius: 8,
                    barThickness: 120
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
                    data: [${lectureData.avgLectureRating}],
                    backgroundColor: '#35c5b3',
                    borderRadius: 8,
                    barThickness: 120
                    }]
                },
                options: { scales: { y: { beginAtZero: true, max: 5 } } }
            });

            /* ===========================
               AJAX 페이징 함수
            =========================== */
            function loadComments(page) {
                fetch('/ajax/comments?classLectureNo=' + ${lectureData.classLectureNo} + '&page=' + page)
                    .then(resp => resp.json())
                    .then(data => {

                    /* 댓글 그리기 */
                    const area = document.getElementById("commentArea");
                    area.innerHTML = "";

                    if (data.commentList.length === 0) {
                        area.innerHTML = `<p style="color:#666;">등록된 의견이 없습니다.</p>`;
                    } else {
                        data.commentList.forEach(item => {
                            area.innerHTML += `
                            <div class="card feedback-card">
                                <p class="feedback-text">\${item.suggestion}</p>
                            </div>`;
                        });
                    }

                    /* 페이징 그리기 */
                    const pageArea = document.getElementById("pageArea");
                    pageArea.innerHTML = "";

                    if (page > 1) {
                        pageArea.innerHTML +=
                            '<a href="javascript:void(0)" ' +
                            'class="page-btn" ' +
                            'onclick="loadComments(' + (page - 1) + ')">' +
                            '◀' +
                            '</a>';
                    }

                    // 페이지 번호
                    for (let p = 1; p <= data.maxPage; p++) {
                        pageArea.innerHTML +=
                            '<a href="javascript:void(0)" ' +
                            'class="page-btn' + (p === page ? ' active' : '') + '" ' +
                            'onclick="loadComments(' + p + ')">' +
                            p +
                            '</a>';
                    }

                    // ▶ 다음 버튼
                    if (page < data.maxPage) {
                        pageArea.innerHTML +=
                            '<a href="javascript:void(0)" ' +
                            'class="page-btn" ' +
                            'onclick="loadComments(' + (page + 1) + ')">' +
                            '▶' +
                            '</a>';
                    }
                });
            }

            /* 첫 페이지 자동 로딩 */
            loadComments(1);
        </script>
    </body>
</html>
