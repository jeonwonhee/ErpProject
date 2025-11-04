<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>KH EduERP | 학생 대시보드</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Pretendard:wght@400;500;600;700&display=swap');

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Pretendard', sans-serif;
    }

    body {
      background: #f8f9fc;
      display: flex;
    }

    /* ===== 사이드바 ===== */
    .sidebar {
      width: 230px;
      background: #e8ecff;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      padding: 25px 20px;
      position: fixed;
      top: 0;
      left: 0;
      bottom: 0;
      height: 100vh;
      z-index: 10;
    }

    .logo {
      display: flex;
      align-items: center;
      gap: 8px;
      font-weight: 600;
      font-size: 18px;
      color: #2a4cff;
    }

    .menu {
      list-style: none;
      margin-top: 40px;
    }

    .menu li {
      padding: 10px 12px;
      border-radius: 8px;
      margin-bottom: 8px;
      font-size: 15px;
      cursor: pointer;
      transition: 0.15s;
    }

    .menu li.active,
    .menu li:hover {
      background: #d5d9ff;
      font-weight: 600;
    }

    .sidebar footer {
      font-size: 12px;
      color: #666;
      text-align: center;
    }

    /* ===== 메인 ===== */
    .main {
      margin-left: 230px;
      flex: 1;
      display: flex;
      flex-direction: column;
      background: #fff;
    }

    .topbar {
      position: fixed;
      top: 0;
      left: 230px;
      right: 0;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 16px 28px;
      border-bottom: 1px solid #ddd;
      background: #fff;
      z-index: 9;
    }

    .path {
      font-size: 15px;
      color: #444;
    }

    .path b {
      margin-left: 6px;
    }

    .user-info {
      font-size: 14px;
      color: #666;
    }

    .user-info span {
      color: #ff3b3b;
      font-weight: 600;
    }

    .content {
      flex: 1;
      padding: 120px 40px 40px;
      display: grid;
      grid-template-columns: 2fr 1.2fr;
      gap: 24px;
      background: #f8f9fc;
    }

    .card {
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 14px;
      padding: 25px 30px;
      box-shadow: 0 1px 4px rgba(0, 0, 0, 0.04);
    }

    .card h2 {
      font-size: 17px;
      font-weight: 700;
      margin-bottom: 16px;
      color: #222;
    }

    /* ===== 출석률 차트 ===== */
    .attendance-wrapper {
      display: flex;
      align-items: center;
      gap: 24px;
    }

    .donut-wrapper {
      position: relative;
      width: 180px;
      aspect-ratio: 1 / 1;
    }

    svg {
      width: 100%;
      height: 100%;
      transform: rotate(-90deg);
    }

    circle {
      fill: none;
      stroke-width: 18;
      transform-origin: center;
    }

    .bg { stroke: #e5e5ff; }

    .attend {
      stroke: #4b45ff;
      stroke-dasharray: 491.73 73.75;
      stroke-linecap: round;
    }

    .late {
      stroke: #ffd84d;
      stroke-dasharray: 49.17 516.31;
      stroke-dashoffset: -491.73;
      stroke-linecap: butt;
    }

    .absent {
      stroke: #ff6b6b;
      stroke-dasharray: 24.59 540.89;
      stroke-dashoffset: -540.9;
      stroke-linecap: butt;
    }

    .chart-text {
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      font-size: 22px;
      font-weight: 700;
      color: #222;
    }

    .attendance-details {
      display: flex;
      flex-direction: column;
      gap: 6px;
      font-size: 15px;
    }

    .legend {
      display: flex;
      gap: 16px;
      margin-top: 8px;
      font-size: 13px;
      color: #555;
    }

    .legend span::before {
      content: '';
      display: inline-block;
      width: 10px;
      height: 10px;
      border-radius: 50%;
      margin-right: 5px;
      vertical-align: middle;
    }

    .legend .att::before { background: #4b45ff; }
    .legend .late::before { background: #ffd84d; }
    .legend .abs::before { background: #ff6b6b; }

    /* ===== 이번달 일정 ===== */
    .schedule ul {
      margin-top: 6px;
      margin-left: 18px;
      line-height: 1.8;
      font-size: 14px;
      color: #333;
    }

    /* ===== 상세기록 표 ===== */
    .details-card table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 10px;
      font-size: 14px;
    }

    .details-card th, .details-card td {
      border: 1px solid #ddd;
      text-align: center;
      padding: 10px;
    }

    .details-card th {
      background: #f3f3ff;
      font-weight: 600;
      color: #333;
    }

    .details-card tbody tr:hover {
      background: #eef0ff;
      transition: 0.15s;
    }
  </style>
</head>
<body>
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
