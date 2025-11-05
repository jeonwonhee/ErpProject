<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>KH EduERP | 강사 대시보드</title>
  
  <link rel="stylesheet" href="styles\default.css">
  <link rel="stylesheet" href="styles\style.css">
  <link rel="stylesheet" href="styles\lecture.css">
</head>
<body class="lecture lecture-dashboard">
<!-- 사이드바 -->
<jsp:include page="/WEB-INF/views/common/sidBar.jsp" />


<main class="main">
    <header class="topbar">
      <div class="path">강사 › 대시보드 <b>강사 페이지</b></div>
      <div class="user-info">알림(<span>2</span>) 김강사(강사)</div>
    </header>

    <section class="content">
      <!-- Calendar Section -->
      <div class="calendar-box">
        <div class="calendar-header">
          <div class="month-control">
            <button class="month-btn">◀</button>
            <div class="month-title">2025년 10월</div>
            <button class="month-btn">▶</button>
          </div>
          <div class="legend">
            <span><span class="dot blue"></span>수업</span>
            <span><span class="dot orange"></span>시험</span>
            <span><span class="dot red"></span>휴원/행사</span>
          </div>
        </div>
        <div class="calendar-grid" id="calendar"></div>
      </div>

      <!-- Info Cards -->
      <div class="info-section">
        <div class="card">
          <h3>최근 신청 리스트</h3>
          <table>
            <thead><tr><th>이름</th><th>신청일</th><th>신청 사유</th></tr></thead>
            <tbody>
              <tr><td>○○○</td><td>25.10.19</td><td>휴가 신청 합니다.</td></tr>
              <tr><td>○○○</td><td>25.10.19</td><td>출결 정정 신청입니다.</td></tr>
            </tbody>
          </table>
        </div>
        <div class="card">
          <h3>출석 현황</h3>
          <table>
            <thead><tr><th>클래스명</th><th>인원수</th><th>출석률</th></tr></thead>
            <tbody>
              <tr><td>A반</td><td>23명</td><td>86%</td></tr>
              <tr><td>B반</td><td>25명</td><td>100%</td></tr>
            </tbody>
          </table>
        </div>
      </div>
    </section>
  </main>

  <!-- Calendar Script -->
  <script>
    const calendar = document.getElementById("calendar");
    const events = {
      3: { type: ["수업", "시험"], details: "수업: 10:00~12:00<br>시험: 14:00~15:00" },
      10: { type: ["수업"], details: "수업: 09:00~11:00" },
      19: { type: ["휴원"], details: "휴원: 한글날 대체휴무" }
    };

    for (let i = 1; i <= 31; i++) {
      const day = document.createElement("div");
      day.classList.add("day-cell");
      day.innerHTML = `<span class='day-num'>${i}</span>`;
      
      if (events[i]) {
        let dots = "";
        if (events[i].type.includes("수업")) dots += `<span class='event-dot blue'></span>`;
        if (events[i].type.includes("시험")) dots += `<span class='event-dot orange'></span>`;
        if (events[i].type.includes("휴원")) dots += `<span class='event-dot red'></span>`;
        day.innerHTML += `<div class='tooltip'>${events[i].details}</div>
                          <div class='event-dots'>${dots}</div>`;
      }

      calendar.appendChild(day);
    }
  </script>
</body>
</html>
