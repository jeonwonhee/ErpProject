<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 학생 대시보드</title>
  
  <link rel="stylesheet" href="/styles/default.css">
  <link rel="stylesheet" href="/styles/style.css">
  <link rel="stylesheet" href="/styles/student.css">
</head>
<body class="student">
      <jsp:include page="/WEB-INF/views/common/sidBar.jsp" />

  <main class="main">
      <jsp:include page="/WEB-INF/views/common/topBar.jsp" />

    <section class="content">
      <div class="left-section">
        <div class="card">
          <h2>이번달 출석률</h2>
          <div class="attendance-wrapper">
            <div class="donut-wrapper">
              <svg viewBox="0 0 220 220">
                <circle class="bg" cx="110" cy="110" r="90" />
                <circle class="attend" cx="110" cy="110" r="90" />
                <circle class="late" cx="110" cy="110" r="90" />
                <circle class="absent" cx="110" cy="110" r="90" />
              </svg>
              <div class="chart-text">87%</div>
            </div>
            <div class="attendance-details">
              <div><strong>출석</strong> 20회</div>
              <div><strong>지각</strong> 2회</div>
              <div><strong>결석</strong> 1회</div>
              <div class="legend">
                <span class="att">출석</span>
                <span class="late">지각</span>
                <span class="abs">결석</span>
              </div>
            </div>
          </div>
        </div>

        <div class="card schedule">
          <h2>이번달 일정</h2>
          <ul>
            <li>10/3~10/8 추석 연휴</li>
            <li>10/24 팀 프로젝트 시작</li>
            <li>10/31 중간 점검(멘토링)</li>
          </ul>
        </div>
      </div>

      <div class="card details-card">
        <h2>상세 기록</h2>
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
            <tr>
              <td>2025.10.24</td>
              <td>✔️</td>
              <td></td>
              <td></td>
            </tr>
            <tr>
              <td>2025.10.23</td>
              <td></td>
              <td>⚠️</td>
              <td></td>
            </tr>
            <tr>
              <td>2025.10.22</td>
              <td></td>
              <td></td>
              <td>❌</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  </main>
</body>
</html>