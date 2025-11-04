<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 강의 만족도 상세</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600&display=swap');
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', sans-serif; }

    body { background: #f8f9fc; display: flex; }

    /* Sidebar */
    .sidebar {
      width: 230px;
      background: #e8ecff;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 25px 20px;
      height: 100vh;
    }

    .logo {
      display: flex;
      align-items: center;
      gap: 8px;
      font-weight: 600;
      font-size: 18px;
      color: #2a4cff;
    }

    .logo img { width: 32px; height: 32px; }

    .menu { list-style: none; margin-top: 40px; }
    .menu li {
      padding: 10px 12px;
      border-radius: 8px;
      margin-bottom: 8px;
      font-size: 15px;
      cursor: pointer;
      color: #333;
      transition: 0.15s;
    }
    .menu li.active, .menu li:hover { background: #d5d9ff; font-weight: 600; }

    .sidebar footer { font-size: 12px; color: #666; text-align: center; }

    /* Main */
    .main { flex: 1; display: flex; flex-direction: column; background: #fff; }
    .topbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 16px 28px;
      border-bottom: 1px solid #ddd;
    }

    .path { font-size: 15px; color: #444; }
    .path b { margin-left: 6px; font-weight: 600; }
    .user-info { font-size: 14px; color: #666; }

    .content { flex: 1; padding: 40px; }
    .card {
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 12px;
      padding: 30px 35px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
      max-width: 900px;
    }

    .card h2 { font-size: 18px; font-weight: 700; margin-bottom: 10px; }
    .card small { color: #777; }

    .chart-container { display: flex; gap: 30px; margin-top: 20px; }
    .chart-box { flex: 1; text-align: center; }

    canvas { background: #fafbff; border-radius: 8px; padding: 10px; }

    .feedback-section { margin-top: 30px; }
    .feedback-list { display: grid; gap: 12px; margin-top: 10px; }

    .feedback-card {
      background: #f9f9ff;
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 12px 16px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    }

    .student-name { font-size: 13px; color: #4b45ff; font-weight: 600; margin-bottom: 6px; }
    .feedback-text { font-size: 14px; color: #333; }
  </style>
</head>
<body>
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
        <h2>강의별 만족도 (%)</h2>
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
            <div class="feedback-card">
              <p class="student-name">익명 학생</p>
              <p class="feedback-text">강의 내용이 명확하고 실습이 많아서 좋았습니다.</p>
            </div>
            <div class="feedback-card">
              <p class="student-name">익명 학생</p>
              <p class="feedback-text">설명이 친절하지만 예시를 더 추가해주시면 좋겠어요.</p>
            </div>
            <div class="feedback-card">
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
